import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:battery_plus/battery_plus.dart';
import 'package:battery_info/battery_info_plugin.dart';
import 'package:battery_info/model/android_battery_info.dart';

class Device extends StatefulWidget {
  @override
  _DeviceState createState() => _DeviceState();
}

class _DeviceState extends State<Device> {
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic> _deviceData = <String, dynamic>{};
  StreamSubscription<BatteryState>? _batteryStateSubscription;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    initPlatformState();

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
    };
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    return <String, dynamic>{
      'Device OS':Platform.isAndroid
          ? 'Android Device Info'
          : Platform.isIOS
          ? 'iOS Device Info'
          : '',
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: ListView(
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
          ),

          StreamBuilder<AndroidBatteryInfo?>(
              stream: BatteryInfoPlugin().androidBatteryInfoStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return
                    Expanded(
                    flex: 7,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                  "Charging status  ",style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),),
                              Text("${(snapshot.data?.chargingStatus.toString().split(".")[1])}")
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Text(
                                "Battery Level  ",style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),),
                              Text(
                                  "${(snapshot.data?.batteryLevel)} %"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return CircularProgressIndicator();
              }
          )
        ],
      ),
    );
  }
}