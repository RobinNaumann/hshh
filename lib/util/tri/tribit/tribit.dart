import 'dart:async';
import 'dart:core';

import 'package:hshh/util/tools.dart';

import '../../elbe_ui/elbe.dart';
import '../tri_error/v_tri_error.dart';
import './tristate.dart';

part 'tri_builder.dart';
part 'tri_notifier.dart';
part 'tri_provider.dart';

extension TriContext on BuildContext {
  B bit<B extends TriBit>() => TriBit.of<B>(this);
  B? maybeBit<B extends TriBit>() => TriBit.maybeOf<B>(this);
}

class TriBit<T> {
  final Future<T> Function()? worker;
  TriState<T> state;

  final _streamController = StreamController<TriState<T>>();
  Stream<TriState<T>>? _stream;

  Stream<TriState<T>> get stream => _stream != null ? _stream! : _init();

  Stream<TriState<T>> _init() {
    _stream = _streamController.stream.asBroadcastStream();
    _stream!.listen((e) => state = e);
    reload();
    return _stream!;
  }

  TriBit(this.worker, {T? initial, bool lazy = true})
      : state =
            initial != null ? TriState.data(initial) : TriState<T>.loading() {
    if (!lazy) _init();
  }

  void _emitState(TriState<T> state) {
    logger.t("TRIBIT: $runtimeType passing a new state");
    if (_streamController.isClosed) {
      logger.w("tried to emit a state within a closed tribit");
      return;
    }
    _streamController.add(state);
  }

  void dispose() => _streamController.close();

  void reload({bool silent = false}) {
    if (worker == null) return;
    if (!silent) emitLoading();
    worker!().then((v) => emit(v), onError: (e) => emitError(e));
  }

  void emit(T data) => _emitState(TriState.data(data));
  void emitLoading() => _emitState(TriState<T>.loading());
  void emitError(dynamic e) => _emitState(TriState.error(e));

  static B? maybeOf<B extends TriBit>(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<_TriInherited<B>>()
      ?.provider
      .value as B;

  static B of<B extends TriBit>(BuildContext context) =>
      maybeOf<B>(context) ??
      (throw Exception("cannot find a TriBit of type $B in the context"));
}
