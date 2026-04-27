package com.example.my_flashlight_plugin

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** MyFlashlightPlugin */
class MyFlashlightPlugin :
    FlutterPlugin,
    MethodCallHandler {
    // The MethodChannel that will the communication between Flutter and native Android
    //
    // This local reference serves to register the plugin with the Flutter Engine and unregister it
    // when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "my_flashlight_plugin")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(
        call: MethodCall,
        result: Result
    ) {
        if (call.method == "flashlightCommand") {
            val isOn = call.argument<Boolean>("isOn") ?: false

            val cameraManager = context.getSestemService(Context.CAMERA_SERVICE) as CameraManager

            for (cameraId in cameraManager.cameraIdList) {
                val characteristics = cameraManager.getCameraCharacteristics(cameraId)
                val hasFlash = characteristics.get(
                    android.hardware.camera2.CameraCharacteristics.FLASH_INFO_AVAILABLE
                ) == true

                if (hasFlash) {
                    cameraManager.setTorchMode(cameraId, isOn)
                    break
                }
            }

            result.success(null)
        } else {
            result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
