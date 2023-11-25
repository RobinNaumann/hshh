import 'dart:math' as math;

import 'package:hshh/services/s_booking.dart';
import 'package:hshh/util/elbe_ui/elbe.dart';

class BookingCheckingView extends StatefulWidget {
  const BookingCheckingView({super.key});

  @override
  State<BookingCheckingView> createState() => _AnimatedBuilderExampleState();
}

/// AnimationControllers can be created with `vsync: this` because of
/// TickerProviderStateMixin.
class _AnimatedBuilderExampleState extends State<BookingCheckingView>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: BookingService.confirmDelay + const Duration(seconds: 1),
    vsync: this,
  )..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedBuilder(
          animation: _controller,
          builder: (BuildContext context, _) {
            return Center(
                child: CircularProgressIndicator(value: _controller.value));
          },
        ),
        const Text.h6(
          "Daten werden\ngeprüft",
          textAlign: TextAlign.center,
        )
      ].spaced(),
    );
  }
}
