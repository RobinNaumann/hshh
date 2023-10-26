import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'tri_state.dart';

abstract class TriCubit<T> extends Cubit<TriState<T>> {
  static Widget _small() => const SizedBox.shrink();

  static Widget builderSmall<C extends TriCubit<T>, T>(
          {Widget Function(C cubit)? onLoading,
          Widget Function(C cubit, dynamic error)? onError,
          Widget Function(C cubit, T data)? onData}) =>
      builder(
          onLoading: onLoading ?? (_) => _small(),
          onError: onError ?? (_, __) => _small(),
          onData: onData ?? (_, __) => _small());

  static Widget builder<C extends TriCubit<T>, T>(
          {required Widget Function(C cubit) onLoading,
          required Widget Function(C cubit, dynamic error) onError,
          required Widget Function(C cubit, T data) onData}) =>
      BlocBuilder<C, TriState<T>>(builder: (context, state) {
        final cubit = context.read<C>();
        return state.when(
            onLoading: () => onLoading(cubit),
            onError: (e) => onError(cubit, e),
            onData: (d) => onData(cubit, d));
      });

  static Widget provider<C extends TriCubit>(
          {required C cubit, required Widget child}) =>
      BlocProvider<C>(
        create: (context) => cubit,
        child: child,
      );

  final FutureOr<T> Function() worker;

  TriCubit(this.worker, [TriState<T>? initial])
      : super(initial ?? TriState<T>.loading()) {
    reload();
  }

  reload({bool silent = false}) async {
    if (!silent) setLoading();
    try {
      setData(await worker());
    } catch (e) {
      setError(e);
    }
  }

  @override
  void emit(TriState<T> state) =>
      throw Exception("use the setData, setLoading, setError function");

  void setLoading() => super.emit(TriState.loading());
  void setError(dynamic e) => super.emit(TriState.error(e));
  void setData(T data) => super.emit(TriState.data(data));
}

Widget errorView(TriCubit cubit, dynamic error) =>
    const Text("an error occurred here");
Widget loadingView(TriCubit cubit) =>
    const Center(child: CircularProgressIndicator.adaptive());
