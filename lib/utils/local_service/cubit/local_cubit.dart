import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class LocaleCubit extends Cubit<Locale> {
  static const String _localeKey = 'locale';
  final GetStorage _storage = GetStorage();

  LocaleCubit() : super(const Locale('en')) {
    _loadSavedLocale();
  }

  // Load the saved locale from GetStorage
  void _loadSavedLocale() {
    final localeCode = _storage.read<String>(_localeKey) ?? 'en';
    emit(Locale(localeCode));
  }

  // Change the locale and save it
  void changeLocale(String languageCode) {
    _storage.write(_localeKey, languageCode);
    emit(Locale(languageCode));
  }
  void toggleLocale() {
    final newLocale = state.languageCode == 'en' ? const Locale('ar') : const Locale('en');
    _storage.write(_localeKey, newLocale.languageCode);
    emit(newLocale);
  }

}