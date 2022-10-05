import 'package:flutter/material.dart';
import 'package:flutter_mobile_vision_2/flutter_mobile_vision_2.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State createState() {
    return _HomePageState();
  }
}


class _HomePageState extends State<HomePage>{
  String _val = ' ';
  final int _ocrCamera = FlutterMobileVision.CAMERA_BACK;

  @override
  void initState() {
    super.initState();
    FlutterMobileVision.start().then((x) => setState(() {}));
  }

  Future<void> scanOCR() async {
    List<OcrText> texts = [];
    try {
      texts = await FlutterMobileVision.read(
        multiple: true,
        camera: _ocrCamera,
        waitTap: false,
        preview: FlutterMobileVision.PREVIEW,
      );
      setState(() {
        _val = '';
        for(var i = 0; i < texts.length; i++) {
          _val += texts[i].value;
        }
      });
    } on Exception {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Failed to recognise text"),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: const Text("BarCode Scanner"),
          centerTitle:true,
        ),
        body: Center(
          child: Column(
            children: [
              const SizedBox(height: 300,),
              ElevatedButton(
                  onPressed: () => scanOCR(),
                  child: const Text("Scan OCR"),
              ),
              Text(_val),
            ],
          ),
        ),
    );
  }
}
