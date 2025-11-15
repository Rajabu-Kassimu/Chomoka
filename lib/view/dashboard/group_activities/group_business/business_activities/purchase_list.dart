import 'package:flutter/material.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:chomoka/model/group_activities/business/PurchaseModel.dart';
import 'package:chomoka/model/group_activities/business/BusinessInfomationModel.dart';
import 'package:chomoka/view/dashboard/group_activities/group_business/business_activities/purchases.dart';
import 'package:intl/intl.dart';
import 'package:chomoka/l10n/app_localizations.dart';


class PurchaseList extends StatefulWidget {
  final int? mzungukoId;
  final BusinessInformationModel businessId;

  const PurchaseList({
    super.key,
    required this.mzungukoId,
    required this.businessId,
  });

  @override
  State<PurchaseList> createState() => _PurchaseListState();
}

class _PurchaseListState extends State<PurchaseList> {
  bool _isLoading = true;
  List<PurchaseModel> _purchases = [];

  @override
  void initState() {
    super.initState();
    _loadPurchases();
  }

  Future<void> _loadPurchases() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Create a purchase model instance to use its methods
      final purchaseModel = PurchaseModel();

      // Query purchases for this business using proper where method
      final purchaseQuery = purchaseModel
          .where('businessId', '=', widget.businessId.id)
          .where('mzungukoId', '=', widget.mzungukoId);

      final purchases = await purchaseQuery.find();

      setState(() {
        _purchases = purchases.map((model) => model as PurchaseModel).toList();
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
        title: AppLocalizations.of(context)!.purchaseListTitle,
        showBackArrow: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Purchases(
                mzungukoId: widget.mzungukoId,
                businessId: widget.businessId,
              ),
            ),
          ).then((_) => _loadPurchases());
        },
        backgroundColor: const Color.fromARGB(255, 4, 34, 207),
        child: const Icon(Icons.add,color: Colors.white,),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _purchases.isEmpty
              ? _buildEmptyState()
              : _buildPurchaseList(),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.shopping_bag_outlined,
            size: 80,
            color: Colors.grey,
          ),
          const SizedBox(height: 16),
          Text(
            AppLocalizations.of(context)!.purchaseListNoPurchases,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            AppLocalizations.of(context)!.purchaseListAddPrompt,
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Purchases(
                    mzungukoId: widget.mzungukoId,
                    businessId: widget.businessId,
                  ),
                ),
              ).then((_) => _loadPurchases());
            },
            icon: const Icon(Icons.add),
            label: Text(AppLocalizations.of(context)!.purchaseListAddPurchase, style: const TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 4, 34, 207),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPurchaseList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _purchases.length,
      itemBuilder: (context, index) {
        final purchase = _purchases[index];
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
                      AppLocalizations.of(context)!.purchaseListAmount(NumberFormat('#,###').format(purchase.amount ?? 0)),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    _buildDateChip(purchase.purchaseDate),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  AppLocalizations.of(context)!.purchaseListBuyer(purchase.buyer ?? AppLocalizations.of(context)!.purchaseListUnknown),
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (purchase.description != null &&
                    purchase.description!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      purchase.description!,
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
    String formattedDate = AppLocalizations.of(context)!.purchaseListNoDate;

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
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.blue.withOpacity(0.5)),
      ),
      child: Text(
        formattedDate,
        style: TextStyle(
          fontSize: 12,
          color: Colors.blue[700],
        ),
      ),
    );
  }
}
