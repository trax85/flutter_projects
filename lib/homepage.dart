import 'package:flutter/material.dart';
import 'package:qrcode_generator/genqrcodepage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State createState() {
    return _HomePageState();
  }
}


class _HomePageState extends State<HomePage>{
  late String _dataString;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _orgController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _desigController = TextEditingController();


  void _genQRcode(){
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => DisplayQRPage(_dataString)));
  }

  void constructData(String name, String org, id, String desig){
    _dataString =
    "name:$name organization:$org employeeID:$id designation:$desig";
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text("QR Code Generator"),
          centerTitle:true,
        ),
        body: Center(
          child:
              Column(
                children: [
                  const SizedBox(height: 100,),
                  SizedBox(width: 200,
                  child:TextField(
                      autofocus: true,
                      controller: _nameController,
                      textCapitalization: TextCapitalization.words,
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        hintText: 'Enter Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  SizedBox(width: 200,
                    child: TextField(
                      autofocus: true,
                      controller: _orgController,
                      textCapitalization: TextCapitalization.words,
                      decoration: const InputDecoration(
                        labelText: 'Organization',
                        hintText: 'Enter Org',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  SizedBox(width: 200,
                  child: TextField(
                      autofocus: true,
                      controller: _idController,
                      decoration: const InputDecoration(
                        labelText: 'Employee ID',
                        hintText: 'Enter Id',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  SizedBox(width: 200,
                  child: TextField(
                      autofocus: true,
                      controller: _desigController,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        labelText: 'Designation',
                        hintText: 'Enter Designation',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20,),
                  ElevatedButton(
                    onPressed: () {
                      constructData(_nameController.text, _orgController.text ,
                          _idController.text , _desigController.text);
                      _genQRcode();
                      },
                    child: const Text("Generate QR code"),
                  ),
                ],
              ),
        ),
    );
  }
}
