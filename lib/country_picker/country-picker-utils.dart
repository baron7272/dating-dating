import 'dart:async';

import 'package:flutter/material.dart';

import '../country_picker/countries.dart';
import '../country_picker/country.dart';

class CountryPickerUtils {
  static Future<Country> getCountryByIsoCode(String isoCode) async {
    final _countries = countriesList.map((item) => Country.fromMap(item)).toList();
    try {
      return _countries
          .where((country) => country.isoCode.toLowerCase() == isoCode.toLowerCase())
          .toList()[0];
    } catch (error) {
      return null;
    }
  }

  static String getFlagImageAssetPath(String isoCode) {
    return "assets/flags/${isoCode.toLowerCase()}.png";
  }

  static Widget getDefaultFlagImage(Country country) {
    // print(CountryPickerUtils.getFlagImageAssetPath(country.isoCode));
    return Image.asset(
      CountryPickerUtils.getFlagImageAssetPath(country.isoCode),
      height: 20.0,
      width: 20.0,
      fit: BoxFit.contain,
    );
  }
}
