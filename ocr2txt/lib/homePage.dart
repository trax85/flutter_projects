import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';

import 'textPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State createState() {
    return _HomePageState();
  }
}


class _HomePageState extends State<HomePage>{
  String _val = 'Scanned text to be displayed here';
  String _versionInfo = '';
  XFile? _imageFile;

  @override
  void initState() {

    initVer();
    super.initState();
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

  void _getImgPath() async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        _imageFile = pickedImage;
        setState(() {});
        getRecognisedText(pickedImage);
      }
    } catch (e) {
      _val = "Error occured while scanning";
      setState(() {});
    }
  }

  void getRecognisedText(XFile image) async {
    final inputImage = InputImage.fromFilePath(image.path);
    final textDetector = GoogleMlKit.vision.textDetector();
    String str = "";
    RecognisedText recognisedText = await textDetector.processImage(inputImage);
    await textDetector.close();

    for (TextBlock block in recognisedText.blocks) {
      for (TextLine line in block.lines) {
        str = "$str${line.text}\n";
      }
    }
    setState(() {
      _val = str;
    });
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => textPage(_val)));
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("OCR Scanner v$_versionInfo"),
        centerTitle:true,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 300,),
            ElevatedButton(
              onPressed: () {
                _getImgPath();
                },
              child: const Text("Scan OCR"),
            ),
            //Text(_val),
          ],
        ),
      ),
    );
  }
}