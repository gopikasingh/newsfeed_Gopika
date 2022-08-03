import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:battery_plus/battery_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Device extends StatefulWidget {
  @override
  _DeviceState createState() => _DeviceState();
}

class _DeviceState extends State<Device> {
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic> _deviceData = <String, dynamic>{};
  final Battery _battery = Battery();

  BatteryState? _batteryState;
  StreamSubscription<BatteryState>? _batteryStateSubscription;
  int _batteryLevel = 0;
  late Timer timer;
  bool? _isInPowerSaveMode;

  @override
  void initState() {
    super.initState();
    initPlatformState();
    getBatteryState();
    Timer.periodic(const Duration(seconds: 5), (timer) {
      getBatteryLevel();
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (_batteryStateSubscription != null) {
      _batteryStateSubscription!.cancel();
    }
  }

  void getBatteryState() {
    _batteryStateSubscription =
        _battery.onBatteryStateChanged.listen((BatteryState state) {
          setState(() {
            _batteryState = state;
          });
        });
  }

  getBatteryLevel() async {
    final level = await _battery.batteryLevel;
    setState(() {
      _batteryLevel = level;
    });
  }



  Future<void> initPlatformState() async {
    var deviceData = <String, dynamic>{};

    try {
      if (Platform.isAndroid) {
        deviceData =
            _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
      } else if (Platform.isIOS) {
        deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
      }
    } on PlatformException {
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }

    if (!mounted) return;

    setState(() {
      _deviceData = deviceData;
    });
  }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{

      'Device OS':Platform.isAndroid
          ? 'Android Device Info'
          : Platform.isIOS
          ? 'iOS Device Info'
          : '',
      'Brand': build.brand,
      'Device': build.device,
      'Battery level':'$_batteryLevel',
      'Is Battery Charging': '$_batteryState',
    };
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    return <String, dynamic>{
      'Device OS':Platform.isAndroid
          ? 'Android Device Info'
          : Platform.isIOS
          ? 'iOS Device Info'
          : '',
      'Battery level':'$_batteryLevel',
      'Is Battery Charging': '$_batteryState',
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: ListView(
        children: _deviceData.keys.map(
              (String property) {
            return Row(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    property,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                      child: Text(
                        '${_deviceData[property]}',
                        maxLines: 10,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )),
              ],
            );
          },
        ).toList(),
      ),



    );



  }
}