import 'package:chomoka/model/MeetingSetupModel.dart';
import 'package:chomoka/model/AttendanceModel.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/vsla/buy_share/buy_share.dart';
import 'package:chomoka/view/dashboard/meetings/new_meeting/vsla/vsla_meeting_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:chomoka/model/KatibaModel.dart';
import 'package:chomoka/model/MemberShareModel.dart';
import 'package:chomoka/model/GroupMemberModel.dart'; // Add this import
import 'package:chomoka/l10n/app_localizations.dart';

import 'package:provider/provider.dart';
import 'package:chomoka/providers/currency_provider.dart';
import 'package:chomoka/utils/currency_formatter.dart';

class ShareSummary extends StatefulWidget {
  final int? meetingId;
  final int? mzungukoId;
  final bool? editingMode;
  final List<Map<String, dynamic>>? purchaseData;

  const ShareSummary({
    Key? key,
    this.meetingId,
    this.mzungukoId,
    this.purchaseData,
    this.editingMode = false,
  }) : super(key: key);

  @override
  State<ShareSummary> createState() => _ShareSummaryState();
}

class _ShareSummaryState extends State<ShareSummary> {
  bool isLoading = true;
  List<Map<String, dynamic>> members = [];
  int totalShares = 0;
  int shareValue = 0;
  int totalAmount = 0;

  @override
  void initState() {
    super.initState();
    _loadShareData();
  }

  Future<void> _loadShareData() async {
    try {
      // Fetch share value from KatibaModel
      final katiba = KatibaModel();
      final shareData = await katiba
          .where('katiba_key', '=', 'share_amount')
          .where('mzungukoId', '=', widget.mzungukoId)
          .findOne();

      if (shareData != null && shareData is KatibaModel) {
        shareValue = int.tryParse(shareData.value?.toString() ?? '0') ?? 3000;
      } else {
        shareValue = 3000; // Default value if not found
      }

      if (widget.purchaseData != null && widget.purchaseData!.isNotEmpty) {
        // Use the provided purchase data
        setState(() {
          members = widget.purchaseData!;

          // Calculate totals
          totalShares =
              members.fold(0, (sum, member) => sum + (member['shares'] as int));
          totalAmount = totalShares * shareValue;

          isLoading = false;
        });
      } else {
        // Fetch attendance records for users marked as "Yupo"
        final attendanceModel = AttendanceModel();
        final yupoAttendances = await attendanceModel
            .where('meeting_id', '=', widget.meetingId)
            .where('mzungukoid', '=', widget.mzungukoId)
            .where('attendance_status', '=', 'Yupo')
            .find();

        // Extract user IDs from attendance records
        List<int?> yupoUserIds = yupoAttendances
            .map((attendance) {
              final map = attendance.toMap();
              return map['user_id'] as int?;
            })
            .where((id) => id != null)
            .toList();

        // Create a map to store member data
        Map<int?, Map<String, dynamic>> memberMap = {};

        // Fetch member details for users with "Yupo" status
        for (int? userId in yupoUserIds) {
          if (userId == null) continue;

          // Fetch member data from GroupMembersModel
          final groupMember = GroupMembersModel();
          final memberData = await groupMember
              .where('id', '=', userId)
              .where('mzungukoId', '=', widget.mzungukoId)
              .findOne();

          String memberName = "Member #$userId";
          String? memberNumber;

          if (memberData != null && memberData is GroupMembersModel) {
            memberName = memberData.name ?? memberName;
            memberNumber = memberData.memberNumber;
          }

          // Initialize member with zero shares
          memberMap[userId] = {
            'id': userId,
            'name': memberName,
            'memberNumber': memberNumber,
            'shares': 0,
          };
        }

        // Now fetch share data to update the members who have shares
        final memberShareModel = MemberShareModel();
        final shares = await memberShareModel
            .where('meeting_id', '=', widget.meetingId)
            .where('mzungukoId', '=', widget.mzungukoId)
            .find();

        // Update share counts for members who have shares
        for (var share in shares) {
          if (share is MemberShareModel) {
            final userId = share.userId;
            final numberOfShares = share.numberOfShares ?? 0;

            if (memberMap.containsKey(userId)) {
              // Update existing member's shares
              memberMap[userId]!['shares'] =
                  (memberMap[userId]!['shares'] as int) + numberOfShares;
            } else if (yupoUserIds.contains(userId)) {
              // This is a fallback in case we missed a member somehow
              // Fetch member name from GroupMembersModel
              final groupMember = GroupMembersModel();
              final memberData = await groupMember
                  .where('id', '=', userId)
                  .where('mzungukoId', '=', widget.mzungukoId)
                  .findOne();

              String memberName = "Member #$userId";
              String? memberNumber;

              if (memberData != null && memberData is GroupMembersModel) {
                memberName = memberData.name ?? memberName;
                memberNumber = memberData.memberNumber;
              }

              memberMap[userId] = {
                'id': userId,
                'name': memberName,
                'memberNumber': memberNumber,
                'shares': numberOfShares,
              };
            }
          }
        }

        // Convert map to list
        members = memberMap.values.toList();

        // Calculate totals
        totalShares =
            members.fold(0, (sum, member) => sum + (member['shares'] as int));
        totalAmount = totalShares * shareValue;

        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error loading share data: $e');
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Kuna hitilafu imetokea: $e')),
      );
    }
  }

