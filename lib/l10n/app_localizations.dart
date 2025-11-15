import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_sw.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr'),
    Locale('pt'),
    Locale('sw')
  ];

  /// No description provided for @selectCountry.
  ///
  /// In en, this message translates to:
  /// **'Select Country'**
  String get selectCountry;

  /// No description provided for @pleaseSelectCountry.
  ///
  /// In en, this message translates to:
  /// **'Please select your country'**
  String get pleaseSelectCountry;

  /// No description provided for @pleaseSelectCountryError.
  ///
  /// In en, this message translates to:
  /// **'Please select a country before continuing.'**
  String get pleaseSelectCountryError;

  /// No description provided for @locationInformation.
  ///
  /// In en, this message translates to:
  /// **'Location Information'**
  String get locationInformation;

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// No description provided for @pleaseSelectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Please select language'**
  String get pleaseSelectLanguage;

  /// No description provided for @selectRegion.
  ///
  /// In en, this message translates to:
  /// **'Select Region'**
  String get selectRegion;

  /// No description provided for @pleaseSelectRegion.
  ///
  /// In en, this message translates to:
  /// **'Please select region'**
  String get pleaseSelectRegion;

  /// No description provided for @loan_based_on_shares.
  ///
  /// In en, this message translates to:
  /// **'Specify how many times (x) a member can borrow based on their shares'**
  String get loan_based_on_shares;

  /// No description provided for @loan_based_on_savings.
  ///
  /// In en, this message translates to:
  /// **'Specify how many times (x) a member can borrow based on their savings'**
  String get loan_based_on_savings;

  /// No description provided for @selectDistrict.
  ///
  /// In en, this message translates to:
  /// **'Select District'**
  String get selectDistrict;

  /// No description provided for @pleaseSelectDistrict.
  ///
  /// In en, this message translates to:
  /// **'Please select district'**
  String get pleaseSelectDistrict;

  /// No description provided for @selectWard.
  ///
  /// In en, this message translates to:
  /// **'Select Ward'**
  String get selectWard;

  /// No description provided for @pleaseSelectWard.
  ///
  /// In en, this message translates to:
  /// **'Please select ward'**
  String get pleaseSelectWard;

  /// No description provided for @enterStreetOrVillage.
  ///
  /// In en, this message translates to:
  /// **'Enter Street or Village'**
  String get enterStreetOrVillage;

  /// No description provided for @pleaseEnterStreetOrVillage.
  ///
  /// In en, this message translates to:
  /// **'Please enter street or village name'**
  String get pleaseEnterStreetOrVillage;

  /// No description provided for @dataSavedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Data saved successfully!'**
  String get dataSavedSuccessfully;

  /// No description provided for @errorSavingData.
  ///
  /// In en, this message translates to:
  /// **'Error saving data: {error}'**
  String errorSavingData(String error);

  /// No description provided for @permissions.
  ///
  /// In en, this message translates to:
  /// **'Permissions'**
  String get permissions;

  /// No description provided for @permissionsDescription.
  ///
  /// In en, this message translates to:
  /// **'Chomoka requires several permissions to work correctly and efficiently.'**
  String get permissionsDescription;

  /// No description provided for @permissionsRequest.
  ///
  /// In en, this message translates to:
  /// **'Please accept all permission requests to continue using Chomoka easily.'**
  String get permissionsRequest;

  /// No description provided for @smsPermission.
  ///
  /// In en, this message translates to:
  /// **'SMS'**
  String get smsPermission;

  /// No description provided for @smsDescription.
  ///
  /// In en, this message translates to:
  /// **'Chomoka uses SMS as backup to store information when there\'s no internet.'**
  String get smsDescription;

  /// No description provided for @locationPermission.
  ///
  /// In en, this message translates to:
  /// **'Your Location'**
  String get locationPermission;

  /// No description provided for @locationDescription.
  ///
  /// In en, this message translates to:
  /// **'To improve system efficiency, CHOMOKA will use your location information.'**
  String get locationDescription;

  /// No description provided for @mediaPermission.
  ///
  /// In en, this message translates to:
  /// **'Photos and Documents'**
  String get mediaPermission;

  /// No description provided for @mediaDescription.
  ///
  /// In en, this message translates to:
  /// **'You can save photos, information, and related documents for verification.'**
  String get mediaDescription;

  /// No description provided for @termsAndConditions.
  ///
  /// In en, this message translates to:
  /// **'Terms and Conditions'**
  String get termsAndConditions;

  /// No description provided for @aboutChomoka.
  ///
  /// In en, this message translates to:
  /// **'About Chomoka'**
  String get aboutChomoka;

  /// No description provided for @aboutChomokaContent.
  ///
  /// In en, this message translates to:
  /// **'To use Chomoka you must agree to the terms and conditions and privacy policy.'**
  String get aboutChomokaContent;

  /// No description provided for @dataManagement.
  ///
  /// In en, this message translates to:
  /// **'Data Management'**
  String get dataManagement;

  /// No description provided for @dataManagementContent.
  ///
  /// In en, this message translates to:
  /// **'By using Chomoka you agree to the collection and storage of your data. The system may use your location information and send messages from your phone.'**
  String get dataManagementContent;

  /// No description provided for @namedData.
  ///
  /// In en, this message translates to:
  /// **'Named Data'**
  String get namedData;

  /// No description provided for @namedDataContent.
  ///
  /// In en, this message translates to:
  /// **'Group and member information will be stored for record keeping. We will not share this information with anyone without group permission.'**
  String get namedDataContent;

  /// No description provided for @generalData.
  ///
  /// In en, this message translates to:
  /// **'General Data'**
  String get generalData;

  /// No description provided for @generalDataContent.
  ///
  /// In en, this message translates to:
  /// **'We will use general data without mentioning member or group names to understand further developments.'**
  String get generalDataContent;

  /// No description provided for @acceptTerms.
  ///
  /// In en, this message translates to:
  /// **'I accept the terms and conditions'**
  String get acceptTerms;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @setupChomoka.
  ///
  /// In en, this message translates to:
  /// **'Setup Chomoka'**
  String get setupChomoka;

  /// No description provided for @groupInfo.
  ///
  /// In en, this message translates to:
  /// **'Group Information'**
  String get groupInfo;

  /// No description provided for @memberInfo.
  ///
  /// In en, this message translates to:
  /// **'Member Information'**
  String get memberInfo;

  /// No description provided for @constitutionInfo.
  ///
  /// In en, this message translates to:
  /// **'Constitution Information'**
  String get constitutionInfo;

  /// No description provided for @fundInfo.
  ///
  /// In en, this message translates to:
  /// **'Fund Information'**
  String get fundInfo;

  /// No description provided for @passwordSetup.
  ///
  /// In en, this message translates to:
  /// **'Password Setup'**
  String get passwordSetup;

  /// No description provided for @passwordSetupComplete.
  ///
  /// In en, this message translates to:
  /// **'Password setup complete!'**
  String get passwordSetupComplete;

  /// No description provided for @finished.
  ///
  /// In en, this message translates to:
  /// **'Finished'**
  String get finished;

  /// No description provided for @groupInformation.
  ///
  /// In en, this message translates to:
  /// **'Enter Group Information'**
  String get groupInformation;

  /// No description provided for @editGroupInformation.
  ///
  /// In en, this message translates to:
  /// **'Edit Group Information'**
  String get editGroupInformation;

  /// No description provided for @groupName.
  ///
  /// In en, this message translates to:
  /// **'Group Name'**
  String get groupName;

  /// No description provided for @enterGroupName.
  ///
  /// In en, this message translates to:
  /// **'Enter Group Name'**
  String get enterGroupName;

  /// No description provided for @groupNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Group name is required!'**
  String get groupNameRequired;

  /// No description provided for @yearEstablished.
  ///
  /// In en, this message translates to:
  /// **'Year Established'**
  String get yearEstablished;

  /// No description provided for @enterYearEstablished.
  ///
  /// In en, this message translates to:
  /// **'Enter Year Established'**
  String get enterYearEstablished;

  /// No description provided for @yearEstablishedRequired.
  ///
  /// In en, this message translates to:
  /// **'Year established is required!'**
  String get yearEstablishedRequired;

  /// No description provided for @enterValidYear.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid year!'**
  String get enterValidYear;

  /// No description provided for @enterYearRange.
  ///
  /// In en, this message translates to:
  /// **'Please enter a year between 1999 and {currentYear}!'**
  String enterYearRange(Object currentYear);

  /// No description provided for @currentRound.
  ///
  /// In en, this message translates to:
  /// **'What round is the group in'**
  String get currentRound;

  /// No description provided for @enterCurrentRound.
  ///
  /// In en, this message translates to:
  /// **'Enter the current round in the group'**
  String get enterCurrentRound;

  /// No description provided for @currentRoundRequired.
  ///
  /// In en, this message translates to:
  /// **'Group round is required!'**
  String get currentRoundRequired;

  /// No description provided for @enterValidRound.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid number for the round!'**
  String get enterValidRound;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @errorUpdatingData.
  ///
  /// In en, this message translates to:
  /// **'Error updating data: {error}'**
  String errorUpdatingData(Object error);

  /// No description provided for @groupSummary.
  ///
  /// In en, this message translates to:
  /// **'Group Summary'**
  String get groupSummary;

  /// No description provided for @sessionSummary.
  ///
  /// In en, this message translates to:
  /// **'Session Summary'**
  String get sessionSummary;

  /// No description provided for @meetingFrequency.
  ///
  /// In en, this message translates to:
  /// **'How Often Do You Meet?'**
  String get meetingFrequency;

  /// No description provided for @pleaseSelectFrequency.
  ///
  /// In en, this message translates to:
  /// **'Please select meeting frequency!'**
  String get pleaseSelectFrequency;

  /// No description provided for @sessionCount.
  ///
  /// In en, this message translates to:
  /// **'Number of Sessions in a Round:'**
  String get sessionCount;

  /// No description provided for @enterSessionCount.
  ///
  /// In en, this message translates to:
  /// **'Enter Number of Sessions'**
  String get enterSessionCount;

  /// No description provided for @sessionCountRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter number of sessions'**
  String get sessionCountRequired;

  /// No description provided for @enterValidSessionCount.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid number for sessions'**
  String get enterValidSessionCount;

  /// No description provided for @pleaseNote.
  ///
  /// In en, this message translates to:
  /// **'Please Note:'**
  String get pleaseNote;

  /// No description provided for @allocationDescription.
  ///
  /// In en, this message translates to:
  /// **'Allocation is Every After {allocationDescription}'**
  String allocationDescription(String allocationDescription);

  /// No description provided for @errorOccurred.
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String errorOccurred(Object error);

  /// No description provided for @groupRegistration.
  ///
  /// In en, this message translates to:
  /// **'Group Registration'**
  String get groupRegistration;

  /// No description provided for @fines.
  ///
  /// In en, this message translates to:
  /// **'Fines'**
  String get fines;

  /// No description provided for @meeting_completed_title.
  ///
  /// In en, this message translates to:
  /// **'Meeting Completed'**
  String get meeting_completed_title;

  /// No description provided for @meeting_completed_message.
  ///
  /// In en, this message translates to:
  /// **'The meeting has been completed. Restart the Chomoka system to begin a new session.'**
  String get meeting_completed_message;

  /// No description provided for @meeting_completed_button.
  ///
  /// In en, this message translates to:
  /// **'Login Again'**
  String get meeting_completed_button;

  /// No description provided for @lateness.
  ///
  /// In en, this message translates to:
  /// **'Late arrival'**
  String get lateness;

  /// No description provided for @absentWithoutPermission.
  ///
  /// In en, this message translates to:
  /// **'Absent without permission'**
  String get absentWithoutPermission;

  /// No description provided for @sendingRepresentative.
  ///
  /// In en, this message translates to:
  /// **'Sent a representative'**
  String get sendingRepresentative;

  /// No description provided for @speakingWithoutPermission.
  ///
  /// In en, this message translates to:
  /// **'Speaking without permission'**
  String get speakingWithoutPermission;

  /// No description provided for @phoneUsageDuringMeeting.
  ///
  /// In en, this message translates to:
  /// **'Phone usage during meeting'**
  String get phoneUsageDuringMeeting;

  /// No description provided for @leadershipMisconduct.
  ///
  /// In en, this message translates to:
  /// **'Leadership misconduct'**
  String get leadershipMisconduct;

  /// No description provided for @forgettingRules.
  ///
  /// In en, this message translates to:
  /// **'Forgetting the rules'**
  String get forgettingRules;

  /// No description provided for @addNewFine.
  ///
  /// In en, this message translates to:
  /// **'Add New Fine'**
  String get addNewFine;

  /// No description provided for @finesWithoutAmountWontShow.
  ///
  /// In en, this message translates to:
  /// **'Fines without amounts won\'t show during meetings'**
  String get finesWithoutAmountWontShow;

  /// No description provided for @fineType.
  ///
  /// In en, this message translates to:
  /// **'Type of fine'**
  String get fineType;

  /// No description provided for @addFineType.
  ///
  /// In en, this message translates to:
  /// **'Add Fine Type'**
  String get addFineType;

  /// No description provided for @amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount;

  /// No description provided for @percentage.
  ///
  /// In en, this message translates to:
  /// **'Percentage'**
  String get percentage;

  /// No description provided for @memberShareTitle.
  ///
  /// In en, this message translates to:
  /// **'Member Shareout'**
  String get memberShareTitle;

  /// No description provided for @shareCount.
  ///
  /// In en, this message translates to:
  /// **'Number of Shares'**
  String get shareCount;

  /// No description provided for @saveButton.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get saveButton;

  /// No description provided for @unnamed.
  ///
  /// In en, this message translates to:
  /// **'Unnamed'**
  String get unnamed;

  /// No description provided for @noPhone.
  ///
  /// In en, this message translates to:
  /// **'No phone'**
  String get noPhone;

  /// No description provided for @errorLoadingData.
  ///
  /// In en, this message translates to:
  /// **'Error loading data: {error}'**
  String errorLoadingData(Object error);

  /// No description provided for @failedToUpdateStatus.
  ///
  /// In en, this message translates to:
  /// **'Failed to update status: {error}'**
  String failedToUpdateStatus(Object error);

  /// No description provided for @fixedAmount.
  ///
  /// In en, this message translates to:
  /// **'Fixed Amount'**
  String get fixedAmount;

  /// No description provided for @enterPenaltyPercentage.
  ///
  /// In en, this message translates to:
  /// **'Enter penalty percentage'**
  String get enterPenaltyPercentage;

  /// No description provided for @percentageRequired.
  ///
  /// In en, this message translates to:
  /// **'Percentage is required'**
  String get percentageRequired;

  /// No description provided for @enterValidPercentage.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid percentage'**
  String get enterValidPercentage;

  /// No description provided for @enterFixedAmount.
  ///
  /// In en, this message translates to:
  /// **'Enter Fixed Amount'**
  String get enterFixedAmount;

  /// No description provided for @fixedAmountRequired.
  ///
  /// In en, this message translates to:
  /// **'Fixed amount is required'**
  String get fixedAmountRequired;

  /// No description provided for @enterValidAmount.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid amount!'**
  String get enterValidAmount;

  /// No description provided for @explainPenaltyUsage.
  ///
  /// In en, this message translates to:
  /// **'Explain how penalties are used for loans when a member fails to make all required payments on time.'**
  String get explainPenaltyUsage;

  /// No description provided for @loanDelayPenalty.
  ///
  /// In en, this message translates to:
  /// **'Loan delay penalty'**
  String get loanDelayPenalty;

  /// No description provided for @noPercentagePenalty.
  ///
  /// In en, this message translates to:
  /// **'No percentage penalty will be charged for loan delays.'**
  String get noPercentagePenalty;

  /// No description provided for @percentagePenaltyExample.
  ///
  /// In en, this message translates to:
  /// **'For example, if a member delays paying their loan, they will pay an additional {percentage}% each month on the remaining loan amount. If they borrow  10,000, they must pay a delay fee of  {amount} per month.'**
  String percentagePenaltyExample(String percentage, String amount);

  /// No description provided for @noFixedAmountPenalty.
  ///
  /// In en, this message translates to:
  /// **'No fixed amount penalty will be charged for loan delays.'**
  String get noFixedAmountPenalty;

  /// No description provided for @fixedAmountPenaltyExample.
  ///
  /// In en, this message translates to:
  /// **'For example, if a member delays paying their loan, they will pay  {amount} as a fixed delay penalty.'**
  String fixedAmountPenaltyExample(String amount);

  /// No description provided for @addAmount.
  ///
  /// In en, this message translates to:
  /// **'Add Amount'**
  String get addAmount;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @continue_.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continue_;

  /// No description provided for @editRegistration.
  ///
  /// In en, this message translates to:
  /// **'Edit Registration'**
  String get editRegistration;

  /// No description provided for @registrationStatus.
  ///
  /// In en, this message translates to:
  /// **'Registration Status'**
  String get registrationStatus;

  /// No description provided for @selectRegistrationStatus.
  ///
  /// In en, this message translates to:
  /// **'Select Registration Status'**
  String get selectRegistrationStatus;

  /// No description provided for @pleaseSelectRegistrationStatus.
  ///
  /// In en, this message translates to:
  /// **'Please select registration status'**
  String get pleaseSelectRegistrationStatus;

  /// No description provided for @appVersionName.
  ///
  /// In en, this message translates to:
  /// **'Chapati Version 1.0.0'**
  String get appVersionName;

  /// No description provided for @appVersionNumber.
  ///
  /// In en, this message translates to:
  /// **'Version 0001'**
  String get appVersionNumber;

  /// No description provided for @open.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get open;

  /// No description provided for @demo.
  ///
  /// In en, this message translates to:
  /// **'Demo'**
  String get demo;

  /// No description provided for @exercise.
  ///
  /// In en, this message translates to:
  /// **'Exercise'**
  String get exercise;

  /// No description provided for @registrationNumber.
  ///
  /// In en, this message translates to:
  /// **'Registration Number'**
  String get registrationNumber;

  /// No description provided for @enterRegistrationNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter Registration Number'**
  String get enterRegistrationNumber;

  /// No description provided for @pleaseEnterRegistrationNumber.
  ///
  /// In en, this message translates to:
  /// **'Please enter registration number'**
  String get pleaseEnterRegistrationNumber;

  /// No description provided for @correct.
  ///
  /// In en, this message translates to:
  /// **'Correct'**
  String get correct;

  /// No description provided for @groupInstitution.
  ///
  /// In en, this message translates to:
  /// **'Group Institution'**
  String get groupInstitution;

  /// No description provided for @editInstitution.
  ///
  /// In en, this message translates to:
  /// **'Edit Group Institution'**
  String get editInstitution;

  /// No description provided for @selectOrganization.
  ///
  /// In en, this message translates to:
  /// **'Select Organization'**
  String get selectOrganization;

  /// No description provided for @pleaseSelectOrganization.
  ///
  /// In en, this message translates to:
  /// **'Please select organization'**
  String get pleaseSelectOrganization;

  /// No description provided for @enterOrganizationName.
  ///
  /// In en, this message translates to:
  /// **'Enter Organization Name'**
  String get enterOrganizationName;

  /// No description provided for @organizationNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Organization name is required!'**
  String get organizationNameRequired;

  /// No description provided for @selectProject.
  ///
  /// In en, this message translates to:
  /// **'Select Project'**
  String get selectProject;

  /// No description provided for @pleaseSelectProject.
  ///
  /// In en, this message translates to:
  /// **'Please select project'**
  String get pleaseSelectProject;

  /// No description provided for @enterProjectName.
  ///
  /// In en, this message translates to:
  /// **'Enter Project Name'**
  String get enterProjectName;

  /// No description provided for @projectNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Project name is required!'**
  String get projectNameRequired;

  /// No description provided for @enterTeacherId.
  ///
  /// In en, this message translates to:
  /// **'Enter Teacher ID'**
  String get enterTeacherId;

  /// No description provided for @teacherIdRequired.
  ///
  /// In en, this message translates to:
  /// **'Teacher ID is required!'**
  String get teacherIdRequired;

  /// No description provided for @continueText.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueText;

  /// No description provided for @selectKeyToReset.
  ///
  /// In en, this message translates to:
  /// **'Select key to reset'**
  String get selectKeyToReset;

  /// No description provided for @keyHolderSecretQuestion.
  ///
  /// In en, this message translates to:
  /// **'The selected key holder member will be asked a secret question during key setup'**
  String get keyHolderSecretQuestion;

  /// No description provided for @resetKey1.
  ///
  /// In en, this message translates to:
  /// **'Reset key 1'**
  String get resetKey1;

  /// No description provided for @resetKey2.
  ///
  /// In en, this message translates to:
  /// **'Reset key 2'**
  String get resetKey2;

  /// No description provided for @resetKey3.
  ///
  /// In en, this message translates to:
  /// **'Reset key 3'**
  String get resetKey3;

  /// No description provided for @selectQuestion.
  ///
  /// In en, this message translates to:
  /// **'Select Question'**
  String get selectQuestion;

  /// No description provided for @answerToQuestion.
  ///
  /// In en, this message translates to:
  /// **'Answer to question'**
  String get answerToQuestion;

  /// No description provided for @enterAnswer.
  ///
  /// In en, this message translates to:
  /// **'Enter answer to question'**
  String get enterAnswer;

  /// No description provided for @incorrectQuestionOrAnswer.
  ///
  /// In en, this message translates to:
  /// **'Question or answer is incorrect'**
  String get incorrectQuestionOrAnswer;

  /// No description provided for @pleaseSelectQuestionAndAnswer.
  ///
  /// In en, this message translates to:
  /// **'Please select question and answer'**
  String get pleaseSelectQuestionAndAnswer;

  /// No description provided for @passwordsDoNotMatchTryAgain.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match, please try again'**
  String get passwordsDoNotMatchTryAgain;

  /// No description provided for @confirmPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password for'**
  String get confirmPasswordTitle;

  /// No description provided for @groupOverview.
  ///
  /// In en, this message translates to:
  /// **'Group Overview'**
  String get groupOverview;

  /// No description provided for @fundOverview.
  ///
  /// In en, this message translates to:
  /// **'Fund Overview'**
  String get fundOverview;

  /// No description provided for @meetingSummary.
  ///
  /// In en, this message translates to:
  /// **'Meeting Summary'**
  String get meetingSummary;

  /// No description provided for @allocation.
  ///
  /// In en, this message translates to:
  /// **'Allocation'**
  String get allocation;

  /// No description provided for @registration.
  ///
  /// In en, this message translates to:
  /// **'Group Registration'**
  String get registration;

  /// No description provided for @registrationType.
  ///
  /// In en, this message translates to:
  /// **'Registration Type'**
  String get registrationType;

  /// No description provided for @institutionalInfo.
  ///
  /// In en, this message translates to:
  /// **'Institutional Information'**
  String get institutionalInfo;

  /// No description provided for @institutionName.
  ///
  /// In en, this message translates to:
  /// **'Institution Name'**
  String get institutionName;

  /// No description provided for @projectName.
  ///
  /// In en, this message translates to:
  /// **'Project Name'**
  String get projectName;

  /// No description provided for @teacherId.
  ///
  /// In en, this message translates to:
  /// **'Teacher ID'**
  String get teacherId;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @loanGuarantors.
  ///
  /// In en, this message translates to:
  /// **'Loan Guarantors'**
  String get loanGuarantors;

  /// No description provided for @doesLoanNeedGuarantor.
  ///
  /// In en, this message translates to:
  /// **'Does the loan need a guarantor?'**
  String get doesLoanNeedGuarantor;

  /// No description provided for @numberOfGuarantors.
  ///
  /// In en, this message translates to:
  /// **'Number of Guarantors'**
  String get numberOfGuarantors;

  /// No description provided for @enterNumberOfGuarantors.
  ///
  /// In en, this message translates to:
  /// **'Enter number of guarantors'**
  String get enterNumberOfGuarantors;

  /// No description provided for @numberOfGuarantorsRequired.
  ///
  /// In en, this message translates to:
  /// **'Number of guarantors is required'**
  String get numberOfGuarantorsRequired;

  /// No description provided for @securityQuestion1.
  ///
  /// In en, this message translates to:
  /// **'What year was your first child born?'**
  String get securityQuestion1;

  /// No description provided for @securityQuestion2.
  ///
  /// In en, this message translates to:
  /// **'What is the first name of your first child?'**
  String get securityQuestion2;

  /// No description provided for @securityQuestion3.
  ///
  /// In en, this message translates to:
  /// **'What year were you born?'**
  String get securityQuestion3;

  /// No description provided for @errorSelectQuestion.
  ///
  /// In en, this message translates to:
  /// **'Please select a security question.'**
  String get errorSelectQuestion;

  /// No description provided for @errorEnterAnswer.
  ///
  /// In en, this message translates to:
  /// **'Please fill in the answer to the question.'**
  String get errorEnterAnswer;

  /// No description provided for @errorSaving.
  ///
  /// In en, this message translates to:
  /// **'There was a problem saving. Please try again.'**
  String get errorSaving;

  /// No description provided for @resetQuestionPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Security Question for Key {passwordNumber}'**
  String resetQuestionPageTitle(int passwordNumber);

  /// No description provided for @selectQuestionLabel.
  ///
  /// In en, this message translates to:
  /// **'Select Question'**
  String get selectQuestionLabel;

  /// No description provided for @selectQuestionHint.
  ///
  /// In en, this message translates to:
  /// **'Select Question'**
  String get selectQuestionHint;

  /// No description provided for @answerLabel.
  ///
  /// In en, this message translates to:
  /// **'Answer'**
  String get answerLabel;

  /// No description provided for @answerHint.
  ///
  /// In en, this message translates to:
  /// **'Enter Answer'**
  String get answerHint;

  /// No description provided for @pleaseEnterValidNumber.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid number'**
  String get pleaseEnterValidNumber;

  /// No description provided for @describeNumberOfGuarantors.
  ///
  /// In en, this message translates to:
  /// **'Describe the number of guarantors required to apply for a loan'**
  String get describeNumberOfGuarantors;

  /// No description provided for @country.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get country;

  /// No description provided for @region.
  ///
  /// In en, this message translates to:
  /// **'Region'**
  String get region;

  /// No description provided for @district.
  ///
  /// In en, this message translates to:
  /// **'District'**
  String get district;

  /// No description provided for @ward.
  ///
  /// In en, this message translates to:
  /// **'Ward'**
  String get ward;

  /// No description provided for @streetOrVillage.
  ///
  /// In en, this message translates to:
  /// **'Street or Village'**
  String get streetOrVillage;

  /// No description provided for @sendSummary.
  ///
  /// In en, this message translates to:
  /// **'SEND SUMMARY'**
  String get sendSummary;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'completed'**
  String get completed;

  /// No description provided for @members.
  ///
  /// In en, this message translates to:
  /// **'Members: {count}'**
  String members(Object count);

  /// No description provided for @noMembers.
  ///
  /// In en, this message translates to:
  /// **'No members available.'**
  String get noMembers;

  /// No description provided for @errorFetchingMembers.
  ///
  /// In en, this message translates to:
  /// **'Error fetching members: {error}'**
  String errorFetchingMembers(Object error);

  /// No description provided for @memberSummary.
  ///
  /// In en, this message translates to:
  /// **'Member Summary'**
  String get memberSummary;

  /// No description provided for @memberIdentity.
  ///
  /// In en, this message translates to:
  /// **'Member Identity'**
  String get memberIdentity;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name:'**
  String get fullName;

  /// No description provided for @memberNumber.
  ///
  /// In en, this message translates to:
  /// **'Member Number:'**
  String get memberNumber;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender:'**
  String get gender;

  /// No description provided for @dob.
  ///
  /// In en, this message translates to:
  /// **'Date of Birth:'**
  String get dob;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number:'**
  String get phoneNumber;

  /// No description provided for @job.
  ///
  /// In en, this message translates to:
  /// **'Job:'**
  String get job;

  /// No description provided for @idType.
  ///
  /// In en, this message translates to:
  /// **'ID Type:'**
  String get idType;

  /// No description provided for @idNumber.
  ///
  /// In en, this message translates to:
  /// **'ID Number:'**
  String get idNumber;

  /// No description provided for @noPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Member has no phone number'**
  String get noPhoneNumber;

  /// No description provided for @summarySent.
  ///
  /// In en, this message translates to:
  /// **'Summary sent to {name} successfully'**
  String summarySent(Object name);

  /// No description provided for @failedToSendSms.
  ///
  /// In en, this message translates to:
  /// **'Failed to send SMS to {name}'**
  String failedToSendSms(Object name);

  /// No description provided for @totalSavings.
  ///
  /// In en, this message translates to:
  /// **'Total Savings'**
  String get totalSavings;

  /// No description provided for @totalDebt.
  ///
  /// In en, this message translates to:
  /// **'Total Debt'**
  String get totalDebt;

  /// No description provided for @totalShares.
  ///
  /// In en, this message translates to:
  /// **'Total Shares'**
  String get totalShares;

  /// No description provided for @communityFundBalance.
  ///
  /// In en, this message translates to:
  /// **'Community Fund Balance'**
  String get communityFundBalance;

  /// No description provided for @currentLoans.
  ///
  /// In en, this message translates to:
  /// **'Current Loans'**
  String get currentLoans;

  /// No description provided for @totalFinesCollected.
  ///
  /// In en, this message translates to:
  /// **'Total Fines Collected'**
  String get totalFinesCollected;

  /// No description provided for @confirmDeleteUser.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this user?'**
  String get confirmDeleteUser;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @enterMemberNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter Member Number'**
  String get enterMemberNumber;

  /// No description provided for @memberNumberRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter member number'**
  String get memberNumberRequired;

  /// No description provided for @memberNumberDigitsOnly.
  ///
  /// In en, this message translates to:
  /// **'Member number should be digits only'**
  String get memberNumberDigitsOnly;

  /// No description provided for @enterFullName.
  ///
  /// In en, this message translates to:
  /// **'Enter Full Name'**
  String get enterFullName;

  /// No description provided for @fullNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter member\'s full name'**
  String get fullNameRequired;

  /// No description provided for @fullNameMinLength.
  ///
  /// In en, this message translates to:
  /// **'Name should have at least 3 characters'**
  String get fullNameMinLength;

  /// No description provided for @selectYear.
  ///
  /// In en, this message translates to:
  /// **'Select Year'**
  String get selectYear;

  /// No description provided for @selectMonth.
  ///
  /// In en, this message translates to:
  /// **'Select Month'**
  String get selectMonth;

  /// No description provided for @selectDay.
  ///
  /// In en, this message translates to:
  /// **'Select Day'**
  String get selectDay;

  /// No description provided for @dobRequired.
  ///
  /// In en, this message translates to:
  /// **'Please select complete date of birth'**
  String get dobRequired;

  /// No description provided for @uniqueMemberNumber.
  ///
  /// In en, this message translates to:
  /// **'Member number should be unique'**
  String get uniqueMemberNumber;

  /// No description provided for @noActiveCycle.
  ///
  /// In en, this message translates to:
  /// **'Error: No active cycle found!'**
  String get noActiveCycle;

  /// No description provided for @appTagline.
  ///
  /// In en, this message translates to:
  /// **'We Help You Strengthen Development'**
  String get appTagline;

  /// No description provided for @example.
  ///
  /// In en, this message translates to:
  /// **'Example'**
  String get example;

  /// No description provided for @mzungukoPendingNoNew.
  ///
  /// In en, this message translates to:
  /// **'The current cycle is already \"pending\". No new cycle has been started.'**
  String get mzungukoPendingNoNew;

  /// No description provided for @newMzungukoCreated.
  ///
  /// In en, this message translates to:
  /// **'New cycle started successfully!'**
  String get newMzungukoCreated;

  /// No description provided for @errorSavingMzunguko.
  ///
  /// In en, this message translates to:
  /// **'Error saving or updating cycle information: {error}'**
  String errorSavingMzunguko(String error);

  /// No description provided for @weekly.
  ///
  /// In en, this message translates to:
  /// **'Weekly'**
  String get weekly;

  /// No description provided for @biWeekly.
  ///
  /// In en, this message translates to:
  /// **'Every Two Weeks'**
  String get biWeekly;

  /// No description provided for @monthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get monthly;

  /// No description provided for @years.
  ///
  /// In en, this message translates to:
  /// **'{count} Years'**
  String years(int count);

  /// No description provided for @months.
  ///
  /// In en, this message translates to:
  /// **'months'**
  String months(int count);

  /// No description provided for @weeks.
  ///
  /// In en, this message translates to:
  /// **'{count} Weeks'**
  String weeks(int count);

  /// No description provided for @registered.
  ///
  /// In en, this message translates to:
  /// **'Registered'**
  String get registered;

  /// No description provided for @notRegistered.
  ///
  /// In en, this message translates to:
  /// **'Not Registered'**
  String get notRegistered;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// No description provided for @memberPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Member Phone Number'**
  String get memberPhoneNumber;

  /// No description provided for @enterMemberPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter Member Phone Number'**
  String get enterMemberPhoneNumber;

  /// No description provided for @selectJob.
  ///
  /// In en, this message translates to:
  /// **'Select Job'**
  String get selectJob;

  /// No description provided for @enterJobName.
  ///
  /// In en, this message translates to:
  /// **'Enter Job Name'**
  String get enterJobName;

  /// No description provided for @pleaseSelectJob.
  ///
  /// In en, this message translates to:
  /// **'Please select job'**
  String get pleaseSelectJob;

  /// No description provided for @pleaseEnterJobName.
  ///
  /// In en, this message translates to:
  /// **'Please enter job name'**
  String get pleaseEnterJobName;

  /// No description provided for @selectIdType.
  ///
  /// In en, this message translates to:
  /// **'Select ID Type'**
  String get selectIdType;

  /// No description provided for @enterIdNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter ID Number'**
  String get enterIdNumber;

  /// No description provided for @pleaseSelectIdType.
  ///
  /// In en, this message translates to:
  /// **'Please select ID type'**
  String get pleaseSelectIdType;

  /// No description provided for @pleaseEnterIdNumber.
  ///
  /// In en, this message translates to:
  /// **'Please enter ID number'**
  String get pleaseEnterIdNumber;

  /// No description provided for @idPhoto.
  ///
  /// In en, this message translates to:
  /// **'ID Photo'**
  String get idPhoto;

  /// No description provided for @removePhoto.
  ///
  /// In en, this message translates to:
  /// **'Remove Photo'**
  String get removePhoto;

  /// No description provided for @takePhoto.
  ///
  /// In en, this message translates to:
  /// **'Take Photo'**
  String get takePhoto;

  /// No description provided for @chooseFromGallery.
  ///
  /// In en, this message translates to:
  /// **'Choose from Gallery'**
  String get chooseFromGallery;

  /// No description provided for @farmer.
  ///
  /// In en, this message translates to:
  /// **'Farmer'**
  String get farmer;

  /// No description provided for @teacher.
  ///
  /// In en, this message translates to:
  /// **'Teacher'**
  String get teacher;

  /// No description provided for @doctor.
  ///
  /// In en, this message translates to:
  /// **'Doctor'**
  String get doctor;

  /// No description provided for @entrepreneur.
  ///
  /// In en, this message translates to:
  /// **'Entrepreneur'**
  String get entrepreneur;

  /// No description provided for @engineer.
  ///
  /// In en, this message translates to:
  /// **'Engineer'**
  String get engineer;

  /// No description provided for @lawyer.
  ///
  /// In en, this message translates to:
  /// **'Lawyer'**
  String get lawyer;

  /// No description provided for @none.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get none;

  /// No description provided for @voterCard.
  ///
  /// In en, this message translates to:
  /// **'Voter ID Card'**
  String get voterCard;

  /// No description provided for @nationalId.
  ///
  /// In en, this message translates to:
  /// **'National ID'**
  String get nationalId;

  /// No description provided for @zanzibarResidentCard.
  ///
  /// In en, this message translates to:
  /// **'Zanzibar Resident Card'**
  String get zanzibarResidentCard;

  /// No description provided for @driversLicense.
  ///
  /// In en, this message translates to:
  /// **'Driver\'s License'**
  String get driversLicense;

  /// No description provided for @localGovernmentLetter.
  ///
  /// In en, this message translates to:
  /// **'Local Government Letter'**
  String get localGovernmentLetter;

  /// No description provided for @errorSavingPhoto.
  ///
  /// In en, this message translates to:
  /// **'Failed to save member photo'**
  String get errorSavingPhoto;

  /// No description provided for @errorRemovingPhoto.
  ///
  /// In en, this message translates to:
  /// **'Failed to remove photo'**
  String get errorRemovingPhoto;

  /// No description provided for @errorLoadingPhoto.
  ///
  /// In en, this message translates to:
  /// **'Failed to load member photo'**
  String get errorLoadingPhoto;

  /// No description provided for @memberInformation.
  ///
  /// In en, this message translates to:
  /// **'Member Information'**
  String get memberInformation;

  /// No description provided for @memberIdentification.
  ///
  /// In en, this message translates to:
  /// **'Member Identification'**
  String get memberIdentification;

  /// No description provided for @dateOfBirth.
  ///
  /// In en, this message translates to:
  /// **'Date of Birth'**
  String get dateOfBirth;

  /// No description provided for @occupation.
  ///
  /// In en, this message translates to:
  /// **'Occupation'**
  String get occupation;

  /// No description provided for @mandatorySavings.
  ///
  /// In en, this message translates to:
  /// **'Mandatory Savings'**
  String get mandatorySavings;

  /// No description provided for @voluntarySavings.
  ///
  /// In en, this message translates to:
  /// **'Voluntary Savings'**
  String get voluntarySavings;

  /// No description provided for @communityFund.
  ///
  /// In en, this message translates to:
  /// **'Community Fund'**
  String get communityFund;

  /// No description provided for @currentLoan.
  ///
  /// In en, this message translates to:
  /// **'Current Loan'**
  String get currentLoan;

  /// No description provided for @finish.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get finish;

  /// No description provided for @enterKey1.
  ///
  /// In en, this message translates to:
  /// **'Enter Key 1'**
  String get enterKey1;

  /// No description provided for @enterKey2.
  ///
  /// In en, this message translates to:
  /// **'Enter Key 2'**
  String get enterKey2;

  /// No description provided for @enterKey3.
  ///
  /// In en, this message translates to:
  /// **'Enter Key 3'**
  String get enterKey3;

  /// No description provided for @enterAllKeys.
  ///
  /// In en, this message translates to:
  /// **'Please fill in all three keys.'**
  String get enterAllKeys;

  /// No description provided for @invalidKeys.
  ///
  /// In en, this message translates to:
  /// **'Secret keys are incorrect. Please try again.'**
  String get invalidKeys;

  /// No description provided for @systemError.
  ///
  /// In en, this message translates to:
  /// **'A problem has occurred. Please try again later.'**
  String get systemError;

  /// No description provided for @resetSecurityKeys.
  ///
  /// In en, this message translates to:
  /// **'RESET SECURITY KEYS'**
  String get resetSecurityKeys;

  /// No description provided for @openButton.
  ///
  /// In en, this message translates to:
  /// **'OPEN'**
  String get openButton;

  /// No description provided for @pleaseEnterNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter new password'**
  String get pleaseEnterNewPassword;

  /// No description provided for @passwordMustBeDigitsOnly.
  ///
  /// In en, this message translates to:
  /// **'Password must be digits only'**
  String get passwordMustBeDigitsOnly;

  /// No description provided for @passwordMustBeLessThan4Digits.
  ///
  /// In en, this message translates to:
  /// **'Password must be less than 4 digits'**
  String get passwordMustBeLessThan4Digits;

  /// No description provided for @pleaseConfirmNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Please confirm new password'**
  String get pleaseConfirmNewPassword;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// No description provided for @errorOccurredTryAgain.
  ///
  /// In en, this message translates to:
  /// **'An error occurred. Please try again.'**
  String get errorOccurredTryAgain;

  /// No description provided for @editPasswordFor.
  ///
  /// In en, this message translates to:
  /// **'Edit Password for {key}'**
  String editPasswordFor(String key);

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// No description provided for @confirmNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm New Password'**
  String get confirmNewPassword;

  /// No description provided for @enterNewPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter new password'**
  String get enterNewPassword;

  /// No description provided for @getHelp.
  ///
  /// In en, this message translates to:
  /// **'Get Help'**
  String get getHelp;

  /// No description provided for @welcomeChomokaPlus.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Chomoka Plus'**
  String get welcomeChomokaPlus;

  /// No description provided for @groupOf.
  ///
  /// In en, this message translates to:
  /// **'Group of: {groupName}'**
  String groupOf(Object groupName);

  /// No description provided for @dashboardHelpText.
  ///
  /// In en, this message translates to:
  /// **'We help you keep records of your group efficiently.'**
  String get dashboardHelpText;

  /// No description provided for @groupServices.
  ///
  /// In en, this message translates to:
  /// **'Group Services'**
  String get groupServices;

  /// No description provided for @startMeeting.
  ///
  /// In en, this message translates to:
  /// **'Start Meeting'**
  String get startMeeting;

  /// No description provided for @continueExistingMeeting.
  ///
  /// In en, this message translates to:
  /// **'Continue existing meeting'**
  String get continueExistingMeeting;

  /// No description provided for @openNewMeeting.
  ///
  /// In en, this message translates to:
  /// **'Open new group meeting'**
  String get openNewMeeting;

  /// No description provided for @group.
  ///
  /// In en, this message translates to:
  /// **'GROUP'**
  String get group;

  /// No description provided for @constitution.
  ///
  /// In en, this message translates to:
  /// **'Constitution'**
  String get constitution;

  /// No description provided for @shareCalculation.
  ///
  /// In en, this message translates to:
  /// **'Share Calculation'**
  String get shareCalculation;

  /// No description provided for @systemFeedback.
  ///
  /// In en, this message translates to:
  /// **'System Feedback'**
  String get systemFeedback;

  /// No description provided for @groupActivities.
  ///
  /// In en, this message translates to:
  /// **'Group Activities'**
  String get groupActivities;

  /// No description provided for @moreServices.
  ///
  /// In en, this message translates to:
  /// **'More Services'**
  String get moreServices;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @viewGroupHistory.
  ///
  /// In en, this message translates to:
  /// **'View group activity history'**
  String get viewGroupHistory;

  /// No description provided for @backupRestore.
  ///
  /// In en, this message translates to:
  /// **'Backup and Restore'**
  String get backupRestore;

  /// No description provided for @backupRestoreDesc.
  ///
  /// In en, this message translates to:
  /// **'Backup and restore group records'**
  String get backupRestoreDesc;

  /// No description provided for @chomokaPlusVersion.
  ///
  /// In en, this message translates to:
  /// **'Chomoka Plus v2.0'**
  String get chomokaPlusVersion;

  /// No description provided for @finishShare.
  ///
  /// In en, this message translates to:
  /// **'Finish Share'**
  String get finishShare;

  /// No description provided for @finishShareDesc.
  ///
  /// In en, this message translates to:
  /// **'The last cycle is complete. Please finish the share.'**
  String get finishShareDesc;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @meetingOptionsWelcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Another Meeting'**
  String get meetingOptionsWelcome;

  /// No description provided for @midCycleInfo.
  ///
  /// In en, this message translates to:
  /// **'This is mid-cycle info'**
  String get midCycleInfo;

  /// No description provided for @openMeetingButton.
  ///
  /// In en, this message translates to:
  /// **'OPEN MEETING'**
  String get openMeetingButton;

  /// No description provided for @startNewCycleQuestion.
  ///
  /// In en, this message translates to:
  /// **'Are you starting a new cycle?'**
  String get startNewCycleQuestion;

  /// No description provided for @pressYesToStartFirstMeeting.
  ///
  /// In en, this message translates to:
  /// **'PRESS YES TO CONDUCT FIRST MEETING'**
  String get pressYesToStartFirstMeeting;

  /// No description provided for @pressNoForPastMeetings.
  ///
  /// In en, this message translates to:
  /// **'PRESS NO TO RECORD PAST MEETINGS'**
  String get pressNoForPastMeetings;

  /// No description provided for @getHelpTitle.
  ///
  /// In en, this message translates to:
  /// **'Get Help'**
  String get getHelpTitle;

  /// No description provided for @needHelpContact.
  ///
  /// In en, this message translates to:
  /// **'Need help? Contact us via:'**
  String get needHelpContact;

  /// No description provided for @call.
  ///
  /// In en, this message translates to:
  /// **'Call'**
  String get call;

  /// No description provided for @whatsapp.
  ///
  /// In en, this message translates to:
  /// **'WhatsApp'**
  String get whatsapp;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @faq.
  ///
  /// In en, this message translates to:
  /// **'FAQs'**
  String get faq;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @failedToOpenPhone.
  ///
  /// In en, this message translates to:
  /// **'Failed to open phone.'**
  String get failedToOpenPhone;

  /// No description provided for @failedToOpenWhatsApp.
  ///
  /// In en, this message translates to:
  /// **'WhatsApp is not available on your phone.'**
  String get failedToOpenWhatsApp;

  /// No description provided for @failedToOpenWhatsAppGeneric.
  ///
  /// In en, this message translates to:
  /// **'Failed to open WhatsApp.'**
  String get failedToOpenWhatsAppGeneric;

  /// No description provided for @failedToOpenEmail.
  ///
  /// In en, this message translates to:
  /// **'Failed to open email.'**
  String get failedToOpenEmail;

  /// No description provided for @constitutionAppTitle.
  ///
  /// In en, this message translates to:
  /// **'Constitution Information'**
  String get constitutionAppTitle;

  /// No description provided for @constitutionGroupType.
  ///
  /// In en, this message translates to:
  /// **'Group Type'**
  String get constitutionGroupType;

  /// No description provided for @kayaCmg.
  ///
  /// In en, this message translates to:
  /// **'Kaya CMG'**
  String get kayaCmg;

  /// No description provided for @kayaCmgHint.
  ///
  /// In en, this message translates to:
  /// **'We use mandatory savings and voluntary savings for lending'**
  String get kayaCmgHint;

  /// No description provided for @vsla.
  ///
  /// In en, this message translates to:
  /// **'VSLA'**
  String get vsla;

  /// No description provided for @vslaHint.
  ///
  /// In en, this message translates to:
  /// **'We use shares to save money and have 5 leaders'**
  String get vslaHint;

  /// No description provided for @shareSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Shares'**
  String get shareSubtitle;

  /// No description provided for @sharePrompt.
  ///
  /// In en, this message translates to:
  /// **'What is the value of one share in Shillings?'**
  String get sharePrompt;

  /// No description provided for @shareValueLabel.
  ///
  /// In en, this message translates to:
  /// **'Share Value'**
  String get shareValueLabel;

  /// No description provided for @shareValueHint.
  ///
  /// In en, this message translates to:
  /// **'Enter share value'**
  String get shareValueHint;

  /// No description provided for @shareValueRequired.
  ///
  /// In en, this message translates to:
  /// **'Share value is required'**
  String get shareValueRequired;

  /// No description provided for @invalidShareValue.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid amount'**
  String get invalidShareValue;

  /// No description provided for @groupLeadersSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Group Leaders'**
  String get groupLeadersSubtitle;

  /// No description provided for @editButton.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get editButton;

  /// No description provided for @selectAllLeadersError.
  ///
  /// In en, this message translates to:
  /// **'Please select all leaders'**
  String get selectAllLeadersError;

  /// No description provided for @positionLabel.
  ///
  /// In en, this message translates to:
  /// **'{position}'**
  String positionLabel(Object position);

  /// No description provided for @selectPositionHint.
  ///
  /// In en, this message translates to:
  /// **'Select {position}'**
  String selectPositionHint(Object position);

  /// No description provided for @positionRequired.
  ///
  /// In en, this message translates to:
  /// **'Please select {position}'**
  String positionRequired(Object position);

  /// No description provided for @jumlaYaHisa.
  ///
  /// In en, this message translates to:
  /// **'Total Shares'**
  String get jumlaYaHisa;

  /// No description provided for @mfukoWaJamiiSalio.
  ///
  /// In en, this message translates to:
  /// **'Community Fund Balance'**
  String get mfukoWaJamiiSalio;

  /// No description provided for @salioLililolalaSandukuni.
  ///
  /// In en, this message translates to:
  /// **'Box Balance'**
  String get salioLililolalaSandukuni;

  /// No description provided for @failedToLoadSummaryData.
  ///
  /// In en, this message translates to:
  /// **'Failed to load summary data. Please try again.'**
  String get failedToLoadSummaryData;

  /// No description provided for @jumlaYa.
  ///
  /// In en, this message translates to:
  /// **'Total of'**
  String get jumlaYa;

  /// No description provided for @wekaJumlaYa.
  ///
  /// In en, this message translates to:
  /// **'Enter total of'**
  String get wekaJumlaYa;

  /// No description provided for @tafadhaliJazaJumlaYa.
  ///
  /// In en, this message translates to:
  /// **'Please fill in total of'**
  String get tafadhaliJazaJumlaYa;

  /// No description provided for @tafadhaliIngizaNambariHalali.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid number.'**
  String get tafadhaliIngizaNambariHalali;

  /// No description provided for @jumlaLazimaIweIsiyoHasi.
  ///
  /// In en, this message translates to:
  /// **'Total must be non-negative.'**
  String get jumlaLazimaIweIsiyoHasi;

  /// No description provided for @loadingData.
  ///
  /// In en, this message translates to:
  /// **'Loading data...'**
  String get loadingData;

  /// No description provided for @taarifaKatikatiYaMzunguko.
  ///
  /// In en, this message translates to:
  /// **'Mid-Cycle Information'**
  String get taarifaKatikatiYaMzunguko;

  /// No description provided for @jumlaZaKikundi.
  ///
  /// In en, this message translates to:
  /// **'Group Totals'**
  String get jumlaZaKikundi;

  /// No description provided for @chairperson.
  ///
  /// In en, this message translates to:
  /// **'Chairperson'**
  String get chairperson;

  /// No description provided for @secretary.
  ///
  /// In en, this message translates to:
  /// **'Secretary'**
  String get secretary;

  /// No description provided for @treasurer.
  ///
  /// In en, this message translates to:
  /// **'Treasurer'**
  String get treasurer;

  /// No description provided for @counter1.
  ///
  /// In en, this message translates to:
  /// **'Counter number 1'**
  String get counter1;

  /// No description provided for @counter2.
  ///
  /// In en, this message translates to:
  /// **'Counter number 2'**
  String get counter2;

  /// No description provided for @finesTitle.
  ///
  /// In en, this message translates to:
  /// **'Constitution Information'**
  String get finesTitle;

  /// No description provided for @finesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Fines'**
  String get finesSubtitle;

  /// No description provided for @finesEmptyAmountNote.
  ///
  /// In en, this message translates to:
  /// **'Fines without an amount will not appear during the meeting'**
  String get finesEmptyAmountNote;

  /// No description provided for @enterFineType.
  ///
  /// In en, this message translates to:
  /// **'Enter type of fine'**
  String get enterFineType;

  /// No description provided for @enterAmount.
  ///
  /// In en, this message translates to:
  /// **'Enter amount'**
  String get enterAmount;

  /// No description provided for @phoneUseInMeeting.
  ///
  /// In en, this message translates to:
  /// **'Phone usage during the meeting'**
  String get phoneUseInMeeting;

  /// No description provided for @amountPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'amount'**
  String get amountPlaceholder;

  /// No description provided for @loanAmountTitle.
  ///
  /// In en, this message translates to:
  /// **'Constitution Information'**
  String get loanAmountTitle;

  /// No description provided for @loanAmountSubtitle.
  ///
  /// In en, this message translates to:
  /// **'How much a member can borrow'**
  String get loanAmountSubtitle;

  /// No description provided for @loanAmountVSLAPrompt.
  ///
  /// In en, this message translates to:
  /// **'How many times can a member borrow based on their current shares?'**
  String get loanAmountVSLAPrompt;

  /// No description provided for @loanAmountCMGPrompt.
  ///
  /// In en, this message translates to:
  /// **'How many times can a member borrow based on their current savings?'**
  String get loanAmountCMGPrompt;

  /// No description provided for @loanAmountVSLAHint.
  ///
  /// In en, this message translates to:
  /// **'Set according to their current shares'**
  String get loanAmountVSLAHint;

  /// No description provided for @loanAmountCMGHint.
  ///
  /// In en, this message translates to:
  /// **'Set according to their current savings'**
  String get loanAmountCMGHint;

  /// No description provided for @loanAmountRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid (numeric) value!'**
  String get loanAmountRequired;

  /// No description provided for @loanAmountInvalidNumber.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid number!'**
  String get loanAmountInvalidNumber;

  /// No description provided for @loanAmountMustBePositive.
  ///
  /// In en, this message translates to:
  /// **'The value must be greater than zero!'**
  String get loanAmountMustBePositive;

  /// No description provided for @loanAmountExample.
  ///
  /// In en, this message translates to:
  /// **'For example, a member can borrow  {amount} if they have {type} worth  10,000, which is {multiplier} times their {type}.'**
  String loanAmountExample(String amount, String type, String multiplier);

  /// No description provided for @interestDescription.
  ///
  /// In en, this message translates to:
  /// **'Describe how service charges apply to your loans'**
  String get interestDescription;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @selectFund.
  ///
  /// In en, this message translates to:
  /// **'Select Fund'**
  String get selectFund;

  /// No description provided for @fundWithoutName.
  ///
  /// In en, this message translates to:
  /// **'Fund Without Name'**
  String get fundWithoutName;

  /// No description provided for @addAnotherFund.
  ///
  /// In en, this message translates to:
  /// **'Add Another Fund'**
  String get addAnotherFund;

  /// No description provided for @communityFundInfo.
  ///
  /// In en, this message translates to:
  /// **'Community Fund Information'**
  String get communityFundInfo;

  /// No description provided for @fundName.
  ///
  /// In en, this message translates to:
  /// **'Fund Name'**
  String get fundName;

  /// No description provided for @enterFundName.
  ///
  /// In en, this message translates to:
  /// **'Enter Fund Name'**
  String get enterFundName;

  /// No description provided for @fundNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Fund name is required!'**
  String get fundNameRequired;

  /// No description provided for @contributionAmount.
  ///
  /// In en, this message translates to:
  /// **'Contribution Amount'**
  String get contributionAmount;

  /// No description provided for @enterContributionAmount.
  ///
  /// In en, this message translates to:
  /// **'Enter Contribution Amount'**
  String get enterContributionAmount;

  /// No description provided for @contributionAmountRequired.
  ///
  /// In en, this message translates to:
  /// **'Contribution amount is required!'**
  String get contributionAmountRequired;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @withdrawalReasons.
  ///
  /// In en, this message translates to:
  /// **'Withdrawal Reasons'**
  String get withdrawalReasons;

  /// No description provided for @noReasonsRecorded.
  ///
  /// In en, this message translates to:
  /// **'No reasons recorded'**
  String get noReasonsRecorded;

  /// No description provided for @equalAmount.
  ///
  /// In en, this message translates to:
  /// **'Equal amount'**
  String get equalAmount;

  /// No description provided for @anyAmount.
  ///
  /// In en, this message translates to:
  /// **'Any amount'**
  String get anyAmount;

  /// No description provided for @notWithdrawableMidCycle.
  ///
  /// In en, this message translates to:
  /// **'Not withdrawable mid-cycle'**
  String get notWithdrawableMidCycle;

  /// No description provided for @withdrawByMemberName.
  ///
  /// In en, this message translates to:
  /// **'Withdraw by member\'s name'**
  String get withdrawByMemberName;

  /// No description provided for @withdrawAsGroup.
  ///
  /// In en, this message translates to:
  /// **'Withdraw as a group'**
  String get withdrawAsGroup;

  /// No description provided for @select.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get select;

  /// No description provided for @education.
  ///
  /// In en, this message translates to:
  /// **'Education'**
  String get education;

  /// No description provided for @agriculture.
  ///
  /// In en, this message translates to:
  /// **'Agriculture'**
  String get agriculture;

  /// No description provided for @communityProject.
  ///
  /// In en, this message translates to:
  /// **'Community Project'**
  String get communityProject;

  /// No description provided for @cocoa.
  ///
  /// In en, this message translates to:
  /// **'Cocoa'**
  String get cocoa;

  /// No description provided for @otherGoals.
  ///
  /// In en, this message translates to:
  /// **'Other Goals'**
  String get otherGoals;

  /// No description provided for @pleaseSelectContributionProcedure.
  ///
  /// In en, this message translates to:
  /// **'Please select Contribution Procedure'**
  String get pleaseSelectContributionProcedure;

  /// No description provided for @pleaseSelectWithdrawalProcedure.
  ///
  /// In en, this message translates to:
  /// **'Please select Withdrawal Procedures'**
  String get pleaseSelectWithdrawalProcedure;

  /// No description provided for @dataUpdatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Data successfully updated!'**
  String get dataUpdatedSuccessfully;

  /// No description provided for @errorSavingDataGeneric.
  ///
  /// In en, this message translates to:
  /// **'There was an error saving data. Please try again.'**
  String get errorSavingDataGeneric;

  /// No description provided for @fundInformation.
  ///
  /// In en, this message translates to:
  /// **'Fund Information'**
  String get fundInformation;

  /// No description provided for @fundProcedures.
  ///
  /// In en, this message translates to:
  /// **'Fund Procedures'**
  String get fundProcedures;

  /// No description provided for @pleaseEnterFundName.
  ///
  /// In en, this message translates to:
  /// **'Please enter the Fund Name'**
  String get pleaseEnterFundName;

  /// No description provided for @fundGoals.
  ///
  /// In en, this message translates to:
  /// **'Fund Goals'**
  String get fundGoals;

  /// No description provided for @pleaseSelectFundGoal.
  ///
  /// In en, this message translates to:
  /// **'Please select a Fund Goal'**
  String get pleaseSelectFundGoal;

  /// No description provided for @enterOtherGoals.
  ///
  /// In en, this message translates to:
  /// **'Enter Other Goals'**
  String get enterOtherGoals;

  /// No description provided for @pleaseEnterOtherGoals.
  ///
  /// In en, this message translates to:
  /// **'Please enter Other Goals'**
  String get pleaseEnterOtherGoals;

  /// No description provided for @contributionProcedure.
  ///
  /// In en, this message translates to:
  /// **'Contribution Procedure'**
  String get contributionProcedure;

  /// No description provided for @pleaseEnterContributionAmount.
  ///
  /// In en, this message translates to:
  /// **'Please enter Contribution Amount'**
  String get pleaseEnterContributionAmount;

  /// No description provided for @loanable.
  ///
  /// In en, this message translates to:
  /// **'Loanable'**
  String get loanable;

  /// No description provided for @withdrawalProcedures.
  ///
  /// In en, this message translates to:
  /// **'Withdrawal Procedures'**
  String get withdrawalProcedures;

  /// No description provided for @fundProcedure.
  ///
  /// In en, this message translates to:
  /// **'Fund Procedure'**
  String get fundProcedure;

  /// No description provided for @withdrawalProcedure.
  ///
  /// In en, this message translates to:
  /// **'Withdrawal Procedure'**
  String get withdrawalProcedure;

  /// No description provided for @notWithdrawableDuringCycle.
  ///
  /// In en, this message translates to:
  /// **'Not withdrawable during the cycle'**
  String get notWithdrawableDuringCycle;

  /// No description provided for @selectOption.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get selectOption;

  /// No description provided for @fundSummarySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Fund Summary'**
  String get fundSummarySubtitle;

  /// No description provided for @withdrawalType.
  ///
  /// In en, this message translates to:
  /// **'Type of Contribution'**
  String get withdrawalType;

  /// No description provided for @deleteFundTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Fund?'**
  String get deleteFundTitle;

  /// No description provided for @thisFund.
  ///
  /// In en, this message translates to:
  /// **'This fund'**
  String get thisFund;

  /// No description provided for @deleteFundWarning.
  ///
  /// In en, this message translates to:
  /// **'This action cannot be undone.'**
  String get deleteFundWarning;

  /// No description provided for @setPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Set password for {step}'**
  String setPasswordTitle(Object step);

  /// No description provided for @allPasswordsSetTitle.
  ///
  /// In en, this message translates to:
  /// **'All Passwords Set'**
  String get allPasswordsSetTitle;

  /// No description provided for @backupCompleted.
  ///
  /// In en, this message translates to:
  /// **'Backup completed successfully!'**
  String get backupCompleted;

  /// No description provided for @uhifadhiKumbukumbu.
  ///
  /// In en, this message translates to:
  /// **'Data Backup'**
  String get uhifadhiKumbukumbu;

  /// No description provided for @tumaTaarifa.
  ///
  /// In en, this message translates to:
  /// **'Send Information'**
  String get tumaTaarifa;

  /// No description provided for @chaguaMahaliNaHifadhi.
  ///
  /// In en, this message translates to:
  /// **'Choose Location and Save'**
  String get chaguaMahaliNaHifadhi;

  /// No description provided for @hifadhiNakala.
  ///
  /// In en, this message translates to:
  /// **'Save Copy'**
  String get hifadhiNakala;

  /// No description provided for @hifadhiNakalaRafiki.
  ///
  /// In en, this message translates to:
  /// **'Send Backup to a Friend'**
  String get hifadhiNakalaRafiki;

  /// No description provided for @hifadhiNakalaRafikiDescription.
  ///
  /// In en, this message translates to:
  /// **'Send a copy of Chomoka data to your friend for better security.'**
  String get hifadhiNakalaRafikiDescription;

  /// No description provided for @uhifadhiKumbukumbuDescription.
  ///
  /// In en, this message translates to:
  /// **'Back up your Chomoka data to a ZIP file. You can restore this data anytime.'**
  String get uhifadhiKumbukumbuDescription;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @errorSharingBackup.
  ///
  /// In en, this message translates to:
  /// **'Error sharing backup: {error}'**
  String errorSharingBackup(Object error);

  /// No description provided for @uwekaji_taarifa_katikati_mzunguko.
  ///
  /// In en, this message translates to:
  /// **'Mid-Cycle Information Entry'**
  String get uwekaji_taarifa_katikati_mzunguko;

  /// No description provided for @loading_group_data.
  ///
  /// In en, this message translates to:
  /// **'Loading group data...'**
  String get loading_group_data;

  /// No description provided for @kikundi_mzunguko.
  ///
  /// In en, this message translates to:
  /// **'What cycle is the group in?'**
  String get kikundi_mzunguko;

  /// No description provided for @taarifa_zimehifadhiwa.
  ///
  /// In en, this message translates to:
  /// **'Data saved successfully!'**
  String get taarifa_zimehifadhiwa;

  /// No description provided for @imeshindwa_kuhifadhi.
  ///
  /// In en, this message translates to:
  /// **'Failed to save data: {error}'**
  String imeshindwa_kuhifadhi(Object error);

  /// No description provided for @thibitisha_ingizo.
  ///
  /// In en, this message translates to:
  /// **'Input validation failed.'**
  String get thibitisha_ingizo;

  /// No description provided for @namba_kikao.
  ///
  /// In en, this message translates to:
  /// **'Session Number'**
  String get namba_kikao;

  /// No description provided for @ingiza_namba_kikao.
  ///
  /// In en, this message translates to:
  /// **'Enter session number'**
  String get ingiza_namba_kikao;

  /// No description provided for @namba_kikao_inahitajika.
  ///
  /// In en, this message translates to:
  /// **'Session number is required'**
  String get namba_kikao_inahitajika;

  /// No description provided for @namba_kikao_halali.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid session number'**
  String get namba_kikao_halali;

  /// No description provided for @endelea.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get endelea;

  /// No description provided for @taarifa_kikao_kilichopita.
  ///
  /// In en, this message translates to:
  /// **'Previous Session Information'**
  String get taarifa_kikao_kilichopita;

  /// No description provided for @hisa_wanachama.
  ///
  /// In en, this message translates to:
  /// **'Members\' Shares'**
  String get hisa_wanachama;

  /// No description provided for @muhtasari_kikao.
  ///
  /// In en, this message translates to:
  /// **'Session Summary'**
  String get muhtasari_kikao;

  /// No description provided for @jumla_kikundi.
  ///
  /// In en, this message translates to:
  /// **'Group Total'**
  String get jumla_kikundi;

  /// No description provided for @akiba_wanachama.
  ///
  /// In en, this message translates to:
  /// **'Members\' Savings'**
  String get akiba_wanachama;

  /// No description provided for @akiba_binafsi.
  ///
  /// In en, this message translates to:
  /// **'Personal Savings'**
  String get akiba_binafsi;

  /// No description provided for @wadaiwa_mikopo.
  ///
  /// In en, this message translates to:
  /// **'Loan Debtors'**
  String get wadaiwa_mikopo;

  /// No description provided for @mchango_haujalipwa.
  ///
  /// In en, this message translates to:
  /// **'Unpaid Contributions'**
  String get mchango_haujalipwa;

  /// No description provided for @jumla_hisa.
  ///
  /// In en, this message translates to:
  /// **'Total Shares'**
  String get jumla_hisa;

  /// No description provided for @jumla_akiba.
  ///
  /// In en, this message translates to:
  /// **'Total Savings'**
  String get jumla_akiba;

  /// No description provided for @jumla_mikopo.
  ///
  /// In en, this message translates to:
  /// **'Total Loans'**
  String get jumla_mikopo;

  /// No description provided for @jumla_riba.
  ///
  /// In en, this message translates to:
  /// **'Total Interest'**
  String get jumla_riba;

  /// No description provided for @jumla_adhabu.
  ///
  /// In en, this message translates to:
  /// **'Total Fines'**
  String get jumla_adhabu;

  /// No description provided for @jumla_mfuko_jamii.
  ///
  /// In en, this message translates to:
  /// **'Total Community Fund'**
  String get jumla_mfuko_jamii;

  /// No description provided for @chaguaNjiaUhifadhi.
  ///
  /// In en, this message translates to:
  /// **'Select Backup Method'**
  String get chaguaNjiaUhifadhi;

  /// No description provided for @taarifaZimehifadhiwa.
  ///
  /// In en, this message translates to:
  /// **'Information saved successfully!'**
  String get taarifaZimehifadhiwa;

  /// No description provided for @sawa.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get sawa;

  /// No description provided for @uhifadhiProgress.
  ///
  /// In en, this message translates to:
  /// **'Backup Progress: {progress}%'**
  String uhifadhiProgress(Object progress);

  /// No description provided for @midCycleMeetingInfo.
  ///
  /// In en, this message translates to:
  /// **'Mid-Cycle Meeting Info'**
  String get midCycleMeetingInfo;

  /// No description provided for @groupTotals.
  ///
  /// In en, this message translates to:
  /// **'Group Totals'**
  String get groupTotals;

  /// No description provided for @groupTotalsSummary.
  ///
  /// In en, this message translates to:
  /// **'Group Totals Summary'**
  String get groupTotalsSummary;

  /// No description provided for @enterTotalShares.
  ///
  /// In en, this message translates to:
  /// **'Enter total shares'**
  String get enterTotalShares;

  /// No description provided for @pleaseEnterTotalShares.
  ///
  /// In en, this message translates to:
  /// **'Please enter total shares'**
  String get pleaseEnterTotalShares;

  /// No description provided for @shareValue.
  ///
  /// In en, this message translates to:
  /// **'Share Value:'**
  String get shareValue;

  /// No description provided for @enterShareValue.
  ///
  /// In en, this message translates to:
  /// **'Enter share value'**
  String get enterShareValue;

  /// No description provided for @pleaseEnterShareValue.
  ///
  /// In en, this message translates to:
  /// **'Please enter share value'**
  String get pleaseEnterShareValue;

  /// No description provided for @enterTotalSavings.
  ///
  /// In en, this message translates to:
  /// **'Enter total savings'**
  String get enterTotalSavings;

  /// No description provided for @pleaseEnterTotalSavings.
  ///
  /// In en, this message translates to:
  /// **'Please enter total savings'**
  String get pleaseEnterTotalSavings;

  /// No description provided for @enterCommunityFundBalance.
  ///
  /// In en, this message translates to:
  /// **'Enter community fund balance'**
  String get enterCommunityFundBalance;

  /// No description provided for @pleaseEnterCommunityFundBalance.
  ///
  /// In en, this message translates to:
  /// **'Please enter community fund balance'**
  String get pleaseEnterCommunityFundBalance;

  /// No description provided for @pleaseEnterValidPositiveNumber.
  ///
  /// In en, this message translates to:
  /// **'The value must be a positive number'**
  String get pleaseEnterValidPositiveNumber;

  /// No description provided for @memberShares.
  ///
  /// In en, this message translates to:
  /// **'Member Shares'**
  String get memberShares;

  /// No description provided for @unpaidContributions.
  ///
  /// In en, this message translates to:
  /// **'Unpaid Contributions'**
  String get unpaidContributions;

  /// No description provided for @memberContributions.
  ///
  /// In en, this message translates to:
  /// **'Member\'s Contributions'**
  String get memberContributions;

  /// No description provided for @fineOwed.
  ///
  /// In en, this message translates to:
  /// **'Fines Owed'**
  String get fineOwed;

  /// No description provided for @enterFineOwed.
  ///
  /// In en, this message translates to:
  /// **'Enter fines owed'**
  String get enterFineOwed;

  /// No description provided for @pleaseEnterFineOwed.
  ///
  /// In en, this message translates to:
  /// **'Please enter fines owed'**
  String get pleaseEnterFineOwed;

  /// No description provided for @communityFundOwed.
  ///
  /// In en, this message translates to:
  /// **'Community Fund Owed'**
  String get communityFundOwed;

  /// No description provided for @enterCommunityFundOwed.
  ///
  /// In en, this message translates to:
  /// **'Enter community fund amount owed'**
  String get enterCommunityFundOwed;

  /// No description provided for @pleaseEnterCommunityFundOwed.
  ///
  /// In en, this message translates to:
  /// **'Please enter the community fund amount owed'**
  String get pleaseEnterCommunityFundOwed;

  /// No description provided for @loanInformation.
  ///
  /// In en, this message translates to:
  /// **'Loan Information'**
  String get loanInformation;

  /// No description provided for @memberLoanInfo.
  ///
  /// In en, this message translates to:
  /// **'Member Loan Info'**
  String get memberLoanInfo;

  /// No description provided for @selectReason.
  ///
  /// In en, this message translates to:
  /// **'Select Reason'**
  String get selectReason;

  /// No description provided for @reasonForLoan.
  ///
  /// In en, this message translates to:
  /// **'Loan Reason'**
  String get reasonForLoan;

  /// No description provided for @pleaseSelectReason.
  ///
  /// In en, this message translates to:
  /// **'Please select a reason'**
  String get pleaseSelectReason;

  /// No description provided for @houseRenovation.
  ///
  /// In en, this message translates to:
  /// **'House Renovation'**
  String get houseRenovation;

  /// No description provided for @business.
  ///
  /// In en, this message translates to:
  /// **'Business'**
  String get business;

  /// No description provided for @enterOtherReason.
  ///
  /// In en, this message translates to:
  /// **'Enter Other Reason'**
  String get enterOtherReason;

  /// No description provided for @otherReason.
  ///
  /// In en, this message translates to:
  /// **'Other Reason'**
  String get otherReason;

  /// No description provided for @pleaseEnterOtherReason.
  ///
  /// In en, this message translates to:
  /// **'Please enter the other reason'**
  String get pleaseEnterOtherReason;

  /// No description provided for @loanAmount.
  ///
  /// In en, this message translates to:
  /// **'Loan Amount'**
  String get loanAmount;

  /// No description provided for @enterLoanAmount.
  ///
  /// In en, this message translates to:
  /// **'Enter loan amount'**
  String get enterLoanAmount;

  /// No description provided for @pleaseEnterLoanAmount.
  ///
  /// In en, this message translates to:
  /// **'Please enter the loan amount'**
  String get pleaseEnterLoanAmount;

  /// No description provided for @pleaseEnterValidAmount.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid amount'**
  String get pleaseEnterValidAmount;

  /// No description provided for @amountPaid.
  ///
  /// In en, this message translates to:
  /// **'Amount Paid:'**
  String get amountPaid;

  /// No description provided for @enterAmountPaid.
  ///
  /// In en, this message translates to:
  /// **'Enter amount paid'**
  String get enterAmountPaid;

  /// No description provided for @pleaseEnterAmountPaid.
  ///
  /// In en, this message translates to:
  /// **'Please enter amount paid'**
  String get pleaseEnterAmountPaid;

  /// No description provided for @outstandingBalance.
  ///
  /// In en, this message translates to:
  /// **'Outstanding Balance'**
  String get outstandingBalance;

  /// No description provided for @calculatedAutomatically.
  ///
  /// In en, this message translates to:
  /// **'Calculated automatically'**
  String get calculatedAutomatically;

  /// No description provided for @pleaseEnterOutstandingAmount.
  ///
  /// In en, this message translates to:
  /// **'Please enter the outstanding balance'**
  String get pleaseEnterOutstandingAmount;

  /// No description provided for @loanMeeting.
  ///
  /// In en, this message translates to:
  /// **'Loan Meeting'**
  String get loanMeeting;

  /// No description provided for @enterLoanMeeting.
  ///
  /// In en, this message translates to:
  /// **'Enter loan meeting number'**
  String get enterLoanMeeting;

  /// No description provided for @pleaseEnterLoanMeeting.
  ///
  /// In en, this message translates to:
  /// **'Please enter loan meeting number'**
  String get pleaseEnterLoanMeeting;

  /// No description provided for @loanDuration.
  ///
  /// In en, this message translates to:
  /// **'Loan Duration (Months)'**
  String get loanDuration;

  /// No description provided for @enterLoanDuration.
  ///
  /// In en, this message translates to:
  /// **'Enter duration in months'**
  String get enterLoanDuration;

  /// No description provided for @pleaseEnterLoanDuration.
  ///
  /// In en, this message translates to:
  /// **'Please enter the loan duration'**
  String get pleaseEnterLoanDuration;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @noMembersFound.
  ///
  /// In en, this message translates to:
  /// **'No members found.'**
  String get noMembersFound;

  /// No description provided for @searchByNameOrPhone.
  ///
  /// In en, this message translates to:
  /// **'Search by name or phone'**
  String get searchByNameOrPhone;

  /// No description provided for @memberList.
  ///
  /// In en, this message translates to:
  /// **'Member List'**
  String get memberList;

  /// No description provided for @validate.
  ///
  /// In en, this message translates to:
  /// **'Validate'**
  String get validate;

  /// No description provided for @dataValidationFailed.
  ///
  /// In en, this message translates to:
  /// **'Data validation failed.'**
  String get dataValidationFailed;

  /// No description provided for @shareInformation.
  ///
  /// In en, this message translates to:
  /// **'Share Information'**
  String get shareInformation;

  /// No description provided for @saveShares.
  ///
  /// In en, this message translates to:
  /// **'Save Shares'**
  String get saveShares;

  /// No description provided for @shares.
  ///
  /// In en, this message translates to:
  /// **'Shares'**
  String get shares;

  /// No description provided for @enterShares.
  ///
  /// In en, this message translates to:
  /// **'Enter number of shares'**
  String get enterShares;

  /// No description provided for @loanSummary.
  ///
  /// In en, this message translates to:
  /// **'Loan Summary'**
  String get loanSummary;

  /// No description provided for @memberLoanSummary.
  ///
  /// In en, this message translates to:
  /// **'Member Loan Summary'**
  String get memberLoanSummary;

  /// No description provided for @loanDetails.
  ///
  /// In en, this message translates to:
  /// **'LOAN DETAILS'**
  String get loanDetails;

  /// No description provided for @vslaMemberShares.
  ///
  /// In en, this message translates to:
  /// **'Member Shares'**
  String get vslaMemberShares;

  /// No description provided for @vslaShareInformation.
  ///
  /// In en, this message translates to:
  /// **'Share Information'**
  String get vslaShareInformation;

  /// No description provided for @vslaShareValue.
  ///
  /// In en, this message translates to:
  /// **'Share Value'**
  String get vslaShareValue;

  /// No description provided for @vslaTotalShares.
  ///
  /// In en, this message translates to:
  /// **'Total Shares'**
  String get vslaTotalShares;

  /// No description provided for @vslaShareValuePerShare.
  ///
  /// In en, this message translates to:
  /// **'Value per Share'**
  String get vslaShareValuePerShare;

  /// No description provided for @vslaEnterShareCount.
  ///
  /// In en, this message translates to:
  /// **'Enter number of shares'**
  String get vslaEnterShareCount;

  /// No description provided for @vslaShareCountRequired.
  ///
  /// In en, this message translates to:
  /// **'Number of shares is required'**
  String get vslaShareCountRequired;

  /// No description provided for @vslaEnterValidShareCount.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid number of shares'**
  String get vslaEnterValidShareCount;

  /// No description provided for @vslaSaveShares.
  ///
  /// In en, this message translates to:
  /// **'Save Shares'**
  String get vslaSaveShares;

  /// No description provided for @vslaSharesSavedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Member shares saved successfully!'**
  String get vslaSharesSavedSuccessfully;

  /// No description provided for @vslaTotalSharesMustMatch.
  ///
  /// In en, this message translates to:
  /// **'Total shares must be {total}. Currently {current}. Please adjust.'**
  String vslaTotalSharesMustMatch(String total, String current);

  /// No description provided for @vslaGroupTotals.
  ///
  /// In en, this message translates to:
  /// **'Group Totals'**
  String get vslaGroupTotals;

  /// No description provided for @vslaGroupTotalsSummary.
  ///
  /// In en, this message translates to:
  /// **'Group Totals Summary'**
  String get vslaGroupTotalsSummary;

  /// No description provided for @vslaCommunityFundBalance.
  ///
  /// In en, this message translates to:
  /// **'Community Fund Balance'**
  String get vslaCommunityFundBalance;

  /// No description provided for @vslaBoxBalance.
  ///
  /// In en, this message translates to:
  /// **'Box Balance'**
  String get vslaBoxBalance;

  /// No description provided for @vslaCurrentLoanBalance.
  ///
  /// In en, this message translates to:
  /// **'Current Loan Balance'**
  String get vslaCurrentLoanBalance;

  /// No description provided for @vslaMembers.
  ///
  /// In en, this message translates to:
  /// **'Members'**
  String get vslaMembers;

  /// No description provided for @vslaUnpaidContributions.
  ///
  /// In en, this message translates to:
  /// **'Unpaid Contributions'**
  String get vslaUnpaidContributions;

  /// No description provided for @vslaTotalFinesOwed.
  ///
  /// In en, this message translates to:
  /// **'Total Fines Owed'**
  String get vslaTotalFinesOwed;

  /// No description provided for @vslaEnterTotalShares.
  ///
  /// In en, this message translates to:
  /// **'Enter Total Shares'**
  String get vslaEnterTotalShares;

  /// No description provided for @vslaEnterCommunityFundBalance.
  ///
  /// In en, this message translates to:
  /// **'Enter Community Fund Balance'**
  String get vslaEnterCommunityFundBalance;

  /// No description provided for @vslaEnterBoxBalance.
  ///
  /// In en, this message translates to:
  /// **'Enter Box Balance'**
  String get vslaEnterBoxBalance;

  /// No description provided for @vslaPleaseEnterTotalShares.
  ///
  /// In en, this message translates to:
  /// **'Please enter total shares'**
  String get vslaPleaseEnterTotalShares;

  /// No description provided for @vslaPleaseEnterCommunityFundBalance.
  ///
  /// In en, this message translates to:
  /// **'Please enter community fund balance'**
  String get vslaPleaseEnterCommunityFundBalance;

  /// No description provided for @vslaPleaseEnterBoxBalance.
  ///
  /// In en, this message translates to:
  /// **'Please enter box balance'**
  String get vslaPleaseEnterBoxBalance;

  /// No description provided for @vslaPleaseEnterValidPositiveNumber.
  ///
  /// In en, this message translates to:
  /// **'Value must be a positive number'**
  String get vslaPleaseEnterValidPositiveNumber;

  /// No description provided for @vslaMidCycleInformation.
  ///
  /// In en, this message translates to:
  /// **'Mid-Cycle Information'**
  String get vslaMidCycleInformation;

  /// No description provided for @vslaMemberShareTitle.
  ///
  /// In en, this message translates to:
  /// **'Member Shares'**
  String get vslaMemberShareTitle;

  /// No description provided for @vslaMemberShareSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter member share information'**
  String get vslaMemberShareSubtitle;

  /// No description provided for @vslaMemberNumber.
  ///
  /// In en, this message translates to:
  /// **'Member Number'**
  String get vslaMemberNumber;

  /// No description provided for @vslaShareCount.
  ///
  /// In en, this message translates to:
  /// **'Share Count'**
  String get vslaShareCount;

  /// No description provided for @vslaNoMembersFound.
  ///
  /// In en, this message translates to:
  /// **'No members found'**
  String get vslaNoMembersFound;

  /// No description provided for @vslaErrorLoadingData.
  ///
  /// In en, this message translates to:
  /// **'Error loading data. Please try again.'**
  String get vslaErrorLoadingData;

  /// No description provided for @vslaErrorSavingData.
  ///
  /// In en, this message translates to:
  /// **'Error saving data: {error}'**
  String vslaErrorSavingData(String error);

  /// No description provided for @uwekajiTaarifaKatikaMzunguko.
  ///
  /// In en, this message translates to:
  /// **'Mid-Cycle Data Entry'**
  String get uwekajiTaarifaKatikaMzunguko;

  /// No description provided for @jumlaYaKikundi.
  ///
  /// In en, this message translates to:
  /// **'Group Total'**
  String get jumlaYaKikundi;

  /// No description provided for @hisaZaWanachama.
  ///
  /// In en, this message translates to:
  /// **'Member Shares'**
  String get hisaZaWanachama;

  /// No description provided for @taarifaZaKikundi.
  ///
  /// In en, this message translates to:
  /// **'Group Information'**
  String get taarifaZaKikundi;

  /// No description provided for @jumlaYaTaarifaZaKikundi.
  ///
  /// In en, this message translates to:
  /// **'Total Group Information'**
  String get jumlaYaTaarifaZaKikundi;

  /// No description provided for @inapakiaTaarifa.
  ///
  /// In en, this message translates to:
  /// **'Loading information...'**
  String get inapakiaTaarifa;

  /// No description provided for @hakunaTaarifaZilizopo.
  ///
  /// In en, this message translates to:
  /// **'No data available at the moment.'**
  String get hakunaTaarifaZilizopo;

  /// No description provided for @taarifaZaHisa.
  ///
  /// In en, this message translates to:
  /// **'Share Information'**
  String get taarifaZaHisa;

  /// No description provided for @thamaniYaHisaMoja.
  ///
  /// In en, this message translates to:
  /// **'Value per Share'**
  String get thamaniYaHisaMoja;

  /// No description provided for @wekaMfukoWaJamiiSalio.
  ///
  /// In en, this message translates to:
  /// **'Set Community Fund Balance'**
  String get wekaMfukoWaJamiiSalio;

  /// No description provided for @tafadhaliJazaMfukoWaJamiiSalio.
  ///
  /// In en, this message translates to:
  /// **'Please fill in the Community Fund Balance.'**
  String get tafadhaliJazaMfukoWaJamiiSalio;

  /// No description provided for @wekaSalioLililolalaSandukuni.
  ///
  /// In en, this message translates to:
  /// **'Set Box Balance'**
  String get wekaSalioLililolalaSandukuni;

  /// No description provided for @tafadhaliJazaSalioLililolalaSandukuni.
  ///
  /// In en, this message translates to:
  /// **'Please fill in the Box Balance.'**
  String get tafadhaliJazaSalioLililolalaSandukuni;

  /// No description provided for @salioLazimaIweIsiyoHasi.
  ///
  /// In en, this message translates to:
  /// **'Balance must be non-negative.'**
  String get salioLazimaIweIsiyoHasi;

  /// No description provided for @jumlaYaThamaniYaHisa.
  ///
  /// In en, this message translates to:
  /// **'Total Share Value'**
  String get jumlaYaThamaniYaHisa;

  /// No description provided for @tafadhaliJazaJumlaYaHisa.
  ///
  /// In en, this message translates to:
  /// **'Please fill in total shares.'**
  String get tafadhaliJazaJumlaYaHisa;

  /// No description provided for @salioLililolalaSandukuniError.
  ///
  /// In en, this message translates to:
  /// **'Box Balance must be greater than the total of Shares and Community Fund.'**
  String get salioLililolalaSandukuniError;

  /// No description provided for @jumlaYaHisaZote.
  ///
  /// In en, this message translates to:
  /// **'Total Number of Shares'**
  String get jumlaYaHisaZote;

  /// No description provided for @mchangoHaujalipwa.
  ///
  /// In en, this message translates to:
  /// **'Unpaid Contribution'**
  String get mchangoHaujalipwa;

  /// No description provided for @wadaiwaMikopo.
  ///
  /// In en, this message translates to:
  /// **'Group Loan Debtors'**
  String get wadaiwaMikopo;

  /// No description provided for @muhtasari.
  ///
  /// In en, this message translates to:
  /// **'Summary'**
  String get muhtasari;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'pending'**
  String get pending;

  /// No description provided for @uhifadhiKumbukumbuTitle.
  ///
  /// In en, this message translates to:
  /// **'Data Backup'**
  String get uhifadhiKumbukumbuTitle;

  /// No description provided for @utunzajiKumbukumbuSmsTab.
  ///
  /// In en, this message translates to:
  /// **'Backup via SMS'**
  String get utunzajiKumbukumbuSmsTab;

  /// No description provided for @kanzidataUhifadhiTab.
  ///
  /// In en, this message translates to:
  /// **'Database Backup'**
  String get kanzidataUhifadhiTab;

  /// No description provided for @tumaTaarifaButton.
  ///
  /// In en, this message translates to:
  /// **'Send Data'**
  String get tumaTaarifaButton;

  /// No description provided for @uhifadhiKumbukumbuCardTitle.
  ///
  /// In en, this message translates to:
  /// **'Database Backup'**
  String get uhifadhiKumbukumbuCardTitle;

  /// No description provided for @uhifadhiKumbukumbuCardDesc.
  ///
  /// In en, this message translates to:
  /// **'Save a backup copy of your Chomoka data to a SQL file. You can restore this data anytime.'**
  String get uhifadhiKumbukumbuCardDesc;

  /// No description provided for @chaguaMahaliNaHifadhiButton.
  ///
  /// In en, this message translates to:
  /// **'Choose Location and Save'**
  String get chaguaMahaliNaHifadhiButton;

  /// No description provided for @sqlDumpSaved.
  ///
  /// In en, this message translates to:
  /// **'SQL dump saved at: {filePath}'**
  String sqlDumpSaved(String filePath);

  /// No description provided for @errorWithMessage.
  ///
  /// In en, this message translates to:
  /// **'Error: {message}'**
  String errorWithMessage(String message);

  /// No description provided for @hifadhiNakalaRafikiCardTitle.
  ///
  /// In en, this message translates to:
  /// **'Share Data with a Friend'**
  String get hifadhiNakalaRafikiCardTitle;

  /// No description provided for @hifadhiNakalaRafikiCardDesc.
  ///
  /// In en, this message translates to:
  /// **'Securely send a copy of your Chomoka data to your friend.'**
  String get hifadhiNakalaRafikiCardDesc;

  /// No description provided for @hifadhiNakalaButton.
  ///
  /// In en, this message translates to:
  /// **'Share Data'**
  String get hifadhiNakalaButton;

  /// No description provided for @loanInterest.
  ///
  /// In en, this message translates to:
  /// **'Loan interest:'**
  String get loanInterest;

  /// No description provided for @interestType.
  ///
  /// In en, this message translates to:
  /// **'Interest Type'**
  String get interestType;

  /// No description provided for @monthlyCalculation.
  ///
  /// In en, this message translates to:
  /// **'Monthly calculation'**
  String get monthlyCalculation;

  /// No description provided for @equalAmountAllMonths.
  ///
  /// In en, this message translates to:
  /// **'Equal amount all months'**
  String get equalAmountAllMonths;

  /// No description provided for @enterInterestRate.
  ///
  /// In en, this message translates to:
  /// **'Enter interest rate'**
  String get enterInterestRate;

  /// No description provided for @loanInterestExample.
  ///
  /// In en, this message translates to:
  /// **'For example, if a member borrows 10,000 they will pay {rate}% of the remaining loan balance every month. If they repay the loan early, they will avoid paying interest.'**
  String loanInterestExample(Object rate);

  /// No description provided for @loanInterestExampleEqual.
  ///
  /// In en, this message translates to:
  /// **'For example, if a member borrows 10,000 they will pay {amount}% of the actual loan amount. They will pay {rate} every month.'**
  String loanInterestExampleEqual(Object amount, Object rate);

  /// No description provided for @loanInterestExampleOnce.
  ///
  /// In en, this message translates to:
  /// **'For example, if a member borrows 10,000 they will repay with an interest of {amount}% of the actual loan amount. They will pay {rate} as interest when repaying the loan.'**
  String loanInterestExampleOnce(Object amount, Object rate);

  /// No description provided for @constitutionTitle.
  ///
  /// In en, this message translates to:
  /// **'Constitution'**
  String get constitutionTitle;

  /// No description provided for @membershipRules.
  ///
  /// In en, this message translates to:
  /// **'Membership Rules'**
  String get membershipRules;

  /// No description provided for @method.
  ///
  /// In en, this message translates to:
  /// **'Method:'**
  String get method;

  /// No description provided for @savings.
  ///
  /// In en, this message translates to:
  /// **'Savings'**
  String get savings;

  /// No description provided for @mandatorySavingsValue.
  ///
  /// In en, this message translates to:
  /// **'Value of mandatory savings:'**
  String get mandatorySavingsValue;

  /// No description provided for @groupLeaders.
  ///
  /// In en, this message translates to:
  /// **'Group Leaders'**
  String get groupLeaders;

  /// No description provided for @cashCounter1.
  ///
  /// In en, this message translates to:
  /// **'Cash Counter No. 1:'**
  String get cashCounter1;

  /// No description provided for @cashCounter2.
  ///
  /// In en, this message translates to:
  /// **'Cash Counter No. 2:'**
  String get cashCounter2;

  /// No description provided for @auditor.
  ///
  /// In en, this message translates to:
  /// **'Auditor:'**
  String get auditor;

  /// No description provided for @contributions.
  ///
  /// In en, this message translates to:
  /// **'Contributions'**
  String get contributions;

  /// No description provided for @communityFundAmount.
  ///
  /// In en, this message translates to:
  /// **'Community Fund Amount:'**
  String get communityFundAmount;

  /// No description provided for @otherFunds.
  ///
  /// In en, this message translates to:
  /// **'Other Funds'**
  String get otherFunds;

  /// No description provided for @noFines.
  ///
  /// In en, this message translates to:
  /// **'No fines recorded for this member.'**
  String get noFines;

  /// No description provided for @loan.
  ///
  /// In en, this message translates to:
  /// **'Loan'**
  String get loan;

  /// No description provided for @loanMultiplier.
  ///
  /// In en, this message translates to:
  /// **'A member is allowed to borrow how many times their shares:'**
  String get loanMultiplier;

  /// No description provided for @loanInterestType.
  ///
  /// In en, this message translates to:
  /// **'Loan interest calculation:'**
  String get loanInterestType;

  /// No description provided for @guarantorCount.
  ///
  /// In en, this message translates to:
  /// **'Number of guarantors'**
  String get guarantorCount;

  /// No description provided for @penaltyCalculation.
  ///
  /// In en, this message translates to:
  /// **'Penalty calculation for late loan:'**
  String get penaltyCalculation;

  /// No description provided for @lateLoanPenalty.
  ///
  /// In en, this message translates to:
  /// **'Late loan penalty:'**
  String get lateLoanPenalty;

  /// No description provided for @fundInfoTitle.
  ///
  /// In en, this message translates to:
  /// **'Fund Information'**
  String get fundInfoTitle;

  /// No description provided for @illness.
  ///
  /// In en, this message translates to:
  /// **'Illness'**
  String get illness;

  /// No description provided for @death.
  ///
  /// In en, this message translates to:
  /// **'Death'**
  String get death;

  /// No description provided for @addNewReason.
  ///
  /// In en, this message translates to:
  /// **'Add New Reason'**
  String get addNewReason;

  /// No description provided for @reasonsWithoutAmountWarning.
  ///
  /// In en, this message translates to:
  /// **'Reasons without amount will not appear during the meeting'**
  String get reasonsWithoutAmountWarning;

  /// No description provided for @reason.
  ///
  /// In en, this message translates to:
  /// **'Reason'**
  String get reason;

  /// No description provided for @enterReason.
  ///
  /// In en, this message translates to:
  /// **'Enter Reason'**
  String get enterReason;

  /// No description provided for @reasonsForGiving.
  ///
  /// In en, this message translates to:
  /// **'Reasons for Giving'**
  String get reasonsForGiving;

  /// No description provided for @reasonsForGivingInFund.
  ///
  /// In en, this message translates to:
  /// **'Reasons for giving in the community fund'**
  String get reasonsForGivingInFund;

  /// No description provided for @addNewReasonToReceiveMoney.
  ///
  /// In en, this message translates to:
  /// **'Add new reason to receive money'**
  String get addNewReasonToReceiveMoney;

  /// No description provided for @loadingGroupData.
  ///
  /// In en, this message translates to:
  /// **'Loading group data...'**
  String get loadingGroupData;

  /// No description provided for @kikundiKipoMzunguko.
  ///
  /// In en, this message translates to:
  /// **'Which cycle is the group in?'**
  String get kikundiKipoMzunguko;

  /// No description provided for @mzunguko.
  ///
  /// In en, this message translates to:
  /// **'Cycle {mzungukoId}'**
  String mzunguko(Object mzungukoId);

  /// No description provided for @invalidGroupDataReceived.
  ///
  /// In en, this message translates to:
  /// **'Invalid group data received'**
  String get invalidGroupDataReceived;

  /// No description provided for @historia.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get historia;

  /// No description provided for @historiaYa.
  ///
  /// In en, this message translates to:
  /// **'History of {name}'**
  String historiaYa(String name);

  /// No description provided for @hakuna_vikao.
  ///
  /// In en, this message translates to:
  /// **'No completed meetings in this cycle!'**
  String get hakuna_vikao;

  /// No description provided for @tafutaJinaSimu.
  ///
  /// In en, this message translates to:
  /// **'Search by name or phone number'**
  String get tafutaJinaSimu;

  /// No description provided for @hakunaWanachama.
  ///
  /// In en, this message translates to:
  /// **'No members found.'**
  String get hakunaWanachama;

  /// No description provided for @muhtasariKikao.
  ///
  /// In en, this message translates to:
  /// **'Meeting Summary'**
  String get muhtasariKikao;

  /// No description provided for @funga.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get funga;

  /// No description provided for @tumaMuhtasari.
  ///
  /// In en, this message translates to:
  /// **'Send Summary'**
  String get tumaMuhtasari;

  /// No description provided for @mwanachamaSiSimu.
  ///
  /// In en, this message translates to:
  /// **'Member does not have a phone number'**
  String get mwanachamaSiSimu;

  /// No description provided for @muhtasariUmetumwa.
  ///
  /// In en, this message translates to:
  /// **'Summary sent to {name} successfully'**
  String muhtasariUmetumwa(String name);

  /// No description provided for @imeshindwaTumaSMS.
  ///
  /// In en, this message translates to:
  /// **'Failed to send SMS, please try again'**
  String get imeshindwaTumaSMS;

  /// No description provided for @kikao.
  ///
  /// In en, this message translates to:
  /// **'Meeting'**
  String get kikao;

  /// No description provided for @kikao_ya.
  ///
  /// In en, this message translates to:
  /// **'Meeting of {name}'**
  String kikao_ya(String name);

  /// No description provided for @mipangilio.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get mipangilio;

  /// No description provided for @badiliLugha.
  ///
  /// In en, this message translates to:
  /// **'Change Language'**
  String get badiliLugha;

  /// No description provided for @chaguaLughaYaProgramu.
  ///
  /// In en, this message translates to:
  /// **'Choose App Language'**
  String get chaguaLughaYaProgramu;

  /// No description provided for @kiswahili.
  ///
  /// In en, this message translates to:
  /// **'Swahili'**
  String get kiswahili;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @french.
  ///
  /// In en, this message translates to:
  /// **'French'**
  String get french;

  /// No description provided for @rekebishaFunguo.
  ///
  /// In en, this message translates to:
  /// **'Adjust keys'**
  String get rekebishaFunguo;

  /// No description provided for @badilishaNenoLaSiri.
  ///
  /// In en, this message translates to:
  /// **'Change password'**
  String get badilishaNenoLaSiri;

  /// No description provided for @kifo.
  ///
  /// In en, this message translates to:
  /// **'Death'**
  String get kifo;

  /// No description provided for @futazoteZaMzungukoHuuKishaAnzaMzungukoMpya.
  ///
  /// In en, this message translates to:
  /// **'Delete all records of this cycle and start a new one'**
  String get futazoteZaMzungukoHuuKishaAnzaMzungukoMpya;

  /// No description provided for @rekebishaMzunguko.
  ///
  /// In en, this message translates to:
  /// **'Edit cycle'**
  String get rekebishaMzunguko;

  /// No description provided for @thibitisha.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get thibitisha;

  /// No description provided for @jeUnaHitajiKufutaTaarifaZoteNaKuanzaMzungukoMpya.
  ///
  /// In en, this message translates to:
  /// **'Do you want to delete all records and start a new cycle?'**
  String get jeUnaHitajiKufutaTaarifaZoteNaKuanzaMzungukoMpya;

  /// No description provided for @ndio.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get ndio;

  /// No description provided for @imeshindwaKuHifadhi.
  ///
  /// In en, this message translates to:
  /// **'Failed to save information: {error}'**
  String imeshindwaKuHifadhi(String error);

  /// No description provided for @hapana.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get hapana;

  /// No description provided for @kuhusuChomoka.
  ///
  /// In en, this message translates to:
  /// **'About Chomoka'**
  String get kuhusuChomoka;

  /// No description provided for @toleoLaChapa100.
  ///
  /// In en, this message translates to:
  /// **'Version 1.0.0'**
  String get toleoLaChapa100;

  /// No description provided for @toleo4684.
  ///
  /// In en, this message translates to:
  /// **'Version 4684'**
  String get toleo4684;

  /// No description provided for @mkataba.
  ///
  /// In en, this message translates to:
  /// **'Contract'**
  String get mkataba;

  /// No description provided for @vigezoNaMasharti.
  ///
  /// In en, this message translates to:
  /// **'Terms and Conditions'**
  String get vigezoNaMasharti;

  /// No description provided for @somaVigezoNaMashartiYaChomoka.
  ///
  /// In en, this message translates to:
  /// **'Read Chomoka terms and conditions'**
  String get somaVigezoNaMashartiYaChomoka;

  /// No description provided for @msaadaWaKitaalamu.
  ///
  /// In en, this message translates to:
  /// **'Technical Support'**
  String get msaadaWaKitaalamu;

  /// No description provided for @chomokaItajaribuKutumaBaadhiYaIliKikundiKipateMsaadaZaidiWaKitalaamu.
  ///
  /// In en, this message translates to:
  /// **'Chomoka will try to send some data so that the group can receive more technical support'**
  String
      get chomokaItajaribuKutumaBaadhiYaIliKikundiKipateMsaadaZaidiWaKitalaamu;

  /// No description provided for @vslaPreviousMeetingSummary.
  ///
  /// In en, this message translates to:
  /// **'Meeting Summary'**
  String get vslaPreviousMeetingSummary;

  /// No description provided for @nimemaliza.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get nimemaliza;

  /// No description provided for @idleBalanceInBox.
  ///
  /// In en, this message translates to:
  /// **'Idle Balance in the Box'**
  String get idleBalanceInBox;

  /// No description provided for @currentLoanBalance.
  ///
  /// In en, this message translates to:
  /// **'Current Loan Balance'**
  String get currentLoanBalance;

  /// No description provided for @remainingCommunityContribution.
  ///
  /// In en, this message translates to:
  /// **'Remaining Contribution to the Community Fund'**
  String get remainingCommunityContribution;

  /// No description provided for @totalOutstandingFines.
  ///
  /// In en, this message translates to:
  /// **'Total Outstanding Fines'**
  String get totalOutstandingFines;

  /// No description provided for @kikundi.
  ///
  /// In en, this message translates to:
  /// **'Group'**
  String get kikundi;

  /// No description provided for @nunuaHisa.
  ///
  /// In en, this message translates to:
  /// **'Buy Shares'**
  String get nunuaHisa;

  /// No description provided for @sasaUtaanzaMchakatoWaKununuaHisaKwaKilaMwanachama.
  ///
  /// In en, this message translates to:
  /// **'Start the process of buying shares for each member'**
  String get sasaUtaanzaMchakatoWaKununuaHisaKwaKilaMwanachama;

  /// No description provided for @anzaSasa.
  ///
  /// In en, this message translates to:
  /// **'START NOW'**
  String get anzaSasa;

  /// No description provided for @rudiNymba.
  ///
  /// In en, this message translates to:
  /// **'GO BACK'**
  String get rudiNymba;

  /// No description provided for @hisa.
  ///
  /// In en, this message translates to:
  /// **'Shares'**
  String get hisa;

  /// No description provided for @hesabuYaHisa.
  ///
  /// In en, this message translates to:
  /// **'Share Account'**
  String get hesabuYaHisa;

  /// No description provided for @jumlaYaAkiba.
  ///
  /// In en, this message translates to:
  /// **'Total Shares'**
  String get jumlaYaAkiba;

  /// No description provided for @hisaAlizonunuaLeo.
  ///
  /// In en, this message translates to:
  /// **'Shares to Buy'**
  String get hisaAlizonunuaLeo;

  /// No description provided for @chaguaIdadiYaHisaZaKununua.
  ///
  /// In en, this message translates to:
  /// **'Select number of shares to buy'**
  String get chaguaIdadiYaHisaZaKununua;

  /// No description provided for @chaguaZote.
  ///
  /// In en, this message translates to:
  /// **'Select All'**
  String get chaguaZote;

  /// No description provided for @ruka.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get ruka;

  /// No description provided for @hisaZilizochaguliwa.
  ///
  /// In en, this message translates to:
  /// **'Shares Selected'**
  String get hisaZilizochaguliwa;

  /// No description provided for @badilishaHisa.
  ///
  /// In en, this message translates to:
  /// **'Edit Shares'**
  String get badilishaHisa;

  /// No description provided for @ongezaHisa.
  ///
  /// In en, this message translates to:
  /// **'Add Shares'**
  String get ongezaHisa;

  /// No description provided for @ongezaHisaZaidiKwaMwanachama.
  ///
  /// In en, this message translates to:
  /// **'Add more shares for each member'**
  String get ongezaHisaZaidiKwaMwanachama;

  /// No description provided for @punguzaHisa.
  ///
  /// In en, this message translates to:
  /// **'Remove Shares'**
  String get punguzaHisa;

  /// No description provided for @punguzaIdadiYaHisaZaMwanachama.
  ///
  /// In en, this message translates to:
  /// **'Remove shares for each member'**
  String get punguzaIdadiYaHisaZaMwanachama;

  /// No description provided for @futaZote.
  ///
  /// In en, this message translates to:
  /// **'Delete All'**
  String get futaZote;

  /// No description provided for @futaHisaZoteZaLeo.
  ///
  /// In en, this message translates to:
  /// **'Delete all shares for this cycle'**
  String get futaHisaZoteZaLeo;

  /// No description provided for @ongeza.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get ongeza;

  /// No description provided for @punguza.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get punguza;

  /// No description provided for @futa.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get futa;

  /// No description provided for @ingizaIdadiYaHisaUnezotakaKununua.
  ///
  /// In en, this message translates to:
  /// **'Enter the number of shares you want to add'**
  String get ingizaIdadiYaHisaUnezotakaKununua;

  /// No description provided for @ingizaIdadiYaHisaUnezotakaKupunguza.
  ///
  /// In en, this message translates to:
  /// **'Enter the number of shares you want to remove'**
  String get ingizaIdadiYaHisaUnezotakaKupunguza;

  /// No description provided for @ghairi.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get ghairi;

  /// No description provided for @idadiYaHisa.
  ///
  /// In en, this message translates to:
  /// **'Number of Shares'**
  String get idadiYaHisa;

  /// No description provided for @tafadhaliIngizaNambaSahihi.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid number'**
  String get tafadhaliIngizaNambaSahihi;

  /// No description provided for @muhtasariWaHisa.
  ///
  /// In en, this message translates to:
  /// **'Share Summary'**
  String get muhtasariWaHisa;

  /// No description provided for @jumlaYaFedha.
  ///
  /// In en, this message translates to:
  /// **'Total Amount'**
  String get jumlaYaFedha;

  /// No description provided for @contributeToFund.
  ///
  /// In en, this message translates to:
  /// **'Contribute to {fundName}'**
  String contributeToFund(String fundName);

  /// No description provided for @amountToContribute.
  ///
  /// In en, this message translates to:
  /// **'Amount to contribute'**
  String get amountToContribute;

  /// No description provided for @totalCollected.
  ///
  /// In en, this message translates to:
  /// **'Total collected'**
  String get totalCollected;

  /// No description provided for @shareNote.
  ///
  /// In en, this message translates to:
  /// **'Note: A member can buy one share worth  {amount} per meeting'**
  String shareNote(Object amount);

  /// No description provided for @help.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get help;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// No description provided for @helpDescription.
  ///
  /// In en, this message translates to:
  /// **'We help you keep records of your group efficiently'**
  String get helpDescription;

  /// No description provided for @continueMeeting.
  ///
  /// In en, this message translates to:
  /// **'Continue Meeting'**
  String get continueMeeting;

  /// No description provided for @wanachama.
  ///
  /// In en, this message translates to:
  /// **'Members'**
  String get wanachama;

  /// No description provided for @fund.
  ///
  /// In en, this message translates to:
  /// **'Group Distribution'**
  String get fund;

  /// No description provided for @feedback.
  ///
  /// In en, this message translates to:
  /// **'Feedback'**
  String get feedback;

  /// No description provided for @groupsActivities.
  ///
  /// In en, this message translates to:
  /// **'Group Activities'**
  String get groupsActivities;

  /// No description provided for @historyDescription.
  ///
  /// In en, this message translates to:
  /// **'View the history of group activities'**
  String get historyDescription;

  /// No description provided for @backupAndRestore.
  ///
  /// In en, this message translates to:
  /// **'Backup and Restore'**
  String get backupAndRestore;

  /// No description provided for @backupDescription.
  ///
  /// In en, this message translates to:
  /// **'Backup and restore group records'**
  String get backupDescription;

  /// No description provided for @serviceMore.
  ///
  /// In en, this message translates to:
  /// **'More Services'**
  String get serviceMore;

  /// No description provided for @historyHints.
  ///
  /// In en, this message translates to:
  /// **'View the history of group activities'**
  String get historyHints;

  /// No description provided for @sendData.
  ///
  /// In en, this message translates to:
  /// **'Backup and Restore'**
  String get sendData;

  /// No description provided for @sendDataHint.
  ///
  /// In en, this message translates to:
  /// **'Backup and restore group records'**
  String get sendDataHint;

  /// No description provided for @whatsappNotInstalled.
  ///
  /// In en, this message translates to:
  /// **'WhatsApp is not installed on your phone'**
  String get whatsappNotInstalled;

  /// No description provided for @whatsappFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to open WhatsApp'**
  String get whatsappFailed;

  /// No description provided for @helpEmailSubject.
  ///
  /// In en, this message translates to:
  /// **'Help - Chomoka Plus App'**
  String get helpEmailSubject;

  /// No description provided for @welcomeNextMeeting.
  ///
  /// In en, this message translates to:
  /// **'Welcome to the Next Meeting'**
  String get welcomeNextMeeting;

  /// No description provided for @midCycleReport.
  ///
  /// In en, this message translates to:
  /// **'Mid-Cycle Report'**
  String get midCycleReport;

  /// No description provided for @tapToOpenMeeting.
  ///
  /// In en, this message translates to:
  /// **'Tap the button below to open the meeting'**
  String get tapToOpenMeeting;

  /// No description provided for @tapYesToStartFirstMeeting.
  ///
  /// In en, this message translates to:
  /// **'TAP YES TO START THE FIRST MEETING'**
  String get tapYesToStartFirstMeeting;

  /// No description provided for @openMeeting.
  ///
  /// In en, this message translates to:
  /// **'OPEN MEETING'**
  String get openMeeting;

  /// No description provided for @tapNoToEnterPastMeetings.
  ///
  /// In en, this message translates to:
  /// **'TAP NO TO ENTER DATA FOR PREVIOUS MEETINGS'**
  String get tapNoToEnterPastMeetings;

  /// No description provided for @meetingTitle.
  ///
  /// In en, this message translates to:
  /// **'Meeting No. {meetingNumber}'**
  String meetingTitle(Object meetingNumber);

  /// No description provided for @groupAttendance.
  ///
  /// In en, this message translates to:
  /// **'Check Attendance'**
  String get groupAttendance;

  /// No description provided for @contributeMfukoJamii.
  ///
  /// In en, this message translates to:
  /// **'Contribute to Community Fund'**
  String get contributeMfukoJamii;

  /// No description provided for @buyShares.
  ///
  /// In en, this message translates to:
  /// **'Buy Shares'**
  String get buyShares;

  /// No description provided for @contributeOtherFund.
  ///
  /// In en, this message translates to:
  /// **'Contribute to {mfukoName}'**
  String contributeOtherFund(Object mfukoName);

  /// No description provided for @repayLoan.
  ///
  /// In en, this message translates to:
  /// **'Repay Loan'**
  String get repayLoan;

  /// No description provided for @payFine.
  ///
  /// In en, this message translates to:
  /// **'Pay Fine'**
  String get payFine;

  /// No description provided for @withdrawFromMfukoJamii.
  ///
  /// In en, this message translates to:
  /// **'Withdraw from Social Fund'**
  String get withdrawFromMfukoJamii;

  /// No description provided for @giveLoan.
  ///
  /// In en, this message translates to:
  /// **'Disburse Loan'**
  String get giveLoan;

  /// No description provided for @markCompleted.
  ///
  /// In en, this message translates to:
  /// **'completed'**
  String get markCompleted;

  /// No description provided for @markPending.
  ///
  /// In en, this message translates to:
  /// **'pending'**
  String get markPending;

  /// No description provided for @menuBulkSaving.
  ///
  /// In en, this message translates to:
  /// **'Bulk Saving'**
  String get menuBulkSaving;

  /// No description provided for @menuExpense.
  ///
  /// In en, this message translates to:
  /// **'Enter Expense Details'**
  String get menuExpense;

  /// No description provided for @menuLogout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get menuLogout;

  /// No description provided for @snackbarLoggedOut.
  ///
  /// In en, this message translates to:
  /// **'Logged out'**
  String get snackbarLoggedOut;

  /// No description provided for @attendance.
  ///
  /// In en, this message translates to:
  /// **'Attendance'**
  String get attendance;

  /// No description provided for @attendanceSummary.
  ///
  /// In en, this message translates to:
  /// **'Attendance Summary'**
  String get attendanceSummary;

  /// No description provided for @totalMembers.
  ///
  /// In en, this message translates to:
  /// **'Total Members'**
  String get totalMembers;

  /// No description provided for @present.
  ///
  /// In en, this message translates to:
  /// **'Present'**
  String get present;

  /// No description provided for @onTime.
  ///
  /// In en, this message translates to:
  /// **'On Time'**
  String get onTime;

  /// No description provided for @lates.
  ///
  /// In en, this message translates to:
  /// **'Late'**
  String get lates;

  /// No description provided for @sentRepresentative.
  ///
  /// In en, this message translates to:
  /// **'Sent Representative'**
  String get sentRepresentative;

  /// No description provided for @absent.
  ///
  /// In en, this message translates to:
  /// **'Absent'**
  String get absent;

  /// No description provided for @withPermission.
  ///
  /// In en, this message translates to:
  /// **'With Permission'**
  String get withPermission;

  /// No description provided for @withoutPermission.
  ///
  /// In en, this message translates to:
  /// **'Without Permission'**
  String get withoutPermission;

  /// No description provided for @reasonForAbsence.
  ///
  /// In en, this message translates to:
  /// **'Reason for Absence'**
  String get reasonForAbsence;

  /// No description provided for @amountToPaid.
  ///
  /// In en, this message translates to:
  /// **'Amount the member should pay:'**
  String get amountToPaid;

  /// No description provided for @whatWasCollected.
  ///
  /// In en, this message translates to:
  /// **'What was collected:'**
  String get whatWasCollected;

  /// No description provided for @hasPaid.
  ///
  /// In en, this message translates to:
  /// **'Has Paid'**
  String get hasPaid;

  /// No description provided for @hasNotPaid.
  ///
  /// In en, this message translates to:
  /// **'Has Not Paid'**
  String get hasNotPaid;

  /// No description provided for @compulsorySavingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Compulsory Savings Information'**
  String get compulsorySavingsTitle;

  /// No description provided for @compulsorySavingsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Member Contributions'**
  String get compulsorySavingsSubtitle;

  /// No description provided for @loadingMessage.
  ///
  /// In en, this message translates to:
  /// **'Loading information...'**
  String get loadingMessage;

  /// No description provided for @doneButton.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get doneButton;

  /// No description provided for @noCompulsorySavings.
  ///
  /// In en, this message translates to:
  /// **'No compulsory savings amount owed by the member'**
  String get noCompulsorySavings;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @dueMeeting.
  ///
  /// In en, this message translates to:
  /// **'Due for meeting'**
  String get dueMeeting;

  /// No description provided for @owedAmount.
  ///
  /// In en, this message translates to:
  /// **'Compulsory savings owed:  {amount}'**
  String owedAmount(Object amount);

  /// No description provided for @pay.
  ///
  /// In en, this message translates to:
  /// **'Pay'**
  String get pay;

  /// No description provided for @alreadyPaid.
  ///
  /// In en, this message translates to:
  /// **'Already Paid'**
  String get alreadyPaid;

  /// No description provided for @socialFundTitle.
  ///
  /// In en, this message translates to:
  /// **'Social Fund Information'**
  String get socialFundTitle;

  /// No description provided for @socialFundDueAmount.
  ///
  /// In en, this message translates to:
  /// **'Amount Due for Social Fund:  {amount}'**
  String socialFundDueAmount(Object amount);

  /// No description provided for @contributionSummary.
  ///
  /// In en, this message translates to:
  /// **'Contribution Summary'**
  String get contributionSummary;

  /// No description provided for @memberName.
  ///
  /// In en, this message translates to:
  /// **'Member: {name}'**
  String memberName(Object name);

  /// No description provided for @paid.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get paid;

  /// No description provided for @unpaid.
  ///
  /// In en, this message translates to:
  /// **'Unpaid'**
  String get unpaid;

  /// No description provided for @noSocialFundDue.
  ///
  /// In en, this message translates to:
  /// **'No social fund amount is owed by the member'**
  String get noSocialFundDue;

  /// No description provided for @totalLoan.
  ///
  /// In en, this message translates to:
  /// **'Total Loan'**
  String get totalLoan;

  /// No description provided for @noUnpaidMemberJamii.
  ///
  /// In en, this message translates to:
  /// **'No Member Has Outstanding Social Fund Contributions'**
  String get noUnpaidMemberJamii;

  /// No description provided for @unpaidContributionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Unpaid Contributions'**
  String get unpaidContributionsTitle;

  /// No description provided for @unpaidContributionsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Social Fund Contributions'**
  String get unpaidContributionsSubtitle;

  /// No description provided for @loanDebtorsTitle.
  ///
  /// In en, this message translates to:
  /// **'Loan Debtors'**
  String get loanDebtorsTitle;

  /// No description provided for @loanSummaryTitle.
  ///
  /// In en, this message translates to:
  /// **'Loan Summary'**
  String get loanSummaryTitle;

  /// No description provided for @loanIssuedAmount.
  ///
  /// In en, this message translates to:
  /// **'Total Loans Issued:'**
  String get loanIssuedAmount;

  /// No description provided for @loanRepaidAmount.
  ///
  /// In en, this message translates to:
  /// **'Total Loans Repaid:'**
  String get loanRepaidAmount;

  /// No description provided for @loanRemainingAmount.
  ///
  /// In en, this message translates to:
  /// **'Remaining Loan Balance:'**
  String get loanRemainingAmount;

  /// No description provided for @noUnpaidLoans.
  ///
  /// In en, this message translates to:
  /// **'No members with unpaid loans.'**
  String get noUnpaidLoans;

  /// No description provided for @loanDebtors.
  ///
  /// In en, this message translates to:
  /// **'Loan Debtors'**
  String get loanDebtors;

  /// No description provided for @memberLabel.
  ///
  /// In en, this message translates to:
  /// **'Member:'**
  String get memberLabel;

  /// No description provided for @unpaidLoanAmount.
  ///
  /// In en, this message translates to:
  /// **'Unpaid \nloan amount'**
  String get unpaidLoanAmount;

  /// No description provided for @loanDetailsTitle.
  ///
  /// In en, this message translates to:
  /// **'Loan Details'**
  String get loanDetailsTitle;

  /// No description provided for @makePayment.
  ///
  /// In en, this message translates to:
  /// **'Make Payment'**
  String get makePayment;

  /// No description provided for @remainingAmount.
  ///
  /// In en, this message translates to:
  /// **'Remaining Amount:  {amount}'**
  String remainingAmount(Object amount);

  /// No description provided for @choosePaymentType.
  ///
  /// In en, this message translates to:
  /// **'Choose Payment Type:'**
  String get choosePaymentType;

  /// No description provided for @payAll.
  ///
  /// In en, this message translates to:
  /// **'Pay All'**
  String get payAll;

  /// No description provided for @reduceLoan.
  ///
  /// In en, this message translates to:
  /// **'Reduce Loan'**
  String get reduceLoan;

  /// No description provided for @enterPaymentAmount.
  ///
  /// In en, this message translates to:
  /// **'Enter Payment Amount'**
  String get enterPaymentAmount;

  /// No description provided for @payLoan.
  ///
  /// In en, this message translates to:
  /// **'Pay Loan'**
  String get payLoan;

  /// No description provided for @member.
  ///
  /// In en, this message translates to:
  /// **'MEMBER'**
  String get member;

  /// No description provided for @loanTaken.
  ///
  /// In en, this message translates to:
  /// **'Loan Amount Taken:'**
  String get loanTaken;

  /// No description provided for @loanToPay.
  ///
  /// In en, this message translates to:
  /// **'Amount to Repay:'**
  String get loanToPay;

  /// No description provided for @loanRemaining.
  ///
  /// In en, this message translates to:
  /// **'Remaining Loan Amount:'**
  String get loanRemaining;

  /// No description provided for @paymentHistory.
  ///
  /// In en, this message translates to:
  /// **'Payment History:'**
  String get paymentHistory;

  /// No description provided for @noPaymentsMade.
  ///
  /// In en, this message translates to:
  /// **'No payments made yet.'**
  String get noPaymentsMade;

  /// No description provided for @youPaid.
  ///
  /// In en, this message translates to:
  /// **'You Paid:  {amount}'**
  String youPaid(Object amount);

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String date(Object date);

  /// No description provided for @fainiPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Issue Fine'**
  String get fainiPageTitle;

  /// No description provided for @pageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Select Fine'**
  String get pageSubtitle;

  /// No description provided for @undefinedFine.
  ///
  /// In en, this message translates to:
  /// **'Undefined fine'**
  String get undefinedFine;

  /// No description provided for @priceLabel.
  ///
  /// In en, this message translates to:
  /// **'Price: {price} Tsh'**
  String priceLabel(Object price);

  /// No description provided for @saveFine.
  ///
  /// In en, this message translates to:
  /// **'Save Fine'**
  String get saveFine;

  /// No description provided for @payFineTitle.
  ///
  /// In en, this message translates to:
  /// **'Pay Fine'**
  String get payFineTitle;

  /// No description provided for @remainingFineAmount.
  ///
  /// In en, this message translates to:
  /// **'Remaining Amount:  {amount}'**
  String remainingFineAmount(Object amount);

  /// No description provided for @payAllFines.
  ///
  /// In en, this message translates to:
  /// **'Pay All Fines'**
  String get payAllFines;

  /// No description provided for @payCustomAmount.
  ///
  /// In en, this message translates to:
  /// **'Pay Custom Amount'**
  String get payCustomAmount;

  /// No description provided for @confirmFinePayment.
  ///
  /// In en, this message translates to:
  /// **'Pay Fine'**
  String get confirmFinePayment;

  /// No description provided for @fineTitle.
  ///
  /// In en, this message translates to:
  /// **'Member Fines'**
  String get fineTitle;

  /// No description provided for @fineSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Pay Fine'**
  String get fineSubtitle;

  /// No description provided for @totalFines.
  ///
  /// In en, this message translates to:
  /// **'Total Fines Due:  {amount}'**
  String totalFines(Object amount);

  /// No description provided for @paidFines.
  ///
  /// In en, this message translates to:
  /// **'Fines Paid:  {amount}'**
  String paidFines(Object amount);

  /// No description provided for @remainingFines.
  ///
  /// In en, this message translates to:
  /// **'Remaining Amount:  {amount}'**
  String remainingFines(Object amount);

  /// No description provided for @pigaFainiTitle.
  ///
  /// In en, this message translates to:
  /// **'Issue Fine'**
  String get pigaFainiTitle;

  /// No description provided for @pigaFainiSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Select Member'**
  String get pigaFainiSubtitle;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search by name or member number'**
  String get searchHint;

  /// No description provided for @fainiSummarySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Fine Summary'**
  String get fainiSummarySubtitle;

  /// No description provided for @unknownName.
  ///
  /// In en, this message translates to:
  /// **'No name'**
  String get unknownName;

  /// No description provided for @unknownPhone.
  ///
  /// In en, this message translates to:
  /// **'Phone unknown'**
  String get unknownPhone;

  /// No description provided for @backToFines.
  ///
  /// In en, this message translates to:
  /// **'Back to Fines'**
  String get backToFines;

  /// No description provided for @lipaFainiTitle.
  ///
  /// In en, this message translates to:
  /// **'Pay Fine'**
  String get lipaFainiTitle;

  /// No description provided for @totalFinesDue.
  ///
  /// In en, this message translates to:
  /// **'Total Fines Due'**
  String get totalFinesDue;

  /// No description provided for @totalFinesPaid.
  ///
  /// In en, this message translates to:
  /// **'Total Fines Paid'**
  String get totalFinesPaid;

  /// No description provided for @noFineMembers.
  ///
  /// In en, this message translates to:
  /// **'No members with fines.'**
  String get noFineMembers;

  /// No description provided for @unpaidFinesTitle.
  ///
  /// In en, this message translates to:
  /// **'Unpaid Fines'**
  String get unpaidFinesTitle;

  /// No description provided for @memberTotalFines.
  ///
  /// In en, this message translates to:
  /// **'Total Fines:  {amount}'**
  String memberTotalFines(Object amount);

  /// No description provided for @navigationError.
  ///
  /// In en, this message translates to:
  /// **'An error occurred while navigating. Please try again.'**
  String get navigationError;

  /// No description provided for @memberFinesTitle.
  ///
  /// In en, this message translates to:
  /// **'Member Fines'**
  String get memberFinesTitle;

  /// No description provided for @memberNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Member: {name}'**
  String memberNameLabel(Object name);

  /// No description provided for @memberNumberLabel.
  ///
  /// In en, this message translates to:
  /// **'Member Number: {number}'**
  String memberNumberLabel(Object number);

  /// No description provided for @totalFinesLabel.
  ///
  /// In en, this message translates to:
  /// **'Total Fines Owed:  {amount}'**
  String totalFinesLabel(Object amount);

  /// No description provided for @totalPaidLabel.
  ///
  /// In en, this message translates to:
  /// **'Fines Paid:  {amount}'**
  String totalPaidLabel(Object amount);

  /// No description provided for @totalUnpaidLabel.
  ///
  /// In en, this message translates to:
  /// **'Remaining Balance:  {amount}'**
  String totalUnpaidLabel(Object amount);

  /// No description provided for @memberPhone.
  ///
  /// In en, this message translates to:
  /// **'Phone: {phone}'**
  String memberPhone(Object phone);

  /// No description provided for @fineTypes.
  ///
  /// In en, this message translates to:
  /// **'Fine Type: {fineName}'**
  String fineTypes(Object fineName);

  /// No description provided for @fineAmount.
  ///
  /// In en, this message translates to:
  /// **'Fine Amount: {amount} '**
  String fineAmount(Object amount);

  /// No description provided for @meetingNumber.
  ///
  /// In en, this message translates to:
  /// **'Meeting : {meeting}'**
  String meetingNumber(Object meeting, Object meetings);

  /// No description provided for @toa_mfuko_jamii.
  ///
  /// In en, this message translates to:
  /// **'Withdraw Social Fund'**
  String get toa_mfuko_jamii;

  /// No description provided for @sababu_ya_kutoa_mfuko.
  ///
  /// In en, this message translates to:
  /// **'Reason for Withdrawing Social Fund'**
  String get sababu_ya_kutoa_mfuko;

  /// No description provided for @hakuna_sababu.
  ///
  /// In en, this message translates to:
  /// **'No reasons have been filled in yet.'**
  String get hakuna_sababu;

  /// No description provided for @kiasi_cha_juu.
  ///
  /// In en, this message translates to:
  /// **'Maximum Withdrawal Amount:  {amount}'**
  String kiasi_cha_juu(Object amount);

  /// No description provided for @jina.
  ///
  /// In en, this message translates to:
  /// **'Name:'**
  String get jina;

  /// No description provided for @jina_lisiloeleweka.
  ///
  /// In en, this message translates to:
  /// **'Unknown Name'**
  String get jina_lisiloeleweka;

  /// No description provided for @namba_haijapatikana.
  ///
  /// In en, this message translates to:
  /// **'Number Not Found'**
  String get namba_haijapatikana;

  /// No description provided for @chagua_sababu.
  ///
  /// In en, this message translates to:
  /// **'Select Reason for Withdrawing Social Fund'**
  String get chagua_sababu;

  /// No description provided for @tatizo_katika_kupakia.
  ///
  /// In en, this message translates to:
  /// **'An error occurred, please try again.'**
  String get tatizo_katika_kupakia;

  /// No description provided for @chagua_kiwango_kutoa.
  ///
  /// In en, this message translates to:
  /// **'Select Withdrawal Amount'**
  String get chagua_kiwango_kutoa;

  /// No description provided for @namba_ya_mwanachama.
  ///
  /// In en, this message translates to:
  /// **'Member Number:'**
  String get namba_ya_mwanachama;

  /// No description provided for @sababu_ya_kutoa.
  ///
  /// In en, this message translates to:
  /// **'Reason for withdrawing Social Fund:'**
  String get sababu_ya_kutoa;

  /// No description provided for @kiwango_cha_juu.
  ///
  /// In en, this message translates to:
  /// **'Maximum withdrawal amount:'**
  String get kiwango_cha_juu;

  /// No description provided for @salio_la_sasa.
  ///
  /// In en, this message translates to:
  /// **'Current balance:'**
  String get salio_la_sasa;

  /// No description provided for @salio_la_kikao_kilichopita.
  ///
  /// In en, this message translates to:
  /// **'Previous Meeting Social Fund Balance:'**
  String get salio_la_kikao_kilichopita;

  /// No description provided for @toa_kiasi_chote.
  ///
  /// In en, this message translates to:
  /// **'Withdraw full amount'**
  String get toa_kiasi_chote;

  /// No description provided for @toa_kiasi_kingine.
  ///
  /// In en, this message translates to:
  /// **'Withdraw another amount'**
  String get toa_kiasi_kingine;

  /// No description provided for @ingiza_kiasi.
  ///
  /// In en, this message translates to:
  /// **'Enter amount'**
  String get ingiza_kiasi;

  /// No description provided for @thibitisha_utoaji_pesa.
  ///
  /// In en, this message translates to:
  /// **'Confirm fund withdrawal'**
  String get thibitisha_utoaji_pesa;

  /// No description provided for @kiasi_cha_kutoa.
  ///
  /// In en, this message translates to:
  /// **'Withdrawal amount:'**
  String get kiasi_cha_kutoa;

  /// No description provided for @salio_jipya.
  ///
  /// In en, this message translates to:
  /// **'New balance:'**
  String get salio_jipya;

  /// No description provided for @toa_mkopo.
  ///
  /// In en, this message translates to:
  /// **'Issue Loan'**
  String get toa_mkopo;

  /// No description provided for @tahadhari.
  ///
  /// In en, this message translates to:
  /// **'Warning!'**
  String get tahadhari;

  /// No description provided for @hawezi_kukopa.
  ///
  /// In en, this message translates to:
  /// **'A member cannot take another loan until they finish the current one.'**
  String get hawezi_kukopa;

  /// No description provided for @sababu_ya_kutoa_mkopo.
  ///
  /// In en, this message translates to:
  /// **'Reason for taking a loan'**
  String get sababu_ya_kutoa_mkopo;

  /// No description provided for @weka_sababu.
  ///
  /// In en, this message translates to:
  /// **'Enter the reason why member {name} is taking this loan:'**
  String weka_sababu(Object name);

  /// No description provided for @kilimo.
  ///
  /// In en, this message translates to:
  /// **'Agriculture'**
  String get kilimo;

  /// No description provided for @maboresho_nyumba.
  ///
  /// In en, this message translates to:
  /// **'Home Improvement'**
  String get maboresho_nyumba;

  /// No description provided for @elimu.
  ///
  /// In en, this message translates to:
  /// **'Education'**
  String get elimu;

  /// No description provided for @biashara.
  ///
  /// In en, this message translates to:
  /// **'Business'**
  String get biashara;

  /// No description provided for @sababu_nyingine.
  ///
  /// In en, this message translates to:
  /// **'Other Reason'**
  String get sababu_nyingine;

  /// No description provided for @weka_sababu_nyingine.
  ///
  /// In en, this message translates to:
  /// **'Enter Other Reason'**
  String get weka_sababu_nyingine;

  /// No description provided for @thibitisha_sababu.
  ///
  /// In en, this message translates to:
  /// **'Confirm Reason'**
  String get thibitisha_sababu;

  /// No description provided for @tafadhali_weka_sababu_nyingine.
  ///
  /// In en, this message translates to:
  /// **'Please enter another reason.'**
  String get tafadhali_weka_sababu_nyingine;

  /// No description provided for @jumla_ya_akiba.
  ///
  /// In en, this message translates to:
  /// **'Total Savings:'**
  String get jumla_ya_akiba;

  /// No description provided for @kiwango_cha_juu_mkopo.
  ///
  /// In en, this message translates to:
  /// **'Maximum Loan Amount:'**
  String get kiwango_cha_juu_mkopo;

  /// No description provided for @fedha_zilizopo_mkopo.
  ///
  /// In en, this message translates to:
  /// **'Funds Available for Loan:'**
  String get fedha_zilizopo_mkopo;

  /// No description provided for @chukua_mkopo_wote.
  ///
  /// In en, this message translates to:
  /// **'Take Full Loan  {amount}'**
  String chukua_mkopo_wote(Object amount);

  /// No description provided for @kiasi_kingine.
  ///
  /// In en, this message translates to:
  /// **'Other Amount'**
  String get kiasi_kingine;

  /// No description provided for @kiasi.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get kiasi;

  /// No description provided for @weka_kiasi.
  ///
  /// In en, this message translates to:
  /// **'Enter Amount'**
  String get weka_kiasi;

  /// No description provided for @thibitisha_kiasi.
  ///
  /// In en, this message translates to:
  /// **'Confirm Amount'**
  String get thibitisha_kiasi;

  /// No description provided for @tafadhali_chagua_chaguo.
  ///
  /// In en, this message translates to:
  /// **'Please select a loan option.'**
  String get tafadhali_chagua_chaguo;

  /// No description provided for @kiasi_cha_mkopo_wa_mwanachama.
  ///
  /// In en, this message translates to:
  /// **'Member\'s loan amount'**
  String get kiasi_cha_mkopo_wa_mwanachama;

  /// No description provided for @tafadhali_ingiza_kiasi_sahihi.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid amount.'**
  String get tafadhali_ingiza_kiasi_sahihi;

  /// No description provided for @hakuna_kiasi_cha_kutosha.
  ///
  /// In en, this message translates to:
  /// **'Insufficient funds to issue this loan.'**
  String get hakuna_kiasi_cha_kutosha;

  /// No description provided for @kiasi_hakiruhusiwi.
  ///
  /// In en, this message translates to:
  /// **'The selected amount is not allowed.'**
  String get kiasi_hakiruhusiwi;

  /// No description provided for @kiasi_na_riba_vimehifadhiwa.
  ///
  /// In en, this message translates to:
  /// **'Loan amount and interest have been saved.'**
  String get kiasi_na_riba_vimehifadhiwa;

  /// No description provided for @hitilafu_imetokea.
  ///
  /// In en, this message translates to:
  /// **'An error occurred. Please try again.'**
  String get hitilafu_imetokea;

  /// No description provided for @muda_wa_marejesho.
  ///
  /// In en, this message translates to:
  /// **'Repayment Duration'**
  String get muda_wa_marejesho;

  /// No description provided for @kiasi_cha_mkopo_wake_ni.
  ///
  /// In en, this message translates to:
  /// **'His Loan Amount Is:\n {amount}'**
  String kiasi_cha_mkopo_wake_ni(Object amount);

  /// No description provided for @mkopo_wa_miezi_mingapi.
  ///
  /// In en, this message translates to:
  /// **'Loan duration in months?'**
  String get mkopo_wa_miezi_mingapi;

  /// No description provided for @mwezi_1.
  ///
  /// In en, this message translates to:
  /// **'1 Month'**
  String get mwezi_1;

  /// No description provided for @miezi_2.
  ///
  /// In en, this message translates to:
  /// **'2 Months'**
  String get miezi_2;

  /// No description provided for @miezi_3.
  ///
  /// In en, this message translates to:
  /// **'3 Months'**
  String get miezi_3;

  /// No description provided for @miezi_6.
  ///
  /// In en, this message translates to:
  /// **'6 Months'**
  String get miezi_6;

  /// No description provided for @nyingine.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get nyingine;

  /// No description provided for @ingiza_miezi.
  ///
  /// In en, this message translates to:
  /// **'Enter Months'**
  String get ingiza_miezi;

  /// No description provided for @thibitisha_muda.
  ///
  /// In en, this message translates to:
  /// **'Confirm Duration'**
  String get thibitisha_muda;

  /// No description provided for @tafadhali_chagua_muda.
  ///
  /// In en, this message translates to:
  /// **'Please select a repayment period.'**
  String get tafadhali_chagua_muda;

  /// No description provided for @tafadhali_ingiza_muda_sahihi.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid duration.'**
  String get tafadhali_ingiza_muda_sahihi;

  /// No description provided for @muda_wa_marejesho_umehifadhiwa.
  ///
  /// In en, this message translates to:
  /// **'Repayment time saved: {months} months'**
  String muda_wa_marejesho_umehifadhiwa(Object months);

  /// No description provided for @wadhamini.
  ///
  /// In en, this message translates to:
  /// **'Guarantors'**
  String get wadhamini;

  /// No description provided for @jinas.
  ///
  /// In en, this message translates to:
  /// **'Name: {name}'**
  String jinas(Object name);

  /// No description provided for @chagua_wadhamini.
  ///
  /// In en, this message translates to:
  /// **'Select {count} Guarantors:'**
  String chagua_wadhamini(Object count);

  /// No description provided for @haidhibiti_idadi.
  ///
  /// In en, this message translates to:
  /// **'Please select all required guarantors.'**
  String get haidhibiti_idadi;

  /// No description provided for @haijulikani.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get haijulikani;

  /// No description provided for @muhtasari_wa_mkopo.
  ///
  /// In en, this message translates to:
  /// **'Loan Summary'**
  String get muhtasari_wa_mkopo;

  /// No description provided for @thibitisha_mkopo.
  ///
  /// In en, this message translates to:
  /// **'Confirm Loan'**
  String get thibitisha_mkopo;

  /// No description provided for @maelezo_ya_mkopo.
  ///
  /// In en, this message translates to:
  /// **'Loan Details'**
  String get maelezo_ya_mkopo;

  /// No description provided for @kiasi_cha_mkopo.
  ///
  /// In en, this message translates to:
  /// **'Loan Amount'**
  String get kiasi_cha_mkopo;

  /// No description provided for @riba_ya_mkopo.
  ///
  /// In en, this message translates to:
  /// **'Loan Interest'**
  String get riba_ya_mkopo;

  /// No description provided for @maelezo_ya_riba.
  ///
  /// In en, this message translates to:
  /// **'Interest \nDetails'**
  String get maelezo_ya_riba;

  /// No description provided for @salio_la_mkopo.
  ///
  /// In en, this message translates to:
  /// **'Loan Balance'**
  String get salio_la_mkopo;

  /// No description provided for @tarehe_ya_mwisho.
  ///
  /// In en, this message translates to:
  /// **'Due Date'**
  String get tarehe_ya_mwisho;

  /// No description provided for @miezi.
  ///
  /// In en, this message translates to:
  /// **'Months {miezi}'**
  String miezi(Object miezi);

  /// No description provided for @oneTimeInterest.
  ///
  /// In en, this message translates to:
  /// **'Interest is paid only once'**
  String get oneTimeInterest;

  /// No description provided for @guarantorExample.
  ///
  /// In en, this message translates to:
  /// **'For example, if Pili cannot pay her loan debt of  150,000 at the time of sharing, the savings of the {count} members who guaranteed her loan will each be reduced by  {amount}.'**
  String guarantorExample(int count, String amount);

  /// No description provided for @communityFundTitle.
  ///
  /// In en, this message translates to:
  /// **'Community Fund'**
  String get communityFundTitle;

  /// No description provided for @unpaidContribution.
  ///
  /// In en, this message translates to:
  /// **'Unpaid contribution'**
  String get unpaidContribution;

  /// No description provided for @expense.
  ///
  /// In en, this message translates to:
  /// **'Expense'**
  String get expense;

  /// No description provided for @chooseUsageType.
  ///
  /// In en, this message translates to:
  /// **'Choose usage type'**
  String get chooseUsageType;

  /// No description provided for @usageType.
  ///
  /// In en, this message translates to:
  /// **'{type}'**
  String usageType(Object type);

  /// No description provided for @matumziStationery.
  ///
  /// In en, this message translates to:
  /// **'Stationery'**
  String get matumziStationery;

  /// No description provided for @matumziRefreshment.
  ///
  /// In en, this message translates to:
  /// **'Refreshment'**
  String get matumziRefreshment;

  /// No description provided for @matumziLoanPayment.
  ///
  /// In en, this message translates to:
  /// **'Loan Payment'**
  String get matumziLoanPayment;

  /// No description provided for @matumziCallTime.
  ///
  /// In en, this message translates to:
  /// **'Call Time (Vocha)'**
  String get matumziCallTime;

  /// No description provided for @matumziTechnology.
  ///
  /// In en, this message translates to:
  /// **'Technology'**
  String get matumziTechnology;

  /// No description provided for @matumiziMerchandise.
  ///
  /// In en, this message translates to:
  /// **'Business Merchandise'**
  String get matumiziMerchandise;

  /// No description provided for @matumziTransport.
  ///
  /// In en, this message translates to:
  /// **'Transport'**
  String get matumziTransport;

  /// No description provided for @matumiziBackCharges.
  ///
  /// In en, this message translates to:
  /// **'Bank Charges'**
  String get matumiziBackCharges;

  /// No description provided for @matumziOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get matumziOther;

  /// No description provided for @specificUsage.
  ///
  /// In en, this message translates to:
  /// **'Specific Usage'**
  String get specificUsage;

  /// No description provided for @enterSpecificUsage.
  ///
  /// In en, this message translates to:
  /// **'Enter specific usage'**
  String get enterSpecificUsage;

  /// No description provided for @pleaseEnterSpecificUsage.
  ///
  /// In en, this message translates to:
  /// **'Please enter specific usage.'**
  String get pleaseEnterSpecificUsage;

  /// No description provided for @pleaseEnterAmount.
  ///
  /// In en, this message translates to:
  /// **'Please enter an amount'**
  String get pleaseEnterAmount;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @expenseSummary.
  ///
  /// In en, this message translates to:
  /// **'Expense Summary'**
  String get expenseSummary;

  /// No description provided for @totalAmountSpent.
  ///
  /// In en, this message translates to:
  /// **'Total Amount Spent'**
  String get totalAmountSpent;

  /// No description provided for @totalExpenses.
  ///
  /// In en, this message translates to:
  /// **'Other Group Expenses'**
  String get totalExpenses;

  /// No description provided for @noExpensesRecorded.
  ///
  /// In en, this message translates to:
  /// **'No expenses recorded.'**
  String get noExpensesRecorded;

  /// No description provided for @expenseLabel.
  ///
  /// In en, this message translates to:
  /// **'Expense: {label}'**
  String expenseLabel(Object label);

  /// No description provided for @unknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get unknown;

  /// No description provided for @expenseType.
  ///
  /// In en, this message translates to:
  /// **'Type: {type}'**
  String expenseType(Object type);

  /// No description provided for @amountLabel.
  ///
  /// In en, this message translates to:
  /// **'Amount:  {amount}'**
  String amountLabel(Object amount);

  /// No description provided for @fundLabel.
  ///
  /// In en, this message translates to:
  /// **'Fund: {fund}'**
  String fundLabel(Object fund);

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @confirmExpense.
  ///
  /// In en, this message translates to:
  /// **'Confirm Expense'**
  String get confirmExpense;

  /// No description provided for @expenseFund.
  ///
  /// In en, this message translates to:
  /// **'Expense Fund'**
  String get expenseFund;

  /// No description provided for @expenseTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Expense Type'**
  String get expenseTypeLabel;

  /// No description provided for @chooseFund.
  ///
  /// In en, this message translates to:
  /// **'Choose Fund'**
  String get chooseFund;

  /// No description provided for @chooseFundToContribute.
  ///
  /// In en, this message translates to:
  /// **'Choose fund to contribute'**
  String get chooseFundToContribute;

  /// No description provided for @mainGroupFund.
  ///
  /// In en, this message translates to:
  /// **'Main Group Fund'**
  String get mainGroupFund;

  /// No description provided for @socialFund.
  ///
  /// In en, this message translates to:
  /// **'Social Fund'**
  String get socialFund;

  /// No description provided for @pleaseChooseFund.
  ///
  /// In en, this message translates to:
  /// **'Please choose a fund.'**
  String get pleaseChooseFund;

  /// No description provided for @bulkSaving.
  ///
  /// In en, this message translates to:
  /// **'Bulk Saving'**
  String get bulkSaving;

  /// No description provided for @chooseContributionType.
  ///
  /// In en, this message translates to:
  /// **'Choose Contribution Type'**
  String get chooseContributionType;

  /// No description provided for @donationContribution.
  ///
  /// In en, this message translates to:
  /// **'Donation Contribution'**
  String get donationContribution;

  /// No description provided for @businessProfit.
  ///
  /// In en, this message translates to:
  /// **'Business Profit'**
  String get businessProfit;

  /// No description provided for @loanDisbursement.
  ///
  /// In en, this message translates to:
  /// **'Loan Disbursement'**
  String get loanDisbursement;

  /// No description provided for @enterAmountFor.
  ///
  /// In en, this message translates to:
  /// **'Enter amount for {type}:'**
  String enterAmountFor(Object type);

  /// No description provided for @totalContributionsForCycle.
  ///
  /// In en, this message translates to:
  /// **'Total contributions for this cycle'**
  String get totalContributionsForCycle;

  /// No description provided for @contributionsList.
  ///
  /// In en, this message translates to:
  /// **'Contributions List'**
  String get contributionsList;

  /// No description provided for @noContributionsCompleted.
  ///
  /// In en, this message translates to:
  /// **'No contributions completed.'**
  String get noContributionsCompleted;

  /// No description provided for @noFund.
  ///
  /// In en, this message translates to:
  /// **'No Fund'**
  String get noFund;

  /// No description provided for @contributionType.
  ///
  /// In en, this message translates to:
  /// **'Type: {type}'**
  String contributionType(Object type);

  /// No description provided for @confirmContribution.
  ///
  /// In en, this message translates to:
  /// **'Confirm Contribution'**
  String get confirmContribution;

  /// No description provided for @fundBalance.
  ///
  /// In en, this message translates to:
  /// **'Fund Balance'**
  String get fundBalance;

  /// No description provided for @currentContribution.
  ///
  /// In en, this message translates to:
  /// **'Current Contribution'**
  String get currentContribution;

  /// No description provided for @newFundBalance.
  ///
  /// In en, this message translates to:
  /// **'New Fund Balance'**
  String get newFundBalance;

  /// No description provided for @meetingSummaryTitle.
  ///
  /// In en, this message translates to:
  /// **'Meeting Summary {meetingNumber}'**
  String meetingSummaryTitle(Object meetingNumber);

  /// No description provided for @sharePurchaseSection.
  ///
  /// In en, this message translates to:
  /// **'Share Purchase'**
  String get sharePurchaseSection;

  /// No description provided for @totalSharesDeposited.
  ///
  /// In en, this message translates to:
  /// **'Total Shares Deposited'**
  String get totalSharesDeposited;

  /// No description provided for @totalShareValue.
  ///
  /// In en, this message translates to:
  /// **'Total Value of Shares'**
  String get totalShareValue;

  /// No description provided for @amountDeposited.
  ///
  /// In en, this message translates to:
  /// **'Amount Deposited'**
  String get amountDeposited;

  /// No description provided for @amountWithdrawn.
  ///
  /// In en, this message translates to:
  /// **'Amount Withdrawn'**
  String get amountWithdrawn;

  /// No description provided for @loansSection.
  ///
  /// In en, this message translates to:
  /// **'Loans'**
  String get loansSection;

  /// No description provided for @loansIssued.
  ///
  /// In en, this message translates to:
  /// **'Loans Issued'**
  String get loansIssued;

  /// No description provided for @loanAmountRepaid.
  ///
  /// In en, this message translates to:
  /// **'Loan Amount Repaid'**
  String get loanAmountRepaid;

  /// No description provided for @loanAmountOutstanding.
  ///
  /// In en, this message translates to:
  /// **'Loan Amount Outstanding'**
  String get loanAmountOutstanding;

  /// No description provided for @finesSection.
  ///
  /// In en, this message translates to:
  /// **'Fines'**
  String get finesSection;

  /// No description provided for @totalBulkSaving.
  ///
  /// In en, this message translates to:
  /// **'Total Bulk Saving'**
  String get totalBulkSaving;

  /// No description provided for @expensesSection.
  ///
  /// In en, this message translates to:
  /// **'Expenses'**
  String get expensesSection;

  /// No description provided for @loadingAttendanceSummary.
  ///
  /// In en, this message translates to:
  /// **'Loading attendance summary...'**
  String get loadingAttendanceSummary;

  /// No description provided for @presentMembers.
  ///
  /// In en, this message translates to:
  /// **'Present Members'**
  String get presentMembers;

  /// No description provided for @earlyMembers.
  ///
  /// In en, this message translates to:
  /// **'Early'**
  String get earlyMembers;

  /// No description provided for @lateMembers.
  ///
  /// In en, this message translates to:
  /// **'Late'**
  String get lateMembers;

  /// No description provided for @representative.
  ///
  /// In en, this message translates to:
  /// **'Representative'**
  String get representative;

  /// No description provided for @absentMembers.
  ///
  /// In en, this message translates to:
  /// **'Absent Members'**
  String get absentMembers;

  /// No description provided for @closeMeeting.
  ///
  /// In en, this message translates to:
  /// **'Close Meeting'**
  String get closeMeeting;

  /// No description provided for @sendSmsTitle.
  ///
  /// In en, this message translates to:
  /// **'Send SMS'**
  String get sendSmsTitle;

  /// No description provided for @sendSmsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Send SMS to Members'**
  String get sendSmsSubtitle;

  /// No description provided for @chooseSmsSendType.
  ///
  /// In en, this message translates to:
  /// **'Choose how to send SMS'**
  String get chooseSmsSendType;

  /// No description provided for @sendToAll.
  ///
  /// In en, this message translates to:
  /// **'Send to All'**
  String get sendToAll;

  /// No description provided for @chooseMembers.
  ///
  /// In en, this message translates to:
  /// **'Choose Members'**
  String get chooseMembers;

  /// No description provided for @selected.
  ///
  /// In en, this message translates to:
  /// **'Selected'**
  String get selected;

  /// No description provided for @sendSms.
  ///
  /// In en, this message translates to:
  /// **'Send SMS'**
  String get sendSms;

  /// No description provided for @sendSmsWithCount.
  ///
  /// In en, this message translates to:
  /// **'Send SMS ({count})'**
  String sendSmsWithCount(Object count);

  /// No description provided for @selectMembersToSendSms.
  ///
  /// In en, this message translates to:
  /// **'Please select members to send SMS to'**
  String get selectMembersToSendSms;

  /// No description provided for @noMembersToSendSms.
  ///
  /// In en, this message translates to:
  /// **'No members to send SMS to'**
  String get noMembersToSendSms;

  /// No description provided for @smsGreeting.
  ///
  /// In en, this message translates to:
  /// **'Dear {name},'**
  String smsGreeting(Object name);

  /// No description provided for @smsSummaryHeader.
  ///
  /// In en, this message translates to:
  /// **'Meeting summary:'**
  String get smsSummaryHeader;

  /// No description provided for @smsTotalShares.
  ///
  /// In en, this message translates to:
  /// **'Total Shares: {shares} ( {value})'**
  String smsTotalShares(Object shares, Object value);

  /// No description provided for @smsSocialFund.
  ///
  /// In en, this message translates to:
  /// **'Social Fund:  {amount}'**
  String smsSocialFund(Object amount);

  /// No description provided for @smsCurrentLoan.
  ///
  /// In en, this message translates to:
  /// **'Current Loan:  {amount}'**
  String smsCurrentLoan(Object amount);

  /// No description provided for @smsFine.
  ///
  /// In en, this message translates to:
  /// **'Fine:  {amount}'**
  String smsFine(Object amount);

  /// No description provided for @failedToCloseMeeting.
  ///
  /// In en, this message translates to:
  /// **'Failed to close meeting'**
  String get failedToCloseMeeting;

  /// No description provided for @meetingNotFound.
  ///
  /// In en, this message translates to:
  /// **'Meeting not found'**
  String get meetingNotFound;

  /// No description provided for @failedToCloseMeetingWithError.
  ///
  /// In en, this message translates to:
  /// **'Failed to close meeting: {error}'**
  String failedToCloseMeetingWithError(Object error);

  /// No description provided for @agentPreparedAndOnTime.
  ///
  /// In en, this message translates to:
  /// **'Did the agent prepare well and arrive on time?'**
  String get agentPreparedAndOnTime;

  /// No description provided for @agentExplainedChomoka.
  ///
  /// In en, this message translates to:
  /// **'Did the agent explain how to use the Chomoka system?'**
  String get agentExplainedChomoka;

  /// No description provided for @pleaseAnswerThisQuestion.
  ///
  /// In en, this message translates to:
  /// **'Please answer this question.'**
  String get pleaseAnswerThisQuestion;

  /// No description provided for @agentExplainedCosts.
  ///
  /// In en, this message translates to:
  /// **'Did the agent clearly and transparently explain the costs?'**
  String get agentExplainedCosts;

  /// No description provided for @agentRating.
  ///
  /// In en, this message translates to:
  /// **'How would you rate the Chomoka agent?'**
  String get agentRating;

  /// No description provided for @agentRatingLevel1.
  ///
  /// In en, this message translates to:
  /// **'1. Poor'**
  String get agentRatingLevel1;

  /// No description provided for @agentRatingLevel2.
  ///
  /// In en, this message translates to:
  /// **'2. Fair'**
  String get agentRatingLevel2;

  /// No description provided for @agentRatingLevel3.
  ///
  /// In en, this message translates to:
  /// **'3. Good'**
  String get agentRatingLevel3;

  /// No description provided for @agentRatingLevel4.
  ///
  /// In en, this message translates to:
  /// **'4. Very Good'**
  String get agentRatingLevel4;

  /// No description provided for @agentRatingLevel5.
  ///
  /// In en, this message translates to:
  /// **'5. Excellent'**
  String get agentRatingLevel5;

  /// No description provided for @pleaseChooseRating.
  ///
  /// In en, this message translates to:
  /// **'Please choose a rating.'**
  String get pleaseChooseRating;

  /// No description provided for @unansweredQuestion.
  ///
  /// In en, this message translates to:
  /// **'Do you have any question the agent did not answer or you were not satisfied with?'**
  String get unansweredQuestion;

  /// No description provided for @question.
  ///
  /// In en, this message translates to:
  /// **'Question'**
  String get question;

  /// No description provided for @pleaseWriteQuestion.
  ///
  /// In en, this message translates to:
  /// **'Please write your question.'**
  String get pleaseWriteQuestion;

  /// No description provided for @suggestionForChomoka.
  ///
  /// In en, this message translates to:
  /// **'What changes do you suggest for the Chomoka system?'**
  String get suggestionForChomoka;

  /// No description provided for @suggestion.
  ///
  /// In en, this message translates to:
  /// **'Suggestion'**
  String get suggestion;

  /// No description provided for @pleaseWriteSuggestion.
  ///
  /// In en, this message translates to:
  /// **'Please write your suggestion.'**
  String get pleaseWriteSuggestion;

  /// No description provided for @noMeeting.
  ///
  /// In en, this message translates to:
  /// **'No Meeting'**
  String get noMeeting;

  /// No description provided for @noMeetingDesc.
  ///
  /// In en, this message translates to:
  /// **'No meeting has been held in this cycle, please hold a meeting to continue with the shareout.'**
  String get noMeetingDesc;

  /// No description provided for @meetingInProgress.
  ///
  /// In en, this message translates to:
  /// **'Meeting In Progress'**
  String get meetingInProgress;

  /// No description provided for @meetingInProgressDesc.
  ///
  /// In en, this message translates to:
  /// **'Please finish the meeting to continue with the shareout.'**
  String get meetingInProgressDesc;

  /// No description provided for @shareout.
  ///
  /// In en, this message translates to:
  /// **'Shareout'**
  String get shareout;

  /// No description provided for @chooseShareoutType.
  ///
  /// In en, this message translates to:
  /// **'Choose Shareout Type'**
  String get chooseShareoutType;

  /// No description provided for @groupShareout.
  ///
  /// In en, this message translates to:
  /// **'Group Shareout'**
  String get groupShareout;

  /// No description provided for @groupShareoutDesc.
  ///
  /// In en, this message translates to:
  /// **'We have completed our cycle and want to do a shareout. We want to review our group participation status.'**
  String get groupShareoutDesc;

  /// No description provided for @memberShareout.
  ///
  /// In en, this message translates to:
  /// **'Member Shareout'**
  String get memberShareout;

  /// No description provided for @memberShareoutDesc.
  ///
  /// In en, this message translates to:
  /// **'We want to completely remove a member from our group and the member cannot attend any more meetings. We want to review the member\'s participation status.'**
  String get memberShareoutDesc;

  /// No description provided for @returnToHome.
  ///
  /// In en, this message translates to:
  /// **'Return to Home'**
  String get returnToHome;

  /// No description provided for @summary.
  ///
  /// In en, this message translates to:
  /// **'Summary'**
  String get summary;

  /// No description provided for @chooseMember.
  ///
  /// In en, this message translates to:
  /// **'Choose Member'**
  String get chooseMember;

  /// No description provided for @phoneNumberLabel.
  ///
  /// In en, this message translates to:
  /// **'Phone: {phone}'**
  String phoneNumberLabel(Object phone);

  /// No description provided for @totalMandatorySavings.
  ///
  /// In en, this message translates to:
  /// **'Total mandatory savings'**
  String get totalMandatorySavings;

  /// No description provided for @totalVoluntarySavings.
  ///
  /// In en, this message translates to:
  /// **'Total voluntary savings'**
  String get totalVoluntarySavings;

  /// No description provided for @unpaidFineAmount.
  ///
  /// In en, this message translates to:
  /// **'Unpaid \nfine amount'**
  String get unpaidFineAmount;

  /// No description provided for @memberOwesAmount.
  ///
  /// In en, this message translates to:
  /// **'Member owes \nan amount of'**
  String get memberOwesAmount;

  /// No description provided for @totalShareoutAmount.
  ///
  /// In en, this message translates to:
  /// **'Total shareout amount'**
  String get totalShareoutAmount;

  /// No description provided for @confirmShareout.
  ///
  /// In en, this message translates to:
  /// **'Confirm Shareout'**
  String get confirmShareout;

  /// No description provided for @mandatorySavingsToBeWithdrawn.
  ///
  /// In en, this message translates to:
  /// **'Mandatory savings to be withdrawn'**
  String get mandatorySavingsToBeWithdrawn;

  /// No description provided for @voluntarySavingsToBeWithdrawn.
  ///
  /// In en, this message translates to:
  /// **'Voluntary savings to be withdrawn'**
  String get voluntarySavingsToBeWithdrawn;

  /// No description provided for @memberMustPayAmount.
  ///
  /// In en, this message translates to:
  /// **'Member must \npay an amount'**
  String get memberMustPayAmount;

  /// No description provided for @cashPayment.
  ///
  /// In en, this message translates to:
  /// **'Cash Payment'**
  String get cashPayment;

  /// No description provided for @noPaymentToMember.
  ///
  /// In en, this message translates to:
  /// **'Member will not \nreceive any payment'**
  String get noPaymentToMember;

  /// No description provided for @totalSharesCount.
  ///
  /// In en, this message translates to:
  /// **'Total share count'**
  String get totalSharesCount;

  /// No description provided for @totalSharesValue.
  ///
  /// In en, this message translates to:
  /// **'Total share value'**
  String get totalSharesValue;

  /// No description provided for @enterKeysToContinue.
  ///
  /// In en, this message translates to:
  /// **'Enter keys to continue'**
  String get enterKeysToContinue;

  /// No description provided for @smsSummaryTitle.
  ///
  /// In en, this message translates to:
  /// **'Send summary via SMS'**
  String get smsSummaryTitle;

  /// No description provided for @smsYes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get smsYes;

  /// No description provided for @smsNo.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get smsNo;

  /// No description provided for @groupShareTitle.
  ///
  /// In en, this message translates to:
  /// **'Group Share'**
  String get groupShareTitle;

  /// No description provided for @noMembersInGroup.
  ///
  /// In en, this message translates to:
  /// **'There are no members in this group.'**
  String get noMembersInGroup;

  /// No description provided for @selectMember.
  ///
  /// In en, this message translates to:
  /// **'Select member'**
  String get selectMember;

  /// No description provided for @totalFine.
  ///
  /// In en, this message translates to:
  /// **'Total Collected Fines'**
  String get totalFine;

  /// No description provided for @totalSocialFund.
  ///
  /// In en, this message translates to:
  /// **'Total Social Fund'**
  String get totalSocialFund;

  /// No description provided for @totalShareAmount.
  ///
  /// In en, this message translates to:
  /// **'Shares: {shares} ({percentage}%)'**
  String totalShareAmount(Object percentage, Object shares);

  /// No description provided for @unpaidLoanMsg.
  ///
  /// In en, this message translates to:
  /// **'There are unpaid loan payments. Please pay all loans before continuing.'**
  String get unpaidLoanMsg;

  /// No description provided for @unpaidFineMsg.
  ///
  /// In en, this message translates to:
  /// **'There are unpaid fines. Please pay all fines before continuing.'**
  String get unpaidFineMsg;

  /// No description provided for @unpaidSocialFundMsg.
  ///
  /// In en, this message translates to:
  /// **'There are unpaid social fund payments. Please pay all payments before continuing.'**
  String get unpaidSocialFundMsg;

  /// No description provided for @unpaidCompulsorySavingsMsg.
  ///
  /// In en, this message translates to:
  /// **'There are unpaid compulsory savings. Please pay all payments before continuing.'**
  String get unpaidCompulsorySavingsMsg;

  /// No description provided for @warning.
  ///
  /// In en, this message translates to:
  /// **'Warning'**
  String get warning;

  /// No description provided for @profit.
  ///
  /// In en, this message translates to:
  /// **'Profit'**
  String get profit;

  /// No description provided for @totalExtraCollected.
  ///
  /// In en, this message translates to:
  /// **'Total Extra Collected'**
  String get totalExtraCollected;

  /// No description provided for @totalUnpaidAmount.
  ///
  /// In en, this message translates to:
  /// **'Total unpaid amount:  {amount}'**
  String totalUnpaidAmount(Object amount);

  /// No description provided for @totalWithdrawnFromSocialFund.
  ///
  /// In en, this message translates to:
  /// **'Total Withdrawn from Social Fund'**
  String get totalWithdrawnFromSocialFund;

  /// No description provided for @totalFunds.
  ///
  /// In en, this message translates to:
  /// **'Total Funds'**
  String get totalFunds;

  /// No description provided for @expenses.
  ///
  /// In en, this message translates to:
  /// **'Expenses'**
  String get expenses;

  /// No description provided for @otherGroupExpenses.
  ///
  /// In en, this message translates to:
  /// **'Other Group Expenses'**
  String get otherGroupExpenses;

  /// No description provided for @amountRemaining.
  ///
  /// In en, this message translates to:
  /// **'Amount Remaining'**
  String get amountRemaining;

  /// No description provided for @socialFundCarriedForward.
  ///
  /// In en, this message translates to:
  /// **'Social Fund Carried Forward to Next Cycle'**
  String get socialFundCarriedForward;

  /// No description provided for @totalShareFunds.
  ///
  /// In en, this message translates to:
  /// **'Total Share Funds'**
  String get totalShareFunds;

  /// No description provided for @amountNextCycleSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Amount carried to next cycle'**
  String get amountNextCycleSubtitle;

  /// No description provided for @sendToNextCycle.
  ///
  /// In en, this message translates to:
  /// **'Send to next cycle'**
  String get sendToNextCycle;

  /// No description provided for @enterAmountNextCycle.
  ///
  /// In en, this message translates to:
  /// **'Enter the amount you want to carry to the next cycle for each fund'**
  String get enterAmountNextCycle;

  /// No description provided for @availableAmount.
  ///
  /// In en, this message translates to:
  /// **'Available  {amount}'**
  String availableAmount(Object amount);

  /// No description provided for @amountMustBeLessThanOrEqual.
  ///
  /// In en, this message translates to:
  /// **'Amount must be less than or equal to {amount}'**
  String amountMustBeLessThanOrEqual(Object amount);

  /// No description provided for @memberShareDistributionTitle.
  ///
  /// In en, this message translates to:
  /// **'Member Share Distribution'**
  String get memberShareDistributionTitle;

  /// No description provided for @shareValueAmount.
  ///
  /// In en, this message translates to:
  /// **'Share value:  {amount}'**
  String shareValueAmount(Object amount);

  /// No description provided for @totalDistributionAmount.
  ///
  /// In en, this message translates to:
  /// **'Total Distribution:  {amount}'**
  String totalDistributionAmount(Object amount);

  /// No description provided for @groupShareDistributionTitle.
  ///
  /// In en, this message translates to:
  /// **'Group Share Distribution'**
  String get groupShareDistributionTitle;

  /// No description provided for @noProfitEmoji.
  ///
  /// In en, this message translates to:
  /// **'😢'**
  String get noProfitEmoji;

  /// No description provided for @profitEmoji.
  ///
  /// In en, this message translates to:
  /// **'😊'**
  String get profitEmoji;

  /// No description provided for @noProfitMessage.
  ///
  /// In en, this message translates to:
  /// **'Your group did not make any profit'**
  String get noProfitMessage;

  /// No description provided for @profitMessage.
  ///
  /// In en, this message translates to:
  /// **'Congratulations! Your group made  {amount} as profit'**
  String profitMessage(Object amount);

  /// No description provided for @totalDistributionFunds.
  ///
  /// In en, this message translates to:
  /// **'Total distribution funds'**
  String get totalDistributionFunds;

  /// No description provided for @amountTzs.
  ///
  /// In en, this message translates to:
  /// **' {amount}'**
  String amountTzs(Object amount);

  /// No description provided for @nextCycleSocialFund.
  ///
  /// In en, this message translates to:
  /// **'Social fund amount carried to next cycle'**
  String get nextCycleSocialFund;

  /// No description provided for @nextCycleMemberSavings.
  ///
  /// In en, this message translates to:
  /// **'Total member savings carried to next cycle'**
  String get nextCycleMemberSavings;

  /// No description provided for @finishCycle.
  ///
  /// In en, this message translates to:
  /// **'Finish Cycle'**
  String get finishCycle;

  /// No description provided for @memberShareSummaryTitle.
  ///
  /// In en, this message translates to:
  /// **'Member Share Summary'**
  String get memberShareSummaryTitle;

  /// No description provided for @memberShareSummarySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Share Distribution Summary'**
  String get memberShareSummarySubtitle;

  /// No description provided for @giveToNextCycle.
  ///
  /// In en, this message translates to:
  /// **'Send to next cycle'**
  String get giveToNextCycle;

  /// No description provided for @shareInfoSection.
  ///
  /// In en, this message translates to:
  /// **'Share Information'**
  String get shareInfoSection;

  /// No description provided for @numberOfShares.
  ///
  /// In en, this message translates to:
  /// **'Number of Shares:'**
  String get numberOfShares;

  /// No description provided for @sharePercentage.
  ///
  /// In en, this message translates to:
  /// **'Share Percentage:'**
  String get sharePercentage;

  /// No description provided for @profitInfoSection.
  ///
  /// In en, this message translates to:
  /// **'Profit Information'**
  String get profitInfoSection;

  /// No description provided for @profitShare.
  ///
  /// In en, this message translates to:
  /// **'Profit Share (based on shares):'**
  String get profitShare;

  /// No description provided for @socialFundShare.
  ///
  /// In en, this message translates to:
  /// **'Social Fund Share:'**
  String get socialFundShare;

  /// No description provided for @distributionSummarySection.
  ///
  /// In en, this message translates to:
  /// **'Distribution Summary'**
  String get distributionSummarySection;

  /// No description provided for @summaryShareValue.
  ///
  /// In en, this message translates to:
  /// **'Share Value:'**
  String get summaryShareValue;

  /// No description provided for @summaryProfit.
  ///
  /// In en, this message translates to:
  /// **'Profit:'**
  String get summaryProfit;

  /// No description provided for @summarySocialFund.
  ///
  /// In en, this message translates to:
  /// **'Social Fund:'**
  String get summarySocialFund;

  /// No description provided for @summaryTotalDistribution.
  ///
  /// In en, this message translates to:
  /// **'Total Distribution:'**
  String get summaryTotalDistribution;

  /// No description provided for @paymentInfoSection.
  ///
  /// In en, this message translates to:
  /// **'Payment Information'**
  String get paymentInfoSection;

  /// No description provided for @amountToNextCycle.
  ///
  /// In en, this message translates to:
  /// **'Amount to next cycle:'**
  String get amountToNextCycle;

  /// No description provided for @paymentAmount.
  ///
  /// In en, this message translates to:
  /// **'Payment Amount:'**
  String get paymentAmount;

  /// No description provided for @inputAmountForNextCycle.
  ///
  /// In en, this message translates to:
  /// **'Enter amount for next cycle'**
  String get inputAmountForNextCycle;

  /// No description provided for @confirmButton.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirmButton;

  /// No description provided for @amountMustBeLessThanOrEqualTotal.
  ///
  /// In en, this message translates to:
  /// **'The amount must be less than or equal to the total distribution.'**
  String get amountMustBeLessThanOrEqualTotal;

  /// No description provided for @successfullyPaid.
  ///
  /// In en, this message translates to:
  /// **'Paid successfully'**
  String get successfullyPaid;

  /// No description provided for @groupActivitiesTitle.
  ///
  /// In en, this message translates to:
  /// **'Group Activities'**
  String get groupActivitiesTitle;

  /// No description provided for @groupBusiness.
  ///
  /// In en, this message translates to:
  /// **'Group Business'**
  String get groupBusiness;

  /// No description provided for @otherActivities.
  ///
  /// In en, this message translates to:
  /// **'Other Activities'**
  String get otherActivities;

  /// No description provided for @training.
  ///
  /// In en, this message translates to:
  /// **'Training'**
  String get training;

  /// No description provided for @backToHome.
  ///
  /// In en, this message translates to:
  /// **'Back to Home'**
  String get backToHome;

  /// No description provided for @addTrainingTitle.
  ///
  /// In en, this message translates to:
  /// **'Add Training'**
  String get addTrainingTitle;

  /// No description provided for @editTrainingTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Training'**
  String get editTrainingTitle;

  /// No description provided for @trainingType.
  ///
  /// In en, this message translates to:
  /// **'Type of Training'**
  String get trainingType;

  /// No description provided for @enterTrainingType.
  ///
  /// In en, this message translates to:
  /// **'Enter type of training'**
  String get enterTrainingType;

  /// No description provided for @organization.
  ///
  /// In en, this message translates to:
  /// **'Organization'**
  String get organization;

  /// No description provided for @enterOrganization.
  ///
  /// In en, this message translates to:
  /// **'Enter organization name'**
  String get enterOrganization;

  /// No description provided for @chooseDate.
  ///
  /// In en, this message translates to:
  /// **'Choose date'**
  String get chooseDate;

  /// No description provided for @membersCount.
  ///
  /// In en, this message translates to:
  /// **'Number of Members'**
  String get membersCount;

  /// No description provided for @enterMembersCount.
  ///
  /// In en, this message translates to:
  /// **'Enter number of members'**
  String get enterMembersCount;

  /// No description provided for @trainer.
  ///
  /// In en, this message translates to:
  /// **'Trainer'**
  String get trainer;

  /// No description provided for @enterTrainer.
  ///
  /// In en, this message translates to:
  /// **'Enter trainer\'s name'**
  String get enterTrainer;

  /// No description provided for @saveTraining.
  ///
  /// In en, this message translates to:
  /// **'Save Training'**
  String get saveTraining;

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get saveChanges;

  /// No description provided for @trainingSaved.
  ///
  /// In en, this message translates to:
  /// **'Training saved successfully'**
  String get trainingSaved;

  /// No description provided for @trainingUpdated.
  ///
  /// In en, this message translates to:
  /// **'Training updated successfully'**
  String get trainingUpdated;

  /// No description provided for @pleaseFillAllFields.
  ///
  /// In en, this message translates to:
  /// **'Please fill all fields'**
  String get pleaseFillAllFields;

  /// No description provided for @pleaseEnterTrainingType.
  ///
  /// In en, this message translates to:
  /// **'Please enter type of training'**
  String get pleaseEnterTrainingType;

  /// No description provided for @pleaseEnterOrganization.
  ///
  /// In en, this message translates to:
  /// **'Please enter organization name'**
  String get pleaseEnterOrganization;

  /// No description provided for @pleaseEnterMembersCount.
  ///
  /// In en, this message translates to:
  /// **'Please enter number of members'**
  String get pleaseEnterMembersCount;

  /// No description provided for @pleaseEnterTrainer.
  ///
  /// In en, this message translates to:
  /// **'Please enter trainer\'s name'**
  String get pleaseEnterTrainer;

  /// No description provided for @trainingListTitle.
  ///
  /// In en, this message translates to:
  /// **'Training List'**
  String get trainingListTitle;

  /// No description provided for @totalTrainings.
  ///
  /// In en, this message translates to:
  /// **'Total trainings: {count}'**
  String totalTrainings(Object count);

  /// No description provided for @noTrainingsSaved.
  ///
  /// In en, this message translates to:
  /// **'No trainings saved'**
  String get noTrainingsSaved;

  /// No description provided for @addNewTraining.
  ///
  /// In en, this message translates to:
  /// **'Add Training'**
  String get addNewTraining;

  /// No description provided for @deleteTrainingTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Training'**
  String get deleteTrainingTitle;

  /// No description provided for @deleteTrainingConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this training?'**
  String get deleteTrainingConfirm;

  /// No description provided for @trainingDeleted.
  ///
  /// In en, this message translates to:
  /// **'Training deleted successfully'**
  String get trainingDeleted;

  /// No description provided for @addOtherActivityTitle.
  ///
  /// In en, this message translates to:
  /// **'Other Activities'**
  String get addOtherActivityTitle;

  /// No description provided for @editOtherActivityTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Activity'**
  String get editOtherActivityTitle;

  /// No description provided for @activityDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get activityDate;

  /// No description provided for @chooseActivityDate.
  ///
  /// In en, this message translates to:
  /// **'Choose date'**
  String get chooseActivityDate;

  /// No description provided for @activityName.
  ///
  /// In en, this message translates to:
  /// **'Activity Performed'**
  String get activityName;

  /// No description provided for @enterActivityName.
  ///
  /// In en, this message translates to:
  /// **'Enter activity performed'**
  String get enterActivityName;

  /// No description provided for @beneficiariesCount.
  ///
  /// In en, this message translates to:
  /// **'Number of Beneficiaries'**
  String get beneficiariesCount;

  /// No description provided for @enterBeneficiariesCount.
  ///
  /// In en, this message translates to:
  /// **'Enter number of beneficiaries'**
  String get enterBeneficiariesCount;

  /// No description provided for @enterLocation.
  ///
  /// In en, this message translates to:
  /// **'Enter activity location'**
  String get enterLocation;

  /// No description provided for @saveActivity.
  ///
  /// In en, this message translates to:
  /// **'Save Activity'**
  String get saveActivity;

  /// No description provided for @saveActivityChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get saveActivityChanges;

  /// No description provided for @activitySaved.
  ///
  /// In en, this message translates to:
  /// **'Activity saved successfully'**
  String get activitySaved;

  /// No description provided for @activityUpdated.
  ///
  /// In en, this message translates to:
  /// **'Activity updated successfully'**
  String get activityUpdated;

  /// No description provided for @pleaseFillAllActivityFields.
  ///
  /// In en, this message translates to:
  /// **'Please fill all fields'**
  String get pleaseFillAllActivityFields;

  /// No description provided for @pleaseEnterActivityName.
  ///
  /// In en, this message translates to:
  /// **'Please enter activity performed'**
  String get pleaseEnterActivityName;

  /// No description provided for @pleaseEnterBeneficiariesCount.
  ///
  /// In en, this message translates to:
  /// **'Please enter number of beneficiaries'**
  String get pleaseEnterBeneficiariesCount;

  /// No description provided for @pleaseEnterLocation.
  ///
  /// In en, this message translates to:
  /// **'Please enter location'**
  String get pleaseEnterLocation;

  /// No description provided for @activityListTitle.
  ///
  /// In en, this message translates to:
  /// **'Other Activities List'**
  String get activityListTitle;

  /// No description provided for @totalActivities.
  ///
  /// In en, this message translates to:
  /// **'Total activities: {count}'**
  String totalActivities(Object count);

  /// No description provided for @noActivitiesSaved.
  ///
  /// In en, this message translates to:
  /// **'No activities saved'**
  String get noActivitiesSaved;

  /// No description provided for @addNewActivity.
  ///
  /// In en, this message translates to:
  /// **'Add Activity'**
  String get addNewActivity;

  /// No description provided for @editActivity.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get editActivity;

  /// No description provided for @deleteActivity.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteActivity;

  /// No description provided for @deleteActivityTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Activity'**
  String get deleteActivityTitle;

  /// No description provided for @deleteActivityConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this activity?'**
  String get deleteActivityConfirm;

  /// No description provided for @activityDeleted.
  ///
  /// In en, this message translates to:
  /// **'Activity deleted successfully'**
  String get activityDeleted;

  /// No description provided for @orderListTitle.
  ///
  /// In en, this message translates to:
  /// **'Input Requests'**
  String get orderListTitle;

  /// No description provided for @orderListSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Request List'**
  String get orderListSubtitle;

  /// No description provided for @orderListTotalRequests.
  ///
  /// In en, this message translates to:
  /// **'Total Requests'**
  String get orderListTotalRequests;

  /// No description provided for @orderListPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get orderListPending;

  /// No description provided for @orderListApproved.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get orderListApproved;

  /// No description provided for @orderListRejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get orderListRejected;

  /// Number of requests
  ///
  /// In en, this message translates to:
  /// **'Requests {count}'**
  String orderListRequests(Object count);

  /// No description provided for @orderListRefresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get orderListRefresh;

  /// No description provided for @orderListNoRequests.
  ///
  /// In en, this message translates to:
  /// **'No requests saved'**
  String get orderListNoRequests;

  /// No description provided for @orderListAddNewPrompt.
  ///
  /// In en, this message translates to:
  /// **'Press the button to add a new request'**
  String get orderListAddNewPrompt;

  /// No description provided for @orderListDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get orderListDone;

  /// No description provided for @orderListUnknownInput.
  ///
  /// In en, this message translates to:
  /// **'Input'**
  String get orderListUnknownInput;

  /// No description provided for @orderListUnknownCompany.
  ///
  /// In en, this message translates to:
  /// **'Unknown company'**
  String get orderListUnknownCompany;

  /// No description provided for @orderListStatusApproved.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get orderListStatusApproved;

  /// No description provided for @orderListStatusRejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get orderListStatusRejected;

  /// No description provided for @orderListStatusPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get orderListStatusPending;

  /// Amount of input requested
  ///
  /// In en, this message translates to:
  /// **'Amount: {amount}'**
  String orderListAmount(Object amount);

  /// No description provided for @orderListUnknownAmount.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get orderListUnknownAmount;

  /// No description provided for @orderListUnknownDate.
  ///
  /// In en, this message translates to:
  /// **'Unknown date'**
  String get orderListUnknownDate;

  /// No description provided for @orderListPrice.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get orderListPrice;

  /// No description provided for @orderListUnknownPrice.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get orderListUnknownPrice;

  /// No description provided for @orderListFinish.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get orderListFinish;

  /// No description provided for @orderListShowAgain.
  ///
  /// In en, this message translates to:
  /// **'Show again'**
  String get orderListShowAgain;

  /// No description provided for @requestSummaryTitle.
  ///
  /// In en, this message translates to:
  /// **'Input Request Details'**
  String get requestSummaryTitle;

  /// No description provided for @requestSummaryListTitle.
  ///
  /// In en, this message translates to:
  /// **'Input Request List'**
  String get requestSummaryListTitle;

  /// Total number of requests
  ///
  /// In en, this message translates to:
  /// **'Total requests: {count}'**
  String requestSummaryTotal(Object count);

  /// No description provided for @requestSummaryStatus.
  ///
  /// In en, this message translates to:
  /// **'Request Status'**
  String get requestSummaryStatus;

  /// No description provided for @requestSummaryStatusApproved.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get requestSummaryStatusApproved;

  /// No description provided for @requestSummaryStatusRejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get requestSummaryStatusRejected;

  /// No description provided for @requestSummaryStatusPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get requestSummaryStatusPending;

  /// No description provided for @requestSummaryStatusMessageApproved.
  ///
  /// In en, this message translates to:
  /// **'Your input request has been approved. You may proceed with the purchase process.'**
  String get requestSummaryStatusMessageApproved;

  /// No description provided for @requestSummaryStatusMessageRejected.
  ///
  /// In en, this message translates to:
  /// **'Sorry, your input request was rejected. Please contact the administrator for more details.'**
  String get requestSummaryStatusMessageRejected;

  /// No description provided for @requestSummaryStatusMessagePending.
  ///
  /// In en, this message translates to:
  /// **'Your input request has been received and is pending approval. You will be notified once it is approved.'**
  String get requestSummaryStatusMessagePending;

  /// No description provided for @requestSummaryUserInfo.
  ///
  /// In en, this message translates to:
  /// **'User Information'**
  String get requestSummaryUserInfo;

  /// No description provided for @requestSummaryUserName.
  ///
  /// In en, this message translates to:
  /// **'User Name'**
  String get requestSummaryUserName;

  /// No description provided for @requestSummaryMemberNumber.
  ///
  /// In en, this message translates to:
  /// **'Member Number'**
  String get requestSummaryMemberNumber;

  /// No description provided for @requestSummaryPhone.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get requestSummaryPhone;

  /// No description provided for @requestSummaryInputType.
  ///
  /// In en, this message translates to:
  /// **'Input Type'**
  String get requestSummaryInputType;

  /// No description provided for @requestSummaryAmount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get requestSummaryAmount;

  /// No description provided for @requestSummaryRequestDate.
  ///
  /// In en, this message translates to:
  /// **'Request Date'**
  String get requestSummaryRequestDate;

  /// No description provided for @requestSummaryCompany.
  ///
  /// In en, this message translates to:
  /// **'Company'**
  String get requestSummaryCompany;

  /// No description provided for @requestSummaryPrice.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get requestSummaryPrice;

  /// No description provided for @requestSummaryCost.
  ///
  /// In en, this message translates to:
  /// **'Cost'**
  String get requestSummaryCost;

  /// No description provided for @requestSummaryUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get requestSummaryUnknown;

  /// No description provided for @requestSummaryBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get requestSummaryBack;

  /// No description provided for @requestSummaryEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get requestSummaryEdit;

  /// No description provided for @requestSummaryAddRequest.
  ///
  /// In en, this message translates to:
  /// **'Add Request'**
  String get requestSummaryAddRequest;

  /// No description provided for @requestSummaryNoRequests.
  ///
  /// In en, this message translates to:
  /// **'No requests saved'**
  String get requestSummaryNoRequests;

  /// No description provided for @requestSummaryAddNewPrompt.
  ///
  /// In en, this message translates to:
  /// **'Press the button to add a new request'**
  String get requestSummaryAddNewPrompt;

  /// No description provided for @requestInputTitle.
  ///
  /// In en, this message translates to:
  /// **'Order Input'**
  String get requestInputTitle;

  /// No description provided for @requestInputEditTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Input Request'**
  String get requestInputEditTitle;

  /// No description provided for @requestInputType.
  ///
  /// In en, this message translates to:
  /// **'Input Type'**
  String get requestInputType;

  /// No description provided for @requestInputTypeHint.
  ///
  /// In en, this message translates to:
  /// **'Enter input type'**
  String get requestInputTypeHint;

  /// No description provided for @requestInputTypeError.
  ///
  /// In en, this message translates to:
  /// **'Please enter input type'**
  String get requestInputTypeError;

  /// No description provided for @requestInputCompany.
  ///
  /// In en, this message translates to:
  /// **'Company'**
  String get requestInputCompany;

  /// No description provided for @requestInputCompanyHint.
  ///
  /// In en, this message translates to:
  /// **'Enter company name'**
  String get requestInputCompanyHint;

  /// No description provided for @requestInputCompanyError.
  ///
  /// In en, this message translates to:
  /// **'Please enter company name'**
  String get requestInputCompanyError;

  /// No description provided for @requestInputAmount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get requestInputAmount;

  /// No description provided for @requestInputAmountHint.
  ///
  /// In en, this message translates to:
  /// **'Enter amount'**
  String get requestInputAmountHint;

  /// No description provided for @requestInputAmountError.
  ///
  /// In en, this message translates to:
  /// **'Please enter amount'**
  String get requestInputAmountError;

  /// No description provided for @requestInputPrice.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get requestInputPrice;

  /// No description provided for @requestInputPriceHint.
  ///
  /// In en, this message translates to:
  /// **'Enter price'**
  String get requestInputPriceHint;

  /// No description provided for @requestInputPriceError.
  ///
  /// In en, this message translates to:
  /// **'Please enter price'**
  String get requestInputPriceError;

  /// No description provided for @requestInputDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get requestInputDate;

  /// No description provided for @requestInputDateHint.
  ///
  /// In en, this message translates to:
  /// **'Select date'**
  String get requestInputDateHint;

  /// No description provided for @requestInputStatus.
  ///
  /// In en, this message translates to:
  /// **'Request Status'**
  String get requestInputStatus;

  /// No description provided for @requestInputStatusHint.
  ///
  /// In en, this message translates to:
  /// **'Select request status'**
  String get requestInputStatusHint;

  /// No description provided for @requestInputSubmit.
  ///
  /// In en, this message translates to:
  /// **'Submit Request'**
  String get requestInputSubmit;

  /// No description provided for @requestInputSaveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save Changes'**
  String get requestInputSaveChanges;

  /// No description provided for @requestInputSuccess.
  ///
  /// In en, this message translates to:
  /// **'Your request has been submitted successfully'**
  String get requestInputSuccess;

  /// No description provided for @requestInputUpdateSuccess.
  ///
  /// In en, this message translates to:
  /// **'Request updated successfully'**
  String get requestInputUpdateSuccess;

  /// Error message
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String requestInputError(Object error);

  /// No description provided for @requestInputFillAll.
  ///
  /// In en, this message translates to:
  /// **'Please fill all fields'**
  String get requestInputFillAll;

  /// No description provided for @businessDashboardTitle.
  ///
  /// In en, this message translates to:
  /// **'Business Dashboard'**
  String get businessDashboardTitle;

  /// No description provided for @businessDashboardDefaultTitle.
  ///
  /// In en, this message translates to:
  /// **'Business Dashboard'**
  String get businessDashboardDefaultTitle;

  /// No description provided for @businessDashboardLocationUnknown.
  ///
  /// In en, this message translates to:
  /// **'No location'**
  String get businessDashboardLocationUnknown;

  /// No description provided for @businessDashboardProductType.
  ///
  /// In en, this message translates to:
  /// **'Product Type'**
  String get businessDashboardProductType;

  /// No description provided for @businessDashboardProductTypeUnknown.
  ///
  /// In en, this message translates to:
  /// **'No product'**
  String get businessDashboardProductTypeUnknown;

  /// No description provided for @businessDashboardStartDate.
  ///
  /// In en, this message translates to:
  /// **'Start Date'**
  String get businessDashboardStartDate;

  /// No description provided for @businessDashboardDateUnknown.
  ///
  /// In en, this message translates to:
  /// **'No date'**
  String get businessDashboardDateUnknown;

  /// No description provided for @businessDashboardStats.
  ///
  /// In en, this message translates to:
  /// **'Business Statistics'**
  String get businessDashboardStats;

  /// No description provided for @businessDashboardPurchases.
  ///
  /// In en, this message translates to:
  /// **'Purchases'**
  String get businessDashboardPurchases;

  /// No description provided for @businessDashboardSales.
  ///
  /// In en, this message translates to:
  /// **'Sales'**
  String get businessDashboardSales;

  /// No description provided for @businessDashboardExpenses.
  ///
  /// In en, this message translates to:
  /// **'Expenses'**
  String get businessDashboardExpenses;

  /// No description provided for @businessDashboardProfit.
  ///
  /// In en, this message translates to:
  /// **'Profit'**
  String get businessDashboardProfit;

  /// No description provided for @businessDashboardActions.
  ///
  /// In en, this message translates to:
  /// **'Actions'**
  String get businessDashboardActions;

  /// No description provided for @businessDashboardProfitShare.
  ///
  /// In en, this message translates to:
  /// **'Profit Distribution'**
  String get businessDashboardProfitShare;

  /// No description provided for @businessDashboardActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get businessDashboardActive;

  /// No description provided for @businessDashboardInactive.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get businessDashboardInactive;

  /// No description provided for @businessDashboardPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get businessDashboardPending;

  /// No description provided for @businessDashboardStatus.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get businessDashboardStatus;

  /// Error message
  ///
  /// In en, this message translates to:
  /// **'Error: {error}'**
  String businessDashboardError(Object error);

  /// No description provided for @businessListTitle.
  ///
  /// In en, this message translates to:
  /// **'Business List'**
  String get businessListTitle;

  /// Number of businesses
  ///
  /// In en, this message translates to:
  /// **'Businesses {count}'**
  String businessListCount(Object count);

  /// No description provided for @businessListRefresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get businessListRefresh;

  /// No description provided for @businessListNoBusinesses.
  ///
  /// In en, this message translates to:
  /// **'No businesses registered'**
  String get businessListNoBusinesses;

  /// No description provided for @businessListAddPrompt.
  ///
  /// In en, this message translates to:
  /// **'Tap the + button to add a business'**
  String get businessListAddPrompt;

  /// No description provided for @businessListViewMore.
  ///
  /// In en, this message translates to:
  /// **'View More'**
  String get businessListViewMore;

  /// No description provided for @businessListLocationUnknown.
  ///
  /// In en, this message translates to:
  /// **'No location'**
  String get businessListLocationUnknown;

  /// No description provided for @businessListProductTypeUnknown.
  ///
  /// In en, this message translates to:
  /// **'No product'**
  String get businessListProductTypeUnknown;

  /// No description provided for @businessListStatusActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get businessListStatusActive;

  /// No description provided for @businessListStatusInactive.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get businessListStatusInactive;

  /// No description provided for @businessListStatusPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get businessListStatusPending;

  /// No description provided for @businessListDateUnknown.
  ///
  /// In en, this message translates to:
  /// **'No date'**
  String get businessListDateUnknown;

  /// No description provided for @businessInformationTitle.
  ///
  /// In en, this message translates to:
  /// **'Business Information'**
  String get businessInformationTitle;

  /// No description provided for @businessInformationName.
  ///
  /// In en, this message translates to:
  /// **'Business Name'**
  String get businessInformationName;

  /// No description provided for @businessInformationNameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter business name'**
  String get businessInformationNameHint;

  /// No description provided for @businessInformationNameAbove.
  ///
  /// In en, this message translates to:
  /// **'Business Name:'**
  String get businessInformationNameAbove;

  /// No description provided for @businessInformationNameError.
  ///
  /// In en, this message translates to:
  /// **'Please enter business name'**
  String get businessInformationNameError;

  /// No description provided for @businessInformationLocation.
  ///
  /// In en, this message translates to:
  /// **'Business Location'**
  String get businessInformationLocation;

  /// No description provided for @businessInformationLocationHint.
  ///
  /// In en, this message translates to:
  /// **'Enter business location'**
  String get businessInformationLocationHint;

  /// No description provided for @businessInformationLocationAbove.
  ///
  /// In en, this message translates to:
  /// **'Business Location:'**
  String get businessInformationLocationAbove;

  /// No description provided for @businessInformationLocationError.
  ///
  /// In en, this message translates to:
  /// **'Please enter business location'**
  String get businessInformationLocationError;

  /// No description provided for @businessInformationStartDate.
  ///
  /// In en, this message translates to:
  /// **'Business Start Date'**
  String get businessInformationStartDate;

  /// No description provided for @businessInformationStartDateHint.
  ///
  /// In en, this message translates to:
  /// **'Select date'**
  String get businessInformationStartDateHint;

  /// No description provided for @businessInformationStartDateAbove.
  ///
  /// In en, this message translates to:
  /// **'Business Start Date:'**
  String get businessInformationStartDateAbove;

  /// No description provided for @businessInformationProductTypeAbove.
  ///
  /// In en, this message translates to:
  /// **'Product Type:'**
  String get businessInformationProductTypeAbove;

  /// No description provided for @businessInformationProductType.
  ///
  /// In en, this message translates to:
  /// **'Product Type'**
  String get businessInformationProductType;

  /// No description provided for @businessInformationProductTypeError.
  ///
  /// In en, this message translates to:
  /// **'Please select product type'**
  String get businessInformationProductTypeError;

  /// No description provided for @businessInformationOtherProductType.
  ///
  /// In en, this message translates to:
  /// **'Specify Product Type'**
  String get businessInformationOtherProductType;

  /// No description provided for @businessInformationOtherProductTypeHint.
  ///
  /// In en, this message translates to:
  /// **'Enter product type'**
  String get businessInformationOtherProductTypeHint;

  /// No description provided for @businessInformationOtherProductTypeAbove.
  ///
  /// In en, this message translates to:
  /// **'Specify Product Type:'**
  String get businessInformationOtherProductTypeAbove;

  /// No description provided for @businessInformationOtherProductTypeError.
  ///
  /// In en, this message translates to:
  /// **'Please enter product type'**
  String get businessInformationOtherProductTypeError;

  /// No description provided for @businessInformationSave.
  ///
  /// In en, this message translates to:
  /// **'Save Information'**
  String get businessInformationSave;

  /// No description provided for @businessInformationSaved.
  ///
  /// In en, this message translates to:
  /// **'Business information saved successfully'**
  String get businessInformationSaved;

  /// No description provided for @businessSummaryTitle.
  ///
  /// In en, this message translates to:
  /// **'Business Summary'**
  String get businessSummaryTitle;

  /// No description provided for @businessSummaryNoInfo.
  ///
  /// In en, this message translates to:
  /// **'No business information'**
  String get businessSummaryNoInfo;

  /// No description provided for @businessSummaryRegisterPrompt.
  ///
  /// In en, this message translates to:
  /// **'Please register a business first to see the summary'**
  String get businessSummaryRegisterPrompt;

  /// No description provided for @businessSummaryRegister.
  ///
  /// In en, this message translates to:
  /// **'Register Business'**
  String get businessSummaryRegister;

  /// No description provided for @businessSummaryDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get businessSummaryDone;

  /// No description provided for @businessSummaryInfo.
  ///
  /// In en, this message translates to:
  /// **'Business Information'**
  String get businessSummaryInfo;

  /// No description provided for @businessSummaryName.
  ///
  /// In en, this message translates to:
  /// **'Business Name:'**
  String get businessSummaryName;

  /// No description provided for @businessSummaryLocation.
  ///
  /// In en, this message translates to:
  /// **'Business Location:'**
  String get businessSummaryLocation;

  /// No description provided for @businessSummaryStartDate.
  ///
  /// In en, this message translates to:
  /// **'Start Date:'**
  String get businessSummaryStartDate;

  /// No description provided for @businessSummaryProductType.
  ///
  /// In en, this message translates to:
  /// **'Product Type:'**
  String get businessSummaryProductType;

  /// No description provided for @businessSummaryOtherProductType.
  ///
  /// In en, this message translates to:
  /// **'Other Product Type:'**
  String get businessSummaryOtherProductType;

  /// No description provided for @businessSummaryEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit Information'**
  String get businessSummaryEdit;

  /// No description provided for @expensesListTitle.
  ///
  /// In en, this message translates to:
  /// **'Expenses List'**
  String get expensesListTitle;

  /// No description provided for @expensesListNoExpenses.
  ///
  /// In en, this message translates to:
  /// **'No expenses recorded'**
  String get expensesListNoExpenses;

  /// No description provided for @expensesListAddPrompt.
  ///
  /// In en, this message translates to:
  /// **'Tap the + button to add an expense'**
  String get expensesListAddPrompt;

  /// No description provided for @expensesListAddExpense.
  ///
  /// In en, this message translates to:
  /// **'Add Expense'**
  String get expensesListAddExpense;

  /// No description provided for @expensesListAmount.
  ///
  /// In en, this message translates to:
  /// **'TSh {amount}'**
  String expensesListAmount(Object amount);

  /// No description provided for @expensesListReason.
  ///
  /// In en, this message translates to:
  /// **'Reason: {reason}'**
  String expensesListReason(Object reason);

  /// No description provided for @expensesListPayer.
  ///
  /// In en, this message translates to:
  /// **'Payer: {payer}'**
  String expensesListPayer(Object payer);

  /// No description provided for @expensesListUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get expensesListUnknown;

  /// No description provided for @expensesListNoDate.
  ///
  /// In en, this message translates to:
  /// **'No date'**
  String get expensesListNoDate;

  /// No description provided for @purchaseListTitle.
  ///
  /// In en, this message translates to:
  /// **'Purchase List'**
  String get purchaseListTitle;

  /// No description provided for @purchaseListNoPurchases.
  ///
  /// In en, this message translates to:
  /// **'No purchases recorded'**
  String get purchaseListNoPurchases;

  /// No description provided for @purchaseListAddPrompt.
  ///
  /// In en, this message translates to:
  /// **'Tap the + button to add a purchase'**
  String get purchaseListAddPrompt;

  /// No description provided for @purchaseListAddPurchase.
  ///
  /// In en, this message translates to:
  /// **'Add Purchase'**
  String get purchaseListAddPurchase;

  /// No description provided for @purchaseListAmount.
  ///
  /// In en, this message translates to:
  /// **'TSh {amount}'**
  String purchaseListAmount(Object amount);

  /// No description provided for @purchaseListBuyer.
  ///
  /// In en, this message translates to:
  /// **'Buyer: {buyer}'**
  String purchaseListBuyer(Object buyer);

  /// No description provided for @purchaseListUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get purchaseListUnknown;

  /// No description provided for @purchaseListNoDate.
  ///
  /// In en, this message translates to:
  /// **'No date'**
  String get purchaseListNoDate;

  /// No description provided for @saleListTitle.
  ///
  /// In en, this message translates to:
  /// **'Sales List'**
  String get saleListTitle;

  /// No description provided for @saleListNoSales.
  ///
  /// In en, this message translates to:
  /// **'No sales recorded'**
  String get saleListNoSales;

  /// No description provided for @saleListAddPrompt.
  ///
  /// In en, this message translates to:
  /// **'Tap the + button to add a sale'**
  String get saleListAddPrompt;

  /// No description provided for @saleListAddSale.
  ///
  /// In en, this message translates to:
  /// **'Add Sale'**
  String get saleListAddSale;

  /// No description provided for @saleListAmount.
  ///
  /// In en, this message translates to:
  /// **'TSh {amount}'**
  String saleListAmount(Object amount);

  /// No description provided for @saleListCustomer.
  ///
  /// In en, this message translates to:
  /// **'Customer: {customer}'**
  String saleListCustomer(Object customer);

  /// No description provided for @saleListSeller.
  ///
  /// In en, this message translates to:
  /// **'Seller: {seller}'**
  String saleListSeller(Object seller);

  /// No description provided for @saleListUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get saleListUnknown;

  /// No description provided for @saleListNoDate.
  ///
  /// In en, this message translates to:
  /// **'No date'**
  String get saleListNoDate;

  /// No description provided for @expensesTitle.
  ///
  /// In en, this message translates to:
  /// **'Record Expense'**
  String get expensesTitle;

  /// No description provided for @expensesBusinessName.
  ///
  /// In en, this message translates to:
  /// **'Business'**
  String get expensesBusinessName;

  /// No description provided for @expensesBusinessLocationUnknown.
  ///
  /// In en, this message translates to:
  /// **'No location'**
  String get expensesBusinessLocationUnknown;

  /// No description provided for @expensesInfo.
  ///
  /// In en, this message translates to:
  /// **'Expense Information'**
  String get expensesInfo;

  /// No description provided for @expensesDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get expensesDate;

  /// No description provided for @expensesDateHint.
  ///
  /// In en, this message translates to:
  /// **'dd/mm/yyyy'**
  String get expensesDateHint;

  /// No description provided for @expensesDateError.
  ///
  /// In en, this message translates to:
  /// **'Please select a date'**
  String get expensesDateError;

  /// No description provided for @expensesDateAbove.
  ///
  /// In en, this message translates to:
  /// **'Expense Date'**
  String get expensesDateAbove;

  /// No description provided for @expensesReason.
  ///
  /// In en, this message translates to:
  /// **'Expense Reason'**
  String get expensesReason;

  /// No description provided for @expensesReasonHint.
  ///
  /// In en, this message translates to:
  /// **'Enter expense reason'**
  String get expensesReasonHint;

  /// No description provided for @expensesReasonError.
  ///
  /// In en, this message translates to:
  /// **'Please enter expense reason'**
  String get expensesReasonError;

  /// No description provided for @expensesReasonAbove.
  ///
  /// In en, this message translates to:
  /// **'Expense Reason'**
  String get expensesReasonAbove;

  /// No description provided for @expensesAmount.
  ///
  /// In en, this message translates to:
  /// **'Expense Amount'**
  String get expensesAmount;

  /// No description provided for @expensesAmountHint.
  ///
  /// In en, this message translates to:
  /// **'Enter amount in TSh'**
  String get expensesAmountHint;

  /// No description provided for @expensesAmountError.
  ///
  /// In en, this message translates to:
  /// **'Please enter amount'**
  String get expensesAmountError;

  /// No description provided for @expensesAmountInvalidError.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid number'**
  String get expensesAmountInvalidError;

  /// No description provided for @expensesAmountAbove.
  ///
  /// In en, this message translates to:
  /// **'Amount (TSh)'**
  String get expensesAmountAbove;

  /// No description provided for @expensesPayer.
  ///
  /// In en, this message translates to:
  /// **'Payer Name'**
  String get expensesPayer;

  /// No description provided for @expensesPayerHint.
  ///
  /// In en, this message translates to:
  /// **'Enter payer name'**
  String get expensesPayerHint;

  /// No description provided for @expensesPayerError.
  ///
  /// In en, this message translates to:
  /// **'Please enter payer name'**
  String get expensesPayerError;

  /// No description provided for @expensesPayerAbove.
  ///
  /// In en, this message translates to:
  /// **'Payer'**
  String get expensesPayerAbove;

  /// No description provided for @expensesDescription.
  ///
  /// In en, this message translates to:
  /// **'Expense Description'**
  String get expensesDescription;

  /// No description provided for @expensesDescriptionHint.
  ///
  /// In en, this message translates to:
  /// **'Enter additional expense details'**
  String get expensesDescriptionHint;

  /// No description provided for @expensesDescriptionAbove.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get expensesDescriptionAbove;

  /// No description provided for @expensesSave.
  ///
  /// In en, this message translates to:
  /// **'Save Information'**
  String get expensesSave;

  /// No description provided for @purchasesTitle.
  ///
  /// In en, this message translates to:
  /// **'Record Purchase'**
  String get purchasesTitle;

  /// No description provided for @purchasesBusinessName.
  ///
  /// In en, this message translates to:
  /// **'Business'**
  String get purchasesBusinessName;

  /// No description provided for @purchasesBusinessLocationUnknown.
  ///
  /// In en, this message translates to:
  /// **'No location'**
  String get purchasesBusinessLocationUnknown;

  /// No description provided for @purchasesInfo.
  ///
  /// In en, this message translates to:
  /// **'Purchase Information'**
  String get purchasesInfo;

  /// No description provided for @purchasesDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get purchasesDate;

  /// No description provided for @purchasesDateHint.
  ///
  /// In en, this message translates to:
  /// **'dd/mm/yyyy'**
  String get purchasesDateHint;

  /// No description provided for @purchasesDateError.
  ///
  /// In en, this message translates to:
  /// **'Please select a date'**
  String get purchasesDateError;

  /// No description provided for @purchasesDateAbove.
  ///
  /// In en, this message translates to:
  /// **'Purchase Date'**
  String get purchasesDateAbove;

  /// No description provided for @purchasesAmount.
  ///
  /// In en, this message translates to:
  /// **'Purchase Amount'**
  String get purchasesAmount;

  /// No description provided for @purchasesAmountHint.
  ///
  /// In en, this message translates to:
  /// **'Enter amount in TSh'**
  String get purchasesAmountHint;

  /// No description provided for @purchasesAmountError.
  ///
  /// In en, this message translates to:
  /// **'Please enter amount'**
  String get purchasesAmountError;

  /// No description provided for @purchasesAmountInvalidError.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid number'**
  String get purchasesAmountInvalidError;

  /// No description provided for @purchasesAmountAbove.
  ///
  /// In en, this message translates to:
  /// **'Purchase Cost'**
  String get purchasesAmountAbove;

  /// No description provided for @purchasesBuyer.
  ///
  /// In en, this message translates to:
  /// **'Buyer Name'**
  String get purchasesBuyer;

  /// No description provided for @purchasesBuyerHint.
  ///
  /// In en, this message translates to:
  /// **'Enter buyer name'**
  String get purchasesBuyerHint;

  /// No description provided for @purchasesBuyerError.
  ///
  /// In en, this message translates to:
  /// **'Please enter buyer name'**
  String get purchasesBuyerError;

  /// No description provided for @purchasesBuyerAbove.
  ///
  /// In en, this message translates to:
  /// **'Buyer'**
  String get purchasesBuyerAbove;

  /// No description provided for @purchasesDescription.
  ///
  /// In en, this message translates to:
  /// **'Purchase Description'**
  String get purchasesDescription;

  /// No description provided for @purchasesDescriptionHint.
  ///
  /// In en, this message translates to:
  /// **'Enter additional purchase details'**
  String get purchasesDescriptionHint;

  /// No description provided for @purchasesDescriptionAbove.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get purchasesDescriptionAbove;

  /// No description provided for @purchasesSave.
  ///
  /// In en, this message translates to:
  /// **'Save Information'**
  String get purchasesSave;

  /// No description provided for @salesTitle.
  ///
  /// In en, this message translates to:
  /// **'Record Sale'**
  String get salesTitle;

  /// No description provided for @salesBusinessName.
  ///
  /// In en, this message translates to:
  /// **'Business'**
  String get salesBusinessName;

  /// No description provided for @salesBusinessLocationUnknown.
  ///
  /// In en, this message translates to:
  /// **'No location'**
  String get salesBusinessLocationUnknown;

  /// No description provided for @salesInfo.
  ///
  /// In en, this message translates to:
  /// **'Sales Information'**
  String get salesInfo;

  /// No description provided for @salesDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get salesDate;

  /// No description provided for @salesDateHint.
  ///
  /// In en, this message translates to:
  /// **'dd/mm/yyyy'**
  String get salesDateHint;

  /// No description provided for @salesDateError.
  ///
  /// In en, this message translates to:
  /// **'Please select a date'**
  String get salesDateError;

  /// No description provided for @salesDateAbove.
  ///
  /// In en, this message translates to:
  /// **'Sale Date'**
  String get salesDateAbove;

  /// No description provided for @salesCustomer.
  ///
  /// In en, this message translates to:
  /// **'Customer Name'**
  String get salesCustomer;

  /// No description provided for @salesCustomerHint.
  ///
  /// In en, this message translates to:
  /// **'Enter customer name'**
  String get salesCustomerHint;

  /// No description provided for @salesCustomerError.
  ///
  /// In en, this message translates to:
  /// **'Please enter customer name'**
  String get salesCustomerError;

  /// No description provided for @salesCustomerAbove.
  ///
  /// In en, this message translates to:
  /// **'Customer'**
  String get salesCustomerAbove;

  /// No description provided for @salesRevenue.
  ///
  /// In en, this message translates to:
  /// **'Revenue Amount'**
  String get salesRevenue;

  /// No description provided for @salesRevenueHint.
  ///
  /// In en, this message translates to:
  /// **'Enter amount in TSh'**
  String get salesRevenueHint;

  /// No description provided for @salesRevenueError.
  ///
  /// In en, this message translates to:
  /// **'Please enter amount'**
  String get salesRevenueError;

  /// No description provided for @salesRevenueInvalidError.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid number'**
  String get salesRevenueInvalidError;

  /// No description provided for @salesRevenueAbove.
  ///
  /// In en, this message translates to:
  /// **'Revenue'**
  String get salesRevenueAbove;

  /// No description provided for @salesSeller.
  ///
  /// In en, this message translates to:
  /// **'Seller Name'**
  String get salesSeller;

  /// No description provided for @salesSellerHint.
  ///
  /// In en, this message translates to:
  /// **'Enter seller name'**
  String get salesSellerHint;

  /// No description provided for @salesSellerError.
  ///
  /// In en, this message translates to:
  /// **'Please enter seller name'**
  String get salesSellerError;

  /// No description provided for @salesSellerAbove.
  ///
  /// In en, this message translates to:
  /// **'Seller'**
  String get salesSellerAbove;

  /// No description provided for @salesDescription.
  ///
  /// In en, this message translates to:
  /// **'Sales Description'**
  String get salesDescription;

  /// No description provided for @salesDescriptionHint.
  ///
  /// In en, this message translates to:
  /// **'Enter additional sales details'**
  String get salesDescriptionHint;

  /// No description provided for @salesDescriptionAbove.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get salesDescriptionAbove;

  /// No description provided for @salesSave.
  ///
  /// In en, this message translates to:
  /// **'Save Information'**
  String get salesSave;

  /// No description provided for @badiliSarafu.
  ///
  /// In en, this message translates to:
  /// **'Change Currency'**
  String get badiliSarafu;

  /// No description provided for @chaguaSarafuYaProgramu.
  ///
  /// In en, this message translates to:
  /// **'Select the app currency'**
  String get chaguaSarafuYaProgramu;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fr', 'pt', 'sw'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
    case 'pt':
      return AppLocalizationsPt();
    case 'sw':
      return AppLocalizationsSw();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
