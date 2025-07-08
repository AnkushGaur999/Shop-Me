sealed class DataState<T> {}

class InitialState<T> extends DataState<T> {}

class LoadingState<T> extends DataState<T> {}

class SuccessState<T> extends DataState<T> {
  final T data;

  SuccessState(this.data);
}

class ErrorState<T> extends DataState<T> {
  final String message;

  ErrorState(this.message);
}
