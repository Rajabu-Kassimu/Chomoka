import 'package:chomoka/view/dashboard/group_activities/group_business/business_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:chomoka/model/group_activities/business/BusinessInfomationModel.dart';
import 'package:chomoka/view/dashboard/group_activities/group_business/business_information.dart';
import 'package:chomoka/view/dashboard/group_activities/group_business/business_summary.dart';
import 'package:intl/intl.dart';
import 'package:chomoka/l10n/app_localizations.dart';


class BusinessList extends StatefulWidget {
  final int? groupId;
  final int? mzungukoId;

  const BusinessList({
    super.key,
    this.groupId,
    this.mzungukoId,
  });

  @override
  State<BusinessList> createState() => _BusinessListState();
}

class _BusinessListState extends State<BusinessList> {
  bool _isLoading = true;
  List<BusinessInformationModel> _businesses = [];
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadBusinesses();
  }

  Future<void> _loadBusinesses() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Load all businesses for this group/mzunguko
      final businessModel = BusinessInformationModel();

      // Create a query with proper conditions
      if (widget.mzungukoId != null) {
        businessModel.where('mzungukoId', '=', widget.mzungukoId);
      }

      if (widget.groupId != null) {
        businessModel.where('groupId', '=', widget.groupId);
      }

      // Now call find() to execute the query
      final results = await businessModel.find();

      setState(() {
        _businesses =
            results.map((model) => model as BusinessInformationModel).toList();
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Hitilafu: ${e.toString()}')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  List<BusinessInformationModel> _getFilteredBusinesses() {
    if (_searchQuery.isEmpty) {
      return _businesses;
    }

    return _businesses.where((business) {
      final businessName = business.businessName?.toLowerCase() ?? '';
      final businessLocation = business.businessLocation?.toLowerCase() ?? '';
      final productType = business.productType?.toLowerCase() ?? '';
      final query = _searchQuery.toLowerCase();

      return businessName.contains(query) ||
          businessLocation.contains(query) ||
          productType.contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredBusinesses = _getFilteredBusinesses();

    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.businessListTitle,
        showBackArrow: true,
      ),
      body: Column(
        children: [
          // Search bar
          //   Padding(
          //     padding: const EdgeInsets.all(16.0),
          //     child: TextField(
          //       decoration: InputDecoration(
          //         hintText: 'Tafuta biashara...',
          //         prefixIcon: const Icon(Icons.search),
          //         border: OutlineInputBorder(
          //           borderRadius: BorderRadius.circular(),
          //         ),
          //         contentPadding: const EdgeInsets.symmetric(vertical: 12),
          //         filled: true,
          //         fillColor: Colors.grey[100],
          //       ),
          //       onChanged: (value) {
          //         setState(() {
          //           _searchQuery = value;
          //         });
          //       },
          //     ),
          //   ),

          // List header
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.businessListCount(filteredBusinesses.length.toString()),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: _loadBusinesses,
                  tooltip: AppLocalizations.of(context)!.businessListRefresh,
                ),
              ],
            ),
          ),

          // Main content
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : filteredBusinesses.isEmpty
                    ? _buildEmptyState()
                    : _buildBusinessList(filteredBusinesses),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BusinessInformation(
                groupId: widget.groupId,
                mzungukoId: widget.mzungukoId,
              ),
            ),
          );

          if (result == true) {
            _loadBusinesses();
          }
        },
        backgroundColor: const Color.fromARGB(255, 42, 39, 241),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.business,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            AppLocalizations.of(context)!.businessListNoBusinesses,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            AppLocalizations.of(context)!.businessListAddPrompt,
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBusinessList(List<BusinessInformationModel> businesses) {
    return ListView.builder(
      itemCount: businesses.length,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      itemBuilder: (context, index) {
        final business = businesses[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 10.0),
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: InkWell(
            onTap: () {
              // Navigate to business dashboard when clicking the card
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BusinessDashboard(
                    groupId: widget.groupId,
                    mzungukoId: widget.mzungukoId,
                    businessInfo: business,
                  ),
                ),
              ).then((value) {
                if (value == true) {
                  _loadBusinesses();
                }
              });
            },
            borderRadius: BorderRadius.circular(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with business name and status
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 240, 245, 255),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          business.businessName ?? AppLocalizations.of(context)!.businessDashboardDefaultTitle,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 42, 39, 241),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      _buildStatusBadge(business.status ?? 'active', context),
                    ],
                  ),
                ),

                // Business details - simplified
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Location
                      _buildInfoRow(
                        Icons.location_on,
                        business.businessLocation ?? AppLocalizations.of(context)!.businessListLocationUnknown,
                        const Color.fromARGB(255, 100, 100, 100),
                      ),
                      const SizedBox(height: 6),

                      // Product type
                      _buildInfoRow(
                        Icons.category,
                        business.productType ?? AppLocalizations.of(context)!.businessListProductTypeUnknown,
                        const Color.fromARGB(255, 100, 100, 100),
                      ),
                    ],
                  ),
                ),

                // Footer with action button
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 245, 245, 245),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton.icon(
                        onPressed: () {
                          // Navigate to business summary when clicking "Angalia Zaidi"
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BusinessSummary(
                                groupId: widget.groupId,
                                mzungukoId: widget.mzungukoId,
                                businessInfo: business,
                              ),
                            ),
                          ).then((value) {
                            if (value == true) {
                              _loadBusinesses();
                            }
                          });
                        },
                        icon: const Icon(Icons.visibility, size: 14),
                        label: Text(AppLocalizations.of(context)!.businessListViewMore, style: TextStyle(fontSize: 13)),
                        style: TextButton.styleFrom(
                          foregroundColor: const Color.fromARGB(255, 42, 39, 241),
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                          minimumSize: const Size(0, 28),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Helper method to build info rows with icons
  Widget _buildInfoRow(IconData icon, String text, Color iconColor) {
    return Row(
      children: [
        Icon(icon, size: 16, color: iconColor),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 13,
              color: Color.fromARGB(255, 75, 75, 75),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusBadge(String status, BuildContext context) {
    Color badgeColor;
    String statusText;

    switch (status.toLowerCase()) {
      case 'active':
        badgeColor = const Color.fromARGB(255, 0, 130, 0);
        statusText = AppLocalizations.of(context)!.businessListStatusActive;
        break;
      case 'inactive':
        badgeColor = const Color.fromARGB(255, 180, 0, 0);
        statusText = AppLocalizations.of(context)!.businessListStatusInactive;
        break;
      case 'pending':
        badgeColor = const Color.fromARGB(255, 180, 90, 0);
        statusText = AppLocalizations.of(context)!.businessListStatusPending;
        break;
      default:
        badgeColor = const Color.fromARGB(255, 42, 39, 241);
        statusText = status;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: badgeColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: badgeColor.withOpacity(0.5), width: 0.5),
      ),
      child: Text(
        statusText,
        style: TextStyle(
          color: badgeColor,
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  String _formatDate(String? dateString, BuildContext context) {
    if (dateString == null || dateString.isEmpty) {
      return AppLocalizations.of(context)!.businessListDateUnknown;
    }

    try {
      final date = DateTime.parse(dateString);
      return DateFormat('dd/MM/yyyy').format(date);
    } catch (e) {
      return dateString;
    }
  }
}
