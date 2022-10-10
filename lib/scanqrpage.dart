import 'package:flutter/material.dart';
import 'package:qr_code_dart_scan/qr_code_dart_scan.dart';

class ScanQRPage extends StatefulWidget {
  bool _isFront = false;

  ScanQRPage(bool isFront, {super.key}){
    _isFront = isFront;
  }
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ScanQRPageState(_isFront);
  }
}

class _ScanQRPageState extends State<ScanQRPage> {
  bool _isDecoded = false;
  bool _isFront = false;

  _ScanQRPageState(bool isFront){
    _isFront = isFront;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text("QRCode Scan"),
      ),
      body: Center(
          child:
          QRCodeDartScanView(
            typeCamera: (_isFront == true) ? TypeCamera.front : TypeCamera.back,
            scanInvertedQRCode: true, // enable scan invert qr code ( default = false)
            typeScan: TypeScan.live, // if TypeScan.takePicture will try decode when click to take a picture (default TypeScan.live)
            // resolutionPreset: = QrCodeDartScanResolutionPreset.high,
            formats: const [ // You can restrict specific formats.
               BarcodeFormat.QR_CODE,
               //BarcodeFormat.AZTEC,
               //BarcodeFormat.DATA_MATRIX,
               //BarcodeFormat.PDF_417,
               //BarcodeFormat.CODE_39,
               BarcodeFormat.CODE_93,
               BarcodeFormat.CODE_128,
              BarcodeFormat.EAN_8,
               BarcodeFormat.EAN_13,
            ],
            onCapture: (Result result) {
              // do anything with result
              // result.text
              // result.rawBytes
              // result.resultPoints
              // result.format
              // result.numBits
              // result.resultMetadata
              // result.time
              if(_isDecoded) return;
              setState(() {
                _isDecoded = true;
              });
              Navigator.pop(context, result.text);
            },
          ),
      ),
    );
  }
}