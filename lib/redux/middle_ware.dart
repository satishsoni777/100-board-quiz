import 'package:gamedemo/redux/model.dart';
import 'package:redux/redux.dart';

AppState middleWare(Store<AppState> state, action, NextDispatcher next) {
  return AppState(no: 0);
}
