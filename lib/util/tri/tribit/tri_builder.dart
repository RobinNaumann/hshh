part of 'tribit.dart';

class TriBuilder<T, B extends TriBit<T>> extends StatelessWidget {
  final Widget Function(B tribit)? onLoading;
  final Widget Function(B tribit, dynamic error)? onError;
  final Widget Function(B tribit, T data) onData;
  final bool small;
  const TriBuilder(
      {super.key,
      this.onLoading,
      this.onError,
      required this.onData,
      this.small = false});

  factory TriBuilder.make(
          {Key? key,
          Widget Function(B tribit)? onLoading,
          Widget Function(B tribit, dynamic error)? onError,
          required Widget Function(B tribit, T data) onData,
          bool small = false}) =>
      TriBuilder(
          key: key,
          onLoading: onLoading,
          onError: onError,
          onData: onData,
          small: small);

  @override
  Widget build(BuildContext context) {
    final bit = TriBit.of<B>(context);

    return StreamBuilder<TriState<T>>(
        initialData: bit.state,
        stream: bit.stream,
        builder: (c, s) {
          final state = s.data!;
          return state.when(
              onLoading: () =>
                  onLoading?.call(bit) ??
                  (small ? triEmptyView() : triLoadingView(bit)),
              onError: (e) =>
                  onError?.call(bit, e) ??
                  (small ? triEmptyView() : triErrorView(bit, e)),
              onData: (d) => onData(bit, d));
        });
  }
}

Widget triEmptyView() => const SizedBox.shrink();

Widget triErrorView(TriBit bit, dynamic error) =>
    Center(child: TriErrorView(bit: bit, error: error));

Widget triLoadingView(TriBit bit) => const Center(
    child: Padding(
        padding: EdgeInsets.all(10),
        child: CircularProgressIndicator.adaptive()));
