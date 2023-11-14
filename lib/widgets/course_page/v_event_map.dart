import 'package:hshh/models/m_course.dart';
import 'package:hshh/util/elbe_ui/elbe.dart';
// ignore: depend_on_referenced_packages
import 'package:maps_launcher/maps_launcher.dart';

class EventMapView extends StatelessWidget {
  final EventLocation? location;
  const EventMapView({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    return location == null
        ? const Center(
            child: Text("Entnimm den Ort\nder Beschreibung",
                textAlign: TextAlign.center))
        : InkWell(
            onTap: () =>
                MapsLauncher.launchCoordinates(location!.lat, location!.long),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child: Text(location!.name, variant: TypeVariants.bold)),
                const SizedBox(width: 10),
                const Icon(
                  Icons.map,
                  style: TypeStyles.bodyS,
                )
              ].spaced(amount: 0.5),
            ),
          );
  }
}
