import 'package:chomoka/model/GroupMemberModel.dart';
import 'package:chomoka/model/group_activities/RequestPembejeoModel.dart';
import 'package:chomoka/view/dashboard/group_activities/agriculture/member_list.dart';
import 'package:chomoka/view/dashboard/group_activities/agriculture/order_list.dart';
import 'package:chomoka/view/dashboard/group_activities/agriculture/request_pembejeo.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:chomoka/l10n/app_localizations.dart';


class RequestPembejeoSummary extends StatefulWidget {
  final int? mzungukoId;
  final int? userId;
  final RequestPembejeoModel? request; // Add this parameter

  const RequestPembejeoSummary({
    super.key,
    this.mzungukoId,
    this.userId,
    this.request, // Add this parameter
  });

  @override
  State<RequestPembejeoSummary> createState() => _RequestPembejeoSummaryState();
}

class _RequestPembejeoSummaryState extends State<RequestPembejeoSummary> {
  bool _isLoading = true;
  List<RequestPembejeoModel> _requests = [];
  RequestPembejeoModel? _currentRequest;

  @override
  void initState() {
    super.initState();
    if (widget.request != null) {
      // If a specific request was passed, use it
      setState(() {
        _currentRequest = widget.request;
        _isLoading = false;
      });
    } else {
      // Otherwise load all requests
      _loadRequests();
    }
  }

  Future<void> _loadRequests() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Load requests for this user and mzunguko
      final requestModel = RequestPembejeoModel();
      final query = requestModel.where('mzungukoId', '=', widget.mzungukoId);

      if (widget.userId != null) {
        query.where('userId', '=', widget.userId);
      }

