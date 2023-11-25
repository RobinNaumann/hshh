part of 'tribit.dart';

class TriNotifier<T, B extends TriBit<T>> extends StatefulWidget {
  final Function(B tribit)? onLoading;
  final Function(B tribit, dynamic error)? onError;
  final Function(B tribit, T data)? onData;
  final Widget child;
  const TriNotifier(
      {super.key,
      this.onLoading,
      this.onError,
      this.onData,
      required this.child});

  factory TriNotifier.make(
          {Key? key,
          Function(B tribit)? onLoading,
          Function(B tribit, dynamic error)? onError,
          Function(B tribit, T data)? onData,
          required Widget child}) =>
      TriNotifier(
          key: key,
          onLoading: onLoading,
          onError: onError,
          onData: onData,
          child: child);

  @override
  State<TriNotifier<T, B>> createState() => _TriNotifierState<T, B>();
}

class _TriNotifierState<T, B extends TriBit<T>>
    extends State<TriNotifier<T, B>> {
  StreamSubscription? streamSub;

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _init());
  }

  _init() {
    if (streamSub != null) return;
    final bit = TriBit.of<B>(context);
    streamSub = bit.stream.listen((e) => _notify(bit, e));
    _notify(bit, bit.state);
  }

  _notify(B bit, TriState<T> s) => s.when(
      onLoading: () => widget.onLoading?.call(bit),
      onError: (e) => widget.onError?.call(bit, e),
      onData: (d) => widget.onData?.call(bit, d));

  @override
  void dispose() {
    streamSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
