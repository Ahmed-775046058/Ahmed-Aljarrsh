import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../services/database_service.dart';
import '../services/api_service.dart';
import '../models/data_model.dart';

class DataController extends GetxController {
  final DatabaseService databaseService = DatabaseService();
  final ApiService apiService = ApiService();

  @override
  void onInit() {
    super.onInit();
    _checkConnectivity();
  }

  void _checkConnectivity() {
    Connectivity().onConnectivityChanged.listen((result) {
      if (result != ConnectivityResult.none) {
        _syncData();
      }
    });
  }

  Future<void> _syncData() async {
    List<DataModel> dataList = await databaseService.getData();
    for (var data in dataList) {
      await apiService.sendData(data);
      await databaseService.deleteData(data.id);
    }
  }

  Future<void> saveData(DataModel data) async {
    await databaseService.insertData(data);
  }
}