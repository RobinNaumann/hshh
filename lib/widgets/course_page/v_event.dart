import 'package:hshh/bits/c_courses.dart';
import 'package:hshh/models/m_course.dart';
import 'package:hshh/util/tri/tribit/tribit.dart';
import 'package:hshh/widgets/course_page/v_event_map.dart';

import '../../util/elbe_ui/elbe.dart';

class EventView extends StatelessWidget {
  final CourseEvent event;
  const EventView({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final location = context.bit<CoursesBit>().getLocation(event.locationId);

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text.h6(CoursesBit.getWeekday(event.weekday, withS: true) ?? "--"),
          Text(event.timespan.trim()),
          const Spaced.vertical(1),
          EventMapView(location: location),
        ],
      ),
    );
  }
}
