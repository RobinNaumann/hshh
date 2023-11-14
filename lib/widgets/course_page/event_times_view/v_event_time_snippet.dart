import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hshh/cubits/c_event_times.dart';
import 'package:hshh/models/m_event_time.dart';
import 'package:hshh/util/extensions/maybe_map.dart';
import 'package:hshh/util/tools.dart';
import 'package:hshh/widgets/booking_page/p_booking_data.dart';
import 'package:intl/intl.dart';

import '../../../util/elbe_ui/elbe.dart';

class EventTimeSnippet extends StatelessWidget {
  final EventTime eventTime;

  const EventTimeSnippet({super.key, required this.eventTime});

  String _dayHint(DateTime e) {
    final n = DateTime.now();
    final dDiff = DateTime(e.year, e.month, e.day)
        .difference(DateTime(n.year, n.month, n.day))
        .inDays;

    if (dDiff == 1) return "   (morgen)";
    if (dDiff == 2) return "   (übermorgen)";

    return "";
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: eventTime.state.isBookable ? const RemInsets(bottom: 1) : null,
        style: eventTime.state.isBookable
            ? ColorStyles.minorAccent
            : (eventTime.state.isWaitinglist
                ? ColorStyles.minorAlertWarning
                : null),
        state: eventTime.state.isClosed ? ColorStates.disabled : null,
        onTap: () => eventTime.state.isBookable
            ? pushPage(
                context,
                BookingDataPage(
                    dateId: eventTime.bookingId!,
                    sessionId: context.read<EventTimesCubit>().sessionId))
            : null,
        child: Row(
          children: [
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                        DateFormat("EEEE, d.M.yy", "de_DE")
                            .format(eventTime.start)
                            .add(_dayHint(eventTime.start)),
                        variant: TypeVariants.bold),
                    Text(
                        "${DateFormat("HH:mm").format(eventTime.start)} - ${DateFormat("HH:mm").format(eventTime.start)}"),
                    if (!eventTime.state.isClosed)
                      Padded.only(
                          top: 1,
                          child: Text(
                              (eventTime.state.isWaitinglist
                                      ? "Warteliste"
                                      : "buchen")
                                  .toUpperCase(),
                              style: TypeStyles.bodyS,
                              variant: TypeVariants.bold))
                  ].spaced(amount: 0.3)),
            ),
            if (!eventTime.state.isClosed)
              Icon(eventTime.state.isWaitinglist
                  ? Icons.scrollText
                  : Icons.arrowRight)
          ],
        ));
  }
}
