import 'dart:isolate';

import 'package:dio/dio.dart';
import 'package:shopping_app/domain/api_models/dummy_model.dart';
import 'package:shopping_app/domain/api_models/products_model.dart';
import 'package:shopping_app/domain/api_repos_abstract/products_repo.dart';

import '../../shared/constants/app_api_paths.dart';
import '../../shared/console.dart';
import '../api_repos_abstract/dummy_repo.dart';
import '../api_services/api_response.dart';
import '../api_services/handling_response.dart';

// for list do like this
// List<PhotosModel> data = List<PhotosModel>.from(
//     res.data.map((x) => PhotosModel.fromJson(x)));
// List<PhotosModel> data = await Isolate.run(() => List<PhotosModel>.from(
//     res.data.map((x) => PhotosModel.fromJson(x))));
class ProductsRepoImpl extends ProductsRepo {
  @override
  @override
  Future<ApiResponse> getProducts({bool enableLocalPersistence = false}) async {
    try {
      Response res = await apiServices.get(
        AppApiPaths.getProducts,
        enableLocalPersistence: enableLocalPersistence,
      );
      ApiResponse result = HandlingResponse.returnResponse(res);
      console('REPO : ${result.status}');
      if (result.status == Status.completed) {
        ProductsModel data = await Isolate.run(
          () => ProductsModel.fromJson(res.data),
        );
        print('productsModelllllllllll${data.toJson()}');
        return ApiResponse.completed(data);
      } else {
        return result;
      }
    } on DioException catch (w) {
      return HandlingResponse.returnException(w);
    }
  }
}
