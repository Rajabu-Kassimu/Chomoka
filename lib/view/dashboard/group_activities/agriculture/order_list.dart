import 'package:chomoka/model/group_activities/RequestPembejeoModel.dart';
import 'package:chomoka/view/dashboard/group_activities/agriculture/member_list.dart';
import 'package:chomoka/view/dashboard/group_activities/agriculture/request_pembejeo_summary.dart';
import 'package:chomoka/view/dashboard/group_activities/group_activities_dashboard.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:chomoka/l10n/app_localizations.dart';


class OrderList extends StatefulWidget {
  final int? mzungukoId;
  const OrderList({super.key, this.mzungukoId});

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  bool _isLoading = true;
  List<RequestPembejeoModel> _requests = [];
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadRequests();
  }

  Future<void> _loadRequests() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Load all requests for this mzunguko
      final requestModel = RequestPembejeoModel();

      // Create a query with proper conditions
      if (widget.mzungukoId != null) {
        requestModel.where('mzungukoId', '=', widget.mzungukoId);
      }

      // Now call find() to execute the query
      final results = await requestModel.find();

      setState(() {
        _requests =
            results.map((model) => model as RequestPembejeoModel).toList();
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

  List<RequestPembejeoModel> _getFilteredRequests() {
    if (_searchQuery.isEmpty) {
      return _requests;
    }

    return _requests.where((request) {
      final pembejeoType = request.pembejeoType?.toLowerCase() ?? '';
      final company = request.company?.toLowerCase() ?? '';
      final query = _searchQuery.toLowerCase();

      return pembejeoType.contains(query) || company.contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final filteredRequests = _getFilteredRequests();

    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.orderListTitle,
        subtitle: AppLocalizations.of(context)!.orderListSubtitle,
        icon: Icons.add,
        onIconPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MemberList(
                mzungukoId: widget.mzungukoId,
              ),
            ),
          );

          if (result == true) {
            _loadRequests();
          }
        },
        showBackArrow: true,
      ),
      body: Column(
        children: [
          //   // Search bar
          //   Padding(
          //     padding: const EdgeInsets.all(16.0),
          //     child: TextField(
          //       decoration: InputDecoration(
          //         hintText: 'Tafuta ombi...',
          //         prefixIcon: const Icon(Icons.search),
          //         border: OutlineInputBorder(
          //           borderRadius: BorderRadius.circular(0),
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

          const SizedBox(width: 20),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildSummaryCard(
                        AppLocalizations.of(context)!.orderListTotalRequests,
                        _requests.length.toString(),
                        Icons.list_alt,
                        Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Expanded(
                      child: _buildSummaryCard(
                        AppLocalizations.of(context)!.orderListPending,
                        _requests
                            .where((r) => r.status?.toLowerCase() == 'pending')
                            .length
                            .toString(),
                        Icons.pending_actions,
                        Colors.orange,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: _buildSummaryCard(
                        AppLocalizations.of(context)!.orderListApproved,
                        _requests
                            .where((r) => r.status?.toLowerCase() == 'approved')
                            .length
                            .toString(),
                        Icons.check_circle,
                        Colors.green,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Expanded(
                      child: _buildSummaryCard(
                        AppLocalizations.of(context)!.orderListRejected,
                        _requests
                            .where((r) => r.status?.toLowerCase() == 'rejected')
                            .length
                            .toString(),
                        Icons.cancel,
                        Colors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Status filters
          //   Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: 16.0),
          //     child: SingleChildScrollView(
          //       scrollDirection: Axis.horizontal,
          //       child: Row(
          //         children: [
          //           _buildFilterChip('Zote', true),
          //           const SizedBox(width: 8),
          //           _buildFilterChip('Zinasubiri', false),
          //           const SizedBox(width: 8),
          //           _buildFilterChip('Zimeidhinishwa', false),
          //           const SizedBox(width: 8),
          //           _buildFilterChip('Zimekataliwa', false),
          //         ],
          //       ),
          //     ),
          //   ),

          const SizedBox(height: 8),

          // List header
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppLocalizations.of(context)!.orderListRequests(filteredRequests.length.toString()),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: _loadRequests,
                  tooltip: AppLocalizations.of(context)!.orderListRefresh,
                ),
              ],
            ),
          ),

          // Main content
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : filteredRequests.isEmpty
                    ? _buildEmptyState()
                    : _buildRequestsList(filteredRequests),
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CustomButton(
              color: Color.fromARGB(255, 4, 34, 207),
              buttonText: AppLocalizations.of(context)!.orderListDone,
              onPressed: () {
                // Navigate based on group type
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GroupBusinessDashboard(
                      mzungukoId: widget.mzungukoId,
                    ),
                  ),
                );

                print('Button Pressed');
              },
              type: ButtonType.elevated,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (bool selected) {
        // Implement filter logic here
      },
      backgroundColor: Colors.grey[200],
      selectedColor: const Color.fromARGB(255, 42, 39, 241).withOpacity(0.2),
      checkmarkColor: const Color.fromARGB(255, 42, 39, 241),
      labelStyle: TextStyle(
        color: isSelected
            ? const Color.fromARGB(255, 42, 39, 241)
            : Colors.black87,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            AppLocalizations.of(context)!.orderListNoRequests,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            AppLocalizations.of(context)!.orderListAddNewPrompt,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequestsList(List<RequestPembejeoModel> requests) {
    return ListView.builder(
      itemCount: requests.length,
      padding: const EdgeInsets.all(12),
      itemBuilder: (context, index) {
        final request = requests[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RequestPembejeoSummary(
                    mzungukoId: widget.mzungukoId,
                    request: request,
                  ),
                ),
              ).then((value) {
                if (value == true) {
                  _loadRequests();
                }
              });
            },
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with type and status
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(Icons.agriculture,
                            size: 24,
                            color: const Color.fromARGB(255, 42, 39, 241)),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              request.pembejeoType ?? AppLocalizations.of(context)!.orderListUnknownInput,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              request.company ?? AppLocalizations.of(context)!.orderListUnknownCompany,
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 14,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: _getStatusColor(request.status),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          _getStatusText(request.status, context),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Divider(height: 1),
                  ),

                  // Details section
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.shopping_bag,
                                    size: 16, color: Colors.grey[600]),
                                const SizedBox(width: 6),
                                Text(
                                  AppLocalizations.of(context)!.orderListAmount(request.amount ?? AppLocalizations.of(context)!.orderListUnknownAmount),
                                  style: TextStyle(
                                    color: Colors.grey[800],
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(Icons.calendar_today,
                                    size: 16, color: Colors.grey[600]),
                                const SizedBox(width: 6),
                                Text(
                                  request.requestDate != null
                                      ? DateFormat('dd MMM yyyy').format(
                                          DateTime.parse(request.requestDate!))
                                      : AppLocalizations.of(context)!.orderListUnknownDate,
                                  style: TextStyle(
                                    color: Colors.grey[800],
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              AppLocalizations.of(context)!.orderListPrice,
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              request.price != null
                                  ? 'TZS ${NumberFormat("#,###").format(request.price)}'
                                  : AppLocalizations.of(context)!.orderListUnknownPrice,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 42, 39, 241),
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'approved':
        return Colors.green;
      case 'rejected':
        return Colors.red;
      case 'pending':
      default:
        return Colors.orange;
    }
  }

  String _getStatusText(String? status, BuildContext context) {
    switch (status?.toLowerCase()) {
      case 'approved':
        return AppLocalizations.of(context)!.orderListStatusApproved;
      case 'rejected':
        return AppLocalizations.of(context)!.orderListStatusRejected;
      case 'pending':
      default:
        return AppLocalizations.of(context)!.orderListStatusPending;
    }
  }

  Widget _buildSummaryCard(
      String title, String count, IconData icon, Color color) {
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
            Row(
              children: [
                Icon(icon, color: color, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[700],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              count,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
