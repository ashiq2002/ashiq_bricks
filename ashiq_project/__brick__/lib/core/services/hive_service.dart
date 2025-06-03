import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

class HiveService extends GetxService {
  static HiveService get to => Get.find();

  final Map<String, Box> _boxes = {};

  /// Initialize Hive.
  Future<HiveService> init() async {
    var directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    return this;
  }

  /// Open a box of type [T] with the given [boxName] if not already opened.
  Future<void> openBox<T>(String boxName) async {
    if (!_boxes.containsKey(boxName)) {
      _boxes[boxName] = await Hive.openBox<T>(boxName);
    }
  }

  /// Add data of type [T] to the cache in the specified [boxName].
  Future<bool> storeData<T>({required T data, required String boxName}) async {
    try{
      var box = await _ensureBoxIsOpen<T>(boxName);
      await box.add(data);
      return true;
    }catch(e){
      Logger().d("Hive Error: $e");
      return false;
    }
  }

  /// Retrieve the last added data of type [T] from the specified [boxName].
  Future<T?> retrieveData<T>(String boxName) async {
    var box = await _ensureBoxIsOpen<T>(boxName);
    if (box.isNotEmpty) {
      return box.values.last;
    }
    return null;
  }

  /// Clear all data from the cache in the specified [boxName].
  Future<void> clearCache(String boxName) async {
    var box = await _ensureBoxIsOpen(boxName);
    await box.clear();
  }

  /// Ensure the box is open before interacting with it.
  Future<Box<T>> _ensureBoxIsOpen<T>(String boxName) async {
    if (!_boxes.containsKey(boxName)) {
      _boxes[boxName] = await Hive.openBox<T>(boxName);
    }
    return _boxes[boxName] as Box<T>;
  }
}
