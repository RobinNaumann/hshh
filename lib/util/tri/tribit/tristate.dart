import 'package:hshh/models/m_data.dart';
import 'package:hshh/util/json_tools.dart';

abstract class TriState<T> extends DataModel {
  const TriState._();
  factory TriState.loading() => _LoadingTriState<T>();
  factory TriState.error(dynamic e) => _ErrorTriState(e);
  factory TriState.data(T data) => _DataTriState(data);

  bool get isLoading => this is _LoadingTriState<T>;
  bool get isError => this is _ErrorTriState<T>;
  bool get isData => this is _DataTriState<T>;

  bool hasSameData(TriState other) =>
      isData && other.isData && other.hashCode == hashCode;

  R when<R>(
          {required R Function() onLoading,
          required R Function(dynamic error) onError,
          required R Function(T data) onData}) =>
      this.isData
          ? onData((this as _DataTriState).data)
          : (this.isError ? onError((this as _ErrorTriState).e) : onLoading());

  R? whenOrNull<R>(
          {R Function()? onLoading,
          R Function(dynamic error)? onError,
          R Function(T data)? onData}) =>
      when(
          onLoading: onLoading ?? () => null,
          onError: onError ?? (_) => null,
          onData: onData ?? (_) => null);
}

class _LoadingTriState<T> extends TriState<T> {
  const _LoadingTriState() : super._();
  @override
  JsonMap get fields => {};
}

class _ErrorTriState<T> extends TriState<T> {
  final dynamic e;
  const _ErrorTriState(this.e) : super._();

  @override
  JsonMap get fields => {"e": e};
}

class _DataTriState<T> extends TriState<T> {
  final T data;
  const _DataTriState(this.data) : super._();

  @override
  JsonMap get fields => {"data": data};
}
