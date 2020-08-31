import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happyshooping/UI/home.dart';
import 'package:happyshooping/UI/redeem/listofstores/listofstorespage.dart';
import 'package:happyshooping/Utils/Constant.dart';
import 'package:happyshooping/bloc/uploadreceipt/uploadreceiptbloc.dart';
import 'package:path/path.dart' as path;

class UploadReceiptUI extends StatefulWidget {
  final imagePath;
  final storeId;
  final products;
  final collectCashback;
  UploadReceiptUI(
      {@required this.imagePath,
      @required this.storeId,
      @required this.products,
      @required this.collectCashback});
  @override
  State<StatefulWidget> createState() {
    return UploadReceiptUIState(
        imagePath: imagePath,
        storeId: storeId,
        products: products,
        collectCashback: collectCashback);
  }
}

class UploadReceiptUIState extends State<UploadReceiptUI> {
  String imagePath;
  String storeId;
  List<String> products;
  int collectCashback;
  UploadReceiptUIState(
      {@required this.imagePath,
      @required this.storeId,
      @required this.products,
      @required this.collectCashback});

  double percent = 0.0;
  //when data to node server uploaded successfully then it will change to true
  bool uploadSuccess = false;
  bool uploadingInProgress = true;
  UploadReceiptBloc _uploadReceiptBloc;
  //key to show snackbar if firestore storage fail
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    uploadReceiptToFirestore();
  }

  @override
  Widget build(BuildContext context) {
    _uploadReceiptBloc = BlocProvider.of<UploadReceiptBloc>(context);
    return BlocListener<UploadReceiptBloc, UploadReceiptState>(
        listener: (context, state) {
          if (state is UploadReceiptFail) {
            uploadSuccess = false;
            uploadingInProgress = false;
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text("${state.error}"),
              backgroundColor: Colors.red,
            ));
          }
          if (state is UploadReceiptSuccess) {
            setState(() {
              uploadSuccess = true;
              uploadingInProgress = false;
            });
          }
        },
        child: Column(
          children: [
            SizedBox(height: 50),
            Center(
              child: Image(
                  height: 220,
                  image: AssetImage('assets/images/cashback2.png')),
            ),
            SizedBox(height: 20),
            Text(
              'Receipt Uploading ${percent.toInt()} %',
              style: TextStyle(
                  fontSize: 19.0,
                  fontFamily: 'RobotoMono',
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Visibility(
              visible: (percent.toInt() == 100 && uploadingInProgress == true),
              child: Text(
                'Wait for a moment',
                style: TextStyle(
                    fontSize: 17.0,
                    fontFamily: 'RobotoMono',
                    color: Constant.highlightedColor),
              ),
            ),
            // SizedBox(height: 20),
            Visibility(
              visible: !uploadingInProgress,
              child: Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Text(
                    uploadSuccess
                        ? 'Rs. $collectCashback will be added to your account after verification'
                        : "Failed Unexpectely. Please try again",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 17.0,
                        fontFamily: 'RobotoMono',
                        color: Constant.highlightedColor),
                  ),
                ),
              ),
            ),
            SizedBox(height: 50),
            //Redeem another receipt
            Visibility(
              visible: !uploadingInProgress,
              child: Padding(
                padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                child: Container(
                  height: Constant.containerHeight50,
                  width: double.infinity,
                  child: RaisedButton(
                    onPressed: () {
                      navigateToListOfStoresPage();
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(Constant.borderCircularRadius),
                    ),
                    color: Colors.greenAccent,
                    child: Text(
                      "Redeem another receipt",
                      style: TextStyle(
                        fontSize: Constant.primaryTextSize,
                        // color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            //Go back to home page
            Visibility(
              visible: !uploadingInProgress,
              child: Padding(
                padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                child: Container(
                  height: Constant.containerHeight50,
                  width: double.infinity,
                  child: RaisedButton(
                    onPressed: () {
                      navigateToHomePage();
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(Constant.borderCircularRadius),
                    ),
                    color: Colors.white,
                    child: Text(
                      "Home Page",
                      style: TextStyle(
                        fontSize: Constant.primaryTextSize,
                        // color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  Future<String> uploadReceiptToFirestore() async {
    FirebaseStorage _storage = FirebaseStorage.instance;
    File file = File(imagePath);
    //Create a reference to the location you want to upload to in firebase
    StorageReference reference =
        _storage.ref().child("receipts/${path.basename(file.path)}");

    //Upload the file to firebase
    StorageUploadTask uploadTask = reference.putFile(file);

    // Waits till the file is uploaded then stores the download url
    // Uri location = (await uploadTask.).downloadUrl;
    String downloadUrl;

    if (uploadTask.isSuccessful || uploadTask.isComplete) {
      final String downloadUrl = await reference.getDownloadURL();
      print("The download URL is (isSuccessful)" + downloadUrl);
      _uploadReceiptBloc.add(UploadReceiptInitiated(
          storeId: storeId,
          downloadUrl: imagePath,
          products: products,
          cashback: collectCashback));
    } else if (uploadTask.isInProgress) {
      uploadTask.events.listen((event) {
        double percentage = 100 *
            (event.snapshot.bytesTransferred.toDouble() /
                event.snapshot.totalByteCount.toDouble());
        print("THe percentage " + percentage.toString());
        setState(() {
          percent = percentage;
        });
      }).onError((error) {
        _scaffoldKey.currentState.showSnackBar(new SnackBar(
          content: new Text(error.toString()),
          backgroundColor: Colors.red,
        ));
      });

      StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
      downloadUrl = await storageTaskSnapshot.ref.getDownloadURL();

      _uploadReceiptBloc.add(UploadReceiptInitiated(
          storeId: storeId,
          downloadUrl: downloadUrl,
          cashback: collectCashback,
          products: products));

      //Here you can get the download URL when the task has been completed.
      print("Download URL (isInProgress) " + downloadUrl.toString());
    } else {
      //Catch any cases here that might come up like canceled, interrupted
    }

    //returns the download url
    return downloadUrl;
  }

  navigateToHomePage() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Home()),
        (Route<dynamic> route) => false);
  }

  navigateToListOfStoresPage() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => StoresListPage()),
        (Route<dynamic> route) => false);
  }
}
