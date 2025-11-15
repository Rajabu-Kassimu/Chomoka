import 'package:chomoka/model/group_activities/RequestPembejeoModel.dart';
import 'package:chomoka/model/group_activities/ShughuliMbalimbaliModel.dart';
import 'package:chomoka/model/group_activities/TrainingModel.dart';
import 'package:chomoka/model/group_activities/business/BusinessInfomationModel.dart';
import 'package:chomoka/view/dashboard/dashboard.dart';
import 'package:chomoka/view/dashboard/group_activities/agriculture/order_list.dart';
import 'package:chomoka/view/dashboard/group_activities/agriculture/request_pembejeo.dart';
import 'package:chomoka/view/dashboard/group_activities/group_business/business_information.dart';
import 'package:chomoka/view/dashboard/group_activities/group_business/business_list.dart';
import 'package:chomoka/view/dashboard/group_activities/other_activities/add_other_activities.dart';
import 'package:chomoka/view/dashboard/group_activities/other_activities/other_activities_summary.dart';
import 'package:chomoka/view/dashboard/group_activities/training/add_training.dart';
import 'package:chomoka/view/dashboard/group_activities/training/training_summary.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/l10n/app_localizations.dart';


class GroupBusinessDashboard extends StatefulWidget {
  var mzungukoId;
  GroupBusinessDashboard({super.key, this.mzungukoId});

  @override
  State<GroupBusinessDashboard> createState() => _GroupBusinessDashboardState();
}

class _GroupBusinessDashboardState extends State<GroupBusinessDashboard> {

  @override
  Widget build(BuildContext context) {
      final l10n = AppLocalizations.of(context)!;

    print("mzunguko id is .....");
    print(widget.mzungukoId);
    return Scaffold(
      appBar: CustomAppBar(
        title: l10n.groupActivitiesTitle,
        showBackArrow: false,
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  ListTiles(
                    icon: Icon(Icons.group,
                        color: const Color.fromARGB(255, 0, 0, 0)),
                    title: l10n.groupBusiness,
                    mark: 'pending',
                    onTap: () async {
                      // Check if there are any businesses for this group
                      final businessModel = BusinessInformationModel();

                      if (widget.mzungukoId != null) {
                        businessModel.where(
                            'mzungukoId', '=', widget.mzungukoId);
                      }

                      try {
                        final results = await businessModel.find();

                        if (mounted) {
                          if (results.isNotEmpty) {
                            // If businesses exist, navigate to business list
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BusinessList(
                                  mzungukoId: widget.mzungukoId,
                                ),
                              ),
                            );
                          } else {
                            // If no businesses, navigate to create business screen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BusinessInformation(
                                  mzungukoId: widget.mzungukoId,
                                ),
                              ),
                            );
                          }
                        }
                      } catch (e) {
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(l10n.errorOccurred(e.toString())),
                              ),
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BusinessInformation(
                                mzungukoId: widget.mzungukoId,
                              ),
                            ),
                          );
                        }
                      }
                    },
                  ),
                  ListTiles(
                    icon: Icon(Icons.check_box,
                        color: Color.fromARGB(144, 12, 36, 252)),
                    title: l10n.agriculture,
                    mark: 'pending',
                    onTap: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrderList(
                            mzungukoId: widget.mzungukoId,
                          ),
                        ),
                      );
                    },
                  ),
                  ListTiles(
                    icon: Icon(Icons.bolt,
                        color: Color.fromARGB(255, 228, 13, 13)),
                    title: l10n.otherActivities,
                    mark: 'pending',
                    onTap: () async {
                      // Check if there are any activities for this mzungukoId
                      final activityModel = ShughuliMbalimbaliModel();
                      final results = await activityModel
                          .where('mzungukoId', '=', widget.mzungukoId)
                          .find();

                      if (results.isNotEmpty) {
                        // If activities exist, navigate to summary
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OtherActivitiesSummary(
                              mzungukoId: widget.mzungukoId,
                            ),
                          ),
                        );
                      } else {
                        // If no activities, navigate to add new activity
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddOtherActivities(
                              mzungukoId: widget.mzungukoId,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  ListTiles(
                    icon: Icon(Icons.label_important_outline_sharp,
                        color: Color.fromARGB(255, 255, 231, 11)),
                    title: l10n.training,
                    mark: 'pending',
                    onTap: () async {
                      try {
                        final trainingModel = TrainingModel();
                        final results = await trainingModel
                            .where('mzungukoId', '=', widget.mzungukoId)
                            .find();

                        if (results.isNotEmpty) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TrainingSummary(
                                mzungukoId: widget.mzungukoId,
                              ),
                            ),
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddTraining(
                                mzungukoId: widget.mzungukoId,
                              ),
                            ),
                          );
                        }
                      } catch (e) {
                        // If there's an error, default to add training
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(l10n.errorOccurred(e.toString()))),
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddTraining(
                              mzungukoId: widget.mzungukoId,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CustomButton(
                color: Color.fromARGB(255, 4, 34, 207),
                buttonText: l10n.backToHome,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => dashboard(
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
      ),
    );
  }
}
