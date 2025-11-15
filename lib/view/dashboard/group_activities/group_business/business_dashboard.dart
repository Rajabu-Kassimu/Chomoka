import 'package:chomoka/view/dashboard/group_activities/group_business/business_activities/expenses.dart';
import 'package:chomoka/view/dashboard/group_activities/group_business/business_activities/expenses_list.dart';
import 'package:chomoka/view/dashboard/group_activities/group_business/business_activities/purchase_list.dart';
import 'package:chomoka/view/dashboard/group_activities/group_business/business_activities/purchases.dart';
import 'package:chomoka/view/dashboard/group_activities/group_business/business_activities/sale_list.dart';
import 'package:chomoka/view/dashboard/group_activities/group_business/business_activities/sales.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:chomoka/model/group_activities/business/BusinessInfomationModel.dart';
import 'package:intl/intl.dart';
import 'package:chomoka/model/group_activities/business/ExpensesModel.dart';
import 'package:chomoka/model/group_activities/business/PurchaseModel.dart';
import 'package:chomoka/model/group_activities/business/SalesModel.dart';
import 'package:chomoka/l10n/app_localizations.dart';

class BusinessDashboard extends StatefulWidget {
  final int? groupId;
  final int? mzungukoId;
  final BusinessInformationModel businessInfo;

  const BusinessDashboard({
    super.key,
    this.groupId,
    this.mzungukoId,
    required this.businessInfo,
  });

  @override
  State<BusinessDashboard> createState() => _BusinessDashboardState();
}

class _BusinessDashboardState extends State<BusinessDashboard> {
  bool _isLoading = false;
  double _totalPurchases = 0;
  double _totalSales = 0;
  double _totalExpenses = 0;
  double _profit = 0;

  @override
  void initState() {
    super.initState();
    _loadBusinessSummary();
  }

  Future<void> _loadBusinessSummary() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Load purchases
      final purchaseModel = PurchaseModel();
      final purchases = await purchaseModel
          .where('businessId', '=', widget.businessInfo.id)
          .where('mzungukoId', '=', widget.mzungukoId)
          .find();

      double totalPurchases = 0;
      for (var purchase in purchases) {
        final purchaseData = purchase as PurchaseModel;
        totalPurchases += purchaseData.amount ?? 0;
      }

      // Load sales
      final salesModel = SalesModel();
      final sales = await salesModel
          .where('businessId', '=', widget.businessInfo.id)
          .where('mzungukoId', '=', widget.mzungukoId)
          .find();

      double totalSales = 0;
      for (var sale in sales) {
        final saleData = sale as SalesModel;
        totalSales += saleData.revenue ?? 0;
      }

      // Load expenses
      final expensesModel = ExpensesModel();
      final expenses = await expensesModel
          .where('businessId', '=', widget.businessInfo.id)
          .where('mzungukoId', '=', widget.mzungukoId)
          .find();

      double totalExpenses = 0;
      for (var expense in expenses) {
        final expenseData = expense as ExpensesModel;
        totalExpenses += expenseData.amount ?? 0;
      }

      // Calculate profit
      final profit = totalSales - totalPurchases - totalExpenses;

