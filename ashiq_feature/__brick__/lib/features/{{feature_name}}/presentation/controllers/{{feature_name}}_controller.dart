import 'package:get/get.dart';

class {{feature_name.pascalCase()}}Controller extends GetxController {
  var data = ''.obs;

  void load() async {
    data.value = 'loaded';
  }
}