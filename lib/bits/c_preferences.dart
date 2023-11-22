import 'package:hshh/models/m_data.dart';
import 'package:hshh/services/s_booking.dart';
import 'package:hshh/services/s_storage.dart';
import 'package:hshh/util/elbe_ui/src/theme/themes/color/color_theme_data.dart';
import 'package:hshh/util/json_tools.dart';
import 'package:hshh/util/tri/tribit/tribit.dart';

class Preferences extends DataModel {
  final ColorThemeMode? themeMode;

  const Preferences({this.themeMode});

  copyWith({ColorThemeMode? Function()? themeMode}) => Preferences(
      themeMode: themeMode != null ? themeMode.call() : this.themeMode);

  factory Preferences.fromMap(JsonMap map) =>
      Preferences(themeMode: _parseMode(map));

  static ColorThemeMode? _parseMode(JsonMap map) {
    const modes = ColorThemeMode.values;
    int? val = map["themeMode"];
    if (val == null || val.isNegative || val > modes.length) return null;
    return modes[val];
  }

  @override
  get map => {"themeMode": themeMode?.index};
}

class PreferencesBit extends TriBit<Preferences> {
  static const builder = TriBuilder<Preferences, PreferencesBit>.make;

  PreferencesBit() : super(() => StorageService.getPreferences());

  void _emitChanged(Preferences p) async {
    await StorageService.setPreferences(p);
    emit(p);
  }

  void setThemeMode(ColorThemeMode? mode) => state.whenOrNull(
      onData: (d) => _emitChanged(d.copyWith(themeMode: () => mode)));
}
