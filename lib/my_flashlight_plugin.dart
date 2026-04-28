// You have generated a new plugin project without specifying the `--platforms`
// flag. A plugin project with no platform support was generated. To add a
// platform, run `flutter create -t plugin --platforms <platforms> .` under the
// same directory. You can also find a detailed instruction on how to add
// platforms in the `pubspec.yaml` at
// https://flutter.dev/to/pubspec-plugin-platforms.

import 'my_flashlight_plugin_platform_interface.dart';

class MyFlashlightPlugin {
  Future<String?> getPlatformVersion() {
    return MyFlashlightPluginPlatform.instance.getPlatformVersion();
  }

  static Future<bool> isSupported() {
    return MyFlashlightPluginPlatform.instance.isSupported();
  }

  static Future<void> flashlightOn() async {
    await MyFlashlightPluginPlatform.instance.flashlightCommand(true);
  }

  static  Future<void> flashlightOff() async {
    await MyFlashlightPluginPlatform.instance.flashlightCommand(false);
  }

  static Future<void> flash(int delay) async {
    await MyFlashlightPluginPlatform.instance.flashlightCommand(true);
    await Future<void>.delayed(Duration(seconds: delay));
    await MyFlashlightPluginPlatform.instance.flashlightCommand(false);
  }
}