  Future<void> _updateStatusToCompleted() async {
    try {
      final meetingSetupModel = MeetingSetupModel(
        meetingId: widget.meetingId,
        mzungukoId: widget.mzungukoId,
        meeting_step: 'akiba_lazima',
        value: 'complete',
      );

      await meetingSetupModel.create();
    } catch (e) {
      print('Error updating status: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update status: $e')),
      );
    }
  }

  Widget _buildSummarySection() {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: EdgeInsets.all(16.0),
      margin: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.muhtasariWaHisa,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.jumlaYaHisa,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.set_meal, size: 16, color: Colors.grey[800]),
                      SizedBox(width: 4),
                      Text(
                        '$totalShares',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    l10n.jumlaYaFedha,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    formatCurrency(totalAmount, Provider.of<CurrencyProvider>(context).currencyCode),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[700],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMembersSection() {
    final l10n = AppLocalizations.of(context)!;
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.members(members.length),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: members.length,
                itemBuilder: (context, index) {
                  final member = members[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BuyShare(
                            meetingId: widget.meetingId,
                            userId: member['id'] is int
                                ? member['id']
                                : int.tryParse(member['id'].toString()),
                            userName: member['name'].toString(),
                            memberNumber: member['memberNumber'] != null
                                ? int.tryParse(
                                    member['memberNumber'].toString())
                                : null,
                            editingMode: true,
                            mzungukoId: widget.mzungukoId,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      margin: EdgeInsets.only(bottom: 12.0),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.grey[300],
                                  child: Icon(Icons.person,
                                      color: Colors.grey[700]),
                                ),
                                SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    member['memberNumber'] != null
                                        ? Text(
                                            'No. ${member['memberNumber']}',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.grey[600],
                                            ),
                                          )
                                        : SizedBox.shrink(),
                                    Text(
                                      member['name'].toString(),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 12),
                            // Shares and value information
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Shares count
                                Row(
                                  children: [
                                    Text(
                                      l10n.hisa,
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    Icon(Icons.set_meal,
                                        size: 16, color: Colors.grey[700]),
                                    SizedBox(width: 4),
                                    Text(
                                      '${member['shares']}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                // Value
                                Text(
                                  formatCurrency((member['shares'] as int) * shareValue, Provider.of<CurrencyProvider>(context).currencyCode),
                                  style: TextStyle(
                                    color: Colors.green[700],
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: CustomAppBar(
        title: l10n.hisa,
        subtitle: l10n.muhtasari,
        showBackArrow: true,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Summary section
                _buildSummarySection(),

                // Members section
                _buildMembersSection(),

                // Complete button
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Color.fromARGB(255, 4, 34, 207), // Green color
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () async {
                        await _updateStatusToCompleted();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => VslaMeetingDashboard(
                              meetingId: widget.meetingId,
                              // mzungukoId: widget.mzungukoId,
                            ),
                          ),
                        );
                      },
                      child: Text(
                        l10n.finish,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
