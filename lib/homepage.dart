import 'package:flutter/material.dart';
import 'scanpage.dart';
import 'package:package_info_plus/package_info_plus.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage>{
  String _val = 'Here is the text to be displayed';
  String _versionInfo = '';

  @override
  void initState() {
    super.initState();
    initVer();
  }

  //Initialise the app version number to be displayed in appbar
  Future<void> initVer() async {
    try{
      PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
        String version = packageInfo.version;
        String buildNumber = packageInfo.buildNumber;
        setState(() {
          _versionInfo = "$version+$buildNumber";
        });
      });
    } on Exception {
      _versionInfo = "v0";
    }
  }

  Future<void> scanQR(BuildContext context) async {
    String result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => const ScanPage())
    );
    if(!mounted) return;
    setState(() {
      _val = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("QR Scanner v$_versionInfo"),
          centerTitle:true,
        ),
        body: Center(
          child: Column(
            children: [
              const SizedBox(height: 300,),
              ElevatedButton(
                  onPressed: () => scanQR(context),
                  child: const Text("Scan QR"),
              ),
              Text(_val),
            ],
          ),
        ),
    );
  }
}
