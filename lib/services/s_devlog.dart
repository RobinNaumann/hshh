import 'package:countly_flutter/countly_flutter.dart';
import 'package:hshh/util/json_tools.dart';

class DevLog {
  static final _config = CountlyConfig(
      "https://hshh-797ecd0432c71.flex.countly.com",
      "e419262c1257251462fefd94ced6a6d4888dfd00");

  static Future<void> init() async {
    /*final isInitialized = await Countly.isInitialized();

    if (isInitialized) return;

    CountlyConfig config = _config;
    config.enableCrashReporting();
    config.setRequiresConsent(true);
    await Countly.initWithConfig(config);
    Countly.giveConsent(["crashes", "views", "events"]);
    //Countly.appLoadingFinished();*/
  }

  static view(String name, [JsonMap? parameters]) =>
      null; //Countly.instance.views.startView(name);

  static giveExtendedConsent() =>
      null; //Countly.giveConsent(["location", "sessions"]);

  static event(String key, [JsonMap? parameters]) =>
      null; //Countly.recordEvent({"key": key, ...?parameters});

  static error(dynamic e, [StackTrace? t]) =>
      null; //Countly.recordDartError(e, t ?? StackTrace.empty);
}
