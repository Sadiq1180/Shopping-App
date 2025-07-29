import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/base_repo/base_repo.dart';
import '../domain/data_models/main_data_model.dart';

final mainProvider =
    NotifierProvider<MainProvider, MainDataModel>(MainProvider.new);

class MainProvider extends Notifier<MainDataModel> with BaseRepo {
  @override
  MainDataModel build() => const MainDataModel(currentIndex: 0);

  changeTab(int index) {
    state = state.copyWith(currentIndex: index);
  }

  movetoAnyTab() {
    state = state.copyWith(currentIndex: 2);
  }
}
