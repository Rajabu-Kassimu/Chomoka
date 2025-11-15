import 'package:chomoka/model/GroupMemberModel.dart';
import 'package:chomoka/view/group_setup/member_Information/member_photo.dart';
import 'package:chomoka/view/group_setup/member_Information/member_summary.dart';
import 'package:chomoka/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:chomoka/l10n/app_localizations.dart';


class memberIdentity extends StatefulWidget {
  final int? groupId;
  final int? mzungukoId;
  final int? userId;
  final bool isUpdateMode;

  const memberIdentity({
    super.key,
    this.groupId,
    this.mzungukoId,
    this.userId,
    this.isUpdateMode = false,
  });

  @override
  State<memberIdentity> createState() => _memberIdentityState();
}

// Move controllers and state variables inside the State class
// TextEditingController phoneNumber = TextEditingController();
// TextEditingController job = TextEditingController();
// TextEditingController id = TextEditingController();
// List<GroupMembersModel> _savedData = [];
// File? _selectedImage;
// final ImagePicker _picker = ImagePicker();

// String? _selectedJob;
// String? _selectedId;

final _formKey = GlobalKey<FormState>();

class _memberIdentityState extends State<memberIdentity> {
  late List<DropdownMenuItem<String>> jobName;
  late List<DropdownMenuItem<String>> idType;

  // Initialize controllers and state variables here
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController job = TextEditingController();
  final TextEditingController id = TextEditingController();
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();
  String? _selectedJob;
  String? _selectedId;
  bool _isLoading = true; // Add loading state

  @override
  void initState() {
    super.initState();
    // Fetch data only if userId is provided
    if (widget.userId != null) {
      _fetchMemberData();
    } else {
      setState(() {
        _isLoading = false; // No data to fetch, stop loading
      });
    }
  }

