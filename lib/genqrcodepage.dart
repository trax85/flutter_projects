import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class DisplayQRPage extends StatelessWidget {
  String _dataString = '';

  DisplayQRPage(String dataString, {super.key}){
    _dataString = dataString;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final bodyHeight = MediaQuery.of(context).size.height - MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('QR Code'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 100,),
            SizedBox(width: 250, height: 250,
            child: QrImage(
                data: _dataString,
                size: bodyHeight,
                errorStateBuilder: (ctx, err){
                  return const Center(
                    child: Text("Failed to generate QR code",
                      textAlign: TextAlign.center,
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

}