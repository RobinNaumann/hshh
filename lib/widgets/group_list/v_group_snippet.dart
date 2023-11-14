import 'package:hshh/widgets/home/v_card_icon.dart';

import '../../models/m_course.dart';
import '../../util/elbe_ui/elbe.dart';
import '../group_page/p_course_group.dart';

class GroupSnippet extends StatelessWidget {
  final CourseGroup group;

  const GroupSnippet({super.key, required this.group});

  String _courseCount(int c) => c == 0 ? "" : "$c Kurs${c == 1 ? '' : 'e'}";

  Widget _cardType() => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (group.flexicard) const CardIcon.flexi(),
          if (group.swimcard) const CardIcon.swim(),
        ].spaced(vertical: false, amount: 0.5),
      );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CourseGroupPage(group: group)),
      ),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text.h6(group.name),
            Row(
              children: [
                Expanded(child: Text(_courseCount(group.courses.length))),
                Expanded(child: _cardType())
              ].spaced(),
            )
          ].spaced(),
        ),
      ),
    );
  }
}
