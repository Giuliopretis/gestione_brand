import 'package:dio/dio.dart';
import 'package:gestione_brand/constants.dart';
import 'package:gestione_brand/data/models/brand.dart';

class ApiProvider {
  final Dio _dio = Dio();

  ApiProvider() {
    _dio.options.headers = {
      'authorization': 'Bearer $BEARER_TOKEN',
      'content-Type': 'application/json'
    };
  }

  Future<List<Brand>> getBrandList() async {
    try {
      Response res = await _dio.get(
        '$PRODUCTION_URL/brands',
      );
      List<Brand> brands = [];
      for (var brand in res.data['data']) {
        brands.add(Brand.fromJson(brand));
      }
      return brands;
    } catch (e) {
      rethrow;
    }
  }
}
