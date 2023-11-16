part of 'tribit.dart';

class TriProvider<T, B extends TriBit<T>> extends StatefulWidget {
  final B? value;
  final B Function(BuildContext context)? create;
  final Widget child;

  const TriProvider(
      {super.key,
      required B Function(BuildContext context) this.create,
      required this.child})
      : value = null;

  const TriProvider.value({super.key, required this.value, required this.child})
      : create = null;

  @override
  createState() => _TriProviderState<T, B>();
}

class _TriProviderState<T, B extends TriBit<T>>
    extends State<TriProvider<T, B>> {
  late B? _value = widget.value;

  B get value => _value ?? (_value = widget.create!(context));

  @override
  void dispose() {
    // only dispose the TriBit if this is the creating provider
    if (widget.value == null) _value?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      _TriInherited<T, B>(provider: this, child: widget.child);
}

class _TriInherited<T, B extends TriBit<T>> extends InheritedWidget {
  final _TriProviderState<T, B> provider;

  const _TriInherited({required this.provider, required Widget child})
      : super(child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}
