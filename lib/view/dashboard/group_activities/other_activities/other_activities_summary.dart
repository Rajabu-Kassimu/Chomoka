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
        backgroundColor: const Color.fromARGB(255, 42, 39, 241),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildEmptyState(AppLocalizations l10n) {
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
                Icons.event_note_outlined,
                size: 80,
                color: Color.fromARGB(255, 42, 39, 241),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              l10n.noActivitiesSaved,
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

  Widget _buildActivitiesList(AppLocalizations l10n) {
    return Container(
      color: Colors.grey[100],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.activityListTitle,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.totalActivities(_activities.length.toString()),
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: RefreshIndicator(
              onRefresh: _loadActivities,
              color: const Color.fromARGB(255, 42, 39, 241),
              child: ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: _activities.length,
                itemBuilder: (context, index) {
                  final activity = _activities[index];
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 42, 39, 241)
                                .withOpacity(0.1),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(0),
                              topRight: Radius.circular(0),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 8),
                                    height: 40,
                                child: Expanded(
                                  child: Text(
                                    (activity.activityName)?.toUpperCase() ??
                                        'Shughuli',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 42, 39, 241),
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  activity.activityDate != null
                                      ? DateFormat('dd MMM yyyy').format(
                                          DateTime.parse(
                                              activity.activityDate!))
                                      : 'Tarehe haijulikani',
                                  style: const TextStyle(
                                    color: Color.fromARGB(255, 42, 39, 241),
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildInfoItemWithSubtitle(
                                Icons.people,
                                'Idadi ya Wanufaika',
                                '${activity.beneficiariesCount ?? 0}',
                              ),
                              const SizedBox(height: 12),

                              _buildInfoItemWithSubtitle(
                                Icons.location_on,
                                'Eneo',
                                activity.location ?? 'Halijulikani',
                              ),

                              const SizedBox(height: 12),
                              const Divider(height: 1),

                              Padding(
                                padding: const EdgeInsets.only(top: 8),
                                child: Row(
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
                                      icon: const Icon(Icons.edit,
                                          size: 16,
                                          color:
                                              Color.fromARGB(255, 42, 39, 241)),
                                      label: const Text(
                                        'Hariri',
                                        style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 42, 39, 241),
                                          fontSize: 13,
                                        ),
                                      ),
                                      style: TextButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        minimumSize: Size.zero,
                                        tapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    TextButton.icon(
                                      onPressed: () {
                                        _deleteActivity(activity);
                                      },
                                      icon: const Icon(Icons.delete,
                                          size: 16, color: Colors.red),
                                      label: const Text(
                                        'Futa',
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 13,
                                        ),
                                      ),
                                      style: TextButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 4),
                                        minimumSize: Size.zero,
                                        tapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                      ),
                                    ),
                                  ],
                                ),
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

  Widget _buildInfoItemWithSubtitle(
      IconData icon, String subtitle, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(icon, size: 16, color: Colors.black),
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
                  fontWeight: FontWeight.w500,
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
