import 'package:chomoka/model/GroupLeadersModel.dart';
import 'package:chomoka/model/GroupMemberModel.dart';
import 'package:chomoka/model/InitSetupModel.dart';
import 'package:chomoka/model/KatibaModel.dart';
import 'package:chomoka/model/FainiModel.dart';
import 'package:chomoka/model/MzungukoModel.dart';
import 'package:chomoka/model/PasswordModel.dart';
import 'package:chomoka/model/MfukoJamiiModel.dart';
import 'package:chomoka/model/MifukoMingineModel.dart';
import 'package:chomoka/view/group_setup/constitution_information/faini.dart';
import 'package:chomoka/view/group_setup/constitution_information/cmg_mode/cmg_group_leaders.dart';
import 'package:chomoka/view/group_setup/constitution_information/loan_amount.dart';
import 'package:chomoka/view/group_setup/constitution_information/cmg_mode/cmg_savings.dart';
import 'package:chomoka/view/group_setup/constitution_information/vsla_mode/vsla_group_leaders.dart';
import 'package:chomoka/view/group_setup/fund_information/MfukoJamiiSummary.dart';
import 'package:chomoka/view/group_setup/home_page.dart';
import 'package:chomoka/view/dashboard/dashboard.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/view/group_setup/constitution_information/vsla_mode/vsla_saving.dart';
import 'package:chomoka/l10n/app_localizations.dart';

import 'package:provider/provider.dart';
import 'package:chomoka/providers/currency_provider.dart';
import 'package:chomoka/utils/currency_formatter.dart';
import 'package:chomoka/model/BaseModel.dart';

class Refferee extends StatefulWidget {
  final dynamic groupId;
  final int mzungukoId;
  final bool isUpdateMode;

  Refferee({
    super.key,
    this.groupId,
    required this.mzungukoId,
    this.isUpdateMode = false,
  });

  @override
  State<Refferee> createState() => _ReffereeState();
}

