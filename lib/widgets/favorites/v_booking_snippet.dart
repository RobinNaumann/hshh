import 'package:collection/collection.dart';
import 'package:hshh/models/m_booking_confirmation.dart';
import 'package:hshh/util/elbe_ui/elbe.dart';
import 'package:hshh/util/elbe_ui/src/util/unix_date.dart';
import 'package:hshh/widgets/favorites/v_booking_state.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../services/d_institutions.dart';

class BookingSnippet extends StatelessWidget {
  final BookingConfirmation booking;
  final Function()? onDelete;
  const BookingSnippet({super.key, required this.booking, this.onDelete});

  Widget _personView() {
    final instId = booking.profileInst;
    final inst = Institution.list.firstWhereOrNull((e) => e.id == instId);

    return Row(
        children: [
      Icon(inst?.type.icon ?? Icons.helpCircle),
      Expanded(
          child: Text(
        booking.profileName ?? "kein Name verfügbar",
        variant: TypeVariants.bold,
      )),
    ].spaced(amount: 0.6, vertical: false));
  }

  @override
  Widget build(BuildContext context) {
    print(booking.bookingId);
    final noTitle = (booking.courseName?.trim() ?? "") == "";
    final starttime = booking.starttime != null
        ? DateFormat("HH:mm").format(UnixDate.parse(booking.starttime!))
        : null;
    final endtime = booking.endtime != null
        ? DateFormat("HH:mm").format(UnixDate.parse(booking.endtime!))
        : null;

    return Card(
        state: booking.isInPast ? ColorStates.disabled : null,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text.h6(booking.groupName),
                      const Spaced.vertical(0.2),
                      Text.bodyM(
                          noTitle ? "Angebot ohne Name" : booking.courseName!,
                          colorState: noTitle ? ColorStates.disabled : null,
                          variant: TypeVariants.bold),
                    ],
                  ),
                ),
                const Spaced(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text.h6(
                      (booking.starttime != null
                          ? DateFormat("E d.M", "de_DE")
                              .format(UnixDate.parse(booking.starttime!))
                          : "kein Datum"),
                    ),
                    Text.bodyS("${starttime ?? '?'} - ${endtime ?? '?'}",
                        variant: TypeVariants.bold),
                  ],
                ),
              ],
            ),
            const Spaced(),
            _personView(),
            const Spaced.vertical(2),
            Row(
              children: [
                booking.isInPast
                    ? const Text.bodyM("(ist in Vergangenheit)",
                        variant: TypeVariants.boldItalic)
                    : BookingStateView(
                        email: booking.profileEmail,
                        bookingId: booking.bookingId),
                const Expanded(child: Spaced.zero),
                //IconButton.integrated(icon: Icons.logOut),
                IconButton.integrated(icon: Icons.trash, onTap: onDelete),
              ],
            ),
          ],
        ));
  }
}
