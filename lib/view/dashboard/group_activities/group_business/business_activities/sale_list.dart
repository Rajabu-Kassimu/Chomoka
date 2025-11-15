import 'package:flutter/material.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:chomoka/model/group_activities/business/SalesModel.dart';
import 'package:chomoka/model/group_activities/business/BusinessInfomationModel.dart';
import 'package:chomoka/view/dashboard/group_activities/group_business/business_activities/sales.dart';
import 'package:intl/intl.dart';
import 'package:chomoka/l10n/app_localizations.dart';


class SaleList extends StatefulWidget {
  final int? mzungukoId;
  final BusinessInformationModel businessId;

  const SaleList({
    super.key,
    required this.mzungukoId,
    required this.businessId,
  });

  @override
  State<SaleList> createState() => _SaleListState();
}

class _SaleListState extends State<SaleList> {
  bool _isLoading = true;
  List<SalesModel> _sales = [];

  @override
  void initState() {
    super.initState();
    _loadSales();
  }

  Future<void> _loadSales() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Create a sales model instance to use its methods
      final salesModel = SalesModel();

      // Query sales for this business
      final salesQuery = salesModel
          .where('businessId', '=', widget.businessId.id)
          .where('mzungukoId', '=', widget.mzungukoId);

      final sales = await salesQuery.find();

      setState(() {
        _sales = sales.map((model) => model as SalesModel).toList();
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
        title: AppLocalizations.of(context)!.saleListTitle,
        showBackArrow: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Sales(
                mzungukoId: widget.mzungukoId,
                businessId: widget.businessId,
              ),
            ),
          ).then((_) => _loadSales());
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _sales.isEmpty
              ? _buildEmptyState()
              : _buildSalesList(),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.point_of_sale,
            size: 80,
            color: Colors.grey,
          ),
          const SizedBox(height: 16),
          Text(
            AppLocalizations.of(context)!.saleListNoSales,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            AppLocalizations.of(context)!.saleListAddPrompt,
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Sales(
                    mzungukoId: widget.mzungukoId,
                    businessId: widget.businessId,
                  ),
                ),
              ).then((_) => _loadSales());
            },
            icon: const Icon(Icons.add, color: Colors.white),
            label: Text(
              AppLocalizations.of(context)!.saleListAddSale,
              style: const TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSalesList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _sales.length,
      itemBuilder: (context, index) {
        final sale = _sales[index];
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
                      AppLocalizations.of(context)!.saleListAmount(NumberFormat('#,###').format(sale.revenue ?? 0)),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    _buildDateChip(sale.saleDate),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  AppLocalizations.of(context)!.saleListCustomer(sale.customer ?? AppLocalizations.of(context)!.saleListUnknown),
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  AppLocalizations.of(context)!.saleListSeller(sale.seller ?? AppLocalizations.of(context)!.saleListUnknown),
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (sale.description != null && sale.description!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      sale.description!,
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
    String formattedDate = AppLocalizations.of(context)!.saleListNoDate;

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
        color: Colors.green.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.green.withOpacity(0.5)),
      ),
      child: Text(
        formattedDate,
        style: TextStyle(
          fontSize: 12,
          color: Colors.green[700],
        ),
      ),
    );
  }
}
