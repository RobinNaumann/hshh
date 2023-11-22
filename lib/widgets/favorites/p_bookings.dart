import 'package:hshh/bits/c_bookings.dart';
import 'package:hshh/util/elbe_ui/elbe.dart';
import 'package:hshh/util/extensions/maybe_map.dart';
import 'package:hshh/util/tri/tribit/tribit.dart';

import '../../util/elbe_ui/confirm_dialog.dart';
import 'v_booking_snippet.dart';

class BookingsPage extends StatelessWidget {
  const BookingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TriProvider(
      create: (_) => BookingsBit(),
      child: Scaffold(
          leadingIcon: const LeadingIcon.back(),
          title: "Buchungen",
          body: Padded.all(
              child: BookingsBit.builder(
                  onData: (bit, bs) => ListView(
                      children: bs.listMap((e) => BookingSnippet(
                            booking: e,
                            onDelete: () => showConfirmDialog(context,
                                title: "nur aus App löschen",
                                text:
                                    "Die Buchung wird nur aus der App gelöscht. Beim HsHH kann sie über die Email freigegeben werden.",
                                confirmLabel: "löschen",
                                onConfirm: () => bit.delete(e.bookingId)),
                          )))))),
    );
  }
}
