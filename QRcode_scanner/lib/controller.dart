import 'package:get/get.dart';
import 'package:qr_code_dart_scan/qr_code_dart_scan.dart';

class StoreController extends GetxController {
  final _camLens = 0.obs;

  updateCamLens(){
    if(_camLens.value == 1) {
      _camLens.value = 0;
    } else {
      _camLens.value = 1;
    }
    print("Update lens" + _camLens.toString());
  }

  getCamLens(){
    print("get came lens");
    if(_camLens.value == 1) {
      return TypeCamera.front;
    } else {
      return TypeCamera.back;
    }
  }
}