import 'package:hive_flutter/adapters.dart';

class AppLocal {
  static final AppLocal ins = AppLocal._internal();
  AppLocal._internal();

  Future initStorage() async {
    await Hive.initFlutter();
    final boxNames = [_appBoxName, _userBoxName, _dataBoxName, _cartBoxName];
    for (var box in boxNames) {
      // await Hive.openBox<CartItemModel>(_cartBoxName);

      await Hive.openBox(box);
    }
  }

  // Box names
  final String _appBoxName = "APP_BOX";
  final String _userBoxName = "USER_BOX";
  final String _dataBoxName = "DATA_BOX";

  /// cart box name
  final String _cartBoxName = "CART_BOX";

  //Getter for Boxes
  Box get appBox => Hive.box(_appBoxName);
  Box get userBox => Hive.box(_userBoxName);
  Box get dataBox => Hive.box(_dataBoxName);
  //getter for cart box
  Box get cartBox => Hive.box(_cartBoxName);
}
