import 'package:hshh/models/m_data.dart';
import 'package:hshh/services/s_storage.dart';
import 'package:hshh/util/elbe_ui/elbe.dart';
import 'package:hshh/util/json_tools.dart';
import 'package:hshh/util/tri/tribit/tribit.dart';

class Preferences extends DataModel {
  final ColorModes? themeMode;
  final bool launchMessageAccepted;

  const Preferences({this.themeMode, this.launchMessageAccepted = false});

  Preferences copyWith(
          {ColorModes? Function()? themeMode, bool? launchMessageAccepted}) =>
      Preferences(
          themeMode: themeMode != null ? themeMode.call() : this.themeMode,
          launchMessageAccepted:
              launchMessageAccepted ?? this.launchMessageAccepted);

  factory Preferences.fromMap(JsonMap map) => Preferences(
      themeMode: _parseMode(map),
      launchMessageAccepted: map.maybeCast("launchMessageAccepted") ?? false);

  static ColorModes? _parseMode(JsonMap map) {
    const modes = ColorModes.values;
    int? val = map["themeMode"];
    if (val == null || val.isNegative || val > modes.length) return null;
    return modes[val];
  }

  @override
  get map => {
        "themeMode": themeMode?.index,
        "launchMessageAccepted": launchMessageAccepted
      };
}

class PreferencesBit extends TriBit<Preferences> {
  static const builder = TriBuilder<Preferences, PreferencesBit>.make;
  static const notifier = TriNotifier<Preferences, PreferencesBit>.make;

  PreferencesBit() : super(() => StorageService.getPreferences());

  void _emitChanged(Preferences p) async {
    await StorageService.setPreferences(p);
    emit(p);
  }

  void setLaunchMessageAccepted(bool v) => state.whenOrNull(
      onData: (d) => _emitChanged(d.copyWith(launchMessageAccepted: v)));

  void setColorMode(ColorModes? mode) => state.whenOrNull(
      onData: (d) => _emitChanged(d.copyWith(themeMode: () => mode)));
}
