import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/api_services/api_response.dart';
import '../domain/base_repo/base_repo.dart';
import '../domain/data_models/product.dart';

final productsProvider = NotifierProvider<ProductsProvider, Product>(
  ProductsProvider.new,
);

class ProductsProvider extends Notifier<Product> with BaseRepo {
  @override
  Product build() => Product(productRes: ApiResponse.loading());

  getProducts() async {
    ApiResponse res = await productsRepo.getProducts(
      enableLocalPersistence: true,
    );
    state = state.copyWith(productRes: res);
  }
}
