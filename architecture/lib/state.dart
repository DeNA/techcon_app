/// Copyright (c) 2019 DeNA Co., Ltd.
/// Licensed under the MIT License

import 'package:architecture/app_tab.dart';
import 'package:repository/entity/session.dart';
import 'package:meta/meta.dart';

@immutable
class AppState {
  final bool isLoading;
  final bool hasError;
  final AppTab activeTab;
  final List<Session> sessions;

  AppState(
      {this.activeTab,
      this.isLoading = false,
      this.hasError = false,
      this.sessions});

//  factory AppState.initial() =>
//      AppState(isLoading: true, sessions: List.unmodifiable([]));
  factory AppState.initial() =>
      AppState(isLoading: true, activeTab: AppTab.sessions);

//  factory AppState.loading() => AppState(isLoading: true);

  factory AppState.error(AppState state) =>
      state.copyWith(isLoading: false, hasError: true);

  AppState copyWith({
    bool isLoading,
    bool hasError,
    AppTab activeTab,
    List<Session> sessions,
  }) {
    return AppState(
      isLoading: isLoading ?? this.isLoading,
      hasError: hasError ?? this.hasError,
      activeTab: activeTab ?? this.activeTab,
      sessions: sessions ?? this.sessions,
    );
  }
}