  Future<void> _fetchMemberData() async {
    try {
      final groupMember = GroupMembersModel();
      final memberData = await groupMember
          .where('id', '=', widget.userId)
          .first() as GroupMembersModel?;

      if (memberData != null && mounted) {
        // Check if widget is still mounted
        final l10n = AppLocalizations.of(context)!;
        setState(() {
          phoneNumber.text = memberData.phone ?? '';

          // Check if the job is one of the predefined localized values or 'other'
          final predefinedJobs = jobName.map((item) => item.value).toList();
          if (memberData.job != null &&
              predefinedJobs.contains(memberData.job)) {
            _selectedJob = memberData.job;
          } else if (memberData.job != null) {
            _selectedJob =
                getLocalizedValue('other', l10n); // Set dropdown to 'Other'
            job.text =
                memberData.job!; // Set the text field with the custom job
          }

          _selectedId = memberData.memberIdType;
          if (_requiresIdNumber(_selectedId)) {
            id.text = memberData.memberIdNumber ?? '';
          }
          if (memberData.memberIdImage != null &&
              memberData.memberIdImage!.isNotEmpty) {
            _selectedImage = File(memberData.memberIdImage!);
          }
          _isLoading = false; // Data loaded, stop loading
        });
      } else {
        setState(() {
          _isLoading = false; // No data found or widget unmounted, stop loading
        });
      }
    } catch (e) {
      print('Error fetching member data: $e');
      if (mounted) {
        setState(() {
          _isLoading = false; // Error occurred, stop loading
        });
        // Optionally show an error message
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text('Failed to load member data: $e')),
        // );
      }
    }
  }

  String getLocalizedValue(String value, AppLocalizations l10n) {
    switch (value) {
      // Jobs
      case 'farmer':
        return l10n.farmer;
      case 'teacher':
        return l10n.teacher;
      case 'doctor':
        return l10n.doctor;
      case 'entrepreneur':
        return l10n.entrepreneur;
      case 'engineer':
        return l10n.engineer;
      case 'lawyer':
        return l10n.lawyer;
      case 'other':
        return l10n.other;
      case 'none':
        return l10n.none;
      // ID Types
      case 'voterCard':
        return l10n.voterCard;
      case 'nationalId':
        return l10n.nationalId;
      case 'zanzibarResidentCard':
        return l10n.zanzibarResidentCard;
      case 'driversLicense':
        return l10n.driversLicense;
      case 'localGovernmentLetter':
        return l10n.localGovernmentLetter;
      default:
        return value;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Initialize dropdown items here as it depends on context for l10n
    _initializeDropdownItems();
  }

  void _initializeDropdownItems() {
    final l10n = AppLocalizations.of(context)!;

    jobName = [
      DropdownMenuItem(
          value: getLocalizedValue('farmer', l10n), child: Text(l10n.farmer)),
      DropdownMenuItem(
          value: getLocalizedValue('teacher', l10n), child: Text(l10n.teacher)),
      DropdownMenuItem(
          value: getLocalizedValue('doctor', l10n), child: Text(l10n.doctor)),
      DropdownMenuItem(
          value: getLocalizedValue('entrepreneur', l10n),
          child: Text(l10n.entrepreneur)),
      DropdownMenuItem(
          value: getLocalizedValue('engineer', l10n),
          child: Text(l10n.engineer)),
      DropdownMenuItem(
          value: getLocalizedValue('lawyer', l10n), child: Text(l10n.lawyer)),
      DropdownMenuItem(
          value: getLocalizedValue('other', l10n), child: Text(l10n.other)),
      DropdownMenuItem(
          value: getLocalizedValue('none', l10n), child: Text(l10n.none)),
    ];

    idType = [
      DropdownMenuItem(
          value: getLocalizedValue('voterCard', l10n),
          child: Text(l10n.voterCard)),
      DropdownMenuItem(
          value: getLocalizedValue('nationalId', l10n),
          child: Text(l10n.nationalId)),
      DropdownMenuItem(
          value: getLocalizedValue('zanzibarResidentCard', l10n),
          child: Text(l10n.zanzibarResidentCard)),
      DropdownMenuItem(
          value: getLocalizedValue('driversLicense', l10n),
          child: Text(l10n.driversLicense)),
      DropdownMenuItem(
          value: getLocalizedValue('localGovernmentLetter', l10n),
          child: Text(l10n.localGovernmentLetter)),
      DropdownMenuItem(
          value: getLocalizedValue('none', l10n), child: Text(l10n.none)),
    ];

    // If data hasn't been fetched yet (e.g., new member), ensure dropdowns are initialized
    if (_isLoading && widget.userId == null) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  bool _requiresIdNumber(String? idType) {
    // Ensure context is available before accessing l10n
    if (!mounted) return false;
    final l10n = AppLocalizations.of(context)!;
    return idType == getLocalizedValue('voterCard', l10n) ||
        idType == getLocalizedValue('nationalId', l10n) ||
        idType == getLocalizedValue('zanzibarResidentCard', l10n) ||
        idType == getLocalizedValue('driversLicense', l10n);
  }

  void _saveMemberData() async {
    if (_formKey.currentState!.validate()) {
      try {
        // Ensure context is available before accessing l10n
        if (!mounted) return;
        final l10n = AppLocalizations.of(context)!;
        final Map<String, dynamic> updatedData = {
          'phone':
              phoneNumber.text.trim().isEmpty ? null : phoneNumber.text.trim(),
          'job': _selectedJob == getLocalizedValue('other', l10n)
              ? job.text.trim()
              : _selectedJob,
          'memberIdType': _selectedId,
          'memberIdNumber':
              _requiresIdNumber(_selectedId) ? id.text.trim() : null,
          'memberIdImage': _selectedImage?.path,
        };

        final groupMember = GroupMembersModel();

        // Use updateOrCreate based on whether userId exists
        if (widget.userId != null) {
          await groupMember.where('id', '=', widget.userId).update(updatedData);
        } else {
          // Handle creation if needed, or assume update is always intended if userId is present
          // For now, we assume this page is only for updates if userId is passed
          print(
              "User ID is null, cannot update. Implement creation logic if needed.");
          // Potentially show an error or navigate differently
          return;
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.dataSavedSuccessfully)),
        );

        // Use Navigator.pop if it's an update, or push to next page if creation
        if (widget.isUpdateMode) {
          Navigator.pushReplacement(
            // Use pushReplacement to avoid stacking pages
            context,
            MaterialPageRoute(
              builder: (context) => MemberSummaryPage(
                  groupId: widget.groupId,
                  userId: widget.userId,
                  mzungukoId: widget.mzungukoId),
            ),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MemberPhoto(
                groupId: widget.groupId,
                userId: widget
                    .userId, // Pass the potentially newly created/updated userId
                mzungukoId: widget.mzungukoId,
              ),
            ),
          );
        }
      } catch (e) {
        print('Error saving member data: $e');
        if (mounted) {
          final l10n = AppLocalizations.of(context)!;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(
                    "Error saving data: $e")), // Provide a generic error or use l10n
          );
        }
      }
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _selectImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  void dispose() {
    // Dispose controllers
    phoneNumber.dispose();
    job.dispose();
    id.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Ensure context is available before accessing l10n
    if (!mounted) return Container(); // Return empty container if not mounted
    final l10n = AppLocalizations.of(context)!;

    // Use a conditional build based on loading state
    if (_isLoading) {
      return Scaffold(
        appBar: CustomAppBar(
          title: l10n.memberInfo,
          subtitle: l10n.memberIdentity,
          showBackArrow: true,
        ),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // Use the localized value for 'Other' job comparison
    final otherJobValue = getLocalizedValue('other', l10n);

    return Scaffold(
      appBar: CustomAppBar(
        title: l10n.memberInfo,
        subtitle: l10n.memberIdentity,
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Align labels to the start
              children: [
                SizedBox(height: 10),
                CustomTextField(
                  aboveText: l10n.memberPhoneNumber,
                  labelText: l10n.memberPhoneNumber,
                  hintText: l10n.enterMemberPhoneNumber,
                  keyboardType: TextInputType.phone, // Use phone keyboard type
                  controller: phoneNumber,
                  obscureText: false,
                  validator: (value) {
                    // Remove validation to make phone number optional
                    return null;
                  },
                ),
                SizedBox(height: 20), // Increased spacing
                CustomDropdown<String>(
                  labelText: l10n.job, // Use localized label
                  hintText: l10n.selectJob, // Use localized hint
                  items: jobName,
                  value: _selectedJob,
                  onChanged: (value) {
                    setState(() {
                      _selectedJob = value;
                      // Clear the custom job field if another job is selected
                      if (_selectedJob != otherJobValue) {
                        job.clear();
                      }
                    });
                    print('Selected job: $value');
                  },
                  validator: (value) {
                    if (value == null) {
                      return l10n.pleaseSelectJob; // Use localized error
                    }
                    return null;
                  },
                  aboveText: l10n.job, // Use localized above text
                ),
                // Use the localized 'Other' value for comparison
                if (_selectedJob == otherJobValue) SizedBox(height: 10),
                if (_selectedJob == otherJobValue)
                  CustomTextField(
                    aboveText: l10n.job, // Use localized text
                    labelText: l10n.job, // Use localized text
                    hintText: l10n.enterJobName, // Use localized text
                    controller: job,
                    obscureText: false,
                    validator: (value) {
                      if (_selectedJob == otherJobValue &&
                          (value == null || value.trim().isEmpty)) {
                        return l10n.pleaseEnterJobName; // Use localized error
                      }
                      return null;
                    },
                  ),
                SizedBox(height: 20), // Increased spacing
                CustomDropdown<String>(
                  labelText: l10n.selectIdType, // Use localized text
                  hintText: l10n.selectIdType, // Use localized text
                  items: idType,
                  value: _selectedId,
                  onChanged: (value) {
                    setState(() {
                      _selectedId = value;
                      // Clear ID number and image if ID type changes to one not requiring them
                      if (!_requiresIdNumber(_selectedId)) {
                        id.clear();
                        _selectedImage = null;
                      }
                    });
                    print('Selected ID type: $value');
                  },
                  validator: (value) {
                    // Allow 'None' as a valid selection, but validate others
                    final noneIdValue = getLocalizedValue('none', l10n);
                    if (value == null ||
                        (value != noneIdValue && value == l10n.selectIdType)) {
                      // Adjust validation logic if needed
                      return l10n.pleaseSelectIdType; // Use localized error
                    }
                    return null;
                  },
                  aboveText: l10n.idType, // Use localized text
                ),
                SizedBox(height: 10),
                if (_requiresIdNumber(_selectedId))
                  CustomTextField(
                    aboveText: l10n.idNumber, // Use localized text
                    labelText: l10n.idNumber, // Use localized text
                    hintText: l10n.enterIdNumber, // Use localized text
                    controller: id,
                    obscureText: false,
                    validator: (value) {
                      if (_requiresIdNumber(_selectedId) &&
                          (value == null || value.trim().isEmpty)) {
                        return l10n.pleaseEnterIdNumber; // Use localized error
                      }
                      return null;
                    },
                  ),
                if (_requiresIdNumber(_selectedId))
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            l10n.idPhoto,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          if (_selectedImage != null)
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  _selectedImage = null;
                                });
                              },
                              child: Text(
                                l10n.removePhoto,
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      // Display placeholder or image
                      Center(
                        child: _selectedImage != null
                            ? Image.file(
                                _selectedImage!,
                                height: 200, // Adjusted height
                                width: double.infinity,
                                fit: BoxFit
                                    .contain, // Use contain to see the whole ID
                              )
                            : Container(
                                height: 150,
                                width: double.infinity,
                                color: Colors.grey[300],
                                child: Icon(Icons.image_not_supported,
                                    size: 50, color: Colors.grey[600]),
                              ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceEvenly, // Better spacing
                        children: [
                          ElevatedButton.icon(
                            onPressed: _pickImage,
                            icon: const Icon(Icons.camera_alt),
                            label: Text(l10n.takePhoto),
                            style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 8)), // Adjust padding
                          ),
                          // const SizedBox(width: 10),
                          ElevatedButton.icon(
                            onPressed: _selectImageFromGallery,
                            icon: const Icon(Icons.photo_library),
                            label: Text(l10n.chooseFromGallery),
                            style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 8)), // Adjust padding
                          ),
                        ],
                      ),
                    ],
                  ),
                SizedBox(height: 30), // Increased spacing before button
                Center(
                  // Center the button
                  child: CustomButton(
                    color: const Color.fromARGB(255, 4, 34, 207),
                    buttonText:
                        widget.isUpdateMode ? l10n.update : l10n.continueText,
                    onPressed: _saveMemberData,
                    type: ButtonType.elevated,
                  ),
                ),
                SizedBox(height: 20), // Add padding at the bottom
              ],
            ),
          ),
        ),
      ),
    );
  }
}
