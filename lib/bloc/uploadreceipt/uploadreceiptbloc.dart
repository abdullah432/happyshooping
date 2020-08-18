import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:happyshooping/repositories/receipt_repository.dart';
import 'package:meta/meta.dart';

part 'uploadreceiptevent.dart';
part 'uploadreceiptstate.dart';

class UploadReceiptBloc extends Bloc<UploadReceiptEvent, UploadReceiptState> {
  UploadReceiptBloc() : super(InitialUploadReceiptState());
  final ReceiptRespository _receiptRespository = ReceiptRespository();
  @override
  Stream<UploadReceiptState> mapEventToState(UploadReceiptEvent event) async* {
    if (event is UploadReceiptInitiated) {
      try {
        //upload receiptimage to firestore is already done in uploadreceiptui because
        //I didn't figure out how to show progress bar with bloc
        String result = await _receiptRespository.sendCashBackRequest(
            downloadUrl: event.downloadUrl, storeId: event.storeId, cashback: event.cashback, products: event.products);
        if (result == "Success") {
          yield UploadReceiptSuccess();
        } else {
          print("error in UploadReceipt: "+result);
          yield UploadReceiptFail(error: result);
        }
        
      } on SocketException catch (error) {
        print("StoresListFetchStoresEvent: " + error.message);
        yield UploadReceiptFail(
            error: "Connection Failed. Please check Your Internet connection");
      } catch (error) {
        print("StoresListFetchStoresEvent: " + error);
        yield UploadReceiptFail(
            error: 'Fail to laod data. Please try again\nOr Report the issue');
      }
    }
  }
}
