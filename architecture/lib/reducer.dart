/// Copyright (c) 2019 DeNA Co., Ltd.
/// Licensed under the MIT License

import 'package:architecture/actions.dart';
import 'package:architecture/state.dart';
import 'package:redux/redux.dart';


/// Reducer
final appReducer = combineReducers<AppState>([
  TypedReducer<AppState, LoadingAction>(_onLoading),
  TypedReducer<AppState, ErrorAction>(_onError),
  TypedReducer<AppState, SessionsLoadAction>(_onLoadSessions),
  TypedReducer<AppState, SessionsLoadedAction>(_onLoadedSessions),
  TypedReducer<AppState, UpdateTabAction>(_onUpdateTab),
]);

AppState _onLoading(AppState state, LoadingAction action) => state.copyWith(isLoading: true);

AppState _onError(AppState state, ErrorAction action) => AppState.error(state);

// XXX: Stateをそのまま返す... 変更が無いなら不要か?
AppState _onLoadSessions(AppState state, SessionsLoadAction action) => state;

AppState _onLoadedSessions(AppState state, SessionsLoadedAction action) => state.copyWith(isLoading: false, sessions: action.sessions);

AppState _onUpdateTab(AppState state, UpdateTabAction action)=> state.copyWith(activeTab: action.newTab);

// TODO: Define reducer by combining many smaller reducers into one!
//AppState appReducer(AppState state, action) {
//  return new AppState(
//    isLoading: loadingReducer(state.isLoading, action),
//    sessions: sessionsReducer(state.sessions, action),
//    activeFilter: visibilityReducer(state.activeFilter, action),
//    activeTab: tabsReducer(state.activeTab, action),
//  );
//}

