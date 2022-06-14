import 'package:dio/dio.dart';
import 'package:gestione_brand/constants.dart';
import 'package:gestione_brand/data/models/brand.dart';

class ApiProvider {
  final Dio _dio = Dio();

  Future<List<Brand>> getBrandList() async {
    try {
      Response res = await _dio.get('$PRODUCTION_URL/brands');
      List<Brand> brands =
          res.data.map((data) => Brand.fromJson(data)).toList();
      return brands;
    } catch (e) {
      rethrow;
    }
  }
}
