import '../api_services/api_response.dart';
import '../base_repo/base.dart';

abstract class ProductsRepo extends Base {
  Future<ApiResponse> getProducts({bool enableLocalPersistence = false});
}
