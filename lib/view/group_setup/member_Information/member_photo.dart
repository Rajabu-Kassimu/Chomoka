import 'dart:io';
import 'package:chomoka/model/GroupMemberModel.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'member_summary.dart';
import 'package:chomoka/l10n/app_localizations.dart';


class MemberPhoto extends StatefulWidget {
  final int? groupId;
  final int? userId;
  final int? mzungukoId;
  final bool isUpdateMode;

  const MemberPhoto({
    super.key,
    this.groupId,
    this.mzungukoId,
    this.userId,
    this.isUpdateMode = false,
  });

  @override
  State<MemberPhoto> createState() => _MemberPhotoState();
}

class _MemberPhotoState extends State<MemberPhoto> {
  File? _selectedImage;

  @override
  void initState() {
    super.initState();
    if (widget.isUpdateMode) {
      _loadSavedImage();
    }
  }

  Future<void> _loadSavedImage() async {
    try {
      final groupMembersModel = GroupMembersModel();
      final result =
          await groupMembersModel.where('id', '=', widget.userId).findOne();

      if (result != null && result is GroupMembersModel) {
        if (result.memberImage != null && result.memberImage!.isNotEmpty) {
          setState(() {
            _selectedImage = File(result.memberImage!);
          });
        }
      }
    } catch (e) {
      final l10n = AppLocalizations.of(context)!;
      print('Error fetching saved image: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.errorLoadingPhoto)),
      );
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imageFile = await picker.pickImage(source: ImageSource.camera);

    if (imageFile != null) {
      setState(() {
        _selectedImage = File(imageFile.path);
      });
    }
  }

  Future<void> _selectImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? imageFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (imageFile != null) {
      setState(() {
        _selectedImage = File(imageFile.path);
      });
    }
  }

  Future<void> _saveMemberPhoto() async {
    final l10n = AppLocalizations.of(context)!;
    try {
      final groupMember = GroupMembersModel();
      if (_selectedImage != null) {
        await groupMember
            .where('id', '=', widget.userId)
            .update({'memberImage': _selectedImage!.path});
      } else {
        await groupMember
            .where('id', '=', widget.userId)
            .update({'memberImage': null});
      }

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MemberSummaryPage(
              groupId: widget.groupId,
              userId: widget.userId,
              mzungukoId: widget.mzungukoId),
        ),
      );
    } catch (e) {
      print('Error saving member photo: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.errorSavingPhoto)),
      );
    }
  }

  void _removeImage() async {
    final l10n = AppLocalizations.of(context)!;
    try {
      final groupMember = GroupMembersModel();
      await groupMember
          .where('id', '=', widget.userId)
          .update({'memberImage': null});
      setState(() {
        _selectedImage = null;
      });
    } catch (e) {
      print('Error removing image: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.errorRemovingPhoto)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    Widget avatarContent;
    if (_selectedImage != null) {
      avatarContent = ClipOval(
        child: Image.file(
          _selectedImage!,
          fit: BoxFit.cover,
          width: 300,
          height: 300,
        ),
      );
    } else {
      avatarContent = const Icon(
        Icons.person,
        size: 200,
        color: Colors.white,
      );
    }

    return Scaffold(
      appBar: CustomAppBar(
        title: l10n.groupInformation,
        subtitle: l10n.takePhoto,
        showBackArrow: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            CircleAvatar(
              radius: 150,
              backgroundColor: Colors.grey[400],
              child: avatarContent,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: _pickImage,
                  icon: const Icon(Icons.camera),
                  label: Text(l10n.takePhoto),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(150, 50),
                    backgroundColor: Color.fromARGB(255, 241, 241, 241),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _selectImageFromGallery,
                  icon: const Icon(Icons.photo_library),
                  label: Text(l10n.chooseFromGallery),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(150, 50),
                    backgroundColor: Color.fromARGB(255, 241, 241, 241),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (_selectedImage != null)
              TextButton(
                onPressed: _removeImage,
                child: Text(
                  l10n.removePhoto,
                  style: TextStyle(color: Colors.red),
                ),
              ),
            const SizedBox(height: 20),
            CustomButton(
              color: const Color.fromARGB(255, 4, 34, 207),
              buttonText: widget.isUpdateMode ? l10n.update : l10n.continueText,
              onPressed: _saveMemberPhoto,
              type: ButtonType.elevated,
            ),
          ],
        ),
      ),
    );
  }
}
