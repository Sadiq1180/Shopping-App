import 'package:shopping_app/domain/api_repos_abstract/products_repo.dart';
import 'package:shopping_app/domain/api_repos_impl/products_repo_impl.dart';

import '../api_repos_abstract/dummy_repo.dart';
import '../api_repos_impl/dummy_repo_impl.dart';

mixin BaseRepo {
  final DummyRepo _dummyRepo = DummyRepoImpl();
  DummyRepo get dummyRepo => _dummyRepo;

  final ProductsRepo _productsRepo = ProductsRepoImpl();
  ProductsRepo get productsRepo => _productsRepo;
}
