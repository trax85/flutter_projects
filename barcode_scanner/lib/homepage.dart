import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage>{
  String _val = 'Here is the text to be displayed';
  bool isShowFlashIcon = false;

  Future<void> barcodeScan() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
    } on PlatformException {
      barcodeScanRes = "Failed";
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Failed to scan"),
      ));
    }
    if (!mounted) return;

    if(barcodeScanRes == '-1'){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Failed to scan"),
      ));
      return;
    }
    setState(() {
      _val = barcodeScanRes;
    });
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
                  onPressed: () => barcodeScan(),
                  child: const Text("Scan BarCode"),
              ),
              Text(_val),
            ],
          ),
        ),
    );
  }
}
