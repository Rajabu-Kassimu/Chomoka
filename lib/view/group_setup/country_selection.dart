import 'package:chomoka/model/GroupInformationModel.dart';
import 'package:chomoka/view/group_setup/RegionDistrictWard.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chomoka/controllers/group_information_controller.dart';
import 'package:chomoka/l10n/app_localizations.dart';

import 'package:provider/provider.dart';
import 'package:chomoka/providers/currency_provider.dart';
import 'package:chomoka/providers/language_provider.dart';

class CountrySelectionPage extends StatefulWidget {
  @override
  _CountrySelectionPageState createState() => _CountrySelectionPageState();
}

class _CountrySelectionPageState extends State<CountrySelectionPage> {
  final GroupInformationController _controller = GroupInformationController();
  final List<Map<String, dynamic>> countries = [
    {
      'name': 'Tanzania',
      'flag': 'assets/images/tanzania.jpg',
      'selected': false,
      'language': 'sw',
      'currency': 'TZS'
    },
    {
      'name': 'Kenya',
      'flag': 'assets/images/kenya.jpg',
      'selected': false,
      'language': 'sw',
      'currency': 'KES'
    },
    {
      'name': 'Uganda',
      'flag': 'assets/images/uganda.png',
      'selected': false,
      'language': 'en',
      'currency': 'UGX'
    },
    {
      'name': 'Rwanda',
      'flag': 'assets/images/rwanda.png',
      'selected': false,
      'language': 'fr',
      'currency': 'RWF'
    },
    {
      'name': 'Burundi',
      'flag': 'assets/images/burundi.png',
      'selected': false,
      'language': 'fr',
      'currency': 'BIF'
    },
    {
      'name': 'South Africa',
      'flag': 'assets/images/south_africa.jpg',
      'selected': false,
      'language': 'en',
      'currency': 'ZAR'
    },
    {
      'name': 'Ethiopia',
      'flag': 'assets/images/ethiopia.png',
      'selected': false,
      'language': 'en',
      'currency': 'ETB'
    },
  ];

  bool _showError = false;
  List<GroupInformationModel> _savedCountries = [];
  var selected_country;
  var selected_country_name;
  var selected_index;
  var group_info_id;

  void _selectCountry(int index) {
    setState(() {
      for (int i = 0; i < countries.length; i++) {
        countries[i]['selected'] = i == index;
      }
      _showError = false;
    });
  }

  int? _getCountryIndexByName(String countryName) {
    for (int i = 0; i < countries.length; i++) {
      if (countries[i]['name'] == countryName) {
        return i;
      }
    }
    return null; // Return null if the country is not found
  }

  @override
  void initState() {
    super.initState();
    _initializeCountryAndSettings();
  }

  Future<void> _initializeCountryAndSettings() async {
    final savedData = await _fetchSavedData();
    if (savedData != null) {
      var myindex = _getCountryIndexByName(savedData.country);
      setState(() {
        selected_index = myindex;
        group_info_id = savedData.id;
        selected_country_name = savedData.country;
      });

      if (!mounted) return;
      
      // Set the currency and language for the saved country
      final country = countries[myindex ?? 0];
      Provider.of<CurrencyProvider>(context, listen: false).setCurrency(country['currency']);
      Provider.of<LanguageProvider>(context, listen: false).setLocale(Locale(country['language']));
    }
  }

  @override
  Widget build(BuildContext context) {
    // Remove the _fetchSavedData() call here
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.selectCountry,
        showBackArrow: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              AppLocalizations.of(context)!.pleaseSelectCountry,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            if (_showError)
              Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Text(
                  AppLocalizations.of(context)!.pleaseSelectCountryError,
                  style: TextStyle(fontSize: 14, color: Colors.red),
                ),
              ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: countries.length,
                itemBuilder: (context, index) {
                  final country = countries[index];
                  return Card(
                    child: ListTile(
                      leading: Image.asset(
                        country['flag'],
                        width: 40,
                        height: 30,
                        fit: BoxFit.cover,
                      ),
                      title: Text(country['name']),
                      trailing: Checkbox(
                        value: selected_index == index,
                        onChanged: (bool? newValue) {
                          if (newValue == true) {
                            setState(() {
                              selected_index = index;
                              selected_country_name = countries[index]['name'];
                            });
                          }
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            CustomButton(
              color: Color.fromARGB(255, 4, 34, 207),
              buttonText: AppLocalizations.of(context)!.continueText,  // Make sure to use the correct key from your localizations
              onPressed: _saveData,
              type: ButtonType.elevated,
            ),
          ],
        ),
      ),
    );
  }

  // Update the error messages in _fetchSavedData and _saveData methods
  _fetchSavedData() async {
    try {
      final savedCountry = await _controller.fetchSavedData();
      return savedCountry;
    } catch (e) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text(AppLocalizations.of(context)!.errorFetchingData.replaceAll('{error}', e.toString()))),
      // );
      return null;
    }
  }

  Future<void> _saveData() async {
    if (selected_country_name == null) {
      setState(() {
        _showError = true;
      });
      return;
    }

    try {
      final country = countries[selected_index];
      final currencyCode = country['currency'];
      final languageCode = country['language'];

      if (!mounted) return;
      
      // Set both currency and language in providers
      Provider.of<CurrencyProvider>(context, listen: false).setCurrency(currencyCode);
      Provider.of<LanguageProvider>(context, listen: false).setLocale(Locale(languageCode));

      // Save to database - only country and language
      if (group_info_id == null) {
        final id = await _controller.createGroupInformation({
          'country': selected_country_name,
          'language': languageCode,
          'isReady': 1,
        });
        setState(() {
          group_info_id = id;
        });
      } else {
        await _controller.updateGroupInformation(
          group_info_id,
          {
            'country': selected_country_name,
            'language': languageCode,
          },
        );
      }

      // Save currency and other data in shared preferences
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('app_status', 'setup');
      await prefs.setString('selected_country', selected_country_name);
      await prefs.setString('currency_code', currencyCode);
      await prefs.setString('app_locale', languageCode);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.dataSavedSuccessfully)),
      );
      
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RegionDistrictWardPage(
            group_info_id: group_info_id,
            country_name: selected_country_name,
          ),
        ),
      );
    } catch (e) {
      print('Error saving data: $e');
    }
  }
}
