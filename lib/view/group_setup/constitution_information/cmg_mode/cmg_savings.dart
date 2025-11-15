import 'package:chomoka/model/KatibaModel.dart';
import 'package:chomoka/view/group_setup/constitution_information/constitution_overview.dart';
import 'package:chomoka/view/group_setup/constitution_information/cmg_mode/cmg_group_leaders.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';

class Savings extends StatefulWidget {
  final int groupId;
  final int mzungukoId;
  final bool isUpdateMode;

  Savings({
    super.key,
    required this.groupId,
    required this.mzungukoId,
    this.isUpdateMode = false,
  });

  @override
  State<Savings> createState() => _SavingsState();
}

class _SavingsState extends State<Savings> {
  final TextEditingController _controller = TextEditingController();
  String _selectedOption = '';
  final List<String> _options = ['Ndiyo ruhusu', 'Hapana usiruhusu'];

  int userCount = 10;

  final _formKey = GlobalKey<FormState>();
  String? _akibaError;

  Future<void> _fetchSavedData() async {
    try {
      final katiba = KatibaModel();

      // Fetch akiba_lazima with mzungukoId filter
      final akibaLazimaData = await katiba
          .where('katiba_key', '=', 'akiba_lazima')
          .where('mzungukoId', '=', widget.mzungukoId)
          .findOne();
      if (akibaLazimaData != null && akibaLazimaData is KatibaModel) {
        setState(() {
          _controller.text = akibaLazimaData.value?.toString() ?? '';
        });
      }

      // Fetch akiba_hiari with mzungukoId filter
      final akibaHiariData = await katiba
          .where('katiba_key', '=', 'akiba_hiari')
          .where('mzungukoId', '=', widget.mzungukoId)
          .findOne();
      if (akibaHiariData != null && akibaHiariData is KatibaModel) {
        setState(() {
          _selectedOption = akibaHiariData.value?.toString() ?? _options[0];
        });
      } else {
        // If not found, set default
        setState(() {
          _selectedOption = _options[0];
        });
      }
    } catch (e) {
      print('Error fetching saved data: $e');
    }
  }

  Future<void> _saveData() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    try {
      final katiba = KatibaModel();

      final akibaLazimaQuery = katiba.where('katiba_key', '=', 'akiba_lazima');
      final akibaLazimaData = await akibaLazimaQuery
          .where('mzungukoId', '=', widget.mzungukoId)
          .findOne();

      if (akibaLazimaData != null && akibaLazimaData is KatibaModel) {
        // Update existing record
        await KatibaModel()
            .where('katiba_key', '=', 'akiba_lazima')
            .where('mzungukoId', '=', widget.mzungukoId)
            .update({'value': _controller.text.toString()});
      } else {
        // Create new record
        await KatibaModel(
          katiba_key: 'akiba_lazima',
          mzungukoId: widget.mzungukoId,
          value: _controller.text.toString(),
        ).create();
      }

      // Handle akiba_hiari
      final akibaHiariQuery = katiba.where('katiba_key', '=', 'akiba_hiari');
      final akibaHiariData = await akibaHiariQuery
          .where('mzungukoId', '=', widget.mzungukoId)
          .findOne();

      if (akibaHiariData != null && akibaHiariData is KatibaModel) {
        // Update existing record
        await KatibaModel()
            .where('katiba_key', '=', 'akiba_hiari')
            .where('mzungukoId', '=', widget.mzungukoId)
            .update({'value': _selectedOption});
      } else {
        // Create new record
        await KatibaModel(
          katiba_key: 'akiba_hiari',
          mzungukoId: widget.mzungukoId,
          value: _selectedOption,
        ).create();
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Taarifa zimehifadhiwa kikamilifu!')),
      );

      if (widget.isUpdateMode) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ConstitutionOverview(
              groupId: widget.groupId,
              mzungukoId: widget.mzungukoId,
            ),
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GroupLeaders(
              groupId: widget.groupId,
              mzungukoId: widget.mzungukoId,
            ),
          ),
        );
      }
    } catch (e) {
      print('Error saving data: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save data.')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchSavedData();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.mzungukoId);
    double? akibaValue = double.tryParse(_controller.text);
    double totalAkiba = 0;
    if (akibaValue != null && userCount > 0) {
      totalAkiba = akibaValue * userCount;
    }

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Taarifa za Katiba',
        subtitle: 'Akiba',
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
                  'Kiwango cha akiba lazima ni kiasi gani?',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                CustomTextField(
                  labelText: 'Akiba ya lazima',
                  hintText: 'Akiba ya lazima',
                  keyboardType: TextInputType.number,
                  controller: _controller,
                  obscureText: false,
                  onChanged: (_) {
                    setState(() {}); // Recalculate when input changes
                  },
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Akiba ya lazima inahitajika';
                    }
                    final parsed = double.tryParse(value);
                    if (parsed == null || parsed <= 0) {
                      return 'Tafadhali ingiza kiasi halali';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                if (akibaValue != null && akibaValue > 0 && userCount > 0)
                  Container(
                    color: const Color.fromARGB(255, 197, 197, 197),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Zingatia: Kila mwanachama atatakiwa kulipa kiasi cha TZS ${akibaValue.toStringAsFixed(0)} kwa kila kikao endapo atalipa itasomeka kama deni katika kikao kijacho',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                SizedBox(height: 20),
                Text(
                  'Akiba hiari',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  'Kuhusu wanachama kuweka kiwango chochote cha akiba ya hiari. Mwanachama anaweza kuondoa sehemu ya akiba ya hiari katikati ya mzunguko',
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                CustomRadioGroup<String>(
                  labelText: '',
                  options: _options,
                  value: _selectedOption,
                  onChanged: (String newValue) {
                    setState(() {
                      _selectedOption = newValue;
                    });
                  },
                ),
                SizedBox(height: 20),
                CustomButton(
                  color: Color.fromARGB(255, 4, 34, 207),
                  buttonText: 'Endelea',
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
