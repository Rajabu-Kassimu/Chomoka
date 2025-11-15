import 'package:flutter/material.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:chomoka/model/group_activities/business/ExpensesModel.dart';
import 'package:chomoka/model/group_activities/business/BusinessInfomationModel.dart';
import 'package:chomoka/view/dashboard/group_activities/group_business/business_activities/expenses.dart';
import 'package:intl/intl.dart';
import 'package:chomoka/l10n/app_localizations.dart';


class ExpensesList extends StatefulWidget {
  final int? mzungukoId;
  final BusinessInformationModel businessId;

  const ExpensesList({
    super.key,
    required this.mzungukoId,
    required this.businessId,
  });

  @override
  State<ExpensesList> createState() => _ExpensesListState();
}

class _ExpensesListState extends State<ExpensesList> {
  bool _isLoading = true;
  List<ExpensesModel> _expenses = [];

  @override
  void initState() {
    super.initState();
    _loadExpenses();
  }

  Future<void> _loadExpenses() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Create an expenses model instance to use its methods
      final expensesModel = ExpensesModel();

      // Query expenses for this business
      final expensesQuery = expensesModel
          .where('businessId', '=', widget.businessId.id)
          .where('mzungukoId', '=', widget.mzungukoId);

      final expenses = await expensesQuery.find();

      setState(() {
        _expenses = expenses.map((model) => model as ExpensesModel).toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Hitilafu: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.expensesListTitle,
        showBackArrow: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Expenses(
                mzungukoId: widget.mzungukoId,
                businessId: widget.businessId,
              ),
            ),
          ).then((_) => _loadExpenses());
        },
        backgroundColor: Colors.red,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _expenses.isEmpty
              ? _buildEmptyState()
              : _buildExpensesList(),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.money_off,
            size: 80,
            color: Colors.grey,
          ),
          const SizedBox(height: 16),
          Text(
            AppLocalizations.of(context)!.expensesListNoExpenses,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            AppLocalizations.of(context)!.expensesListAddPrompt,
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Expenses(
                    mzungukoId: widget.mzungukoId,
                    businessId: widget.businessId,
                  ),
                ),
              ).then((_) => _loadExpenses());
            },
            icon: const Icon(Icons.add, color: Colors.white),
            label: Text(
              AppLocalizations.of(context)!.expensesListAddExpense,
              style: const TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpensesList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _expenses.length,
      itemBuilder: (context, index) {
        final expense = _expenses[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.expensesListAmount(NumberFormat('#,###').format(expense.amount ?? 0)),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    _buildDateChip(expense.expenseDate),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  AppLocalizations.of(context)!.expensesListReason(expense.reason ?? AppLocalizations.of(context)!.expensesListUnknown),
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  AppLocalizations.of(context)!.expensesListPayer(expense.payer ?? AppLocalizations.of(context)!.expensesListUnknown),
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (expense.description != null &&
                    expense.description!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      expense.description!,
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDateChip(String? dateString) {
    String formattedDate = AppLocalizations.of(context)!.expensesListNoDate;

    if (dateString != null && dateString.isNotEmpty) {
      try {
        final date = DateTime.parse(dateString);
        formattedDate = DateFormat('dd/MM/yyyy').format(date);
      } catch (e) {
        formattedDate = dateString;
      }
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.red.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.red.withOpacity(0.5)),
      ),
      child: Text(
        formattedDate,
        style: TextStyle(
          fontSize: 12,
          color: Colors.red[700],
        ),
      ),
    );
  }
}
