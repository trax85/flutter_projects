import 'package:flutter/material.dart';
import 'scanpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State createState() {
    return _HomePageState();
  }
}



class _HomePageState extends State<HomePage>{
  String _val = 'Here is the text to be displayed';

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
          title: const Text("QR Scanner"),
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
