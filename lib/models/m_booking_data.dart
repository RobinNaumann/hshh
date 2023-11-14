import 'package:hshh/services/d_institutions.dart';
import 'package:html/dom.dart';

class BookingData {
  final Map<String, String> offer;
  final Element offerHtml;
  final List<InputField> fields;
  final List<Institution> institutions;

  const BookingData(
      {required this.offer,
      required this.offerHtml,
      required this.fields,
      required this.institutions});
}

class InputField {
  final String id;
  final String label;
  final String? type;

  const InputField({required this.id, required this.label, this.type});
}
