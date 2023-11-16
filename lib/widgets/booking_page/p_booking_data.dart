import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hshh/cubits/c_booking_data.dart';
import 'package:hshh/services/s_booking.dart';
import 'package:hshh/util/elbe_ui/elbe.dart';
import 'package:hshh/util/extensions/maybe_map.dart';
import 'package:hshh/util/tools.dart';
import 'package:hshh/util/tri/tri_cubit.dart';
import 'package:hshh/widgets/booking_page/p_booking_confirm.dart';
import 'package:hshh/widgets/booking_page/v_booking_offer.dart';
import 'package:hshh/widgets/profiles/profile_list/v_profile_list.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../cubits/c_profiles.dart';

class BookingDataPage extends StatelessWidget {
  final String sessionId;
  final String dateId;

  const BookingDataPage(
      {super.key, required this.dateId, required this.sessionId});

  static Widget actionBase({required Widget child}) => Card(
      padding: const RemInsets.fromLTRB(1, 1.5, 1, 1),
      scheme: ColorSchemes.secondary,
      border: const Border(
          borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
          style: BorderStyle.none),
      child: child);

  @override
  Widget build(context) => TriProvider(
      cubit: (_) => BookingDataCubit(dateId, sessionId),
      child: const _BookingDataPage());
}

class _BookingDataPage extends StatefulWidget {
  const _BookingDataPage();

  @override
  State<_BookingDataPage> createState() => _BookingDataPageState();
}

class _BookingDataPageState extends State<_BookingDataPage> {
  bool termsAccepted = false;
  int? profileId; // = 0;

  @override
  void initState() {
    super.initState();
  }

  bool isValid() => termsAccepted && profileId != null;

  void _book(Map<int, Profile> profiles, BookingDataCubit c) async {
    final p = profiles.maybe(profileId!);
    if (p == null) {
      showSnackbar(context, "Dieses Profil ist nicht gültig.");
      setState(() => profileId = null);
      return;
    }
    pushPage(
        context,
        BookingConfirmPage(
            data: BookingReqData(
                sessionId: c.sessionId, dateId: c.dateId, profile: p)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        leadingIcon: const LeadingIcon.back(),
        title: "buchen",
        body: Column(
          children: [
            Expanded(
              child: Padded.all(
                  child: ListView(
                      clipBehavior: Clip.none,
                      children: [
                        const AnimatedSize(
                            alignment: Alignment.topCenter,
                            duration: Duration(milliseconds: 400),
                            child: BookingOfferView()),
                        const Title.h5("Person"),
                        ProfileListView(
                            selectedId: profileId,
                            onPressed: (id, p) =>
                                setState(() => profileId = id))
                        //const BookingFormView()
                      ].spaced())),
            ),
            ProfilesCubit.builder(
              onLoading: (_) => Spaced.zero,
              onData: (cubit, profiles) {
                return BookingDataPage.actionBase(
                    child: Column(
                  children: [
                    _TermsCheckbox(
                        value: termsAccepted,
                        onChanged: (v) => setState(() => termsAccepted = v)),
                    Button.major(
                        onTap: isValid()
                            ? () => _book(
                                profiles, context.read<BookingDataCubit>())
                            : null,
                        icon: Icons.arrowRight,
                        label: "prüfen"),
                  ].spaced(),
                ));
              },
            )
          ],
        ));
  }
}

class _TermsCheckbox extends StatelessWidget {
  final bool value;
  final Function(bool) onChanged;
  const _TermsCheckbox({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final scheme = ColorTheme.of(context).activeScheme;
    final accent = scheme.minorAccent.neutral.front;
    final neutral = scheme.plain.neutral.front;
    return Row(
      children: [
        Checkbox(
            checkColor: scheme.majorAccent.neutral.front,
            activeColor: scheme.majorAccent.neutral.back,
            value: value,
            onChanged: (v) => v != null ? onChanged(v) : null),
        Expanded(
            child: RichText(
                text: TextSpan(
          children: [
            TextSpan(
              text: 'Mit der Anmeldung akzeptieren Sie die ',
              style: TextStyle(color: neutral),
            ),
            TextSpan(
              text:
                  'Allgemeinen Geschäftsbedingungen (AGB) des Hochschulsports Hamburg.',
              style: TextStyle(color: accent),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  launchUrlString(
                      'https://www.hochschulsport.uni-hamburg.de/informationen/agb.html');
                },
            ),
          ],
        )))
      ].spaced(amount: 0.3),
    );
  }
}
