import 'package:chomoka/view/dashboard/group_activities/group_business/business_list.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:chomoka/model/group_activities/business/BusinessInfomationModel.dart';
import 'package:intl/intl.dart';
import 'package:chomoka/l10n/app_localizations.dart';


class BusinessSummary extends StatefulWidget {
  final int? groupId;
  final int? mzungukoId;
  final BusinessInformationModel? businessInfo;

  const BusinessSummary({
    super.key,
    this.groupId,
    this.mzungukoId,
    this.businessInfo,
  });

  @override
  State<BusinessSummary> createState() => _BusinessSummaryState();
}

class _BusinessSummaryState extends State<BusinessSummary> {
  bool _isLoading = true;
  BusinessInformationModel? _businessInfo;

  @override
  void initState() {
    super.initState();
    _loadBusinessInfo();
  }

  Future<void> _loadBusinessInfo() async {
    setState(() {
      _isLoading = true;
    });

    try {
      if (widget.businessInfo != null) {
        // Use the provided business info
        _businessInfo = widget.businessInfo;
      } else {
        // Load the latest business info from the database
        final businessInfoModel = BusinessInformationModel();

        if (widget.mzungukoId != null) {
          businessInfoModel.where('mzungukoId', '=', widget.mzungukoId);
        }

        if (widget.groupId != null) {
          businessInfoModel.where('groupId', '=', widget.groupId);
        }

        final result = await businessInfoModel.latest();
        _businessInfo = result as BusinessInformationModel?;
      }
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
        title: AppLocalizations.of(context)!.businessSummaryTitle,
        showBackArrow: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _businessInfo == null
              ? _buildEmptyState()
              : Column(
                  children: [
                    Expanded(child: _buildSummaryContent()),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: CustomButton(
                        color: Color.fromARGB(255, 4, 34, 207),
                        buttonText: AppLocalizations.of(context)!.businessSummaryDone,
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BusinessList(
                                mzungukoId: widget.mzungukoId,
                              ),
                            ),
                          );
                        },
                        type: ButtonType.elevated,
                      ),
                    ),
                  ],
                ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.business,
              size: 80,
              color: Colors.grey[500],
            ),
          ),
          const SizedBox(height: 24),
          Text(
            AppLocalizations.of(context)!.businessSummaryNoInfo,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              AppLocalizations.of(context)!.businessSummaryRegisterPrompt,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 16,
              ),
            ),
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: 200,
            child: CustomButton(
              color: const Color.fromARGB(255, 4, 34, 207),
              buttonText: AppLocalizations.of(context)!.businessSummaryRegister,
              onPressed: () {
                Navigator.pop(context);
              },
              type: ButtonType.elevated,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildBusinessHeader(),
          const SizedBox(height: 24),
          _buildInfoCard(),
        ],
      ),
    );
  }

  Widget _buildBusinessHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 4, 34, 207),
        borderRadius: BorderRadius.circular(0),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  _businessInfo?.businessName ?? 'Biashara',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              // Edit icon button
              IconButton(
                onPressed: () {
                  // Navigate to edit screen
                },
                icon: const Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
                tooltip: 'Hariri Taarifa',
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.location_on, color: Colors.white70, size: 16),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  _businessInfo?.businessLocation ?? '-',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const Icon(Icons.calendar_today, color: Colors.white70, size: 16),
              const SizedBox(width: 6),
              Text(
                _formatDate(_businessInfo?.startDate, context),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Icon(
                    Icons.info_outline,
                    color: Color.fromARGB(255, 4, 34, 207),
                    size: 18,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  AppLocalizations.of(context)!.businessSummaryInfo,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12.0),
              child: Divider(),
            ),
            _buildInfoRowEnhanced(
              AppLocalizations.of(context)!.businessSummaryName,
              _businessInfo?.businessName ?? '-',
              Icons.business,
            ),
            _buildInfoRowEnhanced(
              AppLocalizations.of(context)!.businessSummaryLocation,
              _businessInfo?.businessLocation ?? '-',
              Icons.location_on,
            ),
            _buildInfoRowEnhanced(
              AppLocalizations.of(context)!.businessSummaryStartDate,
              _formatDate(_businessInfo?.startDate, context),
              Icons.calendar_today,
            ),
            _buildInfoRowEnhanced(
              AppLocalizations.of(context)!.businessSummaryProductType,
              _businessInfo?.productType ?? '-',
              Icons.category,
            ),
            if (_businessInfo?.otherProductType != null &&
                _businessInfo!.otherProductType!.isNotEmpty)
              _buildInfoRowEnhanced(
                AppLocalizations.of(context)!.businessSummaryOtherProductType,
                _businessInfo?.otherProductType ?? '-',
                Icons.category_outlined,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRowEnhanced(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(icon, color: Colors.grey[600], size: 16),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
      String title, IconData icon, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
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

  String _formatDate(String? dateString, BuildContext context) {
    if (dateString == null || dateString.isEmpty) {
      return '-';
    }

    try {
      final date = DateTime.parse(dateString);
      return DateFormat('dd/MM/yyyy').format(date);
    } catch (e) {
      return dateString;
    }
  }

  String _getStatusDisplay(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return 'Inafanya kazi';
      case 'inactive':
        return 'Haifanyi kazi';
      case 'pending':
        return 'Inasubiri';
      default:
        return status;
    }
  }
}
