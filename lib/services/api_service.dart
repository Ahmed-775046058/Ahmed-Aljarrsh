import 'package:dio/dio.dart';
import '../consts/api_consts.dart';
import '../models/data_model.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<void> sendData(DataModel data) async {
    await _dio.post(ApiConsts.baseUrl, data: data.toJson());
  }
}