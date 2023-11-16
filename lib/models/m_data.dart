import 'package:hshh/util/json_tools.dart';

abstract class DataModel {
  JsonMap<dynamic> get fields;

  const DataModel();

  @override
  String toString() => "$runtimeType$fields";

  @override
  int get hashCode => toString().hashCode;

  @override
  bool operator ==(Object other) => hashCode == other.hashCode;
}
