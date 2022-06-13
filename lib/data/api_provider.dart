import 'package:dio/dio.dart';
import 'package:gestione_brand/constants.dart';

class ApiProvider {
  final Dio _dio = Dio();

  Future<Response> getBrandList() async {
    try {
      Response res = await _dio.get('$PRODUCTION_URL/brands');
      return res;
    } catch (e) {
      rethrow;
    }
  }
}
