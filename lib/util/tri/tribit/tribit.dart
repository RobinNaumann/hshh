import 'dart:async';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:hshh/util/tools.dart';

import './tristate.dart';
import 'v_tri_error.dart';

part 'tri_provider.dart';
part 'tri_builder.dart';

class TriBit<T> {
  final Future<T> Function() worker;
  TriState<T> state = TriState<T>.loading();

  final _streamController = StreamController<TriState<T>>();
  Stream<TriState<T>>? _stream;

  Stream<TriState<T>> get stream => _stream != null ? _stream! : _init();

  Stream<TriState<T>> _init() {
    _stream = _streamController.stream.asBroadcastStream();
    _stream!.listen((e) => state = e);
    reload();
    return _stream!;
  }

  TriBit({required this.worker, bool lazy = true}) {
    if (!lazy) _init();
  }

  void _emitState(TriState<T> state) {
    if (_streamController.isClosed) {
      logger.w("tried to emit a state within a closed tribit");
    }
    _streamController.add(state);
  }

  void dispose() => _streamController.close();

  void reload({bool silent = false}) {
    if (!silent) emitLoading();
    worker().then((v) => emit(v), onError: (e) => emitError(e));
  }

  void emit(T data) => _emitState(TriState.data(data));
  void emitLoading() => _emitState(TriState<T>.loading());
  void emitError(dynamic e) => _emitState(TriState.error(e));

  static B? maybeOf<T, B extends TriBit<T>>(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<_TriInherited<T, B>>()
      ?.provider
      .value;

  static B of<T, B extends TriBit<T>>(BuildContext context) =>
      maybeOf<T, B>(context) ??
      (throw Exception("cannot find a TriBit of type $B in the context"));
}
