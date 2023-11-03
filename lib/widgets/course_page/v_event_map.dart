import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hshh/models/m_course.dart';
import 'package:hshh/util/tools.dart';
// ignore: depend_on_referenced_packages
import 'package:latlong2/latlong.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:maps_launcher/maps_launcher.dart';

class EventMapView extends StatelessWidget {
  final EventLocation location;
  const EventMapView({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: boxDeco,
      child: Column(
        children: [
          AspectRatio(
              aspectRatio: 1.7,
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(10)),
                child: FlutterMap(
                    options: MapOptions(
                        initialCenter: LatLng(location.lat, location.long)),
                    children: [
                      TileLayer(
                        urlTemplate:
                            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'dev.fleaflet.flutter',
                      ),
                      MarkerLayer(
                        markers: [
                          Marker(
                            point: LatLng(location.lat, location.long),
                            width: 35,
                            height: 35,
                            alignment: Alignment.topCenter,
                            child:
                                const Icon(Icons.location_on_rounded, size: 35),
                          ),
                        ],
                      ),
                    ]),
              )),
          InkWell(
            onTap: () =>
                MapsLauncher.launchCoordinates(location.lat, location.long),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  Expanded(child: Text(location.name)),
                  const SizedBox(width: 10),
                  const Icon(LucideIcons.externalLink)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
