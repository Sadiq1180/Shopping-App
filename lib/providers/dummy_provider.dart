import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_app/domain/data_models/dummy.dart';
import '../domain/api_services/api_response.dart';
import '../domain/base_repo/base_repo.dart';
import '../shared/console.dart';

final dummyProvider = NotifierProvider<DummyProvider, Dummy>(DummyProvider.new);

class DummyProvider extends Notifier<Dummy> with BaseRepo {
  @override
  Dummy build() => Dummy(
    airlineRes: ApiResponse.loading(),
    userRes: ApiResponse.loading(),
    count: 0,
  );
  changeCount() {
    state = state.copyWith(count: Random().nextInt(1000));
  }

  getUsers() async {
    ApiResponse userRes = await dummyRepo.getUser(enableLocalPersistence: true);
    state = state.copyWith(userRes: userRes);
    console('PROVIDERR : ${userRes.status}');
  }

  getAir() async {
    ApiResponse airlineRes = await dummyRepo.getUser(
      enableLocalPersistence: true,
    );
    state = state.copyWith(airlineRes: airlineRes);
    console('PROVIDERR : ${airlineRes.status}');
  }
}

final countProvider = NotifierProvider<CountProvider, int>(CountProvider.new);

class CountProvider extends Notifier<int> {
  @override
  int build() => 0;
  incrementCount() {
    state = state++;
  }

  decrementCount() {
    state = state++;
  }
}
