import 'package:chomoka/model/group_activities/TrainingModel.dart';
import 'package:chomoka/view/dashboard/group_activities/training/add_training.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:chomoka/l10n/app_localizations.dart';


class TrainingSummary extends StatefulWidget {
  final int? mzungukoId;

  const TrainingSummary({super.key, this.mzungukoId});

  @override
  State<TrainingSummary> createState() => _TrainingSummaryState();
}

class _TrainingSummaryState extends State<TrainingSummary> {
  bool _isLoading = true;
  List<TrainingModel> _trainings = [];

  @override
  void initState() {
    super.initState();
    _loadTrainings();
  }

  Future<void> _loadTrainings() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Load trainings for this mzunguko
      if (widget.mzungukoId != null) {
        final trainingModel = TrainingModel();
        final results = await trainingModel
            .where('mzungukoId', '=', widget.mzungukoId)
            .find();

        setState(() {
          _trainings = results.map((model) => model as TrainingModel).toList();
        });
      } else {
        // Load all trainings if no mzungukoId specified
        final trainingModel = TrainingModel();
        final results = await trainingModel.find();

        setState(() {
          _trainings = results.map((model) => model as TrainingModel).toList();
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
        title: l10n.trainingListTitle,
        showBackArrow: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _trainings.isEmpty
              ? _buildEmptyState(l10n)
              : _buildTrainingsList(l10n),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTraining(
                mzungukoId: widget.mzungukoId,
              ),
            ),
          );
          if (result == true) {
            _loadTrainings();
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
                Icons.school_outlined,
                size: 80,
                color: Color.fromARGB(255, 42, 39, 241),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              l10n.noTrainingsSaved,
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
                l10n.addNewTraining,
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
                    builder: (context) => AddTraining(
                      mzungukoId: widget.mzungukoId,
                    ),
                  ),
                );
                if (result == true) {
                  _loadTrainings();
                }
              },
              icon: const Icon(Icons.add),
              label: Text(l10n.addTrainingTitle),
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

  Widget _buildTrainingsList(AppLocalizations l10n) {
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
                  l10n.trainingListTitle,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.totalTrainings(_trainings.length.toString()),
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
              onRefresh: _loadTrainings,
              color: const Color.fromARGB(255, 42, 39, 241),
              child: ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: _trainings.length,
                itemBuilder: (context, index) {
                  final training = _trainings[index];
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
                                    (training.trainingType)?.toUpperCase() ??
                                        'Mafunzo',
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
                                  training.trainingDate != null
                                      ? DateFormat('dd MMM yyyy').format(
                                          DateTime.parse(
                                              training.trainingDate!))
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
                                Icons.business,
                                l10n.organization,
                                training.organization ?? l10n.unknown,
                              ),
                              const SizedBox(height: 12),

                              _buildInfoItemWithSubtitle(
                                Icons.people,
                                l10n.membersCount,
                                '${training.membersCount ?? 0}',
                              ),
                              const SizedBox(height: 12),

                              _buildInfoItemWithSubtitle(
                                Icons.person,
                                l10n.trainer,
                                training.trainer ?? l10n.unknown,
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
                                            builder: (context) => AddTraining(
                                              mzungukoId: widget.mzungukoId,
                                              trainingToEdit: training,
                                            ),
                                          ),
                                        ).then((result) {
                                          if (result == true) {
                                            _loadTrainings();
                                          }
                                        });
                                      },
                                      icon: const Icon(Icons.edit,
                                          size: 16,
                                          color:
                                              Color.fromARGB(255, 42, 39, 241)),
                                      label: Text(l10n.edit),
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
                                        _deleteTraining(training);
                                      },
                                      icon: const Icon(Icons.delete,
                                          size: 16, color: Colors.red),
                                      label: Text(l10n.delete),
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

  Future<void> _deleteTraining(TrainingModel training) async {
        final l10n = AppLocalizations.of(context)!;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.deleteTrainingTitle),
        content: Text(l10n.deleteTrainingConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.no),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(l10n.yes, style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true && training.id != null) {
      try {
        await TrainingModel().where('id', '=', training.id).delete();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Mafunzo yamefutwa kikamilifu')),
        );

        _loadTrainings();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Hitilafu: ${e.toString()}')),
        );
      }
    }
  }
}
