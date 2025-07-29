
import '../api_services/api_response.dart';

class Dummy {
  final ApiResponse? airlineRes;
  final ApiResponse? userRes;
  final int? count;

  Dummy({this.airlineRes, this.userRes, this.count});

  Dummy copyWith({ApiResponse? airlineRes, ApiResponse? userRes, int? count}) {
    return Dummy(
        airlineRes: airlineRes ?? this.airlineRes,
        userRes: userRes ?? this.userRes,
        count: count ?? this.count);
  }
}
