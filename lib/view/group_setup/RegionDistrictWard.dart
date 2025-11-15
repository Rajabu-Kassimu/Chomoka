import 'dart:convert';
import 'package:chomoka/controllers/group_information_controller.dart';
import 'package:chomoka/providers/language_provider.dart';
import 'package:chomoka/view/group_setup/group_Information/group_overview.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:chomoka/l10n/app_localizations.dart';

import 'package:provider/provider.dart';

import 'Permissions.dart';

class RegionDistrictWardPage extends StatefulWidget {
  final dynamic group_info_id;
  final bool isEditingMode;
  final String? country_name;
  var mzungukoId;

  RegionDistrictWardPage(
      {super.key,
      this.group_info_id,
      this.country_name,
      this.mzungukoId,
      this.isEditingMode = false});

  @override
  _RegionDistrictWardPageState createState() => _RegionDistrictWardPageState();
}

class _RegionDistrictWardPageState extends State<RegionDistrictWardPage> {
  final List<Map<String, String>> languages = [
    {'name': 'Kiswahili', 'code': 'sw'},
    {'name': 'English', 'code': 'en'},
    {'name': 'Français', 'code': 'fr'},
    {'name': 'Português', 'code': 'pt'}
  ];

  String selectedLanguage = 'sw';
  late Map<String, Map<String, List<String>>> tanzaniaData = {};
  late Map<String, Map<String, List<String>>> kenyaData = {};
  TextEditingController streetController = TextEditingController();
  String? selectedRegion, selectedDistrict, selectedWard;
  final _formKey = GlobalKey<FormState>();
  final GroupInformationController _controller = GroupInformationController();

  bool get isKenya => (widget.country_name?.toLowerCase() ?? "") == "kenya";

  List<String> get regions =>
      isKenya ? kenyaData.keys.toList() : tanzaniaData.keys.toList();

  List<String> get districts => selectedRegion != null
      ? (isKenya
          ? kenyaData[selectedRegion]!.keys.toList()
          : tanzaniaData[selectedRegion]!.keys.toList())
      : [];

  List<String> get wards => selectedDistrict != null
      ? (isKenya
          ? kenyaData[selectedRegion]![selectedDistrict]!
          : tanzaniaData[selectedRegion]![selectedDistrict]!)
      : [];

  @override
  void initState() {
    super.initState();
    if (isKenya) {
      loadAndTransformKenyaData().then((data) {
        setState(() {
          kenyaData = data;
        });
        _controller.fetchSavedData(id: widget.group_info_id).then((savedData) {
          if (savedData != null) {
            setState(() {
              selectedLanguage = savedData.language ?? 'sw';
              selectedRegion = savedData.region;
              selectedDistrict = savedData.district;
              selectedWard = savedData.ward;
              streetController.text = savedData.streetOrVillage ?? '';
            });
          }
        });
      });
    } else {
      loadAndTransformTanzaniaData().then((data) {
        setState(() {
          tanzaniaData = data;
        });
        _controller.fetchSavedData(id: widget.group_info_id).then((savedData) {
          if (savedData != null) {
            setState(() {
              selectedLanguage = savedData.language ?? 'sw';
              selectedRegion = savedData.region;
              selectedDistrict = savedData.district;
              selectedWard = savedData.ward;
              streetController.text = savedData.streetOrVillage ?? '';
            });
          }
        });
      });
    }
  }

  Future<Map<String, Map<String, List<String>>>>
      loadAndTransformKenyaData() async {
    String jsonString = await rootBundle.loadString('assets/data/kenya.json');
    Map<String, dynamic> rawData = json.decode(jsonString);
    Map<String, Map<String, List<String>>> result = {};

    rawData.forEach((county, countyData) {
      Map<String, dynamic> districts = (countyData
          as Map<String, dynamic>)['districts'] as Map<String, dynamic>;
      Map<String, List<String>> districtMap = {};

      districts.forEach((subcounty, subcountyData) {
        Map<String, dynamic> wards = (subcountyData
            as Map<String, dynamic>)['wards'] as Map<String, dynamic>;
        List<String> wardList = wards.keys.toList();
        districtMap[subcounty] = wardList;
      });

      result[county] = districtMap;
    });

    return result;
  }

