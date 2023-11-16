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

  @override
  Widget build(BuildContext context) {
    final bit = TriBit.of<T, B>(context);

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
    Center(child: TriErrorView(tribit: bit, error: error));

Widget triLoadingView(TriBit bit) => const Center(
    child: Padding(
        padding: EdgeInsets.all(10),
        child: CircularProgressIndicator.adaptive()));
