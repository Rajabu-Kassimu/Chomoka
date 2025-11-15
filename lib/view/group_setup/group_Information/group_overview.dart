import 'package:chomoka/model/AkibaHiariModel.dart';
import 'package:chomoka/model/AkibaLazimaModel.dart';
import 'package:chomoka/model/GroupInformationModel.dart';
import 'package:chomoka/model/GroupMemberModel.dart';
import 'package:chomoka/model/InitSetupModel.dart';
import 'package:chomoka/model/MzungukoModel.dart';
import 'package:chomoka/model/PasswordModel.dart';
import 'package:chomoka/model/RejeshaMkopoModel.dart';
import 'package:chomoka/model/ToaAkibaHiari.dart';
import 'package:chomoka/model/ToaMfukoJamiiModel.dart';
import 'package:chomoka/model/UchangiajiMfukoJamiiModel.dart';
import 'package:chomoka/model/UserFainiModel.dart';
import 'package:chomoka/model/VikaoVilivyopitaModel.dart';
import 'package:chomoka/Service/sms_server.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/cmg/Faini_page/lipa_faini.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/cmg/rejesha_mkopo/rejesha_mkopo.dart';
import 'package:chomoka/view/group_setup/RegionDistrictWard.dart';
import 'package:chomoka/view/group_setup/group_Information/group_Info.dart';
import 'package:chomoka/view/group_setup/group_Information/group_Registration.dart';
import 'package:chomoka/view/group_setup/group_Information/group_Summary.dart';
import 'package:chomoka/view/group_setup/group_Information/group_institution.dart';
import 'package:chomoka/view/group_setup/home_page.dart';
import 'package:chomoka/view/dashboard/dashboard.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/model/UwekajiKwaMkupuoModel.dart';
import 'dart:convert';
import 'package:chomoka/l10n/app_localizations.dart';

import 'package:provider/provider.dart';
import 'package:chomoka/providers/currency_provider.dart';
import 'package:chomoka/utils/currency_formatter.dart';

class GroupOverview extends StatefulWidget {
  final int? data_id;
  final bool isEditingMode;
  final bool fromDashboard;
  final bool fromGroupOverview;
  var mzungukoId;

  GroupOverview({
    Key? key,
    this.data_id,
    this.isEditingMode = false,
    this.mzungukoId,
    this.fromDashboard = false,
    this.fromGroupOverview = false,
  }) : super(key: key);

  @override
  State<GroupOverview> createState() => _GroupOverviewState();
}

