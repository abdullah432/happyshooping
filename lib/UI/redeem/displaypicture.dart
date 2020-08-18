// A widget that displays the picture taken by the user.
import 'dart:io';
import 'dart:typed_data';
import 'listofitemincart/listofproductincartpage.dart';
import 'package:flutter/material.dart';
import 'package:happyshooping/Utils/Constant.dart';
import 'package:photo_view/photo_view.dart';

class DisplayPicturePage extends StatefulWidget {
  final String imagePath;
  final String storeId;

  DisplayPicturePage({Key key, this.imagePath, this.storeId}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return DisplayPicturePageState(imagePath, storeId);
  }
}

class DisplayPicturePageState extends State<DisplayPicturePage> {
  ImageProvider imageProvider;
  String imagePath;
  String storeId;
  DisplayPicturePageState(this.imagePath, this.storeId);
  @override
  Widget build(BuildContext context) {
    imageProvider = MemoryImage(loadData());
    return Scaffold(
        body: Stack(children: <Widget>[
      Container(
        child: PhotoView(
          imageProvider: imageProvider,
        ),
      ),
      Positioned(
          bottom: 0,
          right: 0,
          child: InkWell(
              onTap: () {
                navigateToListOfProductInCartPage();
              },
              splashColor: Constant.primaryColor,
              child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child:
                          //circular button with camera icon
                          Center(
                              child: Container(
                                  decoration: BoxDecoration(
                                    // color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.3),
                                        // spreadRadius: 1,
                                        blurRadius: 7,
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: ClipOval(
                                      child: Material(
                                          color: Colors.white, // button color
                                          child: SizedBox(
                                              width: 55,
                                              height: 55,
                                              child: Icon(
                                                Icons.check,
                                                color: Constant.primaryColor,
                                                size: 30,
                                              ))))))))))
    ]));
  }

  Uint8List loadData() {
    File file = File(imagePath);
    Uint8List bytes = file.readAsBytesSync();
    return bytes;
  }

  navigateToListOfProductInCartPage() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ListOfProductsInCartPage(imagePath: imagePath, storeId: storeId,)));
  }
}
