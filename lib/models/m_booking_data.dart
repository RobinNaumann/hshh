import 'package:hshh/models/m_data.dart';
import 'package:hshh/services/d_institutions.dart';
import 'package:hshh/util/json_tools.dart';
import 'package:html/dom.dart';

class BookingData extends DataModel {
  final Map<String, String> offer;
  final Element offerHtml;
  final List<InputField> inputFields;
  final List<Institution> institutions;

  const BookingData(
      {required this.offer,
      required this.offerHtml,
      required this.inputFields,
      required this.institutions});

  @override
  get fields => {
        "offer": offer,
        "offerHtml": offerHtml,
        "inputFields": inputFields,
        "institutions": institutions
      };
}

class InputField extends DataModel {
  final String id;
  final String label;
  final String? type;

  const InputField({required this.id, required this.label, this.type});

  @override
  get fields => {"id": id, "label": label, "type": type};
}
