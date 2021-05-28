import 'package:flutter/material.dart';

import '../country_picker/countries.dart';
import '../country_picker/country.dart';
import '../country_picker/typedefs.dart';

///Provides a customizable [DropdownButton] for all countries
class CountryPickerDropdown extends StatefulWidget {
  CountryPickerDropdown(
      {this.itemBuilder, this.initialValue, this.onValuePicked});

  ///This function will be called to build the child of DropdownMenuItem
  ///If it is not provided, default one will be used which displays
  ///flag image, isoCode and phoneCode in a row.
  ///Check _buildDefaultMenuItem method for details.
  final ItemBuilder itemBuilder;

  ///It should be one of the ISO ALPHA-2 Code that is provided
  ///in countriesList map of countries.dart file.
  final String initialValue;

  ///This function will be called whenever a Country item is selected.
  final ValueChanged<Country> onValuePicked;

  @override
  _CountryPickerDropdownState createState() => _CountryPickerDropdownState();
}

class _CountryPickerDropdownState extends State<CountryPickerDropdown> {
  List<Country> _countries;
  Country _selectedCountry;

  @override
  void initState() {
    _countries = countriesList.map((item) => Country.fromMap(item)).toList();
    _countries.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    if (widget.initialValue != null) {
      try {
        _selectedCountry = _countries
            .where((country) =>
                country.isoCode == widget.initialValue.toUpperCase())
            .toList()[0];
      } catch (error) {
        throw Exception(
            "The initialValue provided is not a supported iso code!");
      }
    } else {
      _selectedCountry = _countries[0];
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<DropdownMenuItem<Country>> items = _countries
        .map((country) => DropdownMenuItem<Country>(
            value: country,
            child: widget.itemBuilder != null
                ? widget.itemBuilder(country)
                : _buildDefaultMenuItem(country)))
        .toList();

    return Row(
      children: <Widget>[
        DropdownButtonHideUnderline(
          child: DropdownButton<Country>(
            isDense: true,
            onChanged: (value) {
              setState(() {
                _selectedCountry = value;
                widget.onValuePicked(value);
              });
            },
            items: items,
            value: _selectedCountry,
          ),
        ),
      ],
    );
  }

  Widget _buildDefaultMenuItem(Country country) {
    return Row(
      children: <Widget>[
        Text("(${country.isoCode}) +${country.phoneCode}"),
      ],
    );
  }
}
