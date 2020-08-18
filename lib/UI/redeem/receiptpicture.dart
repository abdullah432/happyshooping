import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:happyshooping/UI/redeem/camerascreen.dart';
import 'package:happyshooping/Utils/Constant.dart';

class TakeReceiptPicturePage extends StatefulWidget {
  final storeId;
  TakeReceiptPicturePage({@required this.storeId});

  @override
  State<StatefulWidget> createState() {
    return TakeReceiptPicturePageState(storeId);
  }
}

class TakeReceiptPicturePageState extends State<TakeReceiptPicturePage> {
  var storeId;
  TakeReceiptPicturePageState(this.storeId);
  //initialize camera
  var firstCamera;
  @override
  void initState() {
    loadCamerasList();
    super.initState();
  }

  loadCamerasList() async {
    // Obtain a list of the available cameras on the device.
    final cameras = await availableCameras();

    // Get a specific camera from the list of available cameras.
    firstCamera = cameras.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Constant.customColor4,
        appBar: AppBar(
          backgroundColor: Constant.customColor4,
          elevation: 0.0,
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          title: Text(
            'Get Cashback',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Image(
                    height: 220,
                    image: AssetImage('assets/images/cashback.png')),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Take Picture of your receipt',
              style: TextStyle(
                  fontSize: 19.0,
                  fontFamily: 'RobotoMono',
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Please capture the full receipt, including product details, date and total price',
              textAlign: TextAlign.center,
              style:
                  TextStyle(fontSize: 18.0, color: Constant.highlightedColor),
            ),
            SizedBox(
              height: 50,
            ),
            //circular button with camera icon
            InkWell(
              onTap: () {
                print("hello");
                navigateToCameraScreenPage();
              },
              splashColor: Constant.primaryColor,
              child: Container(
                decoration: BoxDecoration(
                  // color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      // spreadRadius: 1,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Material(
                    color: Colors.white, // button color/ inkwell color
                      child: SizedBox(
                          width: 56, height: 56, child: Icon(Icons.camera_alt)),
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  navigateToCameraScreenPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CameraScreen(camera: firstCamera, storeId: storeId,)));
  }
}
