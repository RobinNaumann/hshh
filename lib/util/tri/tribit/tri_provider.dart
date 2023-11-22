part of 'tribit.dart';

class TriProvider<B extends TriBit> extends StatefulWidget {
  final B? value;
  final B Function(BuildContext context)? create;
  final Widget? child;

  const TriProvider(
      {super.key,
      required B Function(BuildContext context) this.create,
      required this.child})
      : value = null;

  const TriProvider.value({super.key, required this.value, required this.child})
      : create = null;

  const TriProvider.adaptive(
      {super.key,
      required this.value,
      required this.create,
      required this.child});

  @override
  createState() => _TriProviderState<B>();
}

class _TriProviderState<B extends TriBit> extends State<TriProvider<B>> {
  late B? _value = widget.value;

  B get value => _value ?? (_value = widget.create!(context));

  @override
  initState() {
    logger.t("TRIBIT: open  ${widget.runtimeType}");
    super.initState();
  }

  @override
  dispose() {
    logger.t("TRIBIT: close ${widget.runtimeType}");
    // only dispose the TriBit if this is the creating provider
    if (widget.value == null) _value?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      _TriInherited<B>(provider: this, child: widget.child ?? Spaced.zero);
}

class _TriInherited<B extends TriBit> extends InheritedWidget {
  final _TriProviderState provider;

  const _TriInherited({required this.provider, required Widget child})
      : super(child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}
