part of 'uploadreceiptbloc.dart';

class UploadReceiptEvent extends Equatable {
  const UploadReceiptEvent();
  @override
  List<Object> get props => [];
}

class UploadReceiptInitiated extends UploadReceiptEvent {
  final storeId;
  final downloadUrl;
  final products;
  final cashback;
  UploadReceiptInitiated({
    @required this.storeId,
    @required this.downloadUrl,
    @required this.cashback,
    @required this.products,
  });

  @override
  List<Object> get props => [storeId, downloadUrl, cashback, products];
}
