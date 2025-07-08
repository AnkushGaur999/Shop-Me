import 'package:shop_me/core/exceptions/app_exception.dart';

sealed class ResultState<T> {
  final T? data;

  final AppException? exception;

  ResultState({this.data, this.exception});
}

class ResultSuccess<T> extends ResultState<T> {
  ResultSuccess({required T data}) : super(data: data);
}

class ResultFailed<T> extends ResultState<T> {
  ResultFailed({required AppException exception}) : super(exception: exception);
}
