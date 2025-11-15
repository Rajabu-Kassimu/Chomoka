import 'package:chomoka/model/BaseModel.dart';
import 'package:chomoka/model/GroupInformationModel.dart';
import 'package:chomoka/model/KatibaModel.dart';
import 'package:chomoka/model/MeetingModel.dart';
import 'package:chomoka/model/MzungukoModel.dart';
import 'package:url_launcher/url_launcher.dart';

class DashboardController {
  Future<bool> checkActiveMeeting() async {
    await BaseModel.initAppDatabase();
    final model = MeetingModel();
    final activeMeeting = await model.where('status', '=', 'active').findOne();
    return activeMeeting != null && activeMeeting is MeetingModel;
  }

  Future<bool> isLastMeetingCompleted() async {
    try {
      await BaseModel.initAppDatabase();
      final model = MeetingModel();
      final allMeetings = await model.find();

      if (allMeetings.isEmpty) return false;

      allMeetings.sort((a, b) {
        final meetingA = a as MeetingModel;
        final meetingB = b as MeetingModel;
        return meetingB.id!.compareTo(meetingA.id!);
      });

      final lastMeeting = allMeetings.first as MeetingModel;
      return lastMeeting.status == 'complete';
    } catch (e) {
      return false;
    }
  }

  Future<bool> navigateToActiveMeeting() async {
    try {
      final model = MeetingModel();
      final activeMeeting =
          await model.where('status', '=', 'active').findOne();

      if (activeMeeting != null && activeMeeting is MeetingModel) {
        return activeMeeting.id != null && activeMeeting.number != null;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<String?> fetchGroupInformation() async {
    try {
      final groupInformationModel = GroupInformationModel();
      final data =
          await groupInformationModel.first() as GroupInformationModel?;
      return data?.name;
    } catch (e) {
      return null;
    }
  }

  Future<void> dialNumber(String number) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: number);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      throw 'Could not launch $number';
    }
  }

  Future<int?> fetchMzungukoId() async {
    try {
      final mzungukoModel = MzungukoModel();
      final mzungukoResult =
          await mzungukoModel.where('status', '!=', 'pending').select();

      if (mzungukoResult.isEmpty) return null;

      final sortedResults = mzungukoResult
          .map((e) => mzungukoModel.fromMap(e))
          .toList()
        ..sort((a, b) => (b.id ?? 0).compareTo(a.id ?? 0));
      return sortedResults.first.id;
    } catch (e) {
      return null;
    }
  }

  Future<String?> isLastMzungukoCompleted() async {
    try {
      final mzungukoModel = MzungukoModel();
      final mzungukoResult = await mzungukoModel.select();

      if (mzungukoResult.isEmpty) return null;

      final lastMzungukoMap = mzungukoResult.reduce((current, next) {
        return current['id'] > next['id'] ? current : next;
      });

      return lastMzungukoMap['status'];
    } catch (e) {
      return null;
    }
  }

  Future<String> checkGroupPrinciple(int? mzungukoId) async {
    try {
      await BaseModel.ensureDatabaseInitialized();
      final katibaModel = KatibaModel();
      final groupTypeData = await katibaModel
          .where('katiba_key', '=', 'kanuni')
          .where('mzungukoId', '=', mzungukoId)
          .findOne();

      if (groupTypeData != null && groupTypeData is KatibaModel) {
        return groupTypeData.value ?? '';
      }
      return '';
    } catch (e) {
      print('Error fetching group type: $e');
      return '';
    }
  }

  Future<bool> isVSLAGroup(int? mzungukoId) async {
      try {
        String groupType = await checkGroupPrinciple(mzungukoId);
        // Check if the group type contains "VSLA" (case insensitive)
        bool isVSLA = groupType.toUpperCase().contains('VSLA');
        print('Is VSLA group check: $isVSLA (Group type: $groupType)');
        return isVSLA;
      } catch (e) {
        print('Error checking if VSLA group: $e');
        return false;
      }
    }
}
