/// Copyright (c) 2019 DeNA Co., Ltd.
/// Licensed under the MIT License

import 'package:architecture/actions.dart';
import 'package:architecture/state.dart';
import 'package:redux/redux.dart';

import 'package:repository/repository.dart';

Repository _repository;

List<Middleware<AppState>> createStoreMiddleware(Repository repository) {
  _repository = repository;
  return [
      TypedMiddleware<AppState, SessionsLoadAction>(_load),
    ];
}

// Sessions Load
Future _load(Store<AppState> store, action, NextDispatcher next) async {
  print('AppState.isLoading=${store.state.isLoading}');
  // Dispatch a LoadingAction to show a loading spinner
  store.dispatch(LoadingAction());

  // get session
  print('Loading Sessions');
  var sessions = await _repository.getSessionList();
  store.dispatch(SessionsLoadedAction(sessions));
  print('Loaded Sessions');

  next(action);
  print('AppState.isLoading=${store.state.isLoading}');
}