class _ReffereeState extends State<Refferee> {
  final TextEditingController _refereeController = TextEditingController();
  String _selectedOption = 'Hapana';
  final List<String> _options = [
    'Ndio',
    'Hapana',
  ];

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _fetchSavedData();
  }

  @override
  void dispose() {
    _refereeController.dispose();
    super.dispose();
  }

  Future<void> _fetchSavedData() async {
    try {
      final katibaModel = KatibaModel();

      final needData = await katibaModel
          .where('katiba_key', '=', 'need_wadhamini')
          .where('mzungukoId', '=', widget.mzungukoId)
          .findOne();

      final idadiData = await katibaModel
          .where('katiba_key', '=', 'idadi_wadhamini')
          .where('mzungukoId', '=', widget.mzungukoId)
          .findOne();

      String needValue = '0';
      String idadiValue = '0';

      if (needData != null &&
          needData is KatibaModel &&
          needData.value != null) {
        needValue = needData.value!;
      }

      if (idadiData != null &&
          idadiData is KatibaModel &&
          idadiData.value != null) {
        idadiValue = idadiData.value!;
      }

      setState(() {
        if (needValue == '1') {
          _selectedOption = 'Ndio';
          _refereeController.text = idadiValue;
        } else {
          _selectedOption = 'Hapana';
          _refereeController.clear();
        }
      });
    } catch (e) {
      print('Error fetching saved data: $e');
      // Optionally, show an error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text('Imeshindikana kuchukua taarifa. Tafadhali jaribu tena.')),
      );
    }
  }

  Future<void> _saveData() async {
    if (!_formKey.currentState!.validate()) {
      // If form is not valid, do not proceed
      return;
    }

    try {
      final katibaModel = KatibaModel();

      String needValue = _selectedOption == 'Ndio' ? '1' : '0';
      String idadiValue = '0';

      if (_selectedOption == 'Ndio') {
        idadiValue =
            _refereeController.text.isNotEmpty ? _refereeController.text : '0';
      }

      // Update or create the 'need_wadhamini' record
      final needData = await katibaModel
          .where('katiba_key', '=', 'need_wadhamini')
          .where('mzungukoId', '=', widget.mzungukoId)
          .findOne();

      if (needData != null && needData is KatibaModel) {
        await KatibaModel()
            .where('katiba_key', '=', 'need_wadhamini')
            .where('mzungukoId', '=', widget.mzungukoId)
            .update({'value': needValue});
      } else {
        await KatibaModel(
          katiba_key: 'need_wadhamini',
          value: needValue,
          mzungukoId: widget.mzungukoId, // Save mzungukoId in the new record
        ).create();
      }

      // Update or create the 'idadi_wadhamini' record
      final idadiData = await katibaModel
          .where('katiba_key', '=', 'idadi_wadhamini')
          .where('mzungukoId', '=', widget.mzungukoId)
          .findOne();

      if (idadiData != null && idadiData is KatibaModel) {
        await KatibaModel()
            .where('katiba_key', '=', 'idadi_wadhamini')
            .where('mzungukoId', '=', widget.mzungukoId)
            .update({'value': idadiValue});
      } else {
        await KatibaModel(
          katiba_key: 'idadi_wadhamini',
          value: idadiValue,
          mzungukoId: widget.mzungukoId, // Save mzungukoId in the new record
        ).create();
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Taarifa zimehifadhiwa vizuri!')),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => ConstitutionOverview(
                  groupId: widget.groupId,
                  mzungukoId: widget.mzungukoId,
                )),
      );

      print(
          'Data Imehifadhiwa. need_wadhamini=$needValue, idadi_wadhamini=$idadiValue');
    } catch (e) {
      print('Error saving data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text('Imeshindikana kuhifadhi data. Tafadhali jaribu tena.')),
      );
    }
  }

  String _generateExampleText() {
    final int? wadhamini = int.tryParse(_refereeController.text);
    if (wadhamini == null || wadhamini <= 0) {
      return '';
    }

    final double amountPerSponsor = 150000 / wadhamini;
    return 'Kwa mfano ikiwa Pili hawezi kulipa deni lake la TZS 150,000 la mkopo wakati wa kugawana, akiba ya wanachama ${wadhamini.toString()} waliomdhamini mkopo wake, itapunguzwa kwa TZS ${amountPerSponsor.toStringAsFixed(0)} kwa kila mmoja.';
  }

  @override
  Widget build(BuildContext context) {
    print(widget.groupId);
    final String exampleText = _generateExampleText();
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.constitutionInfo,
        subtitle: AppLocalizations.of(context)!.loanGuarantors,
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey, // Assign the form key
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Text(
                  AppLocalizations.of(context)!.doesLoanNeedGuarantor,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                CustomRadioGroup<String>(
                  labelText: '',
                  options: [
                    AppLocalizations.of(context)!.yes,
                    AppLocalizations.of(context)!.no
                  ],
                  value: _selectedOption == 'Ndio'
                      ? AppLocalizations.of(context)!.yes
                      : AppLocalizations.of(context)!.no,
                  onChanged: (String newValue) {
                    setState(() {
                      _selectedOption =
                          newValue == AppLocalizations.of(context)!.yes
                              ? 'Ndio'
                              : 'Hapana';
                      if (_selectedOption == 'Ndio') {
                        // If user switches to 'Ndio', show the field
                      } else {
                        _refereeController.clear();
                      }
                    });
                  },
                ),
                if (_selectedOption == 'Ndio') // Asilimia
                  CustomTextField(
                    aboveText: AppLocalizations.of(context)!.numberOfGuarantors,
                    labelText: AppLocalizations.of(context)!.numberOfGuarantors,
                    hintText:
                        AppLocalizations.of(context)!.enterNumberOfGuarantors,
                    keyboardType: TextInputType.number,
                    controller: _refereeController,
                    obscureText: false,
                    onChanged: (_) {
                      setState(() {}); // Trigger rebuild on input change
                    },
                    validator: (value) {
                      if (_selectedOption != 'Ndio')
                        return null; // Skip validation if not selected
                      if (value == null || value.trim().isEmpty) {
                        return AppLocalizations.of(context)!
                            .numberOfGuarantorsRequired;
                      }
                      final parsed = int.tryParse(value);
                      if (parsed == null || parsed <= 0) {
                        return AppLocalizations.of(context)!
                            .pleaseEnterValidNumber;
                      }
                      return null; // Valid input
                    },
                  ),
                SizedBox(height: 16),
                if (exampleText.isEmpty)
                  Text(
                    AppLocalizations.of(context)!.describeNumberOfGuarantors,
                    style: TextStyle(fontSize: 16),
                  ),
                if (exampleText.isNotEmpty)
                  Container(
                    color: const Color.fromARGB(255, 197, 197, 197),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        exampleText,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                SizedBox(height: 20),
                CustomButton(
                  color: Color.fromARGB(255, 4, 34, 207),
                  buttonText: widget.isUpdateMode
                      ? AppLocalizations.of(context)!.update
                      : AppLocalizations.of(context)!.continue_,
                  onPressed: _saveData,
                  type: ButtonType.elevated,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ConstitutionOverview extends StatefulWidget {
  var groupId;
  var mzungukoId;
  final bool isUpdateMode;
  final bool fromDashboard;

  ConstitutionOverview({
    Key? key,
    this.groupId,
    this.mzungukoId,
    this.isUpdateMode = false,
    this.fromDashboard = false,
  }) : super(key: key);

  @override
  State<ConstitutionOverview> createState() => _ConstitutionOverviewState();
}

class _ConstitutionOverviewState extends State<ConstitutionOverview> {
  // Katiba-related fields
  String akibaLazimaValue = '';
  String akibaHiariValue = '';
  String mbinu = '';

  // Leaders
  String mwenyekiti = '';
  String katibu = '';
  String mwekaHazina = '';
  String mdhibit = '';
  String MhesabuPesaNamba1 = '';
  String MhesabuPesaNamba2 = '';
  String mfukoJamiiAmount = '';

  List<String> allUsers = [];

  Map<String, String?> selectedPositions = {
    'mwenyekiti': null,
    'katibu': null,
    'mweka_hazina': null,
    'mdhibit': null,
  };

  List<Map<String, String>> penalties = [];

  String loanMultiplier = '';
  String interestRate = '';
  String interestType = '';
  String refferees = '';
  String punishmentRate = '';
  String punishmentCalculation = '';
  bool isPasswordSetupComplete = false;
  bool _isMzungukoPending = false;
  int mzungukoId = 0;
  List<Map<String, String>> mifukoMingine = [];
  String _groupType = ''; // Add this variable

  // Add this method to fetch group type
  Future<void> _fetchGroupType() async {
    try {
      final katibaModel = KatibaModel();
      final groupTypeData = await katibaModel
          .where('katiba_key', '=', 'kanuni')
          //   .where('mzungukoId', '=', widget.mzungukoId)
          .findOne();

      if (groupTypeData != null && groupTypeData is KatibaModel) {
        setState(() {
          _groupType = groupTypeData.value ?? '';
        });
      }
    } catch (e) {
      print('Error fetching group type: $e');
    }
  }

  Future<void> _markKatibaAsCompleted() async {
    try {
      final initSetupModel = InitSetupModel(
        init_key: 'katiba',
        mzungukoId: widget.mzungukoId,
        value: 'complete',
      );

      await initSetupModel.create();

      if (widget.fromDashboard) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => dashboard(groupId: widget.groupId),
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => homePage(data_id: widget.groupId),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating group status: $e')),
      );
    }
  }

  Future<void> _fetchKatibaData() async {
    final katiba = KatibaModel();

    // For VSLA, we need to fetch share_value instead of akiba_lazima
    final groupTypeData = await katiba
        .where('katiba_key', '=', 'kanuni')
        // .where('mzungukoId', '=', widget.mzungukoId)
        .findOne();

    final isVSLA = groupTypeData != null &&
        groupTypeData is KatibaModel &&
        groupTypeData.value == 'VSLA';

    if (isVSLA) {
      // Try to get share_value first
      final shareValueData = await katiba
          .where('katiba_key', '=', 'share_value')
          .where('mzungukoId', '=', widget.mzungukoId)
          .findOne();

      if (shareValueData != null && shareValueData is KatibaModel) {
        akibaLazimaValue = shareValueData.value ?? '';
      }

      // If share_value is empty, try share_amount
      if (akibaLazimaValue.isEmpty) {
        final shareAmountData = await katiba
            .where('katiba_key', '=', 'share_amount')
            .where('mzungukoId', '=', widget.mzungukoId)
            .findOne();

        if (shareAmountData != null && shareAmountData is KatibaModel) {
          akibaLazimaValue = shareAmountData.value ?? '';
        }
      }
    } else {
      // For non-VSLA, use akiba_lazima as before
      final akibaLazimaData = await katiba
          .where('katiba_key', '=', 'akiba_lazima')
          .where('mzungukoId', '=', widget.mzungukoId)
          .findOne();
      if (akibaLazimaData != null && akibaLazimaData is KatibaModel) {
        akibaLazimaValue = akibaLazimaData.value ?? '';
      }
    }

    // Rest of the method remains the same
    final akibaHiariData = await katiba
        .where('katiba_key', '=', 'akiba_hiari')
        .where('mzungukoId', '=', widget.mzungukoId)
        .findOne();
    if (akibaHiariData != null && akibaHiariData is KatibaModel) {
      final savedValue = akibaHiariData.value;
      if (savedValue == 'Ndiyo ruhusu') {
        akibaHiariValue = 'Ndiyo ruhusu';
      } else if (savedValue == 'Hapana usiruhusu') {
        akibaHiariValue = 'Hapana usiruhusu';
      } else {
        akibaHiariValue = 'Ndiyo ruhusu';
      }
    } else {
      akibaHiariValue = 'Ndiyo ruhusu';
    }
  }

  Future<void> _fetchGroupLeaders() async {
    try {
      print('Fetching group leaders for group ${widget.groupId} and mzunguko ${widget.mzungukoId}');
      
      final groupLeaderModel = GroupLeaderModel();
      final leaderMaps = await groupLeaderModel
          .where('group_id', '=', widget.groupId)
          .where('mzungukoId', '=', widget.mzungukoId)
          .select();

      print('Found ${leaderMaps.length} leaders in database');
      
      // Reset all positions to default value
      setState(() {
        mwenyekiti = "Hakuna";
        katibu = "Hakuna";
        mwekaHazina = "Hakuna";
        mdhibit = "Hakuna";
        MhesabuPesaNamba1 = "Hakuna";
        MhesabuPesaNamba2 = "Hakuna";
      });

      if (leaderMaps.isEmpty) {
        print('No leaders found in database');
        return;
      }

      for (var leaderMap in leaderMaps) {
        final leader = GroupLeaderModel().fromMap(leaderMap);
        print('Processing leader: position=${leader.position}, userId=${leader.user_id}');
        
        if (leader.position != null && leader.user_id != null) {
          final userName = await _fetchUserName(leader.user_id);
          print('Found leader: ${leader.position} -> $userName');
          
          setState(() {
            final position = leader.position!.toLowerCase().trim();
            // Check both English and Swahili versions of the position
            if (position == 'mwenyekiti' || position == 'chairperson') {
              print('Setting mwenyekiti to $userName');
              mwenyekiti = userName ?? "Hakuna";
            } else if (position == 'katibu' || position == 'secretary') {
              print('Setting katibu to $userName');
              katibu = userName ?? "Hakuna";
            } else if (position == 'mweka hazina' || position == 'treasurer') {
              print('Setting mweka hazina to $userName');
              mwekaHazina = userName ?? "Hakuna";
            } else if (position == 'mdhibiti' || position == 'auditor') {
              print('Setting mdhibiti to $userName');
              mdhibit = userName ?? "Hakuna";
            } else if (position == 'mhesabu pesa namba 1' || position == 'counter1') {
              print('Setting mhesabu pesa namba 1 to $userName');
              MhesabuPesaNamba1 = userName ?? "Hakuna";
            } else if (position == 'mhesabu pesa namba 2' || position == 'counter2') {
              print('Setting mhesabu pesa namba 2 to $userName');
              MhesabuPesaNamba2 = userName ?? "Hakuna";
            } else {
              print("Unknown position: $position");
            }
          });
        }
      }

      print('Final leader values:');
      print('mwenyekiti: $mwenyekiti');
      print('katibu: $katibu');
      print('mwekaHazina: $mwekaHazina');
      print('mdhibit: $mdhibit');
      print('MhesabuPesaNamba1: $MhesabuPesaNamba1');
      print('MhesabuPesaNamba2: $MhesabuPesaNamba2');
      
    } catch (e) {
      print('Error fetching group leaders: $e');
    }
  }

  Future<String?> _fetchUserName(int? userId) async {
    if (userId == null) return null;

    try {
      final groupMember = GroupMembersModel();
      final userRecord = await groupMember
          .where('id', '=', userId)
          .findOne();

      if (userRecord != null) {
        final model = GroupMembersModel().fromMap(userRecord.toMap());
        print('Found user name: ${model.name} for ID: $userId');
        return model.name;
      }
      
      print('No user found for ID: $userId');
      return null;
    } catch (e) {
      print('Error fetching user name for ID $userId: $e');
      return null;
    }
  }

  Future<void> _fetchFines() async {
    if (widget.groupId == null) {
      print("No groupId provided");
      return;
    }

    final faini = FainiModel();
    final fineRecords =
        await faini.where('mzungukoId', '=', widget.mzungukoId).select();

    final fineModels =
        fineRecords.map((record) => FainiModel().fromMap(record)).toList();

    penalties.clear();
    for (var fine in fineModels) {
      String priceValue = fine.penaltiesPrice ?? '0';
      double fineValue = double.tryParse(priceValue.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0;
      penalties.add({'description': fine.penaltiesName ?? '', 'value': fineValue.toString()});
    }
  }

  Future<void> _fetchMkopoData() async {
    final katiba = KatibaModel();

    final multiplierData = await katiba
        .where('katiba_key', '=', 'loanMultiplierValue')
        .where('mzungukoId', '=', widget.mzungukoId)
        .findOne();
    if (multiplierData != null && multiplierData is KatibaModel) {
      loanMultiplier = multiplierData.value ?? '';
    }

    // interest_rate
    final interestRateData = await katiba
        .where('katiba_key', '=', 'interest_rate')
        .where('mzungukoId', '=', widget.mzungukoId)
        .findOne();
    if (interestRateData != null && interestRateData is KatibaModel) {
      interestRate = interestRateData.value ?? '';
    }

    // interest_type
    final interestTypeData = await katiba
        .where('katiba_key', '=', 'interest_type')
        .where('mzungukoId', '=', widget.mzungukoId)
        .findOne();
    if (interestTypeData != null && interestTypeData is KatibaModel) {
      interestType = interestTypeData.value ?? '';
    }

    final reffereenumber = await katiba
        .where('katiba_key', '=', 'idadi_wadhamini')
        .where('mzungukoId', '=', widget.mzungukoId)
        .findOne();
    if (reffereenumber != null && reffereenumber is KatibaModel) {
      refferees = reffereenumber.value ?? '';
    }

    final punishmentAsilimiaData = await katiba
        .where('katiba_key', '=', 'asilimia')
        .where('mzungukoId', '=', widget.mzungukoId)
        .findOne();
    final punishmentKiasiData = await katiba
        .where('katiba_key', '=', 'kiasi_maalumu')
        .where('mzungukoId', '=', widget.mzungukoId)
        .findOne();

    if (punishmentAsilimiaData != null &&
        punishmentAsilimiaData is KatibaModel &&
        (punishmentAsilimiaData.value?.isNotEmpty ?? false)) {
      punishmentRate = punishmentAsilimiaData.value ?? '';
      punishmentCalculation = AppLocalizations.of(context)!.percentage;
    } else if (punishmentKiasiData != null &&
        punishmentKiasiData is KatibaModel &&
        (punishmentKiasiData.value?.isNotEmpty ?? false)) {
      punishmentRate = punishmentKiasiData.value ?? '';
      punishmentCalculation = AppLocalizations.of(context)!.fixedAmount;
    }

    if (punishmentRate.isEmpty) {
      punishmentRate = '0%';
      punishmentCalculation = AppLocalizations.of(context)!.percentage;
    }
  }

  Future<void> _checkPasswordCompletionStatus() async {
    try {
      final passwordModel = PasswordModel();

      final data = await passwordModel.where('status', '=', 'complete').find();

      if (data != null && data.isNotEmpty) {
        setState(() {
          isPasswordSetupComplete = true;
        });
        print("Password setup is complete.");
      } else {
        setState(() {
          isPasswordSetupComplete = false;
        });
        print("Password setup is not complete.");
      }
    } catch (e) {
      print("Error checking password completion: $e");
    }
  }

  Future<void> _fetchMzungukoId() async {
    final mzungukoModel = MzungukoModel();
    final mzungukoResult =
        await mzungukoModel.where('status', '=', 'pending').findOne();
    final int? fetchedMzungukoId =
        (mzungukoResult != null && mzungukoResult is MzungukoModel)
            ? mzungukoResult.id
            : null;

    if (fetchedMzungukoId != null) {
      setState(() {
        mzungukoId = fetchedMzungukoId;
        _isMzungukoPending = true;
      });
    } else {
      setState(() {
        _isMzungukoPending = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Optionally, add a flag to avoid double-fetching if needed
    _fetchData();
  }

  Future<void> _fetchMfukoJamiiAmount() async {
    try {
      final mfukoJamiiModel = MfukoJamiiModel();
      final mfukoData = await mfukoJamiiModel
          .where('mfuko_key', '=', 'Kiasi cha Kuchangia')
          .where('mzungukoId', '=', widget.mzungukoId)
          .findOne();

      if (mfukoData != null && mfukoData is MfukoJamiiModel) {
        setState(() {
          mfukoJamiiAmount = mfukoData.value ?? '0';
        });
      } else {
        setState(() {
          mfukoJamiiAmount = '0';
        });
      }
    } catch (e) {
      print('Error fetching mfuko jamii amount: $e');
      setState(() {
        mfukoJamiiAmount = '0';
      });
    }
  }

  Future<void> _fetchMifukoMingine() async {
    try {
      final mifukoMingineModel = MifukoMingineModel();
      final mifukoData = await mifukoMingineModel
          .where('mzungukoId', '=', widget.mzungukoId)
          .where('status', '=', 'hai')
          .select();

      mifukoMingine.clear();

      if (mifukoData.isNotEmpty) {
        for (var mfukoMap in mifukoData) {
          final mfuko = mifukoMingineModel.fromMap(mfukoMap);
          if (mfuko.mfukoName != null) {
            String amount;
            if (mfuko.mfukoAmount == null ||
                mfuko.mfukoAmount!.trim().isEmpty) {
              amount = 'Kiwango Chochote';
              mifukoMingine.add({'description': '${mfuko.mfukoName}:', 'value': amount});
            } else {
              amount = mfuko.mfukoAmount!;
              double amountValue = double.tryParse(amount.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0;
              mifukoMingine.add({'description': '${mfuko.mfukoName}:', 'value': amountValue.toString()});
            }
          }
        }
      }

      setState(() {});
    } catch (e) {
      print('Error fetching mifuko mingine: $e');
    }
  }

  Future<void> _fetchData() async {
    await _fetchGroupType();
    await _fetchKatibaData();
    await _fetchGroupLeaders();
    await _fetchFines();
    await _fetchMkopoData();
    await _fetchMzungukoId();
    await _fetchMfukoJamiiAmount();
    await _fetchMifukoMingine();

    setState(() {
      mbinu = _groupType == 'VSLA'
          ? 'VSLA'
          : 'CMG'; // Update mbinu based on group type
    });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.groupId);
    final bool isVSLA = _groupType == 'VSLA';
    final currencyCode = Provider.of<CurrencyProvider>(context).currencyCode;
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.constitutionTitle,
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CustomCard(
                titleText: AppLocalizations.of(context)!.membershipRules,
                onEdit: _isMzungukoPending
                    ? () {
                        print("Edit " +
                            AppLocalizations.of(context)!.membershipRules);
                      }
                    : null,
                items: [
                  {
                    'description': AppLocalizations.of(context)!.method,
                    'value': mbinu
                  },
                ],
              ),
              SizedBox(height: 10),
              isVSLA
                  ? CustomCard(
                      titleText: AppLocalizations.of(context)!.shares,
                      onEdit: _isMzungukoPending
                          ? () async {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => VslaSaving(
                                          groupId: widget.groupId,
                                          mzungukoId: widget.mzungukoId,
                                        )),
                              );
                              // Refresh data after returning
                              _fetchData();
                            }
                          : null,
                      items: [
                        {
                          'description':
                              AppLocalizations.of(context)!.shareValue,
                          'value': formatCurrency((double.tryParse(akibaLazimaValue.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0).toInt(), currencyCode)
                        },
                      ],
                    )
                  : CustomCard(
                      titleText: AppLocalizations.of(context)!.savings,
                      onEdit: _isMzungukoPending
                          ? () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Savings(
                                          groupId: widget.groupId,
                                          isUpdateMode: true,
                                          mzungukoId: widget.mzungukoId,
                                        )),
                              );
                            }
                          : null,
                      items: [
                        {
                          'description': AppLocalizations.of(context)!
                              .mandatorySavingsValue,
                          'value': formatCurrency((double.tryParse(akibaLazimaValue.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0).toInt(), currencyCode)
                        },
                        {
                          'description':
                              AppLocalizations.of(context)!.voluntarySavings,
                          'value': akibaHiariValue
                        },
                      ],
                    ),
              SizedBox(height: 10),
              CustomCard(
                titleText: AppLocalizations.of(context)!.groupLeaders,
                onEdit: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VslaGroupLeaders(
                        groupId: widget.groupId,
                        isUpdateMode: true,
                        mzungukoId: widget.mzungukoId,
                      ),
                    ),
                  );
                  // Refresh data after returning
                  _fetchData();
                },
                items: isVSLA
                    ? [
                        {
                          'description':
                              AppLocalizations.of(context)!.chairperson,
                          'value': mwenyekiti ?? "Hakuna"
                        },
                        {
                          'description':
                              AppLocalizations.of(context)!.secretary,
                          'value': katibu ?? "Hakuna"
                        },
                        {
                          'description':
                              AppLocalizations.of(context)!.treasurer,
                          'value': mwekaHazina ?? "Hakuna"
                        },
                        {
                          'description':
                              AppLocalizations.of(context)!.cashCounter1,
                          'value': MhesabuPesaNamba1 ?? "Hakuna"
                        },
                        {
                          'description':
                              AppLocalizations.of(context)!.cashCounter2,
                          'value': MhesabuPesaNamba2 ?? "Hakuna"
                        },
                      ]
                    : [
                        {
                          'description':
                              AppLocalizations.of(context)!.chairperson,
                          'value': mwenyekiti ?? "Hakuna"
                        },
                        {
                          'description':
                              AppLocalizations.of(context)!.secretary,
                          'value': katibu ?? "Hakuna"
                        },
                        {
                          'description':
                              AppLocalizations.of(context)!.treasurer,
                          'value': mwekaHazina ?? "Hakuna"
                        },
                        {
                          'description': AppLocalizations.of(context)!.auditor,
                          'value': mdhibit ?? "Hakuna"
                        },
                      ],
              ),
              SizedBox(height: 10),
              if (widget.fromDashboard)
                CustomCard(
                  titleText: AppLocalizations.of(context)!.contributions,
                  onEdit: () {
                    print(
                        "Edit " + AppLocalizations.of(context)!.contributions);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MfukoSummaryPage(
                                fromDashboard: true,
                                mzungukoId: widget.mzungukoId,
                              )),
                    );
                  },
                  items: [
                    {
                      'description':
                          AppLocalizations.of(context)!.communityFundAmount,
                      'value': formatCurrency((double.tryParse(mfukoJamiiAmount.replaceAll(RegExp(r'[^0-9.]'), '')) ?? 0).toInt(), currencyCode)
                    },
                    ...mifukoMingine.map((mfuko) => {
                      'description': mfuko['description'] ?? '',
                      'value': mfuko['value'] == 'Kiwango Chochote'
                          ? 'Kiwango Chochote'
                          : formatCurrency((double.tryParse(mfuko['value'] ?? '0') ?? 0).toInt(), currencyCode),
                    }).toList(),
                  ],
                ),
              SizedBox(height: 10),
              CustomCard(
                titleText: AppLocalizations.of(context)!.fines,
                onEdit: _isMzungukoPending
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FainiPage(
                                    groupId: widget.groupId,
                                    isUpdateMode: true,
                                    mzungukoId: widget.mzungukoId,
                                  )),
                        );
                        print("Edit " + AppLocalizations.of(context)!.fines);
                      }
                    : null,
                items: penalties.isNotEmpty
                    ? penalties.map((penalty) => {
                        'description': penalty['description'] ?? '',
                        'value': formatCurrency((double.tryParse(penalty['value'] ?? '0') ?? 0).toInt(), currencyCode),
                      } as Map<String, String>).toList()
                    : [
                        {
                          'description': AppLocalizations.of(context)!.noFines,
                          'value': ''
                        }
                      ],
              ),
              SizedBox(height: 10),
              CustomCard(
                titleText: AppLocalizations.of(context)!.loan,
                onEdit: _isMzungukoPending
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoanAmount(
                                    groupId: widget.groupId,
                                    isUpdateMode: true,
                                    mzungukoId: widget.mzungukoId,
                                  )),
                        );
                        print("Edit " + AppLocalizations.of(context)!.loan);
                      }
                    : null,
                items: [
                  {
                    'description': AppLocalizations.of(context)!.loanMultiplier,
                    'value': loanMultiplier
                  },
                  {
                    'description':
                        AppLocalizations.of(context)!.loanInterestType,
                    'value': interestType
                  },
                  {
                    'description': AppLocalizations.of(context)!.loanInterest,
                    'value': '$interestRate%'
                  },
                  {
                    'description': AppLocalizations.of(context)!.guarantorCount,
                    'value': '$refferees'
                  },
                  {
                    'description':
                        AppLocalizations.of(context)!.penaltyCalculation,
                    'value': punishmentCalculation
                  },
                  {
                    'description':
                        AppLocalizations.of(context)!.lateLoanPenalty,
                    'value': '$punishmentRate'
                  },
                ],
              ),
              SizedBox(height: 20),
              CustomButton(
                color: Color.fromARGB(255, 4, 34, 207),
                buttonText: AppLocalizations.of(context)!.finished,
                onPressed: () {
                  if (_isMzungukoPending) {
                    _markKatibaAsCompleted();
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => dashboard(
                                groupId: widget.groupId,
                              )),
                    );
                  }
                },
                type: ButtonType.elevated,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
