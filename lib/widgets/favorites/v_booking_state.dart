import 'package:hshh/services/s_booking.dart';
import 'package:hshh/util/elbe_ui/elbe.dart';
import 'package:hshh/util/tools.dart';
import 'package:hshh/widgets/util/p_web.dart';

import '../../util/tri/tribit/tribit.dart';

class _StateBit extends TriBit<String> {
  static const builder = TriBuilder<String, _StateBit>.make;

  _StateBit({required String bookingId, required String email})
      : super(() => BookingService.getConfirmation(bookingId, email));
}

class BookingStateView extends StatelessWidget {
  final String bookingId;
  final String email;

  const BookingStateView(
      {super.key, required this.bookingId, required this.email});

  @override
  Widget build(BuildContext context) {
    return TriProvider(
        create: (_) => _StateBit(bookingId: bookingId, email: email),
        child: _StateBit.builder(
          onError: (_, __) => Button(
              style: ColorStyles.minorAlertWarning,
              label: "vielleicht ungültig",
              icon: Icons.alertTriangle,
              onTap: () => showDialog(
                  context: context,
                  builder: (_) => AlertDialog.adaptive(
                        title: Row(
                            children: [
                          const Icon(Icons.alertTriangle),
                          const Expanded(
                              child: Text.h6("möglicherweise ungültig"))
                        ].spaced(amount: 0.5)),
                        content: const Text(
                            "Es konnte keine Bestätigung gefunden werden. Prüfe deine Netzwerkverbindung und deine Emails"),
                      ))),
          onData: (tribit, data) => Button(
              style: ColorStyles.minorAlertSuccess,
              label: "Bestätigung",
              icon: Icons.fileCheck,
              onTap: () => pushPage(
                  context,
                  HtmlPage(
                    html: data,
                    baseUrl: "https://buchung.hochschulsport-hamburg.de/",
                    title: "Bestätigung",
                  ))),
        ));
  }
}
