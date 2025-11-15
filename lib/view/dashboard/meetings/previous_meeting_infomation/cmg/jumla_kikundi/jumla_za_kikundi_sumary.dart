import 'package:chomoka/view/dashboard/meetings/previous_meeting_infomation/cmg/uwekaji_taarifa_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/model/BaseModel.dart';
import 'package:chomoka/model/KikaoKilichopitaStepModel.dart';
import 'package:chomoka/model/VikaoVilivyopitaModel.dart';
import 'package:chomoka/widget/widget.dart';

class JumlaKikundiSummary extends StatefulWidget {
  final int? mzungukoId;

  const JumlaKikundiSummary({Key? key, this.mzungukoId}) : super(key: key);

  @override
  State<JumlaKikundiSummary> createState() => _JumlaKikundiSummaryState();
}

class _JumlaKikundiSummaryState extends State<JumlaKikundiSummary> {
  bool isLoading = true;
  Map<String, String> financialData = {};

  final Map<String, String> fieldKeys = {
    'jumla_ya_akiba': 'Jumla ya Akiba',
    'mfuko_wa_jamii_salio': 'Mfuko wa Jamii Salio',
    'akiba_binafsi_salio': 'Akiba Binafsi Salio',
    'salio_lililolala_sandukuni': 'Salio Lililolala Sandukuni',
  };

  @override
  void initState() {
    super.initState();
    _fetchFinancialData();
  }

  Future<void> _updateStatusToCompleted() async {
    try {
      final meetingSetupModel = KikaoKilichopitaModel(
        meeting_step: 'jumla_kikundi',
        mzungukoId: widget.mzungukoId,
        value: 'complete',
      );

      await meetingSetupModel.create();
    } catch (e) {
      debugPrint('Error updating status: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update status: $e')),
      );
    }
  }

  Future<void> _fetchFinancialData() async {
    try {
      VikaovilivyopitaModel vikaoModel = VikaovilivyopitaModel();
      Map<String, String> tempData = {};

      for (String key in fieldKeys.keys) {
        BaseModel? data =
            await vikaoModel.where('kikao_key', '=', key).findOne();

        tempData[key] = (data is VikaovilivyopitaModel && data.value != null)
            ? data.value!
            : '0';
      }

      setState(() {
        financialData = tempData;
        isLoading = false;
      });
    } catch (e) {
      debugPrint('Error fetching financial data: $e');
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to load summary data. Please try again.'),
        ),
      );
    }
  }

  String _formatCurrency(String value) {
    try {
      double amount = double.parse(value);
      return 'TZS ${amount.toStringAsFixed(0)}';
    } catch (e) {
      return value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Taarifa za Kikundi',
        subtitle: 'Jumla ya taarifa za kikundi',
        showBackArrow: true,
      ),
      body: isLoading
          ? _buildLoading()
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: financialData.isNotEmpty
                  ? _buildFinancialList()
                  : _buildEmptyView(),
            ),
    );
  }

  Widget _buildLoading() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            color: Colors.blueAccent,
            strokeWidth: 4.0,
          ),
          const SizedBox(height: 16),
          const Text(
            'Inapakia taarifa...',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.info_outline, color: Colors.grey[400], size: 48),
          const SizedBox(height: 12),
          const Text(
            'Hakuna taarifa zilizopo kwa sasa.',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildFinancialList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: const Text(
            'Jumla za Kikundi',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        const SizedBox(height: 12),
        Expanded(
          child: ListView.separated(
            itemCount: fieldKeys.keys.length,
            separatorBuilder: (_, __) => const Divider(thickness: 1.2),
            itemBuilder: (context, index) {
              final entry = fieldKeys.entries.elementAt(index);
              final key = entry.key;
              final label = entry.value;

              final rawValue = financialData[key] ?? '0';
              final formattedValue = _formatCurrency(rawValue);

              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 3,
                shadowColor: Colors.black26,
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  title: Text(
                    label,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  trailing: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      formattedValue,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        Center(
          child: CustomButton(
            color: const Color(0xFF0422CF),
            buttonText: 'Nimemaliza',
            onPressed: () async {
              await _updateStatusToCompleted();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => uwekajitaarifadashboard(
                    mzungukoId: widget.mzungukoId,
                  ),
                ),
              );
            },
            type: ButtonType.elevated,
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