      final results = await query.find();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: _currentRequest != null
            ? AppLocalizations.of(context)!.requestSummaryTitle
            : AppLocalizations.of(context)!.requestSummaryListTitle,
        showBackArrow: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _currentRequest != null
              ? _buildSingleRequestView(_currentRequest!)
              : _requests.isEmpty
                  ? _buildEmptyState()
                  : _buildRequestsList(),
      floatingActionButton: _currentRequest == null
          ? FloatingActionButton(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RequestPembejeo(
                      mzungukoId: widget.mzungukoId,
                      userId: widget.userId,
                    ),
                  ),
                );

                if (result == true) {
                  _loadRequests();
                }
              },
              backgroundColor: const Color.fromARGB(255, 42, 39, 241),
              child: const Icon(Icons.add, color: Colors.white),
            )
          : null,
    );
  }

  // New method to build a single request view with smaller cards
  Widget _buildSingleRequestView(RequestPembejeoModel request) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status card with more compact design
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: _getStatusColor(request.status).withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              _getStatusIcon(request.status),
                              color: _getStatusColor(request.status),
                              size: 22,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              AppLocalizations.of(context)!.requestSummaryStatus,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[800],
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: _getStatusColor(request.status),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            _getStatusText(request.status, context),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _getStatusMessage(request.status, context),
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[700],
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // User information card - more compact
            FutureBuilder<GroupMembersModel?>(
                future: _getUserInfo(request.userId),
                builder: (context, snapshot) {
                  final username = snapshot.data?.name ?? 'Mtumiaji';
                  return Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.blue[50],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(
                                  Icons.person_outline,
                                  size: 20,
                                  color: Color.fromARGB(255, 42, 39, 241),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                AppLocalizations.of(context)!.requestSummaryUserInfo,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[800],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),

                          // Username
                          _buildCompactDetailItem(
                            AppLocalizations.of(context)!.requestSummaryUserName,
                            username,
                            Icons.person,
                          ),

                          if (snapshot.data?.memberNumber != null) ...[
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Divider(height: 1),
                            ),
                            // Member Number
                            _buildCompactDetailItem(
                              AppLocalizations.of(context)!.requestSummaryMemberNumber,
                              snapshot.data?.memberNumber ?? AppLocalizations.of(context)!.requestSummaryUnknown,
                              Icons.badge_outlined,
                            ),
                          ],

                          if (snapshot.data?.phone != null) ...[
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Divider(height: 1),
                            ),
                            // Phone
                            _buildCompactDetailItem(
                              AppLocalizations.of(context)!.requestSummaryPhone,
                              snapshot.data?.phone ?? AppLocalizations.of(context)!.requestSummaryUnknown,
                              Icons.phone_outlined,
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                }),

            const SizedBox(height: 16),

            // Request details card with more compact design
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 42, 39, 241)
                                .withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.description_outlined,
                            size: 20,
                            color: Color.fromARGB(255, 42, 39, 241),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          AppLocalizations.of(context)!.requestSummaryInputType,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[800],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Two-column layout for details to save space
                    Wrap(
                      spacing: 16.0,
                      runSpacing: 8.0,
                      children: [
                        // Left column
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Pembejeo Type
                              _buildCompactDetailItem(
                                AppLocalizations.of(context)!.requestSummaryInputType,
                                request.pembejeoType ?? AppLocalizations.of(context)!.requestSummaryUnknown,
                                Icons.category_outlined,
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                child: Divider(height: 1),
                              ),
                              // Amount
                              _buildCompactDetailItem(
                                AppLocalizations.of(context)!.requestSummaryAmount,
                                request.amount ?? AppLocalizations.of(context)!.requestSummaryUnknown,
                                Icons.shopping_bag_outlined,
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                child: Divider(height: 1),
                              ),
                              // Date
                              _buildCompactDetailItem(
                                AppLocalizations.of(context)!.requestSummaryRequestDate,
                                request.requestDate != null
                                    ? DateFormat('dd/MM/yyyy').format(
                                        DateTime.parse(request.requestDate!))
                                    : AppLocalizations.of(context)!.requestSummaryUnknown,
                                Icons.calendar_today_outlined,
                              ),
                            ],
                          ),
                        ),

                        // Right column
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Company
                              _buildCompactDetailItem(
                                AppLocalizations.of(context)!.requestSummaryCompany,
                                request.company ?? AppLocalizations.of(context)!.requestSummaryUnknown,
                                Icons.business_outlined,
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                child: Divider(height: 1),
                              ),
                              // Price
                              _buildCompactDetailItem(
                                AppLocalizations.of(context)!.requestSummaryPrice,
                                request.price != null
                                    ? 'TZS ${NumberFormat("#,###").format(request.price)}'
                                    : AppLocalizations.of(context)!.requestSummaryUnknown,
                                Icons.attach_money_outlined,
                              ),
                              if (request.cost != null) ...[
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8),
                                  child: Divider(height: 1),
                                ),
                                // Cost
                                _buildCompactDetailItem(
                                  AppLocalizations.of(context)!.requestSummaryCost,
                                  request.cost != null
                                      ? 'TZS ${NumberFormat("#,###").format(request.cost)}'
                                      : AppLocalizations.of(context)!.requestSummaryUnknown,
                                  Icons.account_balance_wallet_outlined,
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Action buttons with more compact design
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderList(
                            mzungukoId: widget.mzungukoId,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.arrow_back,
                        size: 18, color: Colors.white),
                    label: Text(AppLocalizations.of(context)!.requestSummaryBack),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 247, 147, 16),
                      foregroundColor: const Color.fromARGB(221, 255, 255, 255),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 0,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      // Navigate to edit page
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RequestPembejeo(
                            mzungukoId: widget.mzungukoId,
                            userId: widget.userId,
                            existingRequest: request,
                            isEditing: true,
                          ),
                        ),
                      );

                      // Refresh the page if needed
                      if (result == true && mounted) {
                        setState(() {
                          _isLoading = true;
                        });
                        if (widget.request != null) {
                          // If a specific request was passed, reload it
                          final requestModel = RequestPembejeoModel();
                          final updatedRequest = await requestModel
                              .where('id', '=', widget.request!.id)
                              .find();
                          if (updatedRequest.isNotEmpty) {
                            setState(() {
                              _currentRequest =
                                  updatedRequest.first as RequestPembejeoModel;
                              _isLoading = false;
                            });
                          }
                        } else {
                          // Otherwise reload all requests
                          _loadRequests();
                        }
                      }
                    },
                    icon: const Icon(
                      Icons.edit,
                      size: 18,
                      color: Colors.white,
                    ),
                    label: Text(AppLocalizations.of(context)!.requestSummaryEdit),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 42, 39, 241),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 1,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // New helper method for more compact detail items
  Widget _buildCompactDetailItem(String label, String value, IconData icon) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon,
              size: 16, color: const Color.fromARGB(255, 42, 39, 241)),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Existing methods remain unchanged
  Widget _buildEmptyState() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[50],
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.shopping_cart_outlined,
                size: 80,
                color: Color.fromARGB(255, 42, 39, 241),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              AppLocalizations.of(context)!.requestSummaryNoRequests,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                AppLocalizations.of(context)!.requestSummaryAddNewPrompt,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RequestPembejeo(
                      mzungukoId: widget.mzungukoId,
                      userId: widget.userId,
                    ),
                  ),
                );

                if (result == true) {
                  _loadRequests();
                }
              },
              icon: const Icon(Icons.add),
              label: Text(AppLocalizations.of(context)!.requestSummaryAddRequest),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 42, 39, 241),
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRequestsList() {
    return Container(
      color: Colors.grey[100],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title section
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.requestSummaryListTitle,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  AppLocalizations.of(context)!.requestSummaryTotal(_requests.length.toString()),
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),

          // List of requests
          Expanded(
            child: RefreshIndicator(
              onRefresh: _loadRequests,
              color: const Color.fromARGB(255, 42, 39, 241),
              child: ListView.builder(
                itemCount: _requests.length,
                padding: const EdgeInsets.all(8),
                itemBuilder: (context, index) {
                  final request = _requests[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header with date and status
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                request.pembejeoType ?? 'Pembejeo',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: _getStatusColor(request.status),
                                  borderRadius: BorderRadius.circular(12),
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
                        ),

                        // Request details
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildInfoItem(
                                Icons.calendar_today,
                                AppLocalizations.of(context)!.requestSummaryRequestDate,
                                request.requestDate != null
                                    ? DateFormat('dd MMM yyyy').format(
                                        DateTime.parse(request.requestDate!))
                                    : AppLocalizations.of(context)!.requestSummaryUnknown,
                              ),
                              const SizedBox(height: 12),
                              _buildInfoItem(
                                Icons.shopping_bag,
                                AppLocalizations.of(context)!.requestSummaryAmount,
                                request.amount ?? AppLocalizations.of(context)!.requestSummaryUnknown,
                              ),
                              const SizedBox(height: 12),
                              _buildInfoItem(
                                Icons.business,
                                AppLocalizations.of(context)!.requestSummaryCompany,
                                request.company ?? AppLocalizations.of(context)!.requestSummaryUnknown,
                              ),
                              const SizedBox(height: 12),
                              _buildInfoItem(
                                Icons.attach_money,
                                AppLocalizations.of(context)!.requestSummaryPrice,
                                request.price != null
                                    ? 'TZS ${NumberFormat("#,###").format(request.price)}'
                                    : AppLocalizations.of(context)!.requestSummaryUnknown,
                              ),
                              const SizedBox(height: 12),
                              _buildInfoItem(
                                Icons.account_balance_wallet,
                                AppLocalizations.of(context)!.requestSummaryCost,
                                request.cost != null
                                    ? 'TZS ${NumberFormat("#,###").format(request.cost)}'
                                    : AppLocalizations.of(context)!.requestSummaryUnknown,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 16, color: Colors.black87),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  IconData _getStatusIcon(String? status) {
    switch (status?.toLowerCase()) {
      case 'approved':
        return Icons.check_circle_outline;
      case 'rejected':
        return Icons.cancel_outlined;
      case 'pending':
      default:
        return Icons.hourglass_empty;
    }
  }

  String _getStatusText(String? status, BuildContext context) {
    switch (status?.toLowerCase()) {
      case 'approved':
        return AppLocalizations.of(context)!.requestSummaryStatusApproved;
      case 'rejected':
        return AppLocalizations.of(context)!.requestSummaryStatusRejected;
      case 'pending':
      default:
        return AppLocalizations.of(context)!.requestSummaryStatusPending;
    }
  }

  String _getStatusMessage(String? status, BuildContext context) {
    switch (status?.toLowerCase()) {
      case 'approved':
        return AppLocalizations.of(context)!.requestSummaryStatusMessageApproved;
      case 'rejected':
        return AppLocalizations.of(context)!.requestSummaryStatusMessageRejected;
      case 'pending':
      default:
        return AppLocalizations.of(context)!.requestSummaryStatusMessagePending;
    }
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
}

// Method to get user information
Future<GroupMembersModel?> _getUserInfo(int? userId) async {
  if (userId == null) return null;

  try {
    final memberModel = GroupMembersModel();
    final results = await memberModel.where('id', '=', userId).find();

    if (results.isNotEmpty) {
      return results.first as GroupMembersModel;
    }
    return null;
  } catch (e) {
    print('Error fetching user info: $e');
    return null;
  }
}
