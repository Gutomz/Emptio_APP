import 'package:emptio/core/app_api-errors.dart';
import 'package:emptio/core/app_api.dart';
import 'package:emptio/data/dao/product/product.dao.dart';
import 'package:emptio/models/product.model.dart';
import 'package:emptio/stores/auth.store.dart';
import 'package:emptio/view-models/product_filter.view-model.dart';
import 'package:get_it/get_it.dart';

class ProductRepository {
  final AppApi _api = AppApi();
  final ProductDao _productDao = ProductDao();
  final AuthStore _authStore = GetIt.I<AuthStore>();

  Future<List<ProductModel>> get(ProductFilterViewModel filter) async {
    try {
      if (_authStore.isLogged) {
        List data =
            await _api.get('/products', queryParameters: filter.toQuery());
        var list = data
            .map((product) => ProductModel.fromJson(product))
            .cast<ProductModel>()
            .toList();
        return list;
      }

      return await _productDao.getAll(filter);
    } catch (error) {
      print(error);
      return Future.error(AppApiErrors.handleError(error));
    }
  }
}
