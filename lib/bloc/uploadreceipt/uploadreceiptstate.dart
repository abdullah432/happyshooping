part of 'uploadreceiptbloc.dart';

abstract class UploadReceiptState extends Equatable {
  const UploadReceiptState();
  @override
  List<Object> get props => [];
}

class InitialUploadReceiptState extends UploadReceiptState {}

class UploadReceiptInProgress extends UploadReceiptState {
}

class UploadReceiptSuccess extends UploadReceiptState { }

class UploadReceiptFail extends UploadReceiptState {
  final String error;
  const UploadReceiptFail({@required this.error});

  @override
  List<Object> get props => [error];
}