class TriState<T> {
  const TriState._();
  factory TriState.loading() => const _Loading();
  factory TriState.error(dynamic e) => _Error(e);
  factory TriState.data(T data) => _Data(data);

  R when<R>(
          {required R Function() onLoading,
          required R Function(dynamic error) onError,
          required R Function(T data) onData}) =>
      this is _Data
          ? onData((this as _Data).data)
          : (this is _Error ? onError((this as _Error).e) : onLoading());

  R? whenOrNull<R>(
          {R Function()? onLoading,
          R Function(dynamic error)? onError,
          R Function(T data)? onData}) =>
      when(
          onLoading: onLoading ?? () => null,
          onError: onError ?? (_) => null,
          onData: onData ?? (_) => null);
}

class _Loading<T> extends TriState<T> {
  const _Loading() : super._();
}

class _Error<T> extends TriState<T> {
  final dynamic e;
  const _Error(this.e) : super._();
}

class _Data<T> extends TriState<T> {
  final T data;
  const _Data(this.data) : super._();
}
