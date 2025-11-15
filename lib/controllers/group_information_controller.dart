import 'package:chomoka/model/GroupInformationModel.dart';

class GroupInformationController {
  final GroupInformationModel _model = GroupInformationModel();

  // Create new group information
  Future<int> createGroupInformation(Map<String, dynamic> data) async {
    try {
      final groupInfo = GroupInformationModel(
        name: data['name'],
        yearMade: data['yearMade'],
        round: data['round'],
        mzungukoId: data['mzungukoId'],
        meetingFrequently: data['meetingFrequently'],
        meetingAmount: data['meetingAmount'],
        meetingDescription: data['meetingDescription'],
        registrationStatus: data['registrationStatus'],
        registeredNumber: data['registeredNumber'],
        groupInstitution: data['groupInstitution'],
        projectType: data['projectType'],
        projectName: data['projectName'],
        teacherIdentification: data['teacherIdentification'],
        country: data['country'],
        region: data['region'],
        district: data['district'],
        ward: data['ward'],
        streetOrVillage: data['streetOrVillage'],
        status: data['status'],
        language: data['language'],
        isReady: data['isReady'] ?? 0,
      );
      return await groupInfo.create();
    } catch (e) {
      throw Exception('Failed to create group information: $e');
    }
  }

  // Fetch saved group information
  Future<GroupInformationModel?> fetchSavedData({int? id}) async {
    try {
      if (id != null) {
        return await _model.where('id', '=', id).findOne()
            as GroupInformationModel?;
      }
      return await _model.first() as GroupInformationModel?;
    } catch (e) {
      throw Exception('Failed to fetch group information: $e');
    }
  }

  // Update group information
  Future<int> updateGroupInformation(int id, Map<String, dynamic> data) async {
    try {
      return await _model.where('id', '=', id).update(data);
    } catch (e) {
      throw Exception('Failed to update group information: $e');
    }
  }

  // Delete group information
  Future<int> deleteGroupInformation(int id) async {
    try {
      return await _model.where('id', '=', id).delete();
    } catch (e) {
      throw Exception('Failed to delete group information: $e');
    }
  }

  // Get all group information
  Future<List<GroupInformationModel>> getAllGroupInformation() async {
    try {
      final results = await _model.find();
      return results.map((model) => model as GroupInformationModel).toList();
    } catch (e) {
      throw Exception('Failed to fetch all group information: $e');
    }
  }

  // Get group information by specific condition
  Future<List<GroupInformationModel>> getGroupInformationBy({
    String? country,
    String? region,
    String? district,
    int? isReady,
  }) async {
    try {
      var query = _model;

      // if (country != null) {
      //   query = query.where('country', '=', country);
      // }
      // if (region != null) {
      //   query = query.where('region', '=', region);
      // }
      // if (district != null) {
      //   query = query.where('district', '=', district);
      // }
      // if (isReady != null) {
      //   query = query.where('isReady', '=', isReady);
      // }

      final results = await query.find();
      return results.map((model) => model as GroupInformationModel).toList();
    } catch (e) {
      throw Exception('Failed to fetch filtered group information: $e');
    }
  }
}
