import 'package:expense_manager/main.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Permissions extends StatefulWidget {
  const Permissions({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PermissionsState();
}

class _PermissionsState extends State<Permissions> {
  PermissionStatus _permissionStatus = PermissionStatus.denied;

  @override
  void initState() {
    super.initState();
    _requestForPermissionStatus();
  }

  void _requestForPermissionStatus() async {
    final status = await Permission.sms.request();
    setState(() => _permissionStatus = status);
    if(status.isGranted) {
      await _goToHomeScreen();
    }
  }

  Future<void> _askPermission() async {
    if (!_permissionStatus.isGranted) {
      await openAppSettings();
    } else {
      await _goToHomeScreen();
    }
  }

  Future<void> _goToHomeScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('seen', true);
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const App()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text('Please provide Permissions'),
            MaterialButton(
              child: const Text('Allow Permissions'),
              onPressed: () {
                _askPermission();
              },
            )
          ],
        ),
      ),
    );
  }
}
