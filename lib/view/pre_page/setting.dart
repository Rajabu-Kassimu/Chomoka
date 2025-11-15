import 'package:chomoka/providers/language_provider.dart';
import 'package:chomoka/view/group_setup/password/reset_password_page.dart';
import 'package:chomoka/view/group_setup/term_condition.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:chomoka/l10n/app_localizations.dart';

import 'package:provider/provider.dart';
import 'package:chomoka/providers/currency_provider.dart';
import 'package:chomoka/utils/currency_formatter.dart';

class SettingsPage extends StatefulWidget {
  final bool isFromSetting;
  SettingsPage({this.isFromSetting = false});
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

bool _isBalanceVerificationEnabled = true;

class _SettingsPageState extends State<SettingsPage> {
  String _selectedLanguage = "Kiswahili";
  final Map<String, String> _languageMap = {
    "Kiswahili": "sw",
    "English": "en",
    "Français": "fr",
    "Português": "pt"
  };

  final List<String> _languages = ["Kiswahili", "English", "Français", "Português"];

  @override
  void initState() {
    super.initState();
    _loadCurrentLanguage();
  }

  Future<void> _loadCurrentLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLocale = prefs.getString('app_locale') ?? 'sw';
    setState(() {
      _selectedLanguage = _languageMap.entries
          .firstWhere((entry) => entry.value == savedLocale)
          .key;
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final languageProvider = Provider.of<LanguageProvider>(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: l10n.mipangilio,
        showBackArrow: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.badiliLugha,
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        l10n.chaguaLughaYaProgramu,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16),
                Container(
                  width: 120,
                  child: DropdownButtonFormField<String>(
                    isExpanded: true,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      border: OutlineInputBorder(),
                    ),
                    value: _selectedLanguage,
                    items: _languages.map((lang) {
                      return DropdownMenuItem<String>(
                        value: lang,
                        child: Text(
                          lang,
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          _selectedLanguage = newValue;
                        });
                        final locale = Locale(_languageMap[newValue]!);
                        languageProvider.setLocale(locale);
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          // Currency selection
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.badiliSarafu,
                        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        l10n.chaguaSarafuYaProgramu,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16),
                Container(
                  width: 120,
                  child: Consumer<CurrencyProvider>(
                    builder: (context, currencyProvider, child) {
                      final List<String> currencies = ['TZS', 'USD', 'KES', 'KSH', 'EUR', 'UGX', 'RWF', 'BIF', 'ZAR', 'ETB'];
                      // Remove duplicates and keep only unique codes
                      final uniqueCurrencies = currencies.toSet().toList();
                      // If the current value is not in the list, fallback to the first
                      String dropdownValue = uniqueCurrencies.contains(currencyProvider.currencyCode)
                          ? currencyProvider.currencyCode
                          : uniqueCurrencies.first;
                      return DropdownButtonFormField<String>(
                        isExpanded: true,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                          border: OutlineInputBorder(),
                        ),
                        value: dropdownValue,
                        items: uniqueCurrencies.map((code) {
                          return DropdownMenuItem<String>(
                            value: code,
                            child: Text(getCurrencySymbol(code) + ' $code'),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            currencyProvider.setCurrency(newValue);
                          }
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Divider(),

          ListTile(
            title: Text(
              l10n.rekebishaFunguo,
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              l10n.badilishaNenoLaSiri,
              style: TextStyle(color: Colors.grey),
            ),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ResetPasswordPage(),
                ),
              );
            },
          ),
          Divider(),

          ListTile(
            title: Text(
              l10n.rekebishaMzunguko,
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.red),
            ),
            subtitle: Text(
              l10n.futazoteZaMzungukoHuuKishaAnzaMzungukoMpya,
              style: TextStyle(color: Colors.grey),
            ),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero, // Remove border radius
                    ),
                    backgroundColor: Colors.white,
                    title: Text(
                      l10n.thibitisha,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    content: Text(
                      l10n.jeUnaHitajiKufutaTaarifaZoteNaKuanzaMzungukoMpya,
                      style: TextStyle(fontSize: 16),
                    ),
                    actions: [
                      Container(
                        width: double.infinity,
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero,
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                ),
                                child: Text(
                                  l10n.ndio,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                                onPressed: () async {
                                  try {
                                    // Clear app data using shared preferences
                                    final prefs =
                                        await SharedPreferences.getInstance();
                                    await prefs.clear();

                                    Navigator.of(context).pop();
                                    // Show success message
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content:
                                            Text(l10n.taarifaZimehifadhiwa),
                                        backgroundColor: Colors.green,
                                      ),
                                    );

                                    // Exit the app
                                    SystemNavigator.pop();
                                  } catch (e) {
                                    // Show error message if clearing fails
                                    // ScaffoldMessenger.of(context).showSnackBar(
                                    //   SnackBar(
                                    //     content: Text(
                                    //         l10n.imeshindwaKuHifadhi),
                                    //     backgroundColor: Colors.red,
                                    //   ),
                                    // );
                                  }
                                },
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.grey[200],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero,
                                  ),
                                  padding: EdgeInsets.symmetric(vertical: 15),
                                ),
                                child: Text(
                                  l10n.hapana,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
          Divider(),
          // SwitchListTile(
          //   title: Text(
          //     "Uthibitishaji wa Salio",
          //     style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          //   ),
          //   subtitle: Text(
          //     "Ruhusu uhakiki wa makusanyo yote wakati wa kikao",
          //     style: TextStyle(color: Colors.grey),
          //   ),
          //   value: _isBalanceVerificationEnabled,
          //   onChanged: (bool value) {
          //     setState(() {
          //       _isBalanceVerificationEnabled = value; // Toggle the value
          //     });
          //   },
          // ),
          Divider(),
          ListTile(
            title: Text(
              l10n.kuhusuChomoka,
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              l10n.toleoLaChapa100 + "\n" + l10n.toleo4684,
              style: TextStyle(color: Colors.grey),
            ),
            onTap: () {
              launch('https://chomokaplus.com/privacy-policy');
            },
          ),
          Divider(),

          ListTile(
            title: Text(
              l10n.mkataba,
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              "",
              style: TextStyle(color: Colors.grey),
            ),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              launch('https://chomokaplus.com/privacy-policy');
            },
          ),
          GestureDetector(
            child: ListTile(
              title: Text(
                l10n.vigezoNaMasharti,
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                l10n.somaVigezoNaMashartiYaChomoka,
                style: TextStyle(color: Colors.grey),
              ),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          TermsAndConditionsPage(isFromSetting: true)),
                );
              },
            ),
          ),
          ListTile(
            title: Text(
              l10n.msaadaWaKitaalamu,
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              l10n.chomokaItajaribuKutumaBaadhiYaIliKikundiKipateMsaadaZaidiWaKitalaamu,
              style: TextStyle(color: Colors.grey),
            ),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to About page
            },
          ),
        ],
      ),
    );
  }
}
