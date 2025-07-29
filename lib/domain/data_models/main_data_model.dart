class MainDataModel {
  final int? currentIndex;
  const MainDataModel({this.currentIndex});

  MainDataModel copyWith({int? currentIndex}) {
    return MainDataModel(
      currentIndex: currentIndex ?? this.currentIndex
    );
  }
}