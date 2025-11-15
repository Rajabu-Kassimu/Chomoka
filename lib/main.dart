import 'package:chomoka/model/BaseModel.dart';
import 'package:chomoka/model/GroupInformationModel.dart';
import 'package:chomoka/model/PasswordModel.dart'; // Import PasswordModel
import 'package:chomoka/providers/language_provider.dart';
import 'package:chomoka/view/group_setup/RegionDistrictWard.dart';
import 'package:chomoka/view/group_setup/country_selection.dart';
import 'package:chomoka/view/group_setup/home_page.dart';
import 'package:chomoka/view/pre_page/splash.dart';
import 'package:chomoka/view/pre_page/welcom_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'l10n/app_localizations.dart'; 
import 'package:provider/provider.dart';
import 'package:chomoka/providers/currency_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (defaultTargetPlatform == TargetPlatform.android ||
      defaultTargetPlatform == TargetPlatform.iOS) {
    try {
      await BaseModel.initAppDatabase();
      print('Database initialized!');
    } catch (e) {
      print('Failed to initialize database: $e');
    }
  } else {
    print('This application supports only mobile platforms (Android/iOS).');
  }

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var next_page;

  Future<void> _checkApplicationState() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? status = prefs.getString('app_status');

    try {
      if (status == null) {
        next_page = CountrySelectionPage();
      } else if (status == 'setup') {
        final groupData = await _fetchSavedData();

        if (groupData == null || groupData.country == null) {
          next_page = CountrySelectionPage();
        } else if (groupData.ward == null) {
          next_page = RegionDistrictWardPage(group_info_id: groupData.id);
        } else {
          // Check passwords
          bool hasThreePasswords = await _checkPasswordCount();
          if (hasThreePasswords) {
            next_page = WelcomePage(groupId: groupData.id);
          } else {
            next_page = homePage(data_id: groupData.id);
          }
        }
      }
    } catch (e) {
      print('Error determining next page: $e');
      next_page = CountrySelectionPage();
    } finally {
      setState(() {}); // Ensure the state updates after determining the page
    }
  }

  Future<bool> _checkPasswordCount() async {
    try {
      final passwordModel = PasswordModel();
      final count = await passwordModel.count();
      return count >= 3;
    } catch (e) {
      print('Error checking password count: $e');
      return false;
    }
  }

  Future<GroupInformationModel?> _fetchSavedData() async {
    try {
      final groupInformationModel = GroupInformationModel();
      final savedCountry = await groupInformationModel.first();
      return savedCountry as GroupInformationModel?;
    } catch (e) {
      print('Error fetching saved data: $e');
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    _checkApplicationState(); // Start app state check
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        ChangeNotifierProvider(create: (_) => CurrencyProvider()),
      ],
      child: Consumer<LanguageProvider>(
        builder: (context, languageProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: true,
            title: 'Country Selection App',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: languageProvider.locale,
            home: SplashScreen(
              onCompletion: () =>
                  next_page ??
                  Scaffold(
                    body: Center(child: CircularProgressIndicator()),
                  ),
            ),
          );
        },
      ),
    );
  }
}
