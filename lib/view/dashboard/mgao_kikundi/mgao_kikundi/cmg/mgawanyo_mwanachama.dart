import 'package:chomoka/model/BaseModel.dart';
import 'package:chomoka/view/dashboard/mgao_kikundi/mgao_kikundi/maliza_mgao.dart';
import 'package:chomoka/view/dashboard/mgao_kikundi/mgao_kikundi/cmg/mgao_summary.dart';
import 'package:flutter/material.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:chomoka/model/GroupMemberModel.dart';
import 'package:chomoka/model/UserMgaoModel.dart';
import 'package:chomoka/model/MzungukoModel.dart';

class MgawanyoMwanachama extends StatefulWidget {
  final int? mzungukoId;
  final double? pesaYaMgao;
  final bool isFromSummary;

  MgawanyoMwanachama({
    super.key,
    this.mzungukoId,
    this.pesaYaMgao,
    this.isFromSummary = false,
  });

  @override
  State<MgawanyoMwanachama> createState() => _MgawanyoMwanachamaState();
}

class _MgawanyoMwanachamaState extends State<MgawanyoMwanachama> {
  List<Map<String, dynamic>> _members = [];
  bool isLoading = true;
  bool allPaid = true;
  int? _userLength;

  Future<void> _fetchMembers() async {
    if (_members.isNotEmpty) {
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final groupMembersModel = GroupMembersModel();
      final savedMembers = await groupMembersModel.select();

      final userMgaoModel = UserMgaoModel();
      final allUserMgaos = await userMgaoModel
          .where('mzungukoId', '=', widget.mzungukoId)
          .find();

      Set<int> personalPaidUserIds = allUserMgaos
          .where((mgao) =>
              (mgao as UserMgaoModel).type == 'personal' &&
              (mgao as UserMgaoModel).status == 'paid')
          .map((mgao) => mgao.toMap()['userId'] as int)
          .toSet();

      Set<int> groupPaidUserIds = allUserMgaos
          .where((mgao) =>
              (mgao as UserMgaoModel).type == 'group' &&
              (mgao as UserMgaoModel).status == 'paid')
          .map((mgao) => mgao.toMap()['userId'] as int)
          .toSet();

      final mzungukoModel = MzungukoModel();
      final BaseModel? mzungukoData =
          await mzungukoModel.where('id', '=', widget.mzungukoId).findOne();

      double totalMgaoAmount = 0.0;
      if (mzungukoData != null && mzungukoData is MzungukoModel) {
        totalMgaoAmount = mzungukoData.pesaYaMgao ?? 0.0;
      }

      List<Map<String, dynamic>> unpaidMembers = savedMembers.where((member) {
        return !personalPaidUserIds.contains(member['id']);
      }).toList();

      double mgaoAmount = unpaidMembers.isNotEmpty
          ? totalMgaoAmount / unpaidMembers.length
          : 0.0;

      setState(() {
        _userLength = unpaidMembers.length;
        _members = unpaidMembers.map((member) {
          final bool isGroupPaid = groupPaidUserIds.contains(member['id']);
          return {
            ...member,
            'mgaoAmount': mgaoAmount,
            'status': isGroupPaid ? 'paid' : 'unpaid',
            'type': isGroupPaid ? 'group' : 'personal',
          };
        }).toList();

        // Check if all members are paid
        allPaid = _members.every((member) => member['status'] == 'paid');
        isLoading = false;
      });

      print('Unpaid members count: ${_members.length}');
      print(
          'Mgao amount per unpaid member: TZS ${mgaoAmount.toStringAsFixed(0)}');
    } catch (e) {
      setState(() {
        _members = [];
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading data: $e')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchMembers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Mgao wa Wanachama',
        subtitle: 'Chagua mwanachama',
        showBackArrow: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: _members.isEmpty
                      ? const Center(
                          child: Text('Hakuna wanachama katika kikundi hiki.'))
                      : ListView.builder(
                          itemCount: _members.length,
                          itemBuilder: (context, index) {
                            final member = _members[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MgaoSummary(
                                      mzungukoId: widget.mzungukoId,
                                      member: member,
                                      pesaYaMgao: widget.pesaYaMgao,
                                      userLength: _userLength,
                                      mgaoKiasi: member['mgaoAmount'] ?? 0.0,
                                    ),
                                  ),
                                );
                              },
                              child: CustomMemberCard(
                                memberNumber: member['memberNumber'] ?? '',
                                name: member['name'] ?? '',
                                mgaoAmount: member['mgaoAmount'] ?? 0.0,
                                status: member['status'],
                              ),
                            );
                          },
                        ),
                ),
                if (allPaid)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: CustomButton(
                      color: const Color.fromARGB(255, 4, 34, 207),
                      buttonText: 'Endelea',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MalizaMgao(mzungukoId: widget.mzungukoId),
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
}

class CustomMemberCard extends StatelessWidget {
  final String memberNumber;
  final String name;
  final double mgaoAmount;
  final String? status;

  CustomMemberCard({
    required this.memberNumber,
    required this.name,
    this.mgaoAmount = 0.0,
    this.status,
  });

  @override
  Widget build(BuildContext context) {
    Color amountColor = (status == 'paid') ? Colors.red : Colors.green;

    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30.0,
              child: Icon(Icons.person, size: 30.0, color: Colors.black),
              backgroundColor: Colors.grey[300],
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                        fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Namba ya mwanachama: $memberNumber',
                    style: TextStyle(fontSize: 14.0, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Mgao: TZS ${mgaoAmount.toStringAsFixed(0)}',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: amountColor, // Set color dynamically
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
