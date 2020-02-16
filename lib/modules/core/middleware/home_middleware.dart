import 'package:Mafruka/modules/core/models/app_state.dart';
import 'package:redux/redux.dart';

homeMiddleware(Store<AppState> store, action, NextDispatcher next) {
  next(action);
}
