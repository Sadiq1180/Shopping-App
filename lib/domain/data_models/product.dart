import '../api_services/api_response.dart';

class Product {
  final ApiResponse? productRes;

  Product({this.productRes});

  Product copyWith({ApiResponse? productRes}) {
    return Product(productRes: productRes ?? this.productRes);
  }
}