      setState(() {
        _totalPurchases = totalPurchases;
        _totalSales = totalSales;
        _totalExpenses = totalExpenses;
        _profit = profit;
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
        title: widget.businessInfo.businessName ?? AppLocalizations.of(context)!.businessDashboardDefaultTitle,
        showBackArrow: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildBusinessHeader(),
                    const SizedBox(height: 24),
                    // _buildStatisticsSection(),
                    // const SizedBox(height: 24),
                    _buildActionButtons(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildBusinessHeader() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.businessInfo.businessName ?? AppLocalizations.of(context)!.businessDashboardDefaultTitle,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.location_on,
                              size: 16, color: Colors.grey),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              widget.businessInfo.businessLocation ?? AppLocalizations.of(context)!.businessDashboardLocationUnknown,
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                _buildStatusBadge(widget.businessInfo.status ?? 'active', context),
              ],
            ),
            const Divider(height: 24),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.businessDashboardProductType,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.businessInfo.productType ?? AppLocalizations.of(context)!.businessDashboardProductTypeUnknown,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.businessDashboardStartDate,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _formatDate(widget.businessInfo.startDate, context),
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Summary row for purchases, sales, expenses, profit
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _summaryItem(AppLocalizations.of(context)!.businessDashboardPurchases, _totalPurchases, Colors.blue),
                  _summaryItem(AppLocalizations.of(context)!.businessDashboardSales, _totalSales, Colors.green),
                  _summaryItem(AppLocalizations.of(context)!.businessDashboardExpenses, _totalExpenses, Colors.red),
                  _summaryItem(AppLocalizations.of(context)!.businessDashboardProfit, _profit, _profit >= 0 ? Colors.orange : Colors.red),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryItem(String label, double value, Color color) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            NumberFormat('#,###').format(value),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey[700],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // Widget _buildStatisticsSection() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(
  //         AppLocalizations.of(context)!.businessDashboardStats,
  //         style: TextStyle(
  //           fontSize: 18,
  //           fontWeight: FontWeight.bold,
  //         ),
  //       ),
  //       const SizedBox(height: 16),
  //       Row(
  //         children: [
  //           Expanded(
  //             child: _buildStatCard(
  //               AppLocalizations.of(context)!.businessDashboardPurchases,
  //               'TSh  {NumberFormat("#,###").format(_totalPurchases)}',
  //               Icons.shopping_bag,
  //               const Color.fromARGB(255, 4, 34, 207),
  //             ),
  //           ),
  //           const SizedBox(width: 12),
  //           Expanded(
  //             child: _buildStatCard(
  //               AppLocalizations.of(context)!.businessDashboardSales,
  //               'TSh  {NumberFormat("#,###").format(_totalSales)}',
  //               Icons.point_of_sale,
  //               Colors.green,
  //             ),
  //           ),
  //         ],
  //       ),
  //       const SizedBox(height: 12),
  //       Row(
  //         children: [
  //           Expanded(
  //             child: _buildStatCard(
  //               AppLocalizations.of(context)!.businessDashboardExpenses,
  //               'TSh  {NumberFormat("#,###").format(_totalExpenses)}',
  //               Icons.money_off,
  //               Colors.red,
  //             ),
  //           ),
  //           const SizedBox(width: 12),
  //           Expanded(
  //             child: _buildStatCard(
  //               AppLocalizations.of(context)!.businessDashboardProfit,
  //               'TSh  {NumberFormat("#,###").format(_profit)}',
  //               Icons.account_balance_wallet,
  //               _profit >= 0 ? Colors.orange : Colors.red,
  //             ),
  //           ),
  //         ],
  //       ),
  //     ],
  //   );
  // }

  Widget _buildStatCard(
      String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: color,
              size: 24,
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.businessDashboardActions,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildActionButton(
                AppLocalizations.of(context)!.businessDashboardPurchases,
                Icons.shopping_bag,
                const Color.fromARGB(255, 4, 34, 207),
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PurchaseList(
                        mzungukoId: widget.mzungukoId,
                        businessId: widget.businessInfo,
                      ),
                    ),
                  ).then((_) => _loadBusinessSummary());
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildActionButton(
                AppLocalizations.of(context)!.businessDashboardSales,
                Icons.point_of_sale,
                Colors.green,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SaleList(
                        mzungukoId: widget.mzungukoId,
                        businessId: widget.businessInfo,
                      ),
                    ),
                  ).then((_) => _loadBusinessSummary());
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildActionButton(
                AppLocalizations.of(context)!.businessDashboardExpenses,
                Icons.money_off,
                Colors.red,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ExpensesList(
                        mzungukoId: widget.mzungukoId,
                        businessId: widget.businessInfo,
                      ),
                    ),
                  ).then((_) => _loadBusinessSummary());
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildActionButton(
                AppLocalizations.of(context)!.businessDashboardProfitShare,
                Icons.account_balance_wallet,
                Colors.orange,
                () {
                  // Navigate to profit distribution screen
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton(
      String title, IconData icon, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(0),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: color,
              size: 28,
            ),
            const SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: color.withOpacity(0.8),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String status, BuildContext context) {
    Color badgeColor;
    String statusText;

    switch (status.toLowerCase()) {
      case 'active':
        badgeColor = Colors.green;
        statusText = AppLocalizations.of(context)!.businessDashboardActive;
        break;
      case 'inactive':
        badgeColor = Colors.red;
        statusText = AppLocalizations.of(context)!.businessDashboardInactive;
        break;
      case 'pending':
        badgeColor = Colors.orange;
        statusText = AppLocalizations.of(context)!.businessDashboardPending;
        break;
      default:
        badgeColor = Colors.blue;
        statusText = status;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: badgeColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(0),
        border: Border.all(color: badgeColor),
      ),
      child: Text(
        statusText,
        style: TextStyle(
          color: badgeColor,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  String _formatDate(String? dateString, BuildContext context) {
    if (dateString == null || dateString.isEmpty) {
      return AppLocalizations.of(context)!.businessDashboardDateUnknown;
    }

    try {
      final date = DateTime.parse(dateString);
      return DateFormat('dd/MM/yyyy').format(date);
    } catch (e) {
      return dateString;
    }
  }
}
