import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class ThemeCubit extends HydratedCubit<ThemeMode> {
  ThemeCubit() : super(ThemeMode.system);

  /// Unique storage identifier for runtime production safety
  @override
  String get storagePrefix => 'ThemeCubit';

  /// Toggle between Light and Dark mode
  void toggleTheme() {
    emit(state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light);
  }

  /// Explicitly set theme mode
  void setTheme(ThemeMode themeMode) {
    emit(themeMode);
  }

  /// Load persisted state from storage
  @override
  ThemeMode? fromJson(Map<String, dynamic> json) {
    return ThemeMode.values[json['theme_mode'] as int];
  }

  /// Save state to storage
  @override
  Map<String, dynamic>? toJson(ThemeMode state) {
    return {'theme_mode': state.index};
  }
}