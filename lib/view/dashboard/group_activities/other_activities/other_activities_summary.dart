import 'package:chomoka/model/group_activities/ShughuliMbalimbaliModel.dart';
import 'package:chomoka/view/dashboard/group_activities/other_activities/add_other_activities.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:chomoka/l10n/app_localizations.dart';


class OtherActivitiesSummary extends StatefulWidget {
  final int? mzungukoId;

  const OtherActivitiesSummary({super.key, this.mzungukoId});

  @override
  State<OtherActivitiesSummary> createState() => _OtherActivitiesSummaryState();
}

class _OtherActivitiesSummaryState extends State<OtherActivitiesSummary> {
  static const Color _primary = Color(0xFF2A27F1);

  bool _isLoading = true;
  List<ShughuliMbalimbaliModel> _activities = [];

  @override
  void initState() {
    super.initState();
    _loadActivities();
  }

  Future<void> _loadActivities() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Load activities for this mzunguko
      if (widget.mzungukoId != null) {
        final activityModel = ShughuliMbalimbaliModel();
        final results = await activityModel
            .where('mzungukoId', '=', widget.mzungukoId)
            .find();

        setState(() {
          _activities = results.map((model) => model as ShughuliMbalimbaliModel).toList();
        });
      } else {
        // Load all activities if no mzungukoId specified
        final activityModel = ShughuliMbalimbaliModel();
        final results = await activityModel.find();

        setState(() {
          _activities = results.map((model) => model as ShughuliMbalimbaliModel).toList();
        });
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
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: CustomAppBar(
        title: l10n.activityListTitle,
        showBackArrow: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _activities.isEmpty
              ? _buildEmptyState(l10n)
              : _buildActivitiesList(l10n),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddOtherActivities(
                mzungukoId: widget.mzungukoId,
              ),
            ),
          );
          if (result == true) {
            _loadActivities();
          }
        },
        backgroundColor: _primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildEmptyState(AppLocalizations l10n) {
    return Container(
      color: Colors.grey[50],
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: _primary.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.event_note_outlined,
                size: 72,
                color: _primary,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              l10n.noActivitiesSaved,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF333333),
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                l10n.addNewActivity,
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
                    builder: (context) => AddOtherActivities(
                      mzungukoId: widget.mzungukoId,
                    ),
                  ),
                );
                if (result == true) {
                  _loadActivities();
                }
              },
              icon: const Icon(Icons.add),
              label: Text(l10n.addOtherActivityTitle),
              style: ElevatedButton.styleFrom(
                backgroundColor: _primary,
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

  Widget _buildActivitiesList(AppLocalizations l10n) {
    return Container(
      color: Colors.grey[100],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSummaryHeader(
            icon: Icons.event_note_outlined,
            title: l10n.activityListTitle,
            subtitle: l10n.totalActivities(_activities.length.toString()),
          ),

          Expanded(
            child: RefreshIndicator(
              onRefresh: _loadActivities,
              color: _primary,
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 88),
                itemCount: _activities.length,
                itemBuilder: (context, index) {
                  final activity = _activities[index];
                  return _buildActivityCard(activity);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryHeader({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 4),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [_primary, _primary.withOpacity(0.82)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: _primary.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.white, size: 26),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.white70,
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

  Widget _buildActivityCard(ShughuliMbalimbaliModel activity) {
    final date = _formatDate(activity.activityDate);
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 14),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Card header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            color: _primary.withOpacity(0.06),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.06),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.event_note_outlined,
                    color: _primary,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    (activity.activityName)?.toUpperCase() ?? 'Shughuli',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: _primary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 12),
                _buildDateChip(date),
              ],
            ),
          ),

          // Card body
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoItemWithSubtitle(
                  Icons.people_alt_outlined,
                  'Idadi ya Wanufaika',
                  '${activity.beneficiariesCount ?? 0}',
                ),
                const SizedBox(height: 14),
                _buildInfoItemWithSubtitle(
                  Icons.location_on_outlined,
                  'Eneo',
                  activity.location ?? 'Halijulikani',
                ),
                const SizedBox(height: 8),
                const Divider(height: 1),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddOtherActivities(
                              mzungukoId: widget.mzungukoId,
                              activityToEdit: activity,
                            ),
                          ),
                        ).then((result) {
                          if (result == true) {
                            _loadActivities();
                          }
                        });
                      },
                      icon: const Icon(Icons.edit, size: 16, color: _primary),
                      label: const Text(
                        'Hariri',
                        style: TextStyle(color: _primary, fontSize: 13),
                      ),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                    const SizedBox(width: 4),
                    TextButton.icon(
                      onPressed: () {
                        _deleteActivity(activity);
                      },
                      icon: const Icon(Icons.delete, size: 16, color: Colors.red),
                      label: const Text(
                        'Futa',
                        style: TextStyle(color: Colors.red, fontSize: 13),
                      ),
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateChip(String date) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.calendar_today_outlined, size: 13, color: _primary),
          const SizedBox(width: 5),
          Text(
            date,
            style: const TextStyle(
              color: _primary,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) {
      return 'Tarehe haijulikani';
    }
    try {
      return DateFormat('dd MMM yyyy').format(DateTime.parse(dateString));
    } catch (_) {
      return dateString;
    }
  }

  Widget _buildInfoItemWithSubtitle(
      IconData icon, String subtitle, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _primary.withOpacity(0.08),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 18, color: _primary),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                subtitle,
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
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF333333),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _deleteActivity(ShughuliMbalimbaliModel activity) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Futa Shughuli'),
        content: const Text('Una uhakika unataka kufuta shughuli hii?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Hapana'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Ndio', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true && activity.id != null) {
      try {
        // Use the BaseModel where method to set up the delete condition
        final model = ShughuliMbalimbaliModel();
        await model.where('id', '=', activity.id).delete();

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Shughuli imefutwa kikamilifu')),
          );
        }

        // Reload the activities after deletion
        _loadActivities();
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Hitilafu: ${e.toString()}')),
          );
        }
      }
    }
  }
}
