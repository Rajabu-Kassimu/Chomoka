import 'package:chomoka/model/GroupInformationModel.dart';
import 'package:chomoka/model/KatibaModel.dart';
import 'package:chomoka/model/MemberShareModel.dart';
import 'package:chomoka/model/RejeshaMkopoModel.dart';
import 'package:chomoka/model/ToaMfukoJamiiModel.dart';
import 'package:chomoka/model/UchangiajiMfukoJamiiModel.dart';
import 'package:chomoka/model/UserFainiModel.dart';
import 'package:chomoka/model/UwekajiKwaMkupuoModel.dart';
import 'package:chomoka/model/VikaoVilivyopitaModel.dart';
import 'package:chomoka/model/BaseModel.dart';
import 'package:flutter/material.dart';

class GroupTotalAmount extends StatefulWidget {
  final int? data_id;
  final int mzungukoId;

  const GroupTotalAmount({
    Key? key,
    this.data_id,
    required this.mzungukoId,
  }) : super(key: key);

  @override
  State<GroupTotalAmount> createState() => _GroupTotalAmountState();
}

class _GroupTotalAmountState extends State<GroupTotalAmount> {
  bool isLoading = true;
  GroupInformationModel? groupData;

  double _akibaLazimaTotal = 0;
  double _totalAkibaHiari = 0;
  double _mfukoJamiiTotal = 0;
  double _kilichotolewaMfukoJamii = 0;
  double _mkopoWasasaTotal = 0;
  double _fainiTotal = 0;
  double _salioTotal = 0;
  double _salioLililolala = 0;
  double _TotalHisaValue = 0;
  double shareValue = 0;
  double _jumlaYaAkiba = 0;
  double _mfukoWaJamiiSalio = 0;
  double _akibaBinafsiSalio = 0;
  double _paidLoanTotal = 0;
  double _unpaidFainiTotal = 0;
  double totalContributions = 0;
  double totalAkiba = 0;

  Map<String, void Function(double)>? fieldSetters;
  List<dynamic> _members = [];

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    await Future.wait([
      _fetchSavedData(),
      _fetchSalioLilolala(),
      _fetchMfukoJamiiData(),
      _fetchMkopoWasasaTotal(),
      _fetchFainiTotal(),
      _fetchKilichotolewaMfukoJamii(),
      _fetchContributions(),
      _fetchTotalShareValue(),
    ]);
    _calculateTotal();
    setState(() {
      isLoading = false;
    });
  }

  Future<void> _fetchSavedData() async {
    try {
      final groupInformationModel = GroupInformationModel();
      final data = await groupInformationModel.findOne();
      setState(() {
        groupData = data as GroupInformationModel?;
      });
    } catch (e) {
      print('Error fetching group data: $e');
    }
  }

  Future<void> _fetchSalioLilolala() async {
    try {
      final vikaoModel = VikaovilivyopitaModel();
      for (final key in fieldSetters?.keys ?? []) {
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
    } catch (e) {
      print('Error fetching field values: $e');
    }
  }

  Future<void> _fetchMfukoJamiiData() async {
    try {
      final mfukoJamiiModel = UchangaajiMfukoJamiiModel();
      final records = await mfukoJamiiModel
          .where('mzungukoId', '=', widget.mzungukoId)
          .where('paid_status', '=', 'paid')
          .select();

      double totalSum = records.fold(0.0, (sum, record) {
        return sum + (record['total'] as num?)!.toDouble() ?? 0;
      });

      setState(() {
        _mfukoJamiiTotal = totalSum;
      });
    } catch (e) {
      print('Error fetching Mfuko Jamii data: $e');
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
        double paidTotal = results
            .map((entry) => (entry['paidAmount'] ?? 0).toDouble())
            .fold(0, (sum, element) => sum + element);

        setState(() {
          _mkopoWasasaTotal = total;
          _paidLoanTotal = paidTotal;
        });
      }
    } catch (e) {
      print('Error fetching Mkopo wa Sasa total: $e');
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
        double unpaidTotal = results
            .map((entry) => (entry['unpaidfaini'] ?? 0).toDouble())
            .fold(0, (sum, element) => sum + element);

        setState(() {
          _fainiTotal = total;
          _unpaidFainiTotal = unpaidTotal;
        });
      }
    } catch (e) {
      print('Error fetching total fines: $e');
    }
  }

  void _calculateTotal() {
    setState(() {
      _salioTotal = _akibaLazimaTotal +
          _mfukoJamiiTotal +
          _salioLililolala +
          _fainiTotal +
          totalContributions +
          _TotalHisaValue;
    });
  }

  Future<void> _fetchKilichotolewaMfukoJamii() async {
    try {
      final toaMfukoJamiiModel = ToaMfukoJamiiModel();
      final records = await toaMfukoJamiiModel
          .where('mzungukoId', '=', widget.mzungukoId)
          .select();

      double totalAmountWithdrawn = records.fold(0.0, (sum, record) {
        return sum + (record['amount'] as num?)!.toDouble() ?? 0.0;
      });

      setState(() {
        _kilichotolewaMfukoJamii = totalAmountWithdrawn;
      });
    } catch (e) {
      print('Error fetching withdrawal data: $e');
    }
  }

  Future<void> _fetchContributions() async {
    try {
      final uwakajiModel = UwekajiKwaMkupuoModel();
      final results = await uwakajiModel
          .where('mzungukoId', '=', widget.mzungukoId)
          .select();

      double totalAmount = results.fold(0.0, (sum, contribution) {
        return sum + (contribution['amount'] as num?)!.toDouble() ?? 0;
      });

      setState(() {
        totalContributions = totalAmount;
      });
    } catch (e) {
      print('Error fetching contributions: $e');
    }
  }

  Future<void> _fetchTotalShareValue() async {
    try {
      await BaseModel.initAppDatabase();

      final katiba = KatibaModel();
      final shareData =
          await katiba.where('katiba_key', '=', 'share_amount').findOne();

      if (shareData != null &&
          shareData is KatibaModel &&
          shareData.value != null) {
        shareValue = double.tryParse(shareData.value!) ?? 0;
      }

      final memberShareModel = MemberShareModel();
      final results = await memberShareModel
          .where('mzungukoId', '=', widget.mzungukoId)
          .select();

      int totalShares = results.fold(0, (sum, share) {
        return sum + ((share['number_of_shares'] as num?)?.toInt() ?? 0);
      });

      setState(() {
        _TotalHisaValue = totalShares * shareValue;
      });
    } catch (e) {
      print('Error fetching share data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Total Savings: ${_salioTotal.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            _buildDetailRow('Mandatory Savings', _akibaLazimaTotal),
            _buildDetailRow('Social Fund', _mfukoJamiiTotal),
            _buildDetailRow('Previous Balance', _salioLililolala),
            _buildDetailRow('Fines', _fainiTotal),
            _buildDetailRow('Contributions', totalContributions),
            _buildDetailRow('Share Value', _TotalHisaValue),
            const Divider(),
            _buildDetailRow('Unpaid Fines', _unpaidFainiTotal),
            _buildDetailRow('Current Loans', _mkopoWasasaTotal),
            _buildDetailRow('Paid Loans', _paidLoanTotal),
            _buildDetailRow(
                'Social Fund Withdrawals', _kilichotolewaMfukoJamii),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, double amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(amount.toStringAsFixed(2)),
        ],
      ),
    );
  }
}
