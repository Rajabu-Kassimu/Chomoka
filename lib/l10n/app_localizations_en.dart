// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get selectCountry => 'Select Country';

  @override
  String get pleaseSelectCountry => 'Please select your country';

  @override
  String get pleaseSelectCountryError =>
      'Please select a country before continuing.';

  @override
  String get locationInformation => 'Location Information';

  @override
  String get selectLanguage => 'Select Language';

  @override
  String get pleaseSelectLanguage => 'Please select language';

  @override
  String get selectRegion => 'Select Region';

  @override
  String get pleaseSelectRegion => 'Please select region';

  @override
  String get loan_based_on_shares =>
      'Specify how many times (x) a member can borrow based on their shares';

  @override
  String get loan_based_on_savings =>
      'Specify how many times (x) a member can borrow based on their savings';

  @override
  String get selectDistrict => 'Select District';

  @override
  String get pleaseSelectDistrict => 'Please select district';

  @override
  String get selectWard => 'Select Ward';

  @override
  String get pleaseSelectWard => 'Please select ward';

  @override
  String get enterStreetOrVillage => 'Enter Street or Village';

  @override
  String get pleaseEnterStreetOrVillage =>
      'Please enter street or village name';

  @override
  String get dataSavedSuccessfully => 'Data saved successfully!';

  @override
  String errorSavingData(String error) {
    return 'Error saving data: $error';
  }

  @override
  String get permissions => 'Permissions';

  @override
  String get permissionsDescription =>
      'Chomoka requires several permissions to work correctly and efficiently.';

  @override
  String get permissionsRequest =>
      'Please accept all permission requests to continue using Chomoka easily.';

  @override
  String get smsPermission => 'SMS';

  @override
  String get smsDescription =>
      'Chomoka uses SMS as backup to store information when there\'s no internet.';

  @override
  String get locationPermission => 'Your Location';

  @override
  String get locationDescription =>
      'To improve system efficiency, CHOMOKA will use your location information.';

  @override
  String get mediaPermission => 'Photos and Documents';

  @override
  String get mediaDescription =>
      'You can save photos, information, and related documents for verification.';

  @override
  String get termsAndConditions => 'Terms and Conditions';

  @override
  String get aboutChomoka => 'About Chomoka';

  @override
  String get aboutChomokaContent =>
      'To use Chomoka you must agree to the terms and conditions and privacy policy.';

  @override
  String get dataManagement => 'Data Management';

  @override
  String get dataManagementContent =>
      'By using Chomoka you agree to the collection and storage of your data. The system may use your location information and send messages from your phone.';

  @override
  String get namedData => 'Named Data';

  @override
  String get namedDataContent =>
      'Group and member information will be stored for record keeping. We will not share this information with anyone without group permission.';

  @override
  String get generalData => 'General Data';

  @override
  String get generalDataContent =>
      'We will use general data without mentioning member or group names to understand further developments.';

  @override
  String get acceptTerms => 'I accept the terms and conditions';

  @override
  String get confirm => 'Confirm';

  @override
  String get setupChomoka => 'Setup Chomoka';

  @override
  String get groupInfo => 'Group Information';

  @override
  String get memberInfo => 'Member Information';

  @override
  String get constitutionInfo => 'Constitution Information';

  @override
  String get fundInfo => 'Fund Information';

  @override
  String get passwordSetup => 'Password Setup';

  @override
  String get passwordSetupComplete => 'Password setup complete!';

  @override
  String get finished => 'Finished';

  @override
  String get groupInformation => 'Enter Group Information';

  @override
  String get editGroupInformation => 'Edit Group Information';

  @override
  String get groupName => 'Group Name';

  @override
  String get enterGroupName => 'Enter Group Name';

  @override
  String get groupNameRequired => 'Group name is required!';

  @override
  String get yearEstablished => 'Year Established';

  @override
  String get enterYearEstablished => 'Enter Year Established';

  @override
  String get yearEstablishedRequired => 'Year established is required!';

  @override
  String get enterValidYear => 'Please enter a valid year!';

  @override
  String enterYearRange(Object currentYear) {
    return 'Please enter a year between 1999 and $currentYear!';
  }

  @override
  String get currentRound => 'What round is the group in';

  @override
  String get enterCurrentRound => 'Enter the current round in the group';

  @override
  String get currentRoundRequired => 'Group round is required!';

  @override
  String get enterValidRound => 'Please enter a valid number for the round!';

  @override
  String get update => 'Update';

  @override
  String errorUpdatingData(Object error) {
    return 'Error updating data: $error';
  }

  @override
  String get groupSummary => 'Group Summary';

  @override
  String get sessionSummary => 'Session Summary';

  @override
  String get meetingFrequency => 'How Often Do You Meet?';

  @override
  String get pleaseSelectFrequency => 'Please select meeting frequency!';

  @override
  String get sessionCount => 'Number of Sessions in a Round:';

  @override
  String get enterSessionCount => 'Enter Number of Sessions';

  @override
  String get sessionCountRequired => 'Please enter number of sessions';

  @override
  String get enterValidSessionCount =>
      'Please enter a valid number for sessions';

  @override
  String get pleaseNote => 'Please Note:';

  @override
  String allocationDescription(String allocationDescription) {
    return 'Allocation is Every After $allocationDescription';
  }

  @override
  String errorOccurred(Object error) {
    return 'Error: $error';
  }

  @override
  String get groupRegistration => 'Group Registration';

  @override
  String get fines => 'Fines';

  @override
  String get lateness => 'Late arrival';

  @override
  String get absentWithoutPermission => 'Absent without permission';

  @override
  String get sendingRepresentative => 'Sent a representative';

  @override
  String get speakingWithoutPermission => 'Speaking without permission';

  @override
  String get phoneUsageDuringMeeting => 'Phone usage during meeting';

  @override
  String get leadershipMisconduct => 'Leadership misconduct';

  @override
  String get forgettingRules => 'Forgetting the rules';

  @override
  String get addNewFine => 'Add New Fine';

  @override
  String get finesWithoutAmountWontShow =>
      'Fines without amounts won\'t show during meetings';

  @override
  String get fineType => 'Type of fine';

  @override
  String get addFineType => 'Add Fine Type';

  @override
  String get amount => 'Amount';

  @override
  String get percentage => 'Percentage';

  @override
  String get memberShareTitle => 'Member Shareout';

  @override
  String get shareCount => 'Number of Shares';

  @override
  String get saveButton => 'Save';

  @override
  String get unnamed => 'Unnamed';

  @override
  String get noPhone => 'No phone';

  @override
  String errorLoadingData(Object error) {
    return 'Error loading data: $error';
  }

  @override
  String failedToUpdateStatus(Object error) {
    return 'Failed to update status: $error';
  }

  @override
  String get fixedAmount => 'Fixed Amount';

  @override
  String get enterPenaltyPercentage => 'Enter penalty percentage';

  @override
  String get percentageRequired => 'Percentage is required';

  @override
  String get enterValidPercentage => 'Please enter a valid percentage';

  @override
  String get enterFixedAmount => 'Enter Fixed Amount';

  @override
  String get fixedAmountRequired => 'Fixed amount is required';

  @override
  String get enterValidAmount => 'Please enter a valid amount!';

  @override
  String get explainPenaltyUsage =>
      'Explain how penalties are used for loans when a member fails to make all required payments on time.';

  @override
  String get loanDelayPenalty => 'Loan delay penalty';

  @override
  String get noPercentagePenalty =>
      'No percentage penalty will be charged for loan delays.';

  @override
  String percentagePenaltyExample(String percentage, String amount) {
    return 'For example, if a member delays paying their loan, they will pay an additional $percentage% each month on the remaining loan amount. If they borrow  10,000, they must pay a delay fee of  $amount per month.';
  }

  @override
  String get noFixedAmountPenalty =>
      'No fixed amount penalty will be charged for loan delays.';

  @override
  String fixedAmountPenaltyExample(String amount) {
    return 'For example, if a member delays paying their loan, they will pay  $amount as a fixed delay penalty.';
  }

  @override
  String get addAmount => 'Add Amount';

  @override
  String get cancel => 'Cancel';

  @override
  String get save => 'Save';

  @override
  String get continue_ => 'Continue';

  @override
  String get editRegistration => 'Edit Registration';

  @override
  String get registrationStatus => 'Registration Status';

  @override
  String get selectRegistrationStatus => 'Select Registration Status';

  @override
  String get pleaseSelectRegistrationStatus =>
      'Please select registration status';

  @override
  String get appVersionName => 'Chapati Version 1.0.0';

  @override
  String get appVersionNumber => 'Version 0001';

  @override
  String get open => 'Open';

  @override
  String get demo => 'Demo';

  @override
  String get exercise => 'Exercise';

  @override
  String get registrationNumber => 'Registration Number';

  @override
  String get enterRegistrationNumber => 'Enter Registration Number';

  @override
  String get pleaseEnterRegistrationNumber =>
      'Please enter registration number';

  @override
  String get correct => 'Correct';

  @override
  String get groupInstitution => 'Group Institution';

  @override
  String get editInstitution => 'Edit Group Institution';

  @override
  String get selectOrganization => 'Select Organization';

  @override
  String get pleaseSelectOrganization => 'Please select organization';

  @override
  String get enterOrganizationName => 'Enter Organization Name';

  @override
  String get organizationNameRequired => 'Organization name is required!';

  @override
  String get selectProject => 'Select Project';

  @override
  String get pleaseSelectProject => 'Please select project';

  @override
  String get enterProjectName => 'Enter Project Name';

  @override
  String get projectNameRequired => 'Project name is required!';

  @override
  String get enterTeacherId => 'Enter Teacher ID';

  @override
  String get teacherIdRequired => 'Teacher ID is required!';

  @override
  String get continueText => 'Continue';

  @override
  String get selectKeyToReset => 'Select key to reset';

  @override
  String get keyHolderSecretQuestion =>
      'The selected key holder member will be asked a secret question during key setup';

  @override
  String get resetKey1 => 'Reset key 1';

  @override
  String get resetKey2 => 'Reset key 2';

  @override
  String get resetKey3 => 'Reset key 3';

  @override
  String get selectQuestion => 'Select Question';

  @override
  String get answerToQuestion => 'Answer to question';

  @override
  String get enterAnswer => 'Enter answer to question';

  @override
  String get incorrectQuestionOrAnswer => 'Question or answer is incorrect';

  @override
  String get pleaseSelectQuestionAndAnswer =>
      'Please select question and answer';

  @override
  String get passwordsDoNotMatchTryAgain =>
      'Passwords do not match, please try again';

  @override
  String get confirmPasswordTitle => 'Confirm Password for';

  @override
  String get groupOverview => 'Group Overview';

  @override
  String get fundOverview => 'Fund Overview';

  @override
  String get meetingSummary => 'Meeting Summary';

  @override
  String get allocation => 'Allocation';

  @override
  String get registration => 'Group Registration';

  @override
  String get registrationType => 'Registration Type';

  @override
  String get institutionalInfo => 'Institutional Information';

  @override
  String get institutionName => 'Institution Name';

  @override
  String get projectName => 'Project Name';

  @override
  String get teacherId => 'Teacher ID';

  @override
  String get location => 'Location';

  @override
  String get loanGuarantors => 'Loan Guarantors';

  @override
  String get doesLoanNeedGuarantor => 'Does the loan need a guarantor?';

  @override
  String get numberOfGuarantors => 'Number of Guarantors';

  @override
  String get enterNumberOfGuarantors => 'Enter number of guarantors';

  @override
  String get numberOfGuarantorsRequired => 'Number of guarantors is required';

  @override
  String get securityQuestion1 => 'What year was your first child born?';

  @override
  String get securityQuestion2 => 'What is the first name of your first child?';

  @override
  String get securityQuestion3 => 'What year were you born?';

  @override
  String get errorSelectQuestion => 'Please select a security question.';

  @override
  String get errorEnterAnswer => 'Please fill in the answer to the question.';

  @override
  String get errorSaving => 'There was a problem saving. Please try again.';

  @override
  String resetQuestionPageTitle(int passwordNumber) {
    return 'Security Question for Key $passwordNumber';
  }

  @override
  String get selectQuestionLabel => 'Select Question';

  @override
  String get selectQuestionHint => 'Select Question';

  @override
  String get answerLabel => 'Answer';

  @override
  String get answerHint => 'Enter Answer';

  @override
  String get pleaseEnterValidNumber => 'Please enter a valid number';

  @override
  String get describeNumberOfGuarantors =>
      'Describe the number of guarantors required to apply for a loan';

  @override
  String get country => 'Country';

  @override
  String get region => 'Region';

  @override
  String get district => 'District';

  @override
  String get ward => 'Ward';

  @override
  String get streetOrVillage => 'Street or Village';

  @override
  String get sendSummary => 'SEND SUMMARY';

  @override
  String get completed => 'completed';

  @override
  String members(Object count) {
    return 'Members: $count';
  }

  @override
  String get noMembers => 'No members available.';

  @override
  String errorFetchingMembers(Object error) {
    return 'Error fetching members: $error';
  }

  @override
  String get memberSummary => 'Member Summary';

  @override
  String get memberIdentity => 'Member Identity';

  @override
  String get fullName => 'Full Name:';

  @override
  String get memberNumber => 'Member Number:';

  @override
  String get gender => 'Gender:';

  @override
  String get dob => 'Date of Birth:';

  @override
  String get phoneNumber => 'Phone Number:';

  @override
  String get job => 'Job:';

  @override
  String get idType => 'ID Type:';

  @override
  String get idNumber => 'ID Number:';

  @override
  String get noPhoneNumber => 'Member has no phone number';

  @override
  String summarySent(Object name) {
    return 'Summary sent to $name successfully';
  }

  @override
  String failedToSendSms(Object name) {
    return 'Failed to send SMS to $name';
  }

  @override
  String get totalSavings => 'Total Savings';

  @override
  String get totalDebt => 'Total Debt';

  @override
  String get totalShares => 'Total Shares';

  @override
  String get communityFundBalance => 'Community Fund Balance';

  @override
  String get currentLoans => 'Current Loans';

  @override
  String get totalFinesCollected => 'Total Fines Collected';

  @override
  String get confirmDeleteUser => 'Are you sure you want to delete this user?';

  @override
  String get delete => 'Delete';

  @override
  String get enterMemberNumber => 'Enter Member Number';

  @override
  String get memberNumberRequired => 'Please enter member number';

  @override
  String get memberNumberDigitsOnly => 'Member number should be digits only';

  @override
  String get enterFullName => 'Enter Full Name';

  @override
  String get fullNameRequired => 'Please enter member\'s full name';

  @override
  String get fullNameMinLength => 'Name should have at least 3 characters';

  @override
  String get selectYear => 'Select Year';

  @override
  String get selectMonth => 'Select Month';

  @override
  String get selectDay => 'Select Day';

  @override
  String get dobRequired => 'Please select complete date of birth';

  @override
  String get uniqueMemberNumber => 'Member number should be unique';

  @override
  String get noActiveCycle => 'Error: No active cycle found!';

  @override
  String get appTagline => 'We Help You Strengthen Development';

  @override
  String get example => 'Example';

  @override
  String get mzungukoPendingNoNew =>
      'The current cycle is already \"pending\". No new cycle has been started.';

  @override
  String get newMzungukoCreated => 'New cycle started successfully!';

  @override
  String errorSavingMzunguko(String error) {
    return 'Error saving or updating cycle information: $error';
  }

  @override
  String get weekly => 'Weekly';

  @override
  String get biWeekly => 'Every Two Weeks';

  @override
  String get monthly => 'Monthly';

  @override
  String years(int count) {
    return '$count Years';
  }

  @override
  String months(int count) {
    return 'months';
  }

  @override
  String weeks(int count) {
    return '$count Weeks';
  }

  @override
  String get registered => 'Registered';

  @override
  String get notRegistered => 'Not Registered';

  @override
  String get other => 'Other';

  @override
  String get memberPhoneNumber => 'Member Phone Number';

  @override
  String get enterMemberPhoneNumber => 'Enter Member Phone Number';

  @override
  String get selectJob => 'Select Job';

  @override
  String get enterJobName => 'Enter Job Name';

  @override
  String get pleaseSelectJob => 'Please select job';

  @override
  String get pleaseEnterJobName => 'Please enter job name';

  @override
  String get selectIdType => 'Select ID Type';

  @override
  String get enterIdNumber => 'Enter ID Number';

  @override
  String get pleaseSelectIdType => 'Please select ID type';

  @override
  String get pleaseEnterIdNumber => 'Please enter ID number';

  @override
  String get idPhoto => 'ID Photo';

  @override
  String get removePhoto => 'Remove Photo';

  @override
  String get takePhoto => 'Take Photo';

  @override
  String get chooseFromGallery => 'Choose from Gallery';

  @override
  String get farmer => 'Farmer';

  @override
  String get teacher => 'Teacher';

  @override
  String get doctor => 'Doctor';

  @override
  String get entrepreneur => 'Entrepreneur';

  @override
  String get engineer => 'Engineer';

  @override
  String get lawyer => 'Lawyer';

  @override
  String get none => 'None';

  @override
  String get voterCard => 'Voter ID Card';

  @override
  String get nationalId => 'National ID';

  @override
  String get zanzibarResidentCard => 'Zanzibar Resident Card';

  @override
  String get driversLicense => 'Driver\'s License';

  @override
  String get localGovernmentLetter => 'Local Government Letter';

  @override
  String get errorSavingPhoto => 'Failed to save member photo';

  @override
  String get errorRemovingPhoto => 'Failed to remove photo';

  @override
  String get errorLoadingPhoto => 'Failed to load member photo';

  @override
  String get memberInformation => 'Member Information';

  @override
  String get memberIdentification => 'Member Identification';

  @override
  String get dateOfBirth => 'Date of Birth';

  @override
  String get occupation => 'Occupation';

  @override
  String get mandatorySavings => 'Mandatory Savings';

  @override
  String get voluntarySavings => 'Voluntary Savings';

  @override
  String get communityFund => 'Community Fund';

  @override
  String get currentLoan => 'Current Loan';

  @override
  String get finish => 'Finish';

  @override
  String get enterKey1 => 'Enter Key 1';

  @override
  String get enterKey2 => 'Enter Key 2';

  @override
  String get enterKey3 => 'Enter Key 3';

  @override
  String get enterAllKeys => 'Please fill in all three keys.';

  @override
  String get invalidKeys => 'Secret keys are incorrect. Please try again.';

  @override
  String get systemError => 'A problem has occurred. Please try again later.';

  @override
  String get resetSecurityKeys => 'RESET SECURITY KEYS';

  @override
  String get openButton => 'OPEN';

  @override
  String get pleaseEnterNewPassword => 'Please enter new password';

  @override
  String get passwordMustBeDigitsOnly => 'Password must be digits only';

  @override
  String get passwordMustBeLessThan4Digits =>
      'Password must be less than 4 digits';

  @override
  String get pleaseConfirmNewPassword => 'Please confirm new password';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match';

  @override
  String get errorOccurredTryAgain => 'An error occurred. Please try again.';

  @override
  String editPasswordFor(String key) {
    return 'Edit Password for $key';
  }

  @override
  String get newPassword => 'New Password';

  @override
  String get confirmNewPassword => 'Confirm New Password';

  @override
  String get enterNewPassword => 'Enter new password';

  @override
  String get getHelp => 'Get Help';

  @override
  String get welcomeChomokaPlus => 'Welcome to Chomoka Plus';

  @override
  String groupOf(Object groupName) {
    return 'Group of: $groupName';
  }

  @override
  String get dashboardHelpText =>
      'We help you keep records of your group efficiently.';

  @override
  String get groupServices => 'Group Services';

  @override
  String get startMeeting => 'Start Meeting';

  @override
  String get continueExistingMeeting => 'Continue existing meeting';

  @override
  String get openNewMeeting => 'Open new group meeting';

  @override
  String get group => 'GROUP';

  @override
  String get constitution => 'Constitution';

  @override
  String get shareCalculation => 'Share Calculation';

  @override
  String get systemFeedback => 'System Feedback';

  @override
  String get groupActivities => 'Group Activities';

  @override
  String get moreServices => 'More Services';

  @override
  String get history => 'History';

  @override
  String get viewGroupHistory => 'View group activity history';

  @override
  String get backupRestore => 'Backup and Restore';

  @override
  String get backupRestoreDesc => 'Backup and restore group records';

  @override
  String get chomokaPlusVersion => 'Chomoka Plus v2.0';

  @override
  String get finishShare => 'Finish Share';

  @override
  String get finishShareDesc =>
      'The last cycle is complete. Please finish the share.';

  @override
  String get ok => 'OK';

  @override
  String get meetingOptionsWelcome => 'Welcome to Another Meeting';

  @override
  String get midCycleInfo => 'This is mid-cycle info';

  @override
  String get openMeetingButton => 'OPEN MEETING';

  @override
  String get startNewCycleQuestion => 'Are you starting a new cycle?';

  @override
  String get pressYesToStartFirstMeeting =>
      'PRESS YES TO CONDUCT FIRST MEETING';

  @override
  String get pressNoForPastMeetings => 'PRESS NO TO RECORD PAST MEETINGS';

  @override
  String get getHelpTitle => 'Get Help';

  @override
  String get needHelpContact => 'Need help? Contact us via:';

  @override
  String get call => 'Call';

  @override
  String get whatsapp => 'WhatsApp';

  @override
  String get email => 'Email';

  @override
  String get faq => 'FAQs';

  @override
  String get close => 'Close';

  @override
  String get failedToOpenPhone => 'Failed to open phone.';

  @override
  String get failedToOpenWhatsApp => 'WhatsApp is not available on your phone.';

  @override
  String get failedToOpenWhatsAppGeneric => 'Failed to open WhatsApp.';

  @override
  String get failedToOpenEmail => 'Failed to open email.';

  @override
  String get constitutionAppTitle => 'Constitution Information';

  @override
  String get constitutionGroupType => 'Group Type';

  @override
  String get kayaCmg => 'Kaya CMG';

  @override
  String get kayaCmgHint =>
      'We use mandatory savings and voluntary savings for lending';

  @override
  String get vsla => 'VSLA';

  @override
  String get vslaHint => 'We use shares to save money and have 5 leaders';

  @override
  String get shareSubtitle => 'Shares';

  @override
  String get sharePrompt => 'What is the value of one share in Shillings?';

  @override
  String get shareValueLabel => 'Share Value';

  @override
  String get shareValueHint => 'Enter share value';

  @override
  String get shareValueRequired => 'Share value is required';

  @override
  String get invalidShareValue => 'Please enter a valid amount';

  @override
  String get groupLeadersSubtitle => 'Group Leaders';

  @override
  String get editButton => 'Edit';

  @override
  String get selectAllLeadersError => 'Please select all leaders';

  @override
  String positionLabel(Object position) {
    return '$position';
  }

  @override
  String selectPositionHint(Object position) {
    return 'Select $position';
  }

  @override
  String positionRequired(Object position) {
    return 'Please select $position';
  }

  @override
  String get jumlaYaHisa => 'Total Shares';

  @override
  String get mfukoWaJamiiSalio => 'Community Fund Balance';

  @override
  String get salioLililolalaSandukuni => 'Box Balance';

  @override
  String get failedToLoadSummaryData =>
      'Failed to load summary data. Please try again.';

  @override
  String get jumlaYa => 'Total of';

  @override
  String get wekaJumlaYa => 'Enter total of';

  @override
  String get tafadhaliJazaJumlaYa => 'Please fill in total of';

  @override
  String get tafadhaliIngizaNambariHalali => 'Please enter a valid number.';

  @override
  String get jumlaLazimaIweIsiyoHasi => 'Total must be non-negative.';

  @override
  String get loadingData => 'Loading data...';

  @override
  String get taarifaKatikatiYaMzunguko => 'Mid-Cycle Information';

  @override
  String get jumlaZaKikundi => 'Group Totals';

  @override
  String get chairperson => 'Chairperson';

  @override
  String get secretary => 'Secretary';

  @override
  String get treasurer => 'Treasurer';

  @override
  String get counter1 => 'Counter number 1';

  @override
  String get counter2 => 'Counter number 2';

  @override
  String get finesTitle => 'Constitution Information';

  @override
  String get finesSubtitle => 'Fines';

  @override
  String get finesEmptyAmountNote =>
      'Fines without an amount will not appear during the meeting';

  @override
  String get enterFineType => 'Enter type of fine';

  @override
  String get enterAmount => 'Enter amount';

  @override
  String get phoneUseInMeeting => 'Phone usage during the meeting';

  @override
  String get amountPlaceholder => 'amount';

  @override
  String get loanAmountTitle => 'Constitution Information';

  @override
  String get loanAmountSubtitle => 'How much a member can borrow';

  @override
  String get loanAmountVSLAPrompt =>
      'How many times can a member borrow based on their current shares?';

  @override
  String get loanAmountCMGPrompt =>
      'How many times can a member borrow based on their current savings?';

  @override
  String get loanAmountVSLAHint => 'Set according to their current shares';

  @override
  String get loanAmountCMGHint => 'Set according to their current savings';

  @override
  String get loanAmountRequired => 'Please enter a valid (numeric) value!';

  @override
  String get loanAmountInvalidNumber => 'Please enter a valid number!';

  @override
  String get loanAmountMustBePositive => 'The value must be greater than zero!';

  @override
  String loanAmountExample(String amount, String type, String multiplier) {
    return 'For example, a member can borrow  $amount if they have $type worth  10,000, which is $multiplier times their $type.';
  }

  @override
  String get interestDescription =>
      'Describe how service charges apply to your loans';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get selectFund => 'Select Fund';

  @override
  String get fundWithoutName => 'Fund Without Name';

  @override
  String get addAnotherFund => 'Add Another Fund';

  @override
  String get communityFundInfo => 'Community Fund Information';

  @override
  String get fundName => 'Fund Name';

  @override
  String get enterFundName => 'Enter Fund Name';

  @override
  String get fundNameRequired => 'Fund name is required!';

  @override
  String get contributionAmount => 'Contribution Amount';

  @override
  String get enterContributionAmount => 'Enter Contribution Amount';

  @override
  String get contributionAmountRequired => 'Contribution amount is required!';

  @override
  String get edit => 'Edit';

  @override
  String get withdrawalReasons => 'Withdrawal Reasons';

  @override
  String get noReasonsRecorded => 'No reasons recorded';

  @override
  String get equalAmount => 'Equal amount';

  @override
  String get anyAmount => 'Any amount';

  @override
  String get notWithdrawableMidCycle => 'Not withdrawable mid-cycle';

  @override
  String get withdrawByMemberName => 'Withdraw by member\'s name';

  @override
  String get withdrawAsGroup => 'Withdraw as a group';

  @override
  String get select => 'Select';

  @override
  String get education => 'Education';

  @override
  String get agriculture => 'Agriculture';

  @override
  String get communityProject => 'Community Project';

  @override
  String get cocoa => 'Cocoa';

  @override
  String get otherGoals => 'Other Goals';

  @override
  String get pleaseSelectContributionProcedure =>
      'Please select Contribution Procedure';

  @override
  String get pleaseSelectWithdrawalProcedure =>
      'Please select Withdrawal Procedures';

  @override
  String get dataUpdatedSuccessfully => 'Data successfully updated!';

  @override
  String get errorSavingDataGeneric =>
      'There was an error saving data. Please try again.';

  @override
  String get fundInformation => 'Fund Information';

  @override
  String get fundProcedures => 'Fund Procedures';

  @override
  String get pleaseEnterFundName => 'Please enter the Fund Name';

  @override
  String get fundGoals => 'Fund Goals';

  @override
  String get pleaseSelectFundGoal => 'Please select a Fund Goal';

  @override
  String get enterOtherGoals => 'Enter Other Goals';

  @override
  String get pleaseEnterOtherGoals => 'Please enter Other Goals';

  @override
  String get contributionProcedure => 'Contribution Procedure';

  @override
  String get pleaseEnterContributionAmount =>
      'Please enter Contribution Amount';

  @override
  String get loanable => 'Loanable';

  @override
  String get withdrawalProcedures => 'Withdrawal Procedures';

  @override
  String get fundProcedure => 'Fund Procedure';

  @override
  String get withdrawalProcedure => 'Withdrawal Procedure';

  @override
  String get notWithdrawableDuringCycle => 'Not withdrawable during the cycle';

  @override
  String get selectOption => 'Select';

  @override
  String get fundSummarySubtitle => 'Fund Summary';

  @override
  String get withdrawalType => 'Type of Contribution';

  @override
  String get deleteFundTitle => 'Delete Fund?';

  @override
  String get thisFund => 'This fund';

  @override
  String get deleteFundWarning => 'This action cannot be undone.';

  @override
  String setPasswordTitle(Object step) {
    return 'Set password for $step';
  }

  @override
  String get allPasswordsSetTitle => 'All Passwords Set';

  @override
  String get backupCompleted => 'Backup completed successfully!';

  @override
  String get uhifadhiKumbukumbu => 'Data Backup';

  @override
  String get tumaTaarifa => 'Send Information';

  @override
  String get chaguaMahaliNaHifadhi => 'Choose Location and Save';

  @override
  String get hifadhiNakala => 'Save Copy';

  @override
  String get hifadhiNakalaRafiki => 'Send Backup to a Friend';

  @override
  String get hifadhiNakalaRafikiDescription =>
      'Send a copy of Chomoka data to your friend for better security.';

  @override
  String get uhifadhiKumbukumbuDescription =>
      'Back up your Chomoka data to a ZIP file. You can restore this data anytime.';

  @override
  String get error => 'Error';

  @override
  String errorSharingBackup(Object error) {
    return 'Error sharing backup: $error';
  }

  @override
  String get uwekaji_taarifa_katikati_mzunguko => 'Mid-Cycle Information Entry';

  @override
  String get loading_group_data => 'Loading group data...';

  @override
  String get kikundi_mzunguko => 'What cycle is the group in?';

  @override
  String get taarifa_zimehifadhiwa => 'Data saved successfully!';

  @override
  String imeshindwa_kuhifadhi(Object error) {
    return 'Failed to save data: $error';
  }

  @override
  String get thibitisha_ingizo => 'Input validation failed.';

  @override
  String get namba_kikao => 'Session Number';

  @override
  String get ingiza_namba_kikao => 'Enter session number';

  @override
  String get namba_kikao_inahitajika => 'Session number is required';

  @override
  String get namba_kikao_halali => 'Please enter a valid session number';

  @override
  String get endelea => 'Continue';

  @override
  String get taarifa_kikao_kilichopita => 'Previous Session Information';

  @override
  String get hisa_wanachama => 'Members\' Shares';

  @override
  String get muhtasari_kikao => 'Session Summary';

  @override
  String get jumla_kikundi => 'Group Total';

  @override
  String get akiba_wanachama => 'Members\' Savings';

  @override
  String get akiba_binafsi => 'Personal Savings';

  @override
  String get wadaiwa_mikopo => 'Loan Debtors';

  @override
  String get mchango_haujalipwa => 'Unpaid Contributions';

  @override
  String get jumla_hisa => 'Total Shares';

  @override
  String get jumla_akiba => 'Total Savings';

  @override
  String get jumla_mikopo => 'Total Loans';

  @override
  String get jumla_riba => 'Total Interest';

  @override
  String get jumla_adhabu => 'Total Fines';

  @override
  String get jumla_mfuko_jamii => 'Total Community Fund';

  @override
  String get chaguaNjiaUhifadhi => 'Select Backup Method';

  @override
  String get taarifaZimehifadhiwa => 'Information saved successfully!';

  @override
  String get sawa => 'OK';

  @override
  String uhifadhiProgress(Object progress) {
    return 'Backup Progress: $progress%';
  }

  @override
  String get midCycleMeetingInfo => 'Mid-Cycle Meeting Info';

  @override
  String get groupTotals => 'Group Totals';

  @override
  String get groupTotalsSummary => 'Group Totals Summary';

  @override
  String get enterTotalShares => 'Enter total shares';

  @override
  String get pleaseEnterTotalShares => 'Please enter total shares';

  @override
  String get shareValue => 'Share Value:';

  @override
  String get enterShareValue => 'Enter share value';

  @override
  String get pleaseEnterShareValue => 'Please enter share value';

  @override
  String get enterTotalSavings => 'Enter total savings';

  @override
  String get pleaseEnterTotalSavings => 'Please enter total savings';

  @override
  String get enterCommunityFundBalance => 'Enter community fund balance';

  @override
  String get pleaseEnterCommunityFundBalance =>
      'Please enter community fund balance';

  @override
  String get pleaseEnterValidPositiveNumber =>
      'The value must be a positive number';

  @override
  String get memberShares => 'Member Shares';

  @override
  String get unpaidContributions => 'Unpaid Contributions';

  @override
  String get memberContributions => 'Member\'s Contributions';

  @override
  String get fineOwed => 'Fines Owed';

  @override
  String get enterFineOwed => 'Enter fines owed';

  @override
  String get pleaseEnterFineOwed => 'Please enter fines owed';

  @override
  String get communityFundOwed => 'Community Fund Owed';

  @override
  String get enterCommunityFundOwed => 'Enter community fund amount owed';

  @override
  String get pleaseEnterCommunityFundOwed =>
      'Please enter the community fund amount owed';

  @override
  String get loanInformation => 'Loan Information';

  @override
  String get memberLoanInfo => 'Member Loan Info';

  @override
  String get selectReason => 'Select Reason';

  @override
  String get reasonForLoan => 'Loan Reason';

  @override
  String get pleaseSelectReason => 'Please select a reason';

  @override
  String get houseRenovation => 'House Renovation';

  @override
  String get business => 'Business';

  @override
  String get enterOtherReason => 'Enter Other Reason';

  @override
  String get otherReason => 'Other Reason';

  @override
  String get pleaseEnterOtherReason => 'Please enter the other reason';

  @override
  String get loanAmount => 'Loan Amount';

  @override
  String get enterLoanAmount => 'Enter loan amount';

  @override
  String get pleaseEnterLoanAmount => 'Please enter the loan amount';

  @override
  String get pleaseEnterValidAmount => 'Please enter a valid amount';

  @override
  String get amountPaid => 'Amount Paid:';

  @override
  String get enterAmountPaid => 'Enter amount paid';

  @override
  String get pleaseEnterAmountPaid => 'Please enter amount paid';

  @override
  String get outstandingBalance => 'Outstanding Balance';

  @override
  String get calculatedAutomatically => 'Calculated automatically';

  @override
  String get pleaseEnterOutstandingAmount =>
      'Please enter the outstanding balance';

  @override
  String get loanMeeting => 'Loan Meeting';

  @override
  String get enterLoanMeeting => 'Enter loan meeting number';

  @override
  String get pleaseEnterLoanMeeting => 'Please enter loan meeting number';

  @override
  String get loanDuration => 'Loan Duration (Months)';

  @override
  String get enterLoanDuration => 'Enter duration in months';

  @override
  String get pleaseEnterLoanDuration => 'Please enter the loan duration';

  @override
  String get loading => 'Loading...';

  @override
  String get noMembersFound => 'No members found.';

  @override
  String get searchByNameOrPhone => 'Search by name or phone';

  @override
  String get memberList => 'Member List';

  @override
  String get validate => 'Validate';

  @override
  String get dataValidationFailed => 'Data validation failed.';

  @override
  String get shareInformation => 'Share Information';

  @override
  String get saveShares => 'Save Shares';

  @override
  String get shares => 'Shares';

  @override
  String get enterShares => 'Enter number of shares';

  @override
  String get loanSummary => 'Loan Summary';

  @override
  String get memberLoanSummary => 'Member Loan Summary';

  @override
  String get loanDetails => 'LOAN DETAILS';

  @override
  String get vslaMemberShares => 'Member Shares';

  @override
  String get vslaShareInformation => 'Share Information';

  @override
  String get vslaShareValue => 'Share Value';

  @override
  String get vslaTotalShares => 'Total Shares';

  @override
  String get vslaShareValuePerShare => 'Value per Share';

  @override
  String get vslaEnterShareCount => 'Enter number of shares';

  @override
  String get vslaShareCountRequired => 'Number of shares is required';

  @override
  String get vslaEnterValidShareCount =>
      'Please enter a valid number of shares';

  @override
  String get vslaSaveShares => 'Save Shares';

  @override
  String get vslaSharesSavedSuccessfully => 'Member shares saved successfully!';

  @override
  String vslaTotalSharesMustMatch(String total, String current) {
    return 'Total shares must be $total. Currently $current. Please adjust.';
  }

  @override
  String get vslaGroupTotals => 'Group Totals';

  @override
  String get vslaGroupTotalsSummary => 'Group Totals Summary';

  @override
  String get vslaCommunityFundBalance => 'Community Fund Balance';

  @override
  String get vslaBoxBalance => 'Box Balance';

  @override
  String get vslaCurrentLoanBalance => 'Current Loan Balance';

  @override
  String get vslaMembers => 'Members';

  @override
  String get vslaUnpaidContributions => 'Unpaid Contributions';

  @override
  String get vslaTotalFinesOwed => 'Total Fines Owed';

  @override
  String get vslaEnterTotalShares => 'Enter Total Shares';

  @override
  String get vslaEnterCommunityFundBalance => 'Enter Community Fund Balance';

  @override
  String get vslaEnterBoxBalance => 'Enter Box Balance';

  @override
  String get vslaPleaseEnterTotalShares => 'Please enter total shares';

  @override
  String get vslaPleaseEnterCommunityFundBalance =>
      'Please enter community fund balance';

  @override
  String get vslaPleaseEnterBoxBalance => 'Please enter box balance';

  @override
  String get vslaPleaseEnterValidPositiveNumber =>
      'Value must be a positive number';

  @override
  String get vslaMidCycleInformation => 'Mid-Cycle Information';

  @override
  String get vslaMemberShareTitle => 'Member Shares';

  @override
  String get vslaMemberShareSubtitle => 'Enter member share information';

  @override
  String get vslaMemberNumber => 'Member Number';

  @override
  String get vslaShareCount => 'Share Count';

  @override
  String get vslaNoMembersFound => 'No members found';

  @override
  String get vslaErrorLoadingData => 'Error loading data. Please try again.';

  @override
  String vslaErrorSavingData(String error) {
    return 'Error saving data: $error';
  }

  @override
  String get uwekajiTaarifaKatikaMzunguko => 'Mid-Cycle Data Entry';

  @override
  String get jumlaYaKikundi => 'Group Total';

  @override
  String get hisaZaWanachama => 'Member Shares';

  @override
  String get taarifaZaKikundi => 'Group Information';

  @override
  String get jumlaYaTaarifaZaKikundi => 'Total Group Information';

  @override
  String get inapakiaTaarifa => 'Loading information...';

  @override
  String get hakunaTaarifaZilizopo => 'No data available at the moment.';

  @override
  String get taarifaZaHisa => 'Share Information';

  @override
  String get thamaniYaHisaMoja => 'Value per Share';

  @override
  String get wekaMfukoWaJamiiSalio => 'Set Community Fund Balance';

  @override
  String get tafadhaliJazaMfukoWaJamiiSalio =>
      'Please fill in the Community Fund Balance.';

  @override
  String get wekaSalioLililolalaSandukuni => 'Set Box Balance';

  @override
  String get tafadhaliJazaSalioLililolalaSandukuni =>
      'Please fill in the Box Balance.';

  @override
  String get salioLazimaIweIsiyoHasi => 'Balance must be non-negative.';

  @override
  String get jumlaYaThamaniYaHisa => 'Total Share Value';

  @override
  String get tafadhaliJazaJumlaYaHisa => 'Please fill in total shares.';

  @override
  String get salioLililolalaSandukuniError =>
      'Box Balance must be greater than the total of Shares and Community Fund.';

  @override
  String get jumlaYaHisaZote => 'Total Number of Shares';

  @override
  String get mchangoHaujalipwa => 'Unpaid Contribution';

  @override
  String get wadaiwaMikopo => 'Group Loan Debtors';

  @override
  String get muhtasari => 'Summary';

  @override
  String get pending => 'pending';

  @override
  String get uhifadhiKumbukumbuTitle => 'Data Backup';

  @override
  String get utunzajiKumbukumbuSmsTab => 'Backup via SMS';

  @override
  String get kanzidataUhifadhiTab => 'Database Backup';

  @override
  String get tumaTaarifaButton => 'Send Data';

  @override
  String get uhifadhiKumbukumbuCardTitle => 'Database Backup';

  @override
  String get uhifadhiKumbukumbuCardDesc =>
      'Save a backup copy of your Chomoka data to a SQL file. You can restore this data anytime.';

  @override
  String get chaguaMahaliNaHifadhiButton => 'Choose Location and Save';

  @override
  String sqlDumpSaved(String filePath) {
    return 'SQL dump saved at: $filePath';
  }

  @override
  String errorWithMessage(String message) {
    return 'Error: $message';
  }

  @override
  String get hifadhiNakalaRafikiCardTitle => 'Share Data with a Friend';

  @override
  String get hifadhiNakalaRafikiCardDesc =>
      'Securely send a copy of your Chomoka data to your friend.';

  @override
  String get hifadhiNakalaButton => 'Share Data';

  @override
  String get loanInterest => 'Loan interest:';

  @override
  String get interestType => 'Interest Type';

  @override
  String get monthlyCalculation => 'Monthly calculation';

  @override
  String get equalAmountAllMonths => 'Equal amount all months';

  @override
  String get enterInterestRate => 'Enter interest rate';

  @override
  String loanInterestExample(Object rate) {
    return 'For example, if a member borrows 10,000 they will pay $rate% of the remaining loan balance every month. If they repay the loan early, they will avoid paying interest.';
  }

  @override
  String loanInterestExampleEqual(Object amount, Object rate) {
    return 'For example, if a member borrows 10,000 they will pay $amount% of the actual loan amount. They will pay $rate every month.';
  }

  @override
  String loanInterestExampleOnce(Object amount, Object rate) {
    return 'For example, if a member borrows 10,000 they will repay with an interest of $amount% of the actual loan amount. They will pay $rate as interest when repaying the loan.';
  }

  @override
  String get constitutionTitle => 'Constitution';

  @override
  String get membershipRules => 'Membership Rules';

  @override
  String get method => 'Method:';

  @override
  String get savings => 'Savings';

  @override
  String get mandatorySavingsValue => 'Value of mandatory savings:';

  @override
  String get groupLeaders => 'Group Leaders';

  @override
  String get cashCounter1 => 'Cash Counter No. 1:';

  @override
  String get cashCounter2 => 'Cash Counter No. 2:';

  @override
  String get auditor => 'Auditor:';

  @override
  String get contributions => 'Contributions';

  @override
  String get communityFundAmount => 'Community Fund Amount:';

  @override
  String get otherFunds => 'Other Funds';

  @override
  String get noFines => 'No fines recorded for this member.';

  @override
  String get loan => 'Loan';

  @override
  String get loanMultiplier =>
      'A member is allowed to borrow how many times their shares:';

  @override
  String get loanInterestType => 'Loan interest calculation:';

  @override
  String get guarantorCount => 'Number of guarantors';

  @override
  String get penaltyCalculation => 'Penalty calculation for late loan:';

  @override
  String get lateLoanPenalty => 'Late loan penalty:';

  @override
  String get fundInfoTitle => 'Fund Information';

  @override
  String get illness => 'Illness';

  @override
  String get death => 'Death';

  @override
  String get addNewReason => 'Add New Reason';

  @override
  String get reasonsWithoutAmountWarning =>
      'Reasons without amount will not appear during the meeting';

  @override
  String get reason => 'Reason';

  @override
  String get enterReason => 'Enter Reason';

  @override
  String get reasonsForGiving => 'Reasons for Giving';

  @override
  String get reasonsForGivingInFund =>
      'Reasons for giving in the community fund';

  @override
  String get addNewReasonToReceiveMoney => 'Add new reason to receive money';

  @override
  String get loadingGroupData => 'Loading group data...';

  @override
  String get kikundiKipoMzunguko => 'Which cycle is the group in?';

  @override
  String mzunguko(Object mzungukoId) {
    return 'Cycle $mzungukoId';
  }

  @override
  String get invalidGroupDataReceived => 'Invalid group data received';

  @override
  String get historia => 'History';

  @override
  String historiaYa(String name) {
    return 'History of $name';
  }

  @override
  String get hakuna_vikao => 'No completed meetings in this cycle!';

  @override
  String get tafutaJinaSimu => 'Search by name or phone number';

  @override
  String get hakunaWanachama => 'No members found.';

  @override
  String get muhtasariKikao => 'Meeting Summary';

  @override
  String get funga => 'Close';

  @override
  String get tumaMuhtasari => 'Send Summary';

  @override
  String get mwanachamaSiSimu => 'Member does not have a phone number';

  @override
  String muhtasariUmetumwa(String name) {
    return 'Summary sent to $name successfully';
  }

  @override
  String get imeshindwaTumaSMS => 'Failed to send SMS, please try again';

  @override
  String get kikao => 'Meeting';

  @override
  String kikao_ya(String name) {
    return 'Meeting of $name';
  }

  @override
  String get mipangilio => 'Settings';

  @override
  String get badiliLugha => 'Change Language';

  @override
  String get chaguaLughaYaProgramu => 'Choose App Language';

  @override
  String get kiswahili => 'Swahili';

  @override
  String get english => 'English';

  @override
  String get french => 'French';

  @override
  String get rekebishaFunguo => 'Adjust keys';

  @override
  String get badilishaNenoLaSiri => 'Change password';

  @override
  String get kifo => 'Death';

  @override
  String get futazoteZaMzungukoHuuKishaAnzaMzungukoMpya =>
      'Delete all records of this cycle and start a new one';

  @override
  String get rekebishaMzunguko => 'Edit cycle';

  @override
  String get thibitisha => 'Confirm';

  @override
  String get jeUnaHitajiKufutaTaarifaZoteNaKuanzaMzungukoMpya =>
      'Do you want to delete all records and start a new cycle?';

  @override
  String get ndio => 'Yes';

  @override
  String imeshindwaKuHifadhi(String error) {
    return 'Failed to save information: $error';
  }

  @override
  String get hapana => 'No';

  @override
  String get kuhusuChomoka => 'About Chomoka';

  @override
  String get toleoLaChapa100 => 'Version 1.0.0';

  @override
  String get toleo4684 => 'Version 4684';

  @override
  String get mkataba => 'Contract';

  @override
  String get vigezoNaMasharti => 'Terms and Conditions';

  @override
  String get somaVigezoNaMashartiYaChomoka =>
      'Read Chomoka terms and conditions';

  @override
  String get msaadaWaKitaalamu => 'Technical Support';

  @override
  String get chomokaItajaribuKutumaBaadhiYaIliKikundiKipateMsaadaZaidiWaKitalaamu =>
      'Chomoka will try to send some data so that the group can receive more technical support';

  @override
  String get vslaPreviousMeetingSummary => 'Meeting Summary';

  @override
  String get nimemaliza => 'Submit';

  @override
  String get idleBalanceInBox => 'Idle Balance in the Box';

  @override
  String get currentLoanBalance => 'Current Loan Balance';

  @override
  String get remainingCommunityContribution =>
      'Remaining Contribution to the Community Fund';

  @override
  String get totalOutstandingFines => 'Total Outstanding Fines';

  @override
  String get kikundi => 'Group';

  @override
  String get nunuaHisa => 'Buy Shares';

  @override
  String get sasaUtaanzaMchakatoWaKununuaHisaKwaKilaMwanachama =>
      'Start the process of buying shares for each member';

  @override
  String get anzaSasa => 'START NOW';

  @override
  String get rudiNymba => 'GO BACK';

  @override
  String get hisa => 'Shares';

  @override
  String get hesabuYaHisa => 'Share Account';

  @override
  String get jumlaYaAkiba => 'Total Shares';

  @override
  String get hisaAlizonunuaLeo => 'Shares to Buy';

  @override
  String get chaguaIdadiYaHisaZaKununua => 'Select number of shares to buy';

  @override
  String get chaguaZote => 'Select All';

  @override
  String get ruka => 'Skip';

  @override
  String get hisaZilizochaguliwa => 'Shares Selected';

  @override
  String get badilishaHisa => 'Edit Shares';

  @override
  String get ongezaHisa => 'Add Shares';

  @override
  String get ongezaHisaZaidiKwaMwanachama => 'Add more shares for each member';

  @override
  String get punguzaHisa => 'Remove Shares';

  @override
  String get punguzaIdadiYaHisaZaMwanachama => 'Remove shares for each member';

  @override
  String get futaZote => 'Delete All';

  @override
  String get futaHisaZoteZaLeo => 'Delete all shares for this cycle';

  @override
  String get ongeza => 'Add';

  @override
  String get punguza => 'Remove';

  @override
  String get futa => 'Delete';

  @override
  String get ingizaIdadiYaHisaUnezotakaKununua =>
      'Enter the number of shares you want to add';

  @override
  String get ingizaIdadiYaHisaUnezotakaKupunguza =>
      'Enter the number of shares you want to remove';

  @override
  String get ghairi => 'Cancel';

  @override
  String get idadiYaHisa => 'Number of Shares';

  @override
  String get tafadhaliIngizaNambaSahihi => 'Please enter a valid number';

  @override
  String get muhtasariWaHisa => 'Share Summary';

  @override
  String get jumlaYaFedha => 'Total Amount';

  @override
  String contributeToFund(String fundName) {
    return 'Contribute to $fundName';
  }

  @override
  String get amountToContribute => 'Amount to contribute';

  @override
  String get totalCollected => 'Total collected';

  @override
  String shareNote(Object amount) {
    return 'Note: A member can buy one share worth  $amount per meeting';
  }

  @override
  String get help => 'Help';

  @override
  String get welcome => 'Welcome';

  @override
  String get helpDescription =>
      'We help you keep records of your group efficiently';

  @override
  String get continueMeeting => 'Continue Meeting';

  @override
  String get wanachama => 'Members';

  @override
  String get fund => 'Group Distribution';

  @override
  String get feedback => 'Feedback';

  @override
  String get groupsActivities => 'Group Activities';

  @override
  String get historyDescription => 'View the history of group activities';

  @override
  String get backupAndRestore => 'Backup and Restore';

  @override
  String get backupDescription => 'Backup and restore group records';

  @override
  String get serviceMore => 'More Services';

  @override
  String get historyHints => 'View the history of group activities';

  @override
  String get sendData => 'Backup and Restore';

  @override
  String get sendDataHint => 'Backup and restore group records';

  @override
  String get whatsappNotInstalled => 'WhatsApp is not installed on your phone';

  @override
  String get whatsappFailed => 'Failed to open WhatsApp';

  @override
  String get helpEmailSubject => 'Help - Chomoka Plus App';

  @override
  String get welcomeNextMeeting => 'Welcome to the Next Meeting';

  @override
  String get midCycleReport => 'Mid-Cycle Report';

  @override
  String get tapToOpenMeeting => 'Tap the button below to open the meeting';

  @override
  String get tapYesToStartFirstMeeting => 'TAP YES TO START THE FIRST MEETING';

  @override
  String get openMeeting => 'OPEN MEETING';

  @override
  String get tapNoToEnterPastMeetings =>
      'TAP NO TO ENTER DATA FOR PREVIOUS MEETINGS';

  @override
  String meetingTitle(Object meetingNumber) {
    return 'Meeting No. $meetingNumber';
  }

  @override
  String get groupAttendance => 'Check Attendance';

  @override
  String get contributeMfukoJamii => 'Contribute to Community Fund';

  @override
  String get buyShares => 'Buy Shares';

  @override
  String contributeOtherFund(Object mfukoName) {
    return 'Contribute to $mfukoName';
  }

  @override
  String get repayLoan => 'Repay Loan';

  @override
  String get payFine => 'Pay Fine';

  @override
  String get withdrawFromMfukoJamii => 'Withdraw from Social Fund';

  @override
  String get giveLoan => 'Disburse Loan';

  @override
  String get markCompleted => 'completed';

  @override
  String get markPending => 'pending';

  @override
  String get menuBulkSaving => 'Bulk Saving';

  @override
  String get menuExpense => 'Enter Expense Details';

  @override
  String get menuLogout => 'Logout';

  @override
  String get snackbarLoggedOut => 'Logged out';

  @override
  String get attendance => 'Attendance';

  @override
  String get attendanceSummary => 'Attendance Summary';

  @override
  String get totalMembers => 'Total Members';

  @override
  String get present => 'Present';

  @override
  String get onTime => 'On Time';

  @override
  String get lates => 'Late';

  @override
  String get sentRepresentative => 'Sent Representative';

  @override
  String get absent => 'Absent';

  @override
  String get withPermission => 'With Permission';

  @override
  String get withoutPermission => 'Without Permission';

  @override
  String get reasonForAbsence => 'Reason for Absence';

  @override
  String get amountToPaid => 'Amount the member should pay:';

  @override
  String get whatWasCollected => 'What was collected:';

  @override
  String get hasPaid => 'Has Paid';

  @override
  String get hasNotPaid => 'Has Not Paid';

  @override
  String get compulsorySavingsTitle => 'Compulsory Savings Information';

  @override
  String get compulsorySavingsSubtitle => 'Member Contributions';

  @override
  String get loadingMessage => 'Loading information...';

  @override
  String get doneButton => 'Done';

  @override
  String get noCompulsorySavings =>
      'No compulsory savings amount owed by the member';

  @override
  String get phone => 'Phone';

  @override
  String get dueMeeting => 'Due for meeting';

  @override
  String owedAmount(Object amount) {
    return 'Compulsory savings owed:  $amount';
  }

  @override
  String get pay => 'Pay';

  @override
  String get alreadyPaid => 'Already Paid';

  @override
  String get socialFundTitle => 'Social Fund Information';

  @override
  String socialFundDueAmount(Object amount) {
    return 'Amount Due for Social Fund:  $amount';
  }

  @override
  String get contributionSummary => 'Contribution Summary';

  @override
  String memberName(Object name) {
    return 'Member: $name';
  }

  @override
  String get paid => 'Paid';

  @override
  String get unpaid => 'Unpaid';

  @override
  String get noSocialFundDue => 'No social fund amount is owed by the member';

  @override
  String get totalLoan => 'Total Loan';

  @override
  String get noUnpaidMemberJamii =>
      'No Member Has Outstanding Social Fund Contributions';

  @override
  String get unpaidContributionsTitle => 'Unpaid Contributions';

  @override
  String get unpaidContributionsSubtitle => 'Social Fund Contributions';

  @override
  String get loanDebtorsTitle => 'Loan Debtors';

  @override
  String get loanSummaryTitle => 'Loan Summary';

  @override
  String get loanIssuedAmount => 'Total Loans Issued:';

  @override
  String get loanRepaidAmount => 'Total Loans Repaid:';

  @override
  String get loanRemainingAmount => 'Remaining Loan Balance:';

  @override
  String get noUnpaidLoans => 'No members with unpaid loans.';

  @override
  String get loanDebtors => 'Loan Debtors';

  @override
  String get memberLabel => 'Member:';

  @override
  String get unpaidLoanAmount => 'Unpaid \nloan amount';

  @override
  String get loanDetailsTitle => 'Loan Details';

  @override
  String get makePayment => 'Make Payment';

  @override
  String remainingAmount(Object amount) {
    return 'Remaining Amount:  $amount';
  }

  @override
  String get choosePaymentType => 'Choose Payment Type:';

  @override
  String get payAll => 'Pay All';

  @override
  String get reduceLoan => 'Reduce Loan';

  @override
  String get enterPaymentAmount => 'Enter Payment Amount';

  @override
  String get payLoan => 'Pay Loan';

  @override
  String get member => 'MEMBER';

  @override
  String get loanTaken => 'Loan Amount Taken:';

  @override
  String get loanToPay => 'Amount to Repay:';

  @override
  String get loanRemaining => 'Remaining Loan Amount:';

  @override
  String get paymentHistory => 'Payment History:';

  @override
  String get noPaymentsMade => 'No payments made yet.';

  @override
  String youPaid(Object amount) {
    return 'You Paid:  $amount';
  }

  @override
  String date(Object date) {
    return 'Date';
  }

  @override
  String get fainiPageTitle => 'Issue Fine';

  @override
  String get pageSubtitle => 'Select Fine';

  @override
  String get undefinedFine => 'Undefined fine';

  @override
  String priceLabel(Object price) {
    return 'Price: $price Tsh';
  }

  @override
  String get saveFine => 'Save Fine';

  @override
  String get payFineTitle => 'Pay Fine';

  @override
  String remainingFineAmount(Object amount) {
    return 'Remaining Amount:  $amount';
  }

  @override
  String get payAllFines => 'Pay All Fines';

  @override
  String get payCustomAmount => 'Pay Custom Amount';

  @override
  String get confirmFinePayment => 'Pay Fine';

  @override
  String get fineTitle => 'Member Fines';

  @override
  String get fineSubtitle => 'Pay Fine';

  @override
  String totalFines(Object amount) {
    return 'Total Fines Due:  $amount';
  }

  @override
  String paidFines(Object amount) {
    return 'Fines Paid:  $amount';
  }

  @override
  String remainingFines(Object amount) {
    return 'Remaining Amount:  $amount';
  }

  @override
  String get pigaFainiTitle => 'Issue Fine';

  @override
  String get pigaFainiSubtitle => 'Select Member';

  @override
  String get searchHint => 'Search by name or member number';

  @override
  String get fainiSummarySubtitle => 'Fine Summary';

  @override
  String get unknownName => 'No name';

  @override
  String get unknownPhone => 'Phone unknown';

  @override
  String get backToFines => 'Back to Fines';

  @override
  String get lipaFainiTitle => 'Pay Fine';

  @override
  String get totalFinesDue => 'Total Fines Due';

  @override
  String get totalFinesPaid => 'Total Fines Paid';

  @override
  String get noFineMembers => 'No members with fines.';

  @override
  String get unpaidFinesTitle => 'Unpaid Fines';

  @override
  String memberTotalFines(Object amount) {
    return 'Total Fines:  $amount';
  }

  @override
  String get navigationError =>
      'An error occurred while navigating. Please try again.';

  @override
  String get memberFinesTitle => 'Member Fines';

  @override
  String memberNameLabel(Object name) {
    return 'Member: $name';
  }

  @override
  String memberNumberLabel(Object number) {
    return 'Member Number: $number';
  }

  @override
  String totalFinesLabel(Object amount) {
    return 'Total Fines Owed:  $amount';
  }

  @override
  String totalPaidLabel(Object amount) {
    return 'Fines Paid:  $amount';
  }

  @override
  String totalUnpaidLabel(Object amount) {
    return 'Remaining Balance:  $amount';
  }

  @override
  String memberPhone(Object phone) {
    return 'Phone: $phone';
  }

  @override
  String fineTypes(Object fineName) {
    return 'Fine Type: $fineName';
  }

  @override
  String fineAmount(Object amount) {
    return 'Fine Amount: $amount ';
  }

  @override
  String meetingNumber(Object meeting, Object meetings) {
    return 'Meeting : $meeting';
  }

  @override
  String get toa_mfuko_jamii => 'Withdraw Social Fund';

  @override
  String get sababu_ya_kutoa_mfuko => 'Reason for Withdrawing Social Fund';

  @override
  String get hakuna_sababu => 'No reasons have been filled in yet.';

  @override
  String kiasi_cha_juu(Object amount) {
    return 'Maximum Withdrawal Amount:  $amount';
  }

  @override
  String get jina => 'Name:';

  @override
  String get jina_lisiloeleweka => 'Unknown Name';

  @override
  String get namba_haijapatikana => 'Number Not Found';

  @override
  String get chagua_sababu => 'Select Reason for Withdrawing Social Fund';

  @override
  String get tatizo_katika_kupakia => 'An error occurred, please try again.';

  @override
  String get chagua_kiwango_kutoa => 'Select Withdrawal Amount';

  @override
  String get namba_ya_mwanachama => 'Member Number:';

  @override
  String get sababu_ya_kutoa => 'Reason for withdrawing Social Fund:';

  @override
  String get kiwango_cha_juu => 'Maximum withdrawal amount:';

  @override
  String get salio_la_sasa => 'Current balance:';

  @override
  String get salio_la_kikao_kilichopita =>
      'Previous Meeting Social Fund Balance:';

  @override
  String get toa_kiasi_chote => 'Withdraw full amount';

  @override
  String get toa_kiasi_kingine => 'Withdraw another amount';

  @override
  String get ingiza_kiasi => 'Enter amount';

  @override
  String get thibitisha_utoaji_pesa => 'Confirm fund withdrawal';

  @override
  String get kiasi_cha_kutoa => 'Withdrawal amount:';

  @override
  String get salio_jipya => 'New balance:';

  @override
  String get toa_mkopo => 'Issue Loan';

  @override
  String get tahadhari => 'Warning!';

  @override
  String get hawezi_kukopa =>
      'A member cannot take another loan until they finish the current one.';

  @override
  String get sababu_ya_kutoa_mkopo => 'Reason for taking a loan';

  @override
  String weka_sababu(Object name) {
    return 'Enter the reason why member $name is taking this loan:';
  }

  @override
  String get kilimo => 'Agriculture';

  @override
  String get maboresho_nyumba => 'Home Improvement';

  @override
  String get elimu => 'Education';

  @override
  String get biashara => 'Business';

  @override
  String get sababu_nyingine => 'Other Reason';

  @override
  String get weka_sababu_nyingine => 'Enter Other Reason';

  @override
  String get thibitisha_sababu => 'Confirm Reason';

  @override
  String get tafadhali_weka_sababu_nyingine => 'Please enter another reason.';

  @override
  String get jumla_ya_akiba => 'Total Savings:';

  @override
  String get kiwango_cha_juu_mkopo => 'Maximum Loan Amount:';

  @override
  String get fedha_zilizopo_mkopo => 'Funds Available for Loan:';

  @override
  String chukua_mkopo_wote(Object amount) {
    return 'Take Full Loan  $amount';
  }

  @override
  String get kiasi_kingine => 'Other Amount';

  @override
  String get kiasi => 'Amount';

  @override
  String get weka_kiasi => 'Enter Amount';

  @override
  String get thibitisha_kiasi => 'Confirm Amount';

  @override
  String get tafadhali_chagua_chaguo => 'Please select a loan option.';

  @override
  String get kiasi_cha_mkopo_wa_mwanachama => 'Member\'s loan amount';

  @override
  String get tafadhali_ingiza_kiasi_sahihi => 'Please enter a valid amount.';

  @override
  String get hakuna_kiasi_cha_kutosha =>
      'Insufficient funds to issue this loan.';

  @override
  String get kiasi_hakiruhusiwi => 'The selected amount is not allowed.';

  @override
  String get kiasi_na_riba_vimehifadhiwa =>
      'Loan amount and interest have been saved.';

  @override
  String get hitilafu_imetokea => 'An error occurred. Please try again.';

  @override
  String get muda_wa_marejesho => 'Repayment Duration';

  @override
  String kiasi_cha_mkopo_wake_ni(Object amount) {
    return 'His Loan Amount Is:\n $amount';
  }

  @override
  String get mkopo_wa_miezi_mingapi => 'Loan duration in months?';

  @override
  String get mwezi_1 => '1 Month';

  @override
  String get miezi_2 => '2 Months';

  @override
  String get miezi_3 => '3 Months';

  @override
  String get miezi_6 => '6 Months';

  @override
  String get nyingine => 'Other';

  @override
  String get ingiza_miezi => 'Enter Months';

  @override
  String get thibitisha_muda => 'Confirm Duration';

  @override
  String get tafadhali_chagua_muda => 'Please select a repayment period.';

  @override
  String get tafadhali_ingiza_muda_sahihi => 'Please enter a valid duration.';

  @override
  String muda_wa_marejesho_umehifadhiwa(Object months) {
    return 'Repayment time saved: $months months';
  }

  @override
  String get wadhamini => 'Guarantors';

  @override
  String jinas(Object name) {
    return 'Name: $name';
  }

  @override
  String chagua_wadhamini(Object count) {
    return 'Select $count Guarantors:';
  }

  @override
  String get haidhibiti_idadi => 'Please select all required guarantors.';

  @override
  String get haijulikani => 'Unknown';

  @override
  String get muhtasari_wa_mkopo => 'Loan Summary';

  @override
  String get thibitisha_mkopo => 'Confirm Loan';

  @override
  String get maelezo_ya_mkopo => 'Loan Details';

  @override
  String get kiasi_cha_mkopo => 'Loan Amount';

  @override
  String get riba_ya_mkopo => 'Loan Interest';

  @override
  String get maelezo_ya_riba => 'Interest \nDetails';

  @override
  String get salio_la_mkopo => 'Loan Balance';

  @override
  String get tarehe_ya_mwisho => 'Due Date';

  @override
  String miezi(Object miezi) {
    return 'Months $miezi';
  }

  @override
  String get oneTimeInterest => 'Interest is paid only once';

  @override
  String guarantorExample(int count, String amount) {
    return 'For example, if Pili cannot pay her loan debt of  150,000 at the time of sharing, the savings of the $count members who guaranteed her loan will each be reduced by  $amount.';
  }

  @override
  String get communityFundTitle => 'Community Fund';

  @override
  String get unpaidContribution => 'Unpaid contribution';

  @override
  String get expense => 'Expense';

  @override
  String get chooseUsageType => 'Choose usage type';

  @override
  String usageType(Object type) {
    return '$type';
  }

  @override
  String get matumziStationery => 'Stationery';

  @override
  String get matumziRefreshment => 'Refreshment';

  @override
  String get matumziLoanPayment => 'Loan Payment';

  @override
  String get matumziCallTime => 'Call Time (Vocha)';

  @override
  String get matumziTechnology => 'Technology';

  @override
  String get matumiziMerchandise => 'Business Merchandise';

  @override
  String get matumziTransport => 'Transport';

  @override
  String get matumiziBackCharges => 'Bank Charges';

  @override
  String get matumziOther => 'Other';

  @override
  String get specificUsage => 'Specific Usage';

  @override
  String get enterSpecificUsage => 'Enter specific usage';

  @override
  String get pleaseEnterSpecificUsage => 'Please enter specific usage.';

  @override
  String get pleaseEnterAmount => 'Please enter an amount';

  @override
  String get next => 'Next';

  @override
  String get expenseSummary => 'Expense Summary';

  @override
  String get totalAmountSpent => 'Total Amount Spent';

  @override
  String get totalExpenses => 'Other Group Expenses';

  @override
  String get noExpensesRecorded => 'No expenses recorded.';

  @override
  String expenseLabel(Object label) {
    return 'Expense: $label';
  }

  @override
  String get unknown => 'Unknown';

  @override
  String expenseType(Object type) {
    return 'Type: $type';
  }

  @override
  String amountLabel(Object amount) {
    return 'Amount:  $amount';
  }

  @override
  String fundLabel(Object fund) {
    return 'Fund: $fund';
  }

  @override
  String get done => 'Done';

  @override
  String get confirmExpense => 'Confirm Expense';

  @override
  String get expenseFund => 'Expense Fund';

  @override
  String get expenseTypeLabel => 'Expense Type';

  @override
  String get chooseFund => 'Choose Fund';

  @override
  String get chooseFundToContribute => 'Choose fund to contribute';

  @override
  String get mainGroupFund => 'Main Group Fund';

  @override
  String get socialFund => 'Social Fund';

  @override
  String get pleaseChooseFund => 'Please choose a fund.';

  @override
  String get bulkSaving => 'Bulk Saving';

  @override
  String get chooseContributionType => 'Choose Contribution Type';

  @override
  String get donationContribution => 'Donation Contribution';

  @override
  String get businessProfit => 'Business Profit';

  @override
  String get loanDisbursement => 'Loan Disbursement';

  @override
  String enterAmountFor(Object type) {
    return 'Enter amount for $type:';
  }

  @override
  String get totalContributionsForCycle => 'Total contributions for this cycle';

  @override
  String get contributionsList => 'Contributions List';

  @override
  String get noContributionsCompleted => 'No contributions completed.';

  @override
  String get noFund => 'No Fund';

  @override
  String contributionType(Object type) {
    return 'Type: $type';
  }

  @override
  String get confirmContribution => 'Confirm Contribution';

  @override
  String get fundBalance => 'Fund Balance';

  @override
  String get currentContribution => 'Current Contribution';

  @override
  String get newFundBalance => 'New Fund Balance';

  @override
  String meetingSummaryTitle(Object meetingNumber) {
    return 'Meeting Summary $meetingNumber';
  }

  @override
  String get sharePurchaseSection => 'Share Purchase';

  @override
  String get totalSharesDeposited => 'Total Shares Deposited';

  @override
  String get totalShareValue => 'Total Value of Shares';

  @override
  String get amountDeposited => 'Amount Deposited';

  @override
  String get amountWithdrawn => 'Amount Withdrawn';

  @override
  String get loansSection => 'Loans';

  @override
  String get loansIssued => 'Loans Issued';

  @override
  String get loanAmountRepaid => 'Loan Amount Repaid';

  @override
  String get loanAmountOutstanding => 'Loan Amount Outstanding';

  @override
  String get finesSection => 'Fines';

  @override
  String get totalBulkSaving => 'Total Bulk Saving';

  @override
  String get expensesSection => 'Expenses';

  @override
  String get loadingAttendanceSummary => 'Loading attendance summary...';

  @override
  String get presentMembers => 'Present Members';

  @override
  String get earlyMembers => 'Early';

  @override
  String get lateMembers => 'Late';

  @override
  String get representative => 'Representative';

  @override
  String get absentMembers => 'Absent Members';

  @override
  String get closeMeeting => 'Close Meeting';

  @override
  String get sendSmsTitle => 'Send SMS';

  @override
  String get sendSmsSubtitle => 'Send SMS to Members';

  @override
  String get chooseSmsSendType => 'Choose how to send SMS';

  @override
  String get sendToAll => 'Send to All';

  @override
  String get chooseMembers => 'Choose Members';

  @override
  String get selected => 'Selected';

  @override
  String get sendSms => 'Send SMS';

  @override
  String sendSmsWithCount(Object count) {
    return 'Send SMS ($count)';
  }

  @override
  String get selectMembersToSendSms => 'Please select members to send SMS to';

  @override
  String get noMembersToSendSms => 'No members to send SMS to';

  @override
  String smsGreeting(Object name) {
    return 'Dear $name,';
  }

  @override
  String get smsSummaryHeader => 'Meeting summary:';

  @override
  String smsTotalShares(Object shares, Object value) {
    return 'Total Shares: $shares ( $value)';
  }

  @override
  String smsSocialFund(Object amount) {
    return 'Social Fund:  $amount';
  }

  @override
  String smsCurrentLoan(Object amount) {
    return 'Current Loan:  $amount';
  }

  @override
  String smsFine(Object amount) {
    return 'Fine:  $amount';
  }

  @override
  String get failedToCloseMeeting => 'Failed to close meeting';

  @override
  String get meetingNotFound => 'Meeting not found';

  @override
  String failedToCloseMeetingWithError(Object error) {
    return 'Failed to close meeting: $error';
  }

  @override
  String get agentPreparedAndOnTime =>
      'Did the agent prepare well and arrive on time?';

  @override
  String get agentExplainedChomoka =>
      'Did the agent explain how to use the Chomoka system?';

  @override
  String get pleaseAnswerThisQuestion => 'Please answer this question.';

  @override
  String get agentExplainedCosts =>
      'Did the agent clearly and transparently explain the costs?';

  @override
  String get agentRating => 'How would you rate the Chomoka agent?';

  @override
  String get agentRatingLevel1 => '1. Poor';

  @override
  String get agentRatingLevel2 => '2. Fair';

  @override
  String get agentRatingLevel3 => '3. Good';

  @override
  String get agentRatingLevel4 => '4. Very Good';

  @override
  String get agentRatingLevel5 => '5. Excellent';

  @override
  String get pleaseChooseRating => 'Please choose a rating.';

  @override
  String get unansweredQuestion =>
      'Do you have any question the agent did not answer or you were not satisfied with?';

  @override
  String get question => 'Question';

  @override
  String get pleaseWriteQuestion => 'Please write your question.';

  @override
  String get suggestionForChomoka =>
      'What changes do you suggest for the Chomoka system?';

  @override
  String get suggestion => 'Suggestion';

  @override
  String get pleaseWriteSuggestion => 'Please write your suggestion.';

  @override
  String get noMeeting => 'No Meeting';

  @override
  String get noMeetingDesc =>
      'No meeting has been held in this cycle, please hold a meeting to continue with the shareout.';

  @override
  String get meetingInProgress => 'Meeting In Progress';

  @override
  String get meetingInProgressDesc =>
      'Please finish the meeting to continue with the shareout.';

  @override
  String get shareout => 'Shareout';

  @override
  String get chooseShareoutType => 'Choose Shareout Type';

  @override
  String get groupShareout => 'Group Shareout';

  @override
  String get groupShareoutDesc =>
      'We have completed our cycle and want to do a shareout. We want to review our group participation status.';

  @override
  String get memberShareout => 'Member Shareout';

  @override
  String get memberShareoutDesc =>
      'We want to completely remove a member from our group and the member cannot attend any more meetings. We want to review the member\'s participation status.';

  @override
  String get returnToHome => 'Return to Home';

  @override
  String get summary => 'Summary';

  @override
  String get chooseMember => 'Choose Member';

  @override
  String phoneNumberLabel(Object phone) {
    return 'Phone: $phone';
  }

  @override
  String get totalMandatorySavings => 'Total mandatory savings';

  @override
  String get totalVoluntarySavings => 'Total voluntary savings';

  @override
  String get unpaidFineAmount => 'Unpaid \nfine amount';

  @override
  String get memberOwesAmount => 'Member owes \nan amount of';

  @override
  String get totalShareoutAmount => 'Total shareout amount';

  @override
  String get confirmShareout => 'Confirm Shareout';

  @override
  String get mandatorySavingsToBeWithdrawn =>
      'Mandatory savings to be withdrawn';

  @override
  String get voluntarySavingsToBeWithdrawn =>
      'Voluntary savings to be withdrawn';

  @override
  String get memberMustPayAmount => 'Member must \npay an amount';

  @override
  String get cashPayment => 'Cash Payment';

  @override
  String get noPaymentToMember => 'Member will not \nreceive any payment';

  @override
  String get totalSharesCount => 'Total share count';

  @override
  String get totalSharesValue => 'Total share value';

  @override
  String get enterKeysToContinue => 'Enter keys to continue';

  @override
  String get smsSummaryTitle => 'Send summary via SMS';

  @override
  String get smsYes => 'Yes';

  @override
  String get smsNo => 'No';

  @override
  String get groupShareTitle => 'Group Share';

  @override
  String get noMembersInGroup => 'There are no members in this group.';

  @override
  String get selectMember => 'Select member';

  @override
  String get totalFine => 'Total Collected Fines';

  @override
  String get totalSocialFund => 'Total Social Fund';

  @override
  String totalShareAmount(Object percentage, Object shares) {
    return 'Shares: $shares ($percentage%)';
  }

  @override
  String get unpaidLoanMsg =>
      'There are unpaid loan payments. Please pay all loans before continuing.';

  @override
  String get unpaidFineMsg =>
      'There are unpaid fines. Please pay all fines before continuing.';

  @override
  String get unpaidSocialFundMsg =>
      'There are unpaid social fund payments. Please pay all payments before continuing.';

  @override
  String get unpaidCompulsorySavingsMsg =>
      'There are unpaid compulsory savings. Please pay all payments before continuing.';

  @override
  String get warning => 'Warning';

  @override
  String get profit => 'Profit';

  @override
  String get totalExtraCollected => 'Total Extra Collected';

  @override
  String totalUnpaidAmount(Object amount) {
    return 'Total unpaid amount:  $amount';
  }

  @override
  String get totalWithdrawnFromSocialFund => 'Total Withdrawn from Social Fund';

  @override
  String get totalFunds => 'Total Funds';

  @override
  String get expenses => 'Expenses';

  @override
  String get otherGroupExpenses => 'Other Group Expenses';

  @override
  String get amountRemaining => 'Amount Remaining';

  @override
  String get socialFundCarriedForward =>
      'Social Fund Carried Forward to Next Cycle';

  @override
  String get totalShareFunds => 'Total Share Funds';

  @override
  String get amountNextCycleSubtitle => 'Amount carried to next cycle';

  @override
  String get sendToNextCycle => 'Send to next cycle';

  @override
  String get enterAmountNextCycle =>
      'Enter the amount you want to carry to the next cycle for each fund';

  @override
  String availableAmount(Object amount) {
    return 'Available  $amount';
  }

  @override
  String amountMustBeLessThanOrEqual(Object amount) {
    return 'Amount must be less than or equal to $amount';
  }

  @override
  String get memberShareDistributionTitle => 'Member Share Distribution';

  @override
  String shareValueAmount(Object amount) {
    return 'Share value:  $amount';
  }

  @override
  String totalDistributionAmount(Object amount) {
    return 'Total Distribution:  $amount';
  }

  @override
  String get groupShareDistributionTitle => 'Group Share Distribution';

  @override
  String get noProfitEmoji => '😢';

  @override
  String get profitEmoji => '😊';

  @override
  String get noProfitMessage => 'Your group did not make any profit';

  @override
  String profitMessage(Object amount) {
    return 'Congratulations! Your group made  $amount as profit';
  }

  @override
  String get totalDistributionFunds => 'Total distribution funds';

  @override
  String amountTzs(Object amount) {
    return ' $amount';
  }

  @override
  String get nextCycleSocialFund => 'Social fund amount carried to next cycle';

  @override
  String get nextCycleMemberSavings =>
      'Total member savings carried to next cycle';

  @override
  String get finishCycle => 'Finish Cycle';

  @override
  String get memberShareSummaryTitle => 'Member Share Summary';

  @override
  String get memberShareSummarySubtitle => 'Share Distribution Summary';

  @override
  String get giveToNextCycle => 'Send to next cycle';

  @override
  String get shareInfoSection => 'Share Information';

  @override
  String get numberOfShares => 'Number of Shares:';

  @override
  String get sharePercentage => 'Share Percentage:';

  @override
  String get profitInfoSection => 'Profit Information';

  @override
  String get profitShare => 'Profit Share (based on shares):';

  @override
  String get socialFundShare => 'Social Fund Share:';

  @override
  String get distributionSummarySection => 'Distribution Summary';

  @override
  String get summaryShareValue => 'Share Value:';

  @override
  String get summaryProfit => 'Profit:';

  @override
  String get summarySocialFund => 'Social Fund:';

  @override
  String get summaryTotalDistribution => 'Total Distribution:';

  @override
  String get paymentInfoSection => 'Payment Information';

  @override
  String get amountToNextCycle => 'Amount to next cycle:';

  @override
  String get paymentAmount => 'Payment Amount:';

  @override
  String get inputAmountForNextCycle => 'Enter amount for next cycle';

  @override
  String get confirmButton => 'Confirm';

  @override
  String get amountMustBeLessThanOrEqualTotal =>
      'The amount must be less than or equal to the total distribution.';

  @override
  String get successfullyPaid => 'Paid successfully';

  @override
  String get groupActivitiesTitle => 'Group Activities';

  @override
  String get groupBusiness => 'Group Business';

  @override
  String get otherActivities => 'Other Activities';

  @override
  String get training => 'Training';

  @override
  String get backToHome => 'Back to Home';

  @override
  String get addTrainingTitle => 'Add Training';

  @override
  String get editTrainingTitle => 'Edit Training';

  @override
  String get trainingType => 'Type of Training';

  @override
  String get enterTrainingType => 'Enter type of training';

  @override
  String get organization => 'Organization';

  @override
  String get enterOrganization => 'Enter organization name';

  @override
  String get chooseDate => 'Choose date';

  @override
  String get membersCount => 'Number of Members';

  @override
  String get enterMembersCount => 'Enter number of members';

  @override
  String get trainer => 'Trainer';

  @override
  String get enterTrainer => 'Enter trainer\'s name';

  @override
  String get saveTraining => 'Save Training';

  @override
  String get saveChanges => 'Save Changes';

  @override
  String get trainingSaved => 'Training saved successfully';

  @override
  String get trainingUpdated => 'Training updated successfully';

  @override
  String get pleaseFillAllFields => 'Please fill all fields';

  @override
  String get pleaseEnterTrainingType => 'Please enter type of training';

  @override
  String get pleaseEnterOrganization => 'Please enter organization name';

  @override
  String get pleaseEnterMembersCount => 'Please enter number of members';

  @override
  String get pleaseEnterTrainer => 'Please enter trainer\'s name';

  @override
  String get trainingListTitle => 'Training List';

  @override
  String totalTrainings(Object count) {
    return 'Total trainings: $count';
  }

  @override
  String get noTrainingsSaved => 'No trainings saved';

  @override
  String get addNewTraining => 'Add Training';

  @override
  String get deleteTrainingTitle => 'Delete Training';

  @override
  String get deleteTrainingConfirm =>
      'Are you sure you want to delete this training?';

  @override
  String get trainingDeleted => 'Training deleted successfully';

  @override
  String get addOtherActivityTitle => 'Other Activities';

  @override
  String get editOtherActivityTitle => 'Edit Activity';

  @override
  String get activityDate => 'Date';

  @override
  String get chooseActivityDate => 'Choose date';

  @override
  String get activityName => 'Activity Performed';

  @override
  String get enterActivityName => 'Enter activity performed';

  @override
  String get beneficiariesCount => 'Number of Beneficiaries';

  @override
  String get enterBeneficiariesCount => 'Enter number of beneficiaries';

  @override
  String get enterLocation => 'Enter activity location';

  @override
  String get saveActivity => 'Save Activity';

  @override
  String get saveActivityChanges => 'Save Changes';

  @override
  String get activitySaved => 'Activity saved successfully';

  @override
  String get activityUpdated => 'Activity updated successfully';

  @override
  String get pleaseFillAllActivityFields => 'Please fill all fields';

  @override
  String get pleaseEnterActivityName => 'Please enter activity performed';

  @override
  String get pleaseEnterBeneficiariesCount =>
      'Please enter number of beneficiaries';

  @override
  String get pleaseEnterLocation => 'Please enter location';

  @override
  String get activityListTitle => 'Other Activities List';

  @override
  String totalActivities(Object count) {
    return 'Total activities: $count';
  }

  @override
  String get noActivitiesSaved => 'No activities saved';

  @override
  String get addNewActivity => 'Add Activity';

  @override
  String get editActivity => 'Edit';

  @override
  String get deleteActivity => 'Delete';

  @override
  String get deleteActivityTitle => 'Delete Activity';

  @override
  String get deleteActivityConfirm =>
      'Are you sure you want to delete this activity?';

  @override
  String get activityDeleted => 'Activity deleted successfully';

  @override
  String get orderListTitle => 'Input Requests';

  @override
  String get orderListSubtitle => 'Request List';

  @override
  String get orderListTotalRequests => 'Total Requests';

  @override
  String get orderListPending => 'Pending';

  @override
  String get orderListApproved => 'Approved';

  @override
  String get orderListRejected => 'Rejected';

  @override
  String orderListRequests(Object count) {
    return 'Requests $count';
  }

  @override
  String get orderListRefresh => 'Refresh';

  @override
  String get orderListNoRequests => 'No requests saved';

  @override
  String get orderListAddNewPrompt => 'Press the button to add a new request';

  @override
  String get orderListDone => 'Done';

  @override
  String get orderListUnknownInput => 'Input';

  @override
  String get orderListUnknownCompany => 'Unknown company';

  @override
  String get orderListStatusApproved => 'Approved';

  @override
  String get orderListStatusRejected => 'Rejected';

  @override
  String get orderListStatusPending => 'Pending';

  @override
  String orderListAmount(Object amount) {
    return 'Amount: $amount';
  }

  @override
  String get orderListUnknownAmount => 'Unknown';

  @override
  String get orderListUnknownDate => 'Unknown date';

  @override
  String get orderListPrice => 'Price';

  @override
  String get orderListUnknownPrice => 'Unknown';

  @override
  String get orderListFinish => 'Done';

  @override
  String get orderListShowAgain => 'Show again';

  @override
  String get requestSummaryTitle => 'Input Request Details';

  @override
  String get requestSummaryListTitle => 'Input Request List';

  @override
  String requestSummaryTotal(Object count) {
    return 'Total requests: $count';
  }

  @override
  String get requestSummaryStatus => 'Request Status';

  @override
  String get requestSummaryStatusApproved => 'Approved';

  @override
  String get requestSummaryStatusRejected => 'Rejected';

  @override
  String get requestSummaryStatusPending => 'Pending';

  @override
  String get requestSummaryStatusMessageApproved =>
      'Your input request has been approved. You may proceed with the purchase process.';

  @override
  String get requestSummaryStatusMessageRejected =>
      'Sorry, your input request was rejected. Please contact the administrator for more details.';

  @override
  String get requestSummaryStatusMessagePending =>
      'Your input request has been received and is pending approval. You will be notified once it is approved.';

  @override
  String get requestSummaryUserInfo => 'User Information';

  @override
  String get requestSummaryUserName => 'User Name';

  @override
  String get requestSummaryMemberNumber => 'Member Number';

  @override
  String get requestSummaryPhone => 'Phone Number';

  @override
  String get requestSummaryInputType => 'Input Type';

  @override
  String get requestSummaryAmount => 'Amount';

  @override
  String get requestSummaryRequestDate => 'Request Date';

  @override
  String get requestSummaryCompany => 'Company';

  @override
  String get requestSummaryPrice => 'Price';

  @override
  String get requestSummaryCost => 'Cost';

  @override
  String get requestSummaryUnknown => 'Unknown';

  @override
  String get requestSummaryBack => 'Back';

  @override
  String get requestSummaryEdit => 'Edit';

  @override
  String get requestSummaryAddRequest => 'Add Request';

  @override
  String get requestSummaryNoRequests => 'No requests saved';

  @override
  String get requestSummaryAddNewPrompt =>
      'Press the button to add a new request';

  @override
  String get requestInputTitle => 'Order Input';

  @override
  String get requestInputEditTitle => 'Edit Input Request';

  @override
  String get requestInputType => 'Input Type';

  @override
  String get requestInputTypeHint => 'Enter input type';

  @override
  String get requestInputTypeError => 'Please enter input type';

  @override
  String get requestInputCompany => 'Company';

  @override
  String get requestInputCompanyHint => 'Enter company name';

  @override
  String get requestInputCompanyError => 'Please enter company name';

  @override
  String get requestInputAmount => 'Amount';

  @override
  String get requestInputAmountHint => 'Enter amount';

  @override
  String get requestInputAmountError => 'Please enter amount';

  @override
  String get requestInputPrice => 'Price';

  @override
  String get requestInputPriceHint => 'Enter price';

  @override
  String get requestInputPriceError => 'Please enter price';

  @override
  String get requestInputDate => 'Date';

  @override
  String get requestInputDateHint => 'Select date';

  @override
  String get requestInputStatus => 'Request Status';

  @override
  String get requestInputStatusHint => 'Select request status';

  @override
  String get requestInputSubmit => 'Submit Request';

  @override
  String get requestInputSaveChanges => 'Save Changes';

  @override
  String get requestInputSuccess =>
      'Your request has been submitted successfully';

  @override
  String get requestInputUpdateSuccess => 'Request updated successfully';

  @override
  String requestInputError(Object error) {
    return 'Error: $error';
  }

  @override
  String get requestInputFillAll => 'Please fill all fields';

  @override
  String get businessDashboardTitle => 'Business Dashboard';

  @override
  String get businessDashboardDefaultTitle => 'Business Dashboard';

  @override
  String get businessDashboardLocationUnknown => 'No location';

  @override
  String get businessDashboardProductType => 'Product Type';

  @override
  String get businessDashboardProductTypeUnknown => 'No product';

  @override
  String get businessDashboardStartDate => 'Start Date';

  @override
  String get businessDashboardDateUnknown => 'No date';

  @override
  String get businessDashboardStats => 'Business Statistics';

  @override
  String get businessDashboardPurchases => 'Purchases';

  @override
  String get businessDashboardSales => 'Sales';

  @override
  String get businessDashboardExpenses => 'Expenses';

  @override
  String get businessDashboardProfit => 'Profit';

  @override
  String get businessDashboardActions => 'Actions';

  @override
  String get businessDashboardProfitShare => 'Profit Distribution';

  @override
  String get businessDashboardActive => 'Active';

  @override
  String get businessDashboardInactive => 'Inactive';

  @override
  String get businessDashboardPending => 'Pending';

  @override
  String get businessDashboardStatus => 'Status';

  @override
  String businessDashboardError(Object error) {
    return 'Error: $error';
  }

  @override
  String get businessListTitle => 'Business List';

  @override
  String businessListCount(Object count) {
    return 'Businesses $count';
  }

  @override
  String get businessListRefresh => 'Refresh';

  @override
  String get businessListNoBusinesses => 'No businesses registered';

  @override
  String get businessListAddPrompt => 'Tap the + button to add a business';

  @override
  String get businessListViewMore => 'View More';

  @override
  String get businessListLocationUnknown => 'No location';

  @override
  String get businessListProductTypeUnknown => 'No product';

  @override
  String get businessListStatusActive => 'Active';

  @override
  String get businessListStatusInactive => 'Inactive';

  @override
  String get businessListStatusPending => 'Pending';

  @override
  String get businessListDateUnknown => 'No date';

  @override
  String get businessInformationTitle => 'Business Information';

  @override
  String get businessInformationName => 'Business Name';

  @override
  String get businessInformationNameHint => 'Enter business name';

  @override
  String get businessInformationNameAbove => 'Business Name:';

  @override
  String get businessInformationNameError => 'Please enter business name';

  @override
  String get businessInformationLocation => 'Business Location';

  @override
  String get businessInformationLocationHint => 'Enter business location';

  @override
  String get businessInformationLocationAbove => 'Business Location:';

  @override
  String get businessInformationLocationError =>
      'Please enter business location';

  @override
  String get businessInformationStartDate => 'Business Start Date';

  @override
  String get businessInformationStartDateHint => 'Select date';

  @override
  String get businessInformationStartDateAbove => 'Business Start Date:';

  @override
  String get businessInformationProductTypeAbove => 'Product Type:';

  @override
  String get businessInformationProductType => 'Product Type';

  @override
  String get businessInformationProductTypeError =>
      'Please select product type';

  @override
  String get businessInformationOtherProductType => 'Specify Product Type';

  @override
  String get businessInformationOtherProductTypeHint => 'Enter product type';

  @override
  String get businessInformationOtherProductTypeAbove =>
      'Specify Product Type:';

  @override
  String get businessInformationOtherProductTypeError =>
      'Please enter product type';

  @override
  String get businessInformationSave => 'Save Information';

  @override
  String get businessInformationSaved =>
      'Business information saved successfully';

  @override
  String get businessSummaryTitle => 'Business Summary';

  @override
  String get businessSummaryNoInfo => 'No business information';

  @override
  String get businessSummaryRegisterPrompt =>
      'Please register a business first to see the summary';

  @override
  String get businessSummaryRegister => 'Register Business';

  @override
  String get businessSummaryDone => 'Done';

  @override
  String get businessSummaryInfo => 'Business Information';

  @override
  String get businessSummaryName => 'Business Name:';

  @override
  String get businessSummaryLocation => 'Business Location:';

  @override
  String get businessSummaryStartDate => 'Start Date:';

  @override
  String get businessSummaryProductType => 'Product Type:';

  @override
  String get businessSummaryOtherProductType => 'Other Product Type:';

  @override
  String get businessSummaryEdit => 'Edit Information';

  @override
  String get expensesListTitle => 'Expenses List';

  @override
  String get expensesListNoExpenses => 'No expenses recorded';

  @override
  String get expensesListAddPrompt => 'Tap the + button to add an expense';

  @override
  String get expensesListAddExpense => 'Add Expense';

  @override
  String expensesListAmount(Object amount) {
    return 'TSh $amount';
  }

  @override
  String expensesListReason(Object reason) {
    return 'Reason: $reason';
  }

  @override
  String expensesListPayer(Object payer) {
    return 'Payer: $payer';
  }

  @override
  String get expensesListUnknown => 'Unknown';

  @override
  String get expensesListNoDate => 'No date';

  @override
  String get purchaseListTitle => 'Purchase List';

  @override
  String get purchaseListNoPurchases => 'No purchases recorded';

  @override
  String get purchaseListAddPrompt => 'Tap the + button to add a purchase';

  @override
  String get purchaseListAddPurchase => 'Add Purchase';

  @override
  String purchaseListAmount(Object amount) {
    return 'TSh $amount';
  }

  @override
  String purchaseListBuyer(Object buyer) {
    return 'Buyer: $buyer';
  }

  @override
  String get purchaseListUnknown => 'Unknown';

  @override
  String get purchaseListNoDate => 'No date';

  @override
  String get saleListTitle => 'Sales List';

  @override
  String get saleListNoSales => 'No sales recorded';

  @override
  String get saleListAddPrompt => 'Tap the + button to add a sale';

  @override
  String get saleListAddSale => 'Add Sale';

  @override
  String saleListAmount(Object amount) {
    return 'TSh $amount';
  }

  @override
  String saleListCustomer(Object customer) {
    return 'Customer: $customer';
  }

  @override
  String saleListSeller(Object seller) {
    return 'Seller: $seller';
  }

  @override
  String get saleListUnknown => 'Unknown';

  @override
  String get saleListNoDate => 'No date';

  @override
  String get expensesTitle => 'Record Expense';

  @override
  String get expensesBusinessName => 'Business';

  @override
  String get expensesBusinessLocationUnknown => 'No location';

  @override
  String get expensesInfo => 'Expense Information';

  @override
  String get expensesDate => 'Date';

  @override
  String get expensesDateHint => 'dd/mm/yyyy';

  @override
  String get expensesDateError => 'Please select a date';

  @override
  String get expensesDateAbove => 'Expense Date';

  @override
  String get expensesReason => 'Expense Reason';

  @override
  String get expensesReasonHint => 'Enter expense reason';

  @override
  String get expensesReasonError => 'Please enter expense reason';

  @override
  String get expensesReasonAbove => 'Expense Reason';

  @override
  String get expensesAmount => 'Expense Amount';

  @override
  String get expensesAmountHint => 'Enter amount in TSh';

  @override
  String get expensesAmountError => 'Please enter amount';

  @override
  String get expensesAmountInvalidError => 'Please enter a valid number';

  @override
  String get expensesAmountAbove => 'Amount (TSh)';

  @override
  String get expensesPayer => 'Payer Name';

  @override
  String get expensesPayerHint => 'Enter payer name';

  @override
  String get expensesPayerError => 'Please enter payer name';

  @override
  String get expensesPayerAbove => 'Payer';

  @override
  String get expensesDescription => 'Expense Description';

  @override
  String get expensesDescriptionHint => 'Enter additional expense details';

  @override
  String get expensesDescriptionAbove => 'Description';

  @override
  String get expensesSave => 'Save Information';

  @override
  String get purchasesTitle => 'Record Purchase';

  @override
  String get purchasesBusinessName => 'Business';

  @override
  String get purchasesBusinessLocationUnknown => 'No location';

  @override
  String get purchasesInfo => 'Purchase Information';

  @override
  String get purchasesDate => 'Date';

  @override
  String get purchasesDateHint => 'dd/mm/yyyy';

  @override
  String get purchasesDateError => 'Please select a date';

  @override
  String get purchasesDateAbove => 'Purchase Date';

  @override
  String get purchasesAmount => 'Purchase Amount';

  @override
  String get purchasesAmountHint => 'Enter amount in TSh';

  @override
  String get purchasesAmountError => 'Please enter amount';

  @override
  String get purchasesAmountInvalidError => 'Please enter a valid number';

  @override
  String get purchasesAmountAbove => 'Purchase Cost';

  @override
  String get purchasesBuyer => 'Buyer Name';

  @override
  String get purchasesBuyerHint => 'Enter buyer name';

  @override
  String get purchasesBuyerError => 'Please enter buyer name';

  @override
  String get purchasesBuyerAbove => 'Buyer';

  @override
  String get purchasesDescription => 'Purchase Description';

  @override
  String get purchasesDescriptionHint => 'Enter additional purchase details';

  @override
  String get purchasesDescriptionAbove => 'Description';

  @override
  String get purchasesSave => 'Save Information';

  @override
  String get salesTitle => 'Record Sale';

  @override
  String get salesBusinessName => 'Business';

  @override
  String get salesBusinessLocationUnknown => 'No location';

  @override
  String get salesInfo => 'Sales Information';

  @override
  String get salesDate => 'Date';

  @override
  String get salesDateHint => 'dd/mm/yyyy';

  @override
  String get salesDateError => 'Please select a date';

  @override
  String get salesDateAbove => 'Sale Date';

  @override
  String get salesCustomer => 'Customer Name';

  @override
  String get salesCustomerHint => 'Enter customer name';

  @override
  String get salesCustomerError => 'Please enter customer name';

  @override
  String get salesCustomerAbove => 'Customer';

  @override
  String get salesRevenue => 'Revenue Amount';

  @override
  String get salesRevenueHint => 'Enter amount in TSh';

  @override
  String get salesRevenueError => 'Please enter amount';

  @override
  String get salesRevenueInvalidError => 'Please enter a valid number';

  @override
  String get salesRevenueAbove => 'Revenue';

  @override
  String get salesSeller => 'Seller Name';

  @override
  String get salesSellerHint => 'Enter seller name';

  @override
  String get salesSellerError => 'Please enter seller name';

  @override
  String get salesSellerAbove => 'Seller';

  @override
  String get salesDescription => 'Sales Description';

  @override
  String get salesDescriptionHint => 'Enter additional sales details';

  @override
  String get salesDescriptionAbove => 'Description';

  @override
  String get salesSave => 'Save Information';

  @override
  String get badiliSarafu => 'Change Currency';

  @override
  String get chaguaSarafuYaProgramu => 'Select the app currency';

  @override
  String get male => 'Male';

  @override
  String get female => 'Female';
}