class _GroupOverviewState extends State<GroupOverview>
    with SingleTickerProviderStateMixin {
  GroupInformationModel? groupData;
  bool isLoading = true;
  late TabController _tabController;
  double _akibaLazimaTotal = 0;
  double _unpaidakibaLazimaTotal = 0;
  double _totalAkibaHiari = 0;
  double _mfukoJamiiTotal = 0;
  double _unpaidmfukoJamiiTotal = 0;
  double _kilichotolewaAkibaHiari = 0;
  double _kilichotolewaMfukoJamii = 0;
  double _mkopoWasasaTotal = 0;
  double _fainiTotal = 0;
  double _salioTotal = 0;
  double _salioLililolala = 0;
  int mzungukoId = 0;
  bool isPasswordSetupComplete = false;
  bool _isMzungukoPending = false;
  double _jumlaYaAkiba = 0;
  double _mfukoWaJamiiSalio = 0;
  double _akibaBinafsiSalio = 0;
  double _paidLoanTotal = 0;
  double _unpaidFainiTotal = 0;
  double totalContributions = 0;
  double totalAkiba = 0;
  Map<String, void Function(double)>? fieldSetters;
  var _members = [];

  Future<void> _fetchSavedData() async {
    try {
      final groupInformationModel = GroupInformationModel();
      final data = await groupInformationModel
          // .where('id', '=', widget.data_id)
          .findOne();

      setState(() {
        groupData = data as GroupInformationModel?;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching group data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _fetchSalioLilolala() async {
    try {
      final vikaoModel = VikaovilivyopitaModel();

      for (final key in fieldSetters!.keys) {
        final data = await vikaoModel
            .where('kikao_key', '=', key)
            .where('mzungukoId', '=', widget.mzungukoId)
            .findOne();

        final value = data != null && data is VikaovilivyopitaModel
            ? double.tryParse(data.value ?? '0') ?? 0
            : 0;

        setState(() {
          fieldSetters![key]?.call(value.toDouble());
        });
      }

      print('Fetched values: salioLililolala=$_salioLililolala, '
          'jumlaYaAkiba=$_jumlaYaAkiba, '
          'mfukoWaJamiiSalio=$_mfukoWaJamiiSalio, '
          'akibaBinafsiSalio=$_akibaBinafsiSalio');
    } catch (e) {
      print('Error fetching field values: $e');
      setState(() {
        _salioLililolala = 0;
        _jumlaYaAkiba = 0;
        _mfukoWaJamiiSalio = 0;
        _akibaBinafsiSalio = 0;
      });
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

  Future<void> _markGroupInfoAsCompleted() async {
    if (mzungukoId == null) {
      return;
    }
    try {
      final initSetupModel = InitSetupModel(
        init_key: 'group_info',
        mzungukoId: mzungukoId,
        value: 'complete',
      );
      final createdId = await initSetupModel.create();

      print("Created record ID: $createdId");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Taarifa za Kikundi zimehifadhiwa kikamilifu!')),
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => homePage(
            data_id: widget.data_id,
          ),
        ),
      );
    } catch (e) {
      print("Error saving group info: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating group status: $e')),
      );
    }
  }

  Future<void> _fetchAkibaLazimaDetails() async {
    try {
      final akibaLazimaModel = AkibaLazimaModel();

      final records = await akibaLazimaModel
          .where('mzungukoId', '=', widget.mzungukoId)
          .select();

      double totalSum = 0.0;
      if (records.isNotEmpty) {
        totalSum = records.fold(0.0, (sum, record) {
          final amount = (record['amount'] as num?)?.toDouble() ?? 0;
          return sum + amount;
        });
      }

      setState(() {
        _akibaLazimaTotal = totalSum;
      });

      print(
          'Total Akiba Lazima for mzungukoId ${widget.mzungukoId}: $_akibaLazimaTotal');
    } catch (e) {
      print('Error fetching total Akiba Lazima: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Kuna tatizo la kupakia jumla ya Akiba Lazima.'),
        ),
      );
    }
  }

  Future<void> _fetchTotalAkibaHiari() async {
    try {
      final akibaHiariModel = AkibaHiari();

      // Fetch all records
      final records = await akibaHiariModel
          .where('mzungukoId', '=', widget.mzungukoId)
          .select();

      double totalAmount = 0;

      if (records.isNotEmpty) {
        totalAmount = records.fold(0, (sum, record) {
          final amount = (record['amount'] as num?)?.toDouble() ?? 0;
          return sum + amount; // Ensure `amount` is always a `double`
        });
      }

      setState(() {
        _totalAkibaHiari = totalAmount;
      });

      print('Total Akiba Hiari: $_totalAkibaHiari');
    } catch (e) {
      print('Error fetching total Akiba Hiari: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Kuna tatizo la kupakia jumla ya Akiba Hiari.'),
        ),
      );
    }
  }

  Future<void> _fetchMfukoJamiiData() async {
    try {
      final mfukoJamiiModel = UchangaajiMfukoJamiiModel();

      final records = await mfukoJamiiModel
          .where('mzungukoId', '=', widget.mzungukoId)
          .where('paid_status', '=', 'paid')
          .select();

      double totalSum = 0.0;

      if (records.isNotEmpty) {
        totalSum = records.fold(0.0, (sum, record) {
          final amount = (record['total'] as num?)?.toDouble() ?? 0;
          return sum + amount;
        });
      }

      setState(() {
        _mfukoJamiiTotal = totalSum;
      });

      print(
          'Total Mfuko Jamii for mzungukoId ${widget.mzungukoId}: $_mfukoJamiiTotal');
    } catch (e) {
      print('Error fetching Mfuko Jamii data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Kuna tatizo la kupakia jumla ya Mfuko Jamii.'),
        ),
      );
    }
  }

  Future<void> _fetchMkopoWasasaTotal() async {
    try {
      final rejeshaMkopoModel = RejeshaMkopoModel();
      final results = await rejeshaMkopoModel
          .where('mzungukoId', '=', widget.mzungukoId)
          .select();

      if (results.isNotEmpty) {
        double total = results
            .map((entry) => (entry['unpaidAmount'] ?? 0).toDouble())
            .fold(0, (sum, element) => sum + element);
        double paidtotal = results
            .map((entry) => (entry['paidAmount'] ?? 0).toDouble())
            .fold(0, (sum, element) => sum + element);

        setState(() {
          _mkopoWasasaTotal = total;
          _paidLoanTotal = paidtotal;
        });
      } else {
        setState(() {
          _mkopoWasasaTotal = 0;
        });
      }
    } catch (e) {
      print('Error fetching Mkopo wa Sasa total: $e');
      setState(() {
        _mkopoWasasaTotal = 0;
      });
    }
  }

  Future<void> _fetchFainiTotal() async {
    try {
      final userFainiModel = UserFainiModel();
      final results = await userFainiModel
          .where('mzungukoId', '=', widget.mzungukoId)
          .select();

      if (results.isNotEmpty) {
        double total = results
            .map((entry) => (entry['paidfaini'] ?? 0).toDouble())
            .fold(0, (sum, element) => sum + element);
        double unpaidtotal = results
            .map((entry) => (entry['unpaidfaini'] ?? 0).toDouble())
            .fold(0, (sum, element) => sum + element);

        setState(() {
          _fainiTotal = total;
          _unpaidFainiTotal = unpaidtotal;
        });

        print(_fainiTotal);
      } else {
        setState(() {
          _fainiTotal = 0;
        });
      }
    } catch (e) {
      print('Error fetching total unpaid fines: $e');
      setState(() {
        _fainiTotal = 0;
      });
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

  String _safeGetField(String? field, {String defaultValue = '-'}) {
    return field?.isNotEmpty == true ? field! : defaultValue;
  }

  _calculateTotal() {
    double total = (_akibaLazimaTotal +
        _mfukoJamiiTotal +
        _salioLililolala +
        _fainiTotal +
        totalContributions +
        _totalAkibaHiari +
        _totalAkibaHiari);
    setState(() {
      _salioTotal = total;
    });
  }

  Future<void> _fetchKilichotolewaMfukoJamii() async {
    try {
      final toaMfukoJamiiModel = ToaMfukoJamiiModel();

      toaMfukoJamiiModel.where('mzungukoId', '=', widget.mzungukoId);

      final records = await toaMfukoJamiiModel.select();
      double totalAmountWithdrawn = records.fold(0.0, (sum, record) {
        final amount = (record['amount'] as num?)?.toDouble() ?? 0.0;
        return sum + amount;
      });

      setState(() {
        _kilichotolewaMfukoJamii = totalAmountWithdrawn;
      });
    } catch (e) {
      print('Error fetching withdrawal data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Kuna tatizo la kupakia data za mfuko jamii.'),
        ),
      );
    }
  }

  Future<void> _fetchMembers() async {
    try {
      final groupMembersModel = GroupMembersModel();
      final savedMembers = await groupMembersModel.select();

      setState(() {
        _members = savedMembers;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching members: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  void _sendSms() async {
    await _fetchMembers();

    if (_members.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Hakuna wanachama waliopo"),
          backgroundColor: Colors.black,
        ),
      );
      return;
    }

    for (var member in _members) {
      String? phoneNumber = member['phone']?.toString();

      if (phoneNumber == null || phoneNumber.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Mwanachama ${member['name']} hana namba ya simu"),
            backgroundColor: Colors.black,
          ),
        );
        continue;
      }

      String message = """
Ndugu ${member['name']},

Muhtasari wa kikundi kwa ujumla ni:-

Akiba Lazima: ${formatCurrency(_akibaLazimaTotal, Provider.of<CurrencyProvider>(context, listen: false).currencyCode)}
Akiba Hiari: ${formatCurrency(_totalAkibaHiari, Provider.of<CurrencyProvider>(context, listen: false).currencyCode)}
Mfuko Jamii: ${formatCurrency(_mfukoJamiiTotal, Provider.of<CurrencyProvider>(context, listen: false).currencyCode)}
Mkopo wa Sasa: ${formatCurrency(_mkopoWasasaTotal, Provider.of<CurrencyProvider>(context, listen: false).currencyCode)}
Faini: ${formatCurrency(_fainiTotal, Provider.of<CurrencyProvider>(context, listen: false).currencyCode)}
Jumla ya Uwekaji wa Mkupuo: ${formatCurrency(totalContributions, Provider.of<CurrencyProvider>(context, listen: false).currencyCode)}
""";

      print("Kutuma SMS kwa ${member['name']} (${phoneNumber})");

      try {
        var sendSms = SmsService([phoneNumber], message);
        await sendSms.sendSms();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Muhtasari umetumwa kwa ${member['name']}"),
            backgroundColor: Colors.black,
          ),
        );
      } catch (e) {
        print("Error sending SMS to ${member['name']}: $e");

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Imeshindwa kutuma SMS kwa ${member['name']}"),
            backgroundColor: Colors.black,
          ),
        );
      }
    }
  }

  Future<void> _fetchContributions() async {
    try {
      final uwakajiModel = UwekajiKwaMkupuoModel();
      final results = await uwakajiModel
          .where('mzungukoId', '=', widget.mzungukoId)
          .select();

      // Calculate total amount
      double totalAmount = 0;
      for (var contribution in results) {
        // Safely handle null amounts by using null-aware operator
        final amount = contribution['amount'];
        if (amount != null) {
          totalAmount += (amount as num).toDouble();
        }
      }

      setState(() {
        totalContributions = totalAmount;
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching contributions: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> fetchSumToaAkibaHiari() async {
    try {
      var toaAkibaHiari = ToaAkibaHiariModel();
      final records = await toaAkibaHiari
          .where('mzungukoId', '=', widget.mzungukoId)
          .select();

      double totalWithdrawn = 0.0;

      if (records.isNotEmpty) {
        // Process history and withdrawals for each record
        for (var record in records) {
          List<Map<String, dynamic>> history = [];
          if (record['history'] != null) {
            try {
              history = List<Map<String, dynamic>>.from(
                  json.decode(record['history']));
            } catch (e) {
              print("Error decoding history: $e");
            }
          }

          // Sum up all withdrawals from history
          double withdrawn = history.fold(0.0, (sum, entry) {
            return sum + ((entry['amount'] as num?)?.toDouble() ?? 0.0);
          });

          totalWithdrawn += withdrawn;
        }
      }

      setState(() {
        totalAkiba = totalWithdrawn;
      });
      print('Toa akiba total for user $totalAkiba');
    } catch (e) {
      setState(() {
        totalAkiba = 0;
      });
    }
  }

  Future<void> _fetctData() async {
    await _fetchContributions();
    await _fetchSalioLilolala();
    await _fetchSavedData();
    await _fetchAkibaLazimaDetails();
    await _fetchTotalAkibaHiari();
    await _fetchMfukoJamiiData();
    await _fetchMkopoWasasaTotal();
    await _fetchFainiTotal();
    await _fetchKilichotolewaMfukoJamii();
    await fetchSumToaAkibaHiari();
    await _calculateTotal();
    await _checkPasswordCompletionStatus();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _fetchMzungukoId().then((_) {
      _fetctData();
    });
    _tabController = TabController(length: 2, vsync: this);
    fieldSetters = {
      'salio_lililolala_sandukuni': (value) => _salioLililolala = value,
      'jumla_ya_akiba': (value) => _jumlaYaAkiba = value,
      'mfuko_wa_jamii_salio': (value) => _mfukoWaJamiiSalio = value,
      'akiba_binafsi_salio': (value) => _akibaBinafsiSalio = value,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: isPasswordSetupComplete && !_isMzungukoPending
            ? _safeGetField(groupData?.name)
            : AppLocalizations.of(context)!.groupOverview,
        showBackArrow: true,
        bottom: isPasswordSetupComplete && !_isMzungukoPending
            ? TabBar(
                controller: _tabController,
                indicatorColor: Color.fromARGB(255, 255, 255, 255),
                labelColor: Color.fromARGB(255, 255, 255, 255),
                unselectedLabelColor: Colors.grey,
                tabs: [
                  Tab(text: AppLocalizations.of(context)!.fundOverview),
                  Tab(text: AppLocalizations.of(context)!.groupInfo),
                ],
              )
            : null,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : isPasswordSetupComplete && !_isMzungukoPending
              ? TabBarView(
                  controller: _tabController,
                  children: [
                    _buildTaarifaZaMfuko(),
                    _buildTaarifaZaKikundi(),
                  ],
                )
              : _buildTaarifaZaKikundi(),
    );
  }

  Widget _buildTaarifaZaMfuko() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: 500,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.fundOverview,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      formatCurrency(_salioTotal, Provider.of<CurrencyProvider>(context).currencyCode),
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Jumla ya Madeni: ' + formatCurrency((_mkopoWasasaTotal + _unpaidFainiTotal), Provider.of<CurrencyProvider>(context).currencyCode),
                      style: TextStyle(fontSize: 16, color: Colors.red),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
          _buildDetailsItem(
            "Akiba ya lazima iliyonunuliwa",
            formatCurrency(_akibaLazimaTotal, Provider.of<CurrencyProvider>(context).currencyCode),
            // secondaryText:
            //     "kiasi kinachodaiwa TZS ${(_unpaidakibaLazimaTotal).toStringAsFixed(0)}",
          ),
          Divider(),
          _buildDetailsItem(
            "Mfuko wa jamii salio",
            formatCurrency((_mfukoJamiiTotal + _mfukoWaJamiiSalio - _kilichotolewaMfukoJamii), Provider.of<CurrencyProvider>(context).currencyCode),
          ),
          Divider(),
          _buildDetailsItem("Salio la Akiba ya Hiari",
              formatCurrency((_totalAkibaHiari - _kilichotolewaAkibaHiari), Provider.of<CurrencyProvider>(context).currencyCode)),
          Divider(),
          _buildDetailsItemWithIcon(
            "Mikopo ya sasa iliyolipwa",
            formatCurrency(_paidLoanTotal, Provider.of<CurrencyProvider>(context).currencyCode),
            secondaryText: _mkopoWasasaTotal != 0
                ? 'Amount Owed: ' + formatCurrency(_mkopoWasasaTotal, Provider.of<CurrencyProvider>(context).currencyCode)
                : null,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RejeshaMkopoPage(
                    mzungukoId: widget.mzungukoId,
                    fromGroupOverview: true,
                    fromDashboard: true,
                  ),
                ),
              );
            },
          ),
          Divider(),
          _buildDetailsItemWithIcon(
            "Jumla ya faini zilizokusanywa",
            formatCurrency(_fainiTotal, Provider.of<CurrencyProvider>(context).currencyCode),
            secondaryText: _unpaidFainiTotal != 0
                ? 'Amount Owed: ' + formatCurrency(_unpaidFainiTotal, Provider.of<CurrencyProvider>(context).currencyCode)
                : null,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LipaFainiPage(
                      fromGroupOverview: true,
                      mzungukoId: widget.mzungukoId,
                      fromDashboard: true),
                ),
              );
            },
            // secondaryText: "Salio ya Deni TZS 1,000"
          ),
          SizedBox(height: 24),
          CustomButton(
            color: Colors.green,
            buttonText: 'TUMA MUHTASARI',
            onPressed: () {
              _sendSms();
            },
            type: ButtonType.elevated,
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsItem(String title, String value,
      {String? secondaryText}) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16, color: Colors.black87),
          ),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          if (secondaryText != null) ...[
            SizedBox(height: 4),
            Text(
              secondaryText,
              style: TextStyle(fontSize: 14, color: Colors.red),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDetailsItemWithIcon(String title, String value,
      {String? secondaryText, VoidCallback? onPressed}) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 16, color: Colors.black87),
                ),
                SizedBox(height: 4),
                Text(
                  value,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                if (secondaryText != null) ...[
                  SizedBox(height: 4),
                  Text(
                    secondaryText,
                    style: TextStyle(fontSize: 14, color: Colors.red),
                  ),
                ],
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.remove_red_eye_outlined, color: Colors.grey),
            onPressed: onPressed, // Attach the action here
          ),
        ],
      ),
    );
  }

  Widget _buildTaarifaZaKikundi() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (widget.fromDashboard)
              Column(
                children: [
                  SizedBox(height: 20),
                  Text(
                    AppLocalizations.of(context)!.groupInfo,
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    _safeGetField(groupData?.name),
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            SizedBox(height: 20),
            CustomCard(
              titleText: AppLocalizations.of(context)!.groupInfo,
              onEdit: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => groupInfo(
                      data_id: widget.data_id,
                      // isEditingMode: true,
                    ),
                  ),
                );
              },
              items: [
                {
                  'description': AppLocalizations.of(context)!.groupName,
                  'value': _safeGetField(groupData?.name)
                },
                {
                  'description': AppLocalizations.of(context)!.yearEstablished,
                  'value': _safeGetField(groupData?.yearMade?.toString())
                },
                // {
                //   'description': 'Kikundi kipo mzunguko wa ngapi:',
                //   'value': _safeGetField(widget.mzungukoId.toString())
                // },
              ],
            ),
            SizedBox(
              height: 10,
            ),

            // Meeting Summary
            CustomCard(
              titleText: AppLocalizations.of(context)!.meetingSummary,
              onEdit: _isMzungukoPending
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GroupSummary(
                            data_id: widget.data_id,
                            isEditingMode: true,
                          ),
                        ),
                      );
                    }
                  : null,
              items: [
                {
                  'description': AppLocalizations.of(context)!.meetingFrequency,
                  'value': _safeGetField(groupData?.meetingFrequently)
                },
                {
                  'description': AppLocalizations.of(context)!.sessionCount,
                  'value': _safeGetField(groupData?.meetingAmount?.toString())
                },
                {
                  'description': AppLocalizations.of(context)!.allocation,
                  'value': _safeGetField(groupData?.meetingDescription)
                },
              ],
            ),
            SizedBox(
              height: 10,
            ),

            CustomCard(
              titleText: AppLocalizations.of(context)!.registration,
              onEdit: _isMzungukoPending
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GroupRegistration(
                            data_id: widget.data_id,
                            isEditingMode: true,
                          ),
                        ),
                      );
                    }
                  : null,
              items: [
                {
                  'description': AppLocalizations.of(context)!.registrationType,
                  'value': (() {
                    final status = groupData?.registrationStatus;
                    final l10n = AppLocalizations.of(context)!;
                    if (status == null || status.isEmpty) return l10n.haijulikani;
                    if (status == 'kimesajiliwa') return l10n.registered;
                    if (status == 'hakijasajiliwa') return l10n.notRegistered;
                    return status;
                  })()
                },
                {
                  'description':
                      AppLocalizations.of(context)!.registrationNumber,
                  'value': _safeGetField(groupData?.registeredNumber)
                },
              ],
            ),
            SizedBox(height: 10),
            CustomCard(
              titleText: AppLocalizations.of(context)!.institutionalInfo,
              onEdit: _isMzungukoPending
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GroupInstitution(
                            data_id: widget.data_id,
                            isEditingMode: true,
                          ),
                        ),
                      );
                    }
                  : null,
              items: [
                {
                  'description': AppLocalizations.of(context)!.institutionName,
                  'value': _safeGetField(groupData?.groupInstitution)
                },
                {
                  'description': AppLocalizations.of(context)!.projectName,
                  'value': _safeGetField(groupData?.projectName)
                },
                {
                  'description': AppLocalizations.of(context)!.teacherId,
                  'value': _safeGetField(groupData?.teacherIdentification)
                },
              ],
            ),
            if (isPasswordSetupComplete)
              CustomCard(
                titleText: AppLocalizations.of(context)!.location,
                onEdit: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegionDistrictWardPage(
                        group_info_id: widget.data_id,
                        mzungukoId: mzungukoId,
                        isEditingMode: true,
                      ),
                    ),
                  );
                },
                items: [
                  {
                    'description': AppLocalizations.of(context)!.country,
                    'value': _safeGetField(groupData?.country)
                  },
                  {
                    'description': AppLocalizations.of(context)!.region,
                    'value': _safeGetField(groupData?.region)
                  },
                  {
                    'description': AppLocalizations.of(context)!.district,
                    'value': _safeGetField(groupData?.district)
                  },
                  {
                    'description': AppLocalizations.of(context)!.ward,
                    'value': _safeGetField(groupData?.ward)
                  },
                  {
                    'description':
                        AppLocalizations.of(context)!.streetOrVillage,
                    'value': _safeGetField(groupData?.streetOrVillage)
                  },
                ],
              ),
            SizedBox(height: 20),
            CustomButton(
              color: Color.fromARGB(255, 4, 34, 207),
              buttonText: AppLocalizations.of(context)!.completed,
              onPressed: () {
                if (isPasswordSetupComplete && !_isMzungukoPending) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => dashboard(groupId: widget.data_id),
                    ),
                  );
                } else {
                  _markGroupInfoAsCompleted();
                }
              },
              type: ButtonType.elevated,
            ),
          ],
        ),
      ),
    );
  }
}
