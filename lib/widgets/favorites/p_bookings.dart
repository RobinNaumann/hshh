import 'package:hshh/bits/c_bookings.dart';
import 'package:hshh/util/elbe_ui/elbe.dart';
import 'package:hshh/util/extensions/maybe_map.dart';
import 'package:hshh/util/tools.dart';
import 'package:hshh/util/tri/tribit/tribit.dart';

import '../../util/elbe_ui/confirm_dialog.dart';
import 'v_booking_snippet.dart';

class BookingsPage extends StatefulWidget {
  const BookingsPage({super.key});

  @override
  State<BookingsPage> createState() => _BookingsPageState();
}

class _BookingsPageState extends State<BookingsPage> {
  bool showInPast = false;
  @override
  Widget build(BuildContext context) {
    return TriProvider(
      create: (_) => BookingsBit(),
      child: Scaffold(
          actions: [
            IconButton.integrated(
                icon: showInPast ? Icons.eye : Icons.eyeOff,
                onTap: () {
                  showSnackbar(context,
                      "Vergangene Buchungen ${showInPast ? 'versteckt' : 'angezeigt'}");
                  setState(() => showInPast = !showInPast);
                })
          ],
          leadingIcon: const LeadingIcon.back(),
          title: "Buchungen",
          body: Padded.all(
              child: BookingsBit.builder(
                  onData: (bit, bs) => bs.isEmpty
                      ? const CenterMessage(
                          icon: Icons.sparkles,
                          message: "keine Buchungen\ngefunden")
                      : ListView(
                          children: bs
                              .where((e) => showInPast ? true : !e.isInPast)
                              .map((e) => BookingSnippet(
                                    booking: e,
                                    onDelete: () => showConfirmDialog(context,
                                        title: "nur aus App löschen",
                                        text:
                                            "Die Buchung wird nur aus der App gelöscht. Beim HsHH kann sie über die Email freigegeben werden.",
                                        confirmLabel: "löschen",
                                        onConfirm: () =>
                                            bit.delete(e.bookingId)),
                                  ))
                              .spaced())))),
    );
  }
}