  Future<Map<String, Map<String, List<String>>>>
      loadAndTransformTanzaniaData() async {
    String jsonString = await rootBundle.loadString('assets/data/regions.json');
    Map<String, dynamic> rawData = json.decode(jsonString);
    return rawData.map((region, regionData) {
      return MapEntry(
        region,
        (regionData['districts'] as Map<String, dynamic>)
            .map((district, districtData) {
          return MapEntry(district,
              (districtData['wards'] as Map<String, dynamic>).keys.toList());
        }),
      );
    });
  }

  Future<void> _saveData() async {
    if (_formKey.currentState!.validate()) {
      try {
        await _controller.updateGroupInformation(
          widget.group_info_id,
          {
            'region': selectedRegion,
            'district': selectedDistrict,
            'ward': selectedWard,
            'language': selectedLanguage,
            'streetOrVillage': streetController.text,
          },
        );

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text(AppLocalizations.of(context)!.dataSavedSuccessfully)),
        );

        if (widget.isEditingMode) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => GroupOverview(
                data_id: widget.group_info_id,
                mzungukoId: widget.mzungukoId,
              ),
            ),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PermissionsPage(
                data_id: widget.group_info_id,
              ),
            ),
          );
        }
      } catch (e) {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text(
        //       AppLocalizations.of(context)!.errorSavingData.replaceAll('{error}', e.toString())
        //     ),
        //   ),
        // );
      }
    }
  }

  void _changeLanguage(String languageCode) {
    setState(() {
      selectedLanguage = languageCode;
    });
    final languageProvider =
        Provider.of<LanguageProvider>(context, listen: false);
    languageProvider.setLocale(Locale(languageCode));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.locationInformation,
        showBackArrow: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!widget.isEditingMode)
                        DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            labelText:
                                AppLocalizations.of(context)!.selectLanguage,
                            border: OutlineInputBorder(),
                          ),
                          value: selectedLanguage,
                          isExpanded: true,
                          items: languages.map((lang) {
                            return DropdownMenuItem<String>(
                              value: lang['code'],
                              child: Text(lang['name']!),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            if (newValue != null) {
                              _changeLanguage(newValue);
                            }
                          },
                          validator: (value) => value == null
                              ? AppLocalizations.of(context)!
                                  .pleaseSelectLanguage
                              : null,
                        ),
                      SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                            labelText:
                                AppLocalizations.of(context)!.selectRegion,
                            border: OutlineInputBorder()),
                        value: selectedRegion,
                        items: regions
                            .map((region) => DropdownMenuItem(
                                value: region, child: Text(region)))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedRegion = value;
                            selectedDistrict = null;
                            selectedWard = null;
                          });
                        },
                        validator: (value) => value == null
                            ? AppLocalizations.of(context)!.pleaseSelectRegion
                            : null,
                      ),
                      SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                            labelText:
                                AppLocalizations.of(context)!.selectDistrict,
                            border: OutlineInputBorder()),
                        value: selectedDistrict,
                        items: districts
                            .map((district) => DropdownMenuItem(
                                value: district, child: Text(district)))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedDistrict = value;
                            selectedWard = null;
                          });
                        },
                        validator: (value) => (selectedRegion != null &&
                                value == null)
                            ? AppLocalizations.of(context)!.pleaseSelectDistrict
                            : null,
                      ),
                      SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!.selectWard,
                            border: OutlineInputBorder()),
                        value: selectedWard,
                        items: wards
                            .map((ward) => DropdownMenuItem(
                                value: ward, child: Text(ward)))
                            .toList(),
                        onChanged: (value) =>
                            setState(() => selectedWard = value),
                        validator: (value) =>
                            (selectedDistrict != null && value == null)
                                ? AppLocalizations.of(context)!.pleaseSelectWard
                                : null,
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: streetController,
                        decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!
                                .enterStreetOrVillage,
                            border: OutlineInputBorder()),
                        validator: (value) => (value == null || value.isEmpty)
                            ? AppLocalizations.of(context)!
                                .pleaseEnterStreetOrVillage
                            : null,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 4,
                    offset: Offset(0, -1),
                  ),
                ],
              ),
              child: CustomButton(
                color: Color.fromARGB(255, 4, 34, 207),
                buttonText: AppLocalizations.of(context)!
                    .continueText, // Changed from .continue to .continueText
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _saveData();
                  }
                },
                type: ButtonType.elevated,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
