import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hshh/util/tools.dart';

import 'tri_error/v_tri_error.dart';
import 'tri_state.dart';

class TriProvider<C extends TriCubit> extends StatefulWidget {
  final C Function(BuildContext _) cubit;
  final Widget? child;
  const TriProvider({super.key, required this.cubit, required this.child});

  @override
  State<TriProvider<C>> createState() => __ProviderState<C>();
}

class __ProviderState<C extends TriCubit> extends State<TriProvider<C>> {
  late final cubit = widget.cubit(context);

  @override
  Widget build(BuildContext context) =>
      BlocProvider<C>(create: (_) => cubit, child: widget.child);
}

abstract class TriCubit<T> extends Cubit<TriState<T>> {
  static Widget _small() => const SizedBox.shrink();

  static Widget builder<C extends TriCubit<T>, T>(
      {Key? key,
      Widget Function(C cubit)? onLoading,
      Widget Function(C cubit, dynamic error)? onError,
      required Widget Function(C cubit, T data) onData,
      bool small = false}) {
    return BlocBuilder<C, TriState<T>>(
        buildWhen: (previous, current) => !current.hasSameData(previous),
        key: key,
        builder: (context, state) {
          final cubit = context.read<C>();
          return state.when(
              onLoading: () =>
                  onLoading?.call(cubit) ??
                  (small ? _small() : loadingView(cubit)),
              onError: (e) =>
                  onError?.call(cubit, e) ??
                  (small ? _small() : errorView(cubit, e)),
              onData: (d) => onData(cubit, d));
        });
  }

  static Widget provider<C extends TriCubit>(
          {Key? key,
          required C Function(BuildContext _) cubit,
          required Widget? child}) =>
      BlocProvider<C>(
        key: key,
        create: cubit,
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

  _emit(TriState<T> state) {
    if (isClosed) {
      logger.w("tried to emit a TriState while the Cubit was closed");
      return;
    }
    if (state.hashCode == this.state.hashCode) {
      logger.t("prevented emit of identical TriState");
      return;
    }
    super.emit(state);
  }

  @override
  void emit(TriState<T> state) =>
      throw Exception("use the setData, setLoading, setError function");

  void setLoading() => isClosed ? null : _emit(TriState.loading());
  void setError(dynamic e) => isClosed ? null : _emit(TriState.error(e));
  void setData(T data) => isClosed ? null : _emit(TriState.data(data));
}

Widget errorView(TriCubit cubit, dynamic error) =>
    Center(child: TriErrorView(cubit: cubit, error: error));

Widget loadingView(TriCubit cubit) => const Center(
    child: Padding(
        padding: EdgeInsets.all(10),
        child: CircularProgressIndicator.adaptive()));
