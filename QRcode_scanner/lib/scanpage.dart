import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanPage extends StatelessWidget {
  const ScanPage({super.key});

  @override
  Widget build(BuildContext context) {
    MobileScannerController cameraController = MobileScannerController();
    bool screenOpened = false;

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scan QR"),
        actions: [
          IconButton(
            color: Colors.white,
            icon: ValueListenableBuilder(
              valueListenable: cameraController.cameraFacingState,
              builder: (context, state, child) {
                switch (state) {
                  case CameraFacing.front:
                    return const Icon(Icons.camera_front);
                  case CameraFacing.back:
                    return const Icon(Icons.camera_rear);
                }
              },
            ),
            iconSize: 32.0,
            onPressed: () => cameraController.switchCamera(),
          ),
        ],
      ),

      body: MobileScanner(
        allowDuplicates: true,
        controller: cameraController,
        onDetect: (Barcode barcode, MobileScannerArguments? args) {
          if (!screenOpened) {
            if(barcode.type != BarcodeType.url) {
              return;
            } else {
              //print("Type of URL");
            }
            final String code;
            if(barcode.rawValue == null){
              code = 'failed to fetch qr code';
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Failed to scan QR code"),
              ));
            }else{
              code = barcode.rawValue!;
            }
            screenOpened = true;
            Navigator.pop(context, code);
          }
        },
      ),
    );
  }
}