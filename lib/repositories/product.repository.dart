import 'package:emptio/core/app_api_errors.dart';
import 'package:emptio/core/app_api.dart';
import 'package:emptio/data/dao/product/product.dao.dart';
import 'package:emptio/helpers/logger.dart';
import 'package:emptio/models/product.model.dart';
import 'package:emptio/stores/auth.store.dart';
import 'package:emptio/view-models/product_filter.view-model.dart';
import 'package:get_it/get_it.dart';

class ProductRepository {
  static const String tag = "ProductRepository";
  final AppApi _api = AppApi();
  final AuthStore _authStore = GetIt.I<AuthStore>();

  Future<List<ProductModel>> get(ProductFilterViewModel filter) async {
    try {
      if (_authStore.isLogged) {
        final data = await _api.get('/products',
            queryParameters: filter.toQuery()) as List<dynamic>;
        final list = data
            .map<ProductModel>((product) =>
                ProductModel.fromJson(product as Map<String, dynamic>))
            .toList();
        return list;
      }

      return await ProductDao.getAllParsed(filter);
    } catch (error, stack) {
      Logger.error(tag, "Exception at 'get' function", error, stack);

      return Future.error(AppApiErrors.handleError(error));
    }
  }
}
