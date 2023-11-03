import 'package:flutter/material.dart';
import 'package:hshh/cubits/c_booking_data.dart';
import 'package:hshh/util/extensions/widget_list.dart';
import 'package:hshh/widgets/booking_page/v_booking_form.dart';
import 'package:hshh/widgets/booking_page/v_booking_offer.dart';
import 'package:hshh/widgets/profiles/profile_list/v_profile_list.dart';

class BookingPage extends StatelessWidget {
  final String dateId;
  final String sessionId;
  const BookingPage({super.key, required this.dateId, required this.sessionId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: Text(dateId)),
        body: BookingDataCubit.provider(
            cubit: BookingDataCubit(dateId, sessionId),
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ListView(
                    children: [
                  const BookingOfferView(),
                  const SizedBox(height: 20),
                  ProfileListView()
                  //const BookingFormView()
                ].spaced()))));
  }
}
