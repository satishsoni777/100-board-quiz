class AppState {
  int no = 0;
  AppState({this.no});
  AppState initialData() {
    return AppState(no: 0);
  }
}

class ViewModel {
  String name;
  int id;
}
