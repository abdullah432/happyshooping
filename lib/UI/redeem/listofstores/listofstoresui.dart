import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:happyshooping/UI/redeem/receiptpicture.dart';
import 'package:happyshooping/Utils/Constant.dart';
import 'package:happyshooping/bloc/storeslist/storeslistbloc.dart';
import 'package:happyshooping/models/store.dart';

class StoresListUI extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return StoresListUIState();
  }
}

class StoresListUIState extends State<StoresListUI> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoresListBloc, StoresListState>(
      builder: (context, state) {
        if (state is InitialStoreListState || state is FetchingInProgress)
          return Center(child: SpinKitPulse(size: 51.0, color: Colors.green));
        if (state is FetchStoresListSuccess) {
          return showStoresList(state.storesList);
        }
        if (state is FetchStoresListFail)
          return Center(
              child: Text(state.error,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.red)));
      },
    );
  }

  showStoresList(List<Store> storesList) {
    return ListView.builder(
        itemCount: storesList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              navigateToTakePicturePage();
            },
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(children: [
                ClipOval(
                  child: Container(
                    color: (index % 2 == 0)
                        ? Constant.customColor1
                        : Constant.customColor2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CachedNetworkImage(
                        fit: BoxFit.contain,
                        width: 50,
                        height: 50,
                        imageUrl: storesList[index].iconUrl,
                        placeholder: (context, url) => const SpinKitThreeBounce(
                          color: Colors.white,
                          size: 20.0,
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(storesList[index].name, style: TextStyle(fontWeight: FontWeight.w500)),
              ]),
            ),
          );
        });
  }

  navigateToTakePicturePage() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => TakeReceiptPicturePage()));
  }
}
