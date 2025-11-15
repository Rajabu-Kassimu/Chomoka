// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Swahili (`sw`).
class AppLocalizationsSw extends AppLocalizations {
  AppLocalizationsSw([String locale = 'sw']) : super(locale);

  @override
  String get selectCountry => 'Chagua Nchi';

  @override
  String get pleaseSelectCountry => 'Tafadhali chagua nchi yako';

  @override
  String get pleaseSelectCountryError =>
      'Tafadhali chagua nchi kabla ya kuendelea.';

  @override
  String get locationInformation => 'Taarifa za Eneo';

  @override
  String get selectLanguage => 'Chagua Lugha';

  @override
  String get pleaseSelectLanguage => 'Tafadhali chagua lugha';

  @override
  String get selectRegion => 'Chagua Mkoa';

  @override
  String get pleaseSelectRegion => 'Tafadhali chagua mkoa';

  @override
  String get loan_based_on_shares =>
      'Eleza mara ngapi (x) mwanachama anaweza kukopa kulingana na hisa zake';

  @override
  String get loan_based_on_savings =>
      'Eleza mara ngapi (x) mwanachama anaweza kukopa kulingana na akiba yake';

  @override
  String get selectDistrict => 'Chagua Wilaya';

  @override
  String get pleaseSelectDistrict => 'Tafadhali chagua wilaya';

  @override
  String get selectWard => 'Chagua Kata';

  @override
  String get pleaseSelectWard => 'Tafadhali chagua kata';

  @override
  String get enterStreetOrVillage => 'Weka Mtaa au kijiji';

  @override
  String get pleaseEnterStreetOrVillage =>
      'Tafadhali weka jina la mtaa au kijiji';

  @override
  String get dataSavedSuccessfully => 'Taarifa zimehifadhiwa kikamilifu!';

  @override
  String errorSavingData(String error) {
    return 'Hitilafu katika kuhifadhi data: $error';
  }

  @override
  String get permissions => 'Ruhusu';

  @override
  String get permissionsDescription =>
      'Chomoka inahitaji ruhusa kadhaa ili ifanye kazi kwa usahihi na ufanisi.';

  @override
  String get permissionsRequest =>
      'Tafadhali kubali maombi yote ya ruhusa kuendelea kutumia Chomoka kwa urahisi.';

  @override
  String get smsPermission => 'SMS';

  @override
  String get smsDescription =>
      'Chomoka inatumia SMS bando la kutunza taarifa endapo hakuna intaneti.';

  @override
  String get locationPermission => 'Mahali mlipo';

  @override
  String get locationDescription =>
      'Ili kuboresha ufanisi wa mfumo, CHOMOKA itatumia maelezo ya mahali mlipo.';

  @override
  String get mediaPermission => 'Picha na Nyaraka';

  @override
  String get mediaDescription =>
      'Unaweza kuhifadhi picha, taarifa, na nyaraka husika kwa uthibitisho.';

  @override
  String get termsAndConditions => 'Vigezo na Masharti';

  @override
  String get aboutChomoka => 'Kuhusu Chomoka';

  @override
  String get aboutChomokaContent =>
      'Ili kutumia Chomoka lazima ukubaliane na vigezo na masharti na sera ya usiri.';

  @override
  String get dataManagement => 'Usimamizi wa Taarifa';

  @override
  String get dataManagementContent =>
      'Kwa kutumia Chomoka unakubali ukusanyaji na utunzaji wa taarifa zako. Mfumo unaweza kutumia taarifa za mahali ulipo na kutuma ujumbe kutoka kwenye simu yako.';

  @override
  String get namedData => 'Taarifa zilitajwa jina';

  @override
  String get namedDataContent =>
      'Taarifa za kikundi na wanachama zitahifadhiwa kwa ajili ya kumbukumbu. Hatutatoa taarifa hizi kwa yeyote bila idhini ya kikundi.';

  @override
  String get generalData => 'Taarifa za jumla';

  @override
  String get generalDataContent =>
      'Tutatumia taarifa za jumla bila kutaja jina la mwanachama au kikundi ili kuelewa maendeleo zaidi.';

  @override
  String get acceptTerms => 'Nakubali vigezo na masharti';

  @override
  String get confirm => 'Thibitisha';

  @override
  String get setupChomoka => 'Kuanzisha Chomoka';

  @override
  String get groupInfo => 'Taarifa za Kikundi';

  @override
  String get memberInfo => 'Taarifa za Mwanachama';

  @override
  String get constitutionInfo => 'Taarifa za Katiba';

  @override
  String get fundInfo => 'Taarifa za Mfuko';

  @override
  String get passwordSetup => 'Uwekaji wa Funguo';

  @override
  String get passwordSetupComplete => 'Uwekaji wa funguo umekamilika!';

  @override
  String get finished => 'Nimemaliza';

  @override
  String get groupInformation => 'Ingiza Taarifa za Kikundi';

  @override
  String get editGroupInformation => 'Badilisha Taarifa za Kikundi';

  @override
  String get groupName => 'Jina la Kikundi';

  @override
  String get enterGroupName => 'Ingiza Jina la Kikundi';

  @override
  String get groupNameRequired => 'Jina la kikundi ni lazima!';

  @override
  String get yearEstablished => 'Mwaka Kilipoanzishwa';

  @override
  String get enterYearEstablished => 'Ingiza Mwaka Kilipoanzishwa';

  @override
  String get yearEstablishedRequired => 'Mwaka kilipoanzishwa ni lazima!';

  @override
  String get enterValidYear => 'Tafadhali ingiza mwaka halali!';

  @override
  String enterYearRange(Object currentYear) {
    return 'Tafadhali ingiza mwaka kati ya 1999 na $currentYear!';
  }

  @override
  String get currentRound => 'Kikundi kipo mzunguko wa ngapi';

  @override
  String get enterCurrentRound => 'Ingiza mzunguko uliopo kwenye kikundi';

  @override
  String get currentRoundRequired => 'Mzunguko wa kikundi ni lazima!';

  @override
  String get enterValidRound => 'Tafadhali ingiza namba halali kwa mzunguko!';

  @override
  String get update => 'Sahihisha';

  @override
  String errorUpdatingData(Object error) {
    return 'Hitilafu katika kuhifadhi data: $error';
  }

  @override
  String get groupSummary => 'Muhtasari wa Kikundi';

  @override
  String get sessionSummary => 'Muhtasari wa Kikao';

  @override
  String get meetingFrequency => 'Mnakutana Mara Ngapi';

  @override
  String get pleaseSelectFrequency => 'Tafadhali chagua mara za kukutana!';

  @override
  String get sessionCount => 'Idadi ya Vikao';

  @override
  String get enterSessionCount => 'Ingiza Idadi ya Vikao';

  @override
  String get sessionCountRequired => 'Tafadhali ingiza idadi ya vikao';

  @override
  String get enterValidSessionCount =>
      'Tafadhali ingiza namba halali kwa vikao';

  @override
  String get pleaseNote => 'Tafadhali Zingatia:';

  @override
  String allocationDescription(String allocationDescription) {
    return 'Mgao ni Kila Baada ya $allocationDescription';
  }

  @override
  String errorOccurred(Object error) {
    return 'Kosa limetokea: $error';
  }

  @override
  String get groupRegistration => 'Usajili wa Kikundi';

  @override
  String get fines => 'Faini';

  @override
  String get lateness => 'Kachelewa';

  @override
  String get absentWithoutPermission => 'Hayupo bila ruhusa';

  @override
  String get sendingRepresentative => 'Katuma mwakilishi';

  @override
  String get speakingWithoutPermission => 'Kuongea bila ruhusa';

  @override
  String get phoneUsageDuringMeeting => 'Matumizi ya simu wakati wa kikao';

  @override
  String get leadershipMisconduct => 'Utovu wa nizamu kwa viongozi';

  @override
  String get forgettingRules => 'Kusahau kanuni';

  @override
  String get addNewFine => 'Ongeza Faini Mpya';

  @override
  String get finesWithoutAmountWontShow =>
      'Faini ambazo hazina kiasi hazitoonekana wakati wa kikao';

  @override
  String get fineType => 'Aina ya faini';

  @override
  String get addFineType => 'Ongeza Aina ya faini';

  @override
  String get amount => 'Kiasi';

  @override
  String get percentage => 'Asilimia';

  @override
  String get memberShareTitle => 'Mgao wa Wanachama';

  @override
  String get shareCount => 'Idadi ya Hisa';

  @override
  String get saveButton => 'Hifadhi';

  @override
  String get unnamed => 'Bila Jina';

  @override
  String get noPhone => 'Hakuna simu';

  @override
  String errorLoadingData(Object error) {
    return 'Hitilafu katika kupakia data: $error';
  }

  @override
  String failedToUpdateStatus(Object error) {
    return 'Imeshindwa kusasisha hali: $error';
  }

  @override
  String get fixedAmount => 'Kiasi Maalumu';

  @override
  String get enterPenaltyPercentage => 'Weka asilimia za adhabu';

  @override
  String get percentageRequired => 'Asilimia inahitajika';

  @override
  String get enterValidPercentage => 'Tafadhali ingiza asilimia halali';

  @override
  String get enterFixedAmount => 'Weka Kiasi Maalumu';

  @override
  String get fixedAmountRequired => 'Kiasi Maalumu kinakitajika';

  @override
  String get enterValidAmount => 'Tafadhali weka kiasi halali!';

  @override
  String get explainPenaltyUsage =>
      'Eleza jinsi adhabu zinatumika kwa mkopo ikiwa mwanachama atashindwa kufanya malipo yote yanayotakiwa kwa wakati.';

  @override
  String get loanDelayPenalty => 'Adhabu ya kuchelewesha mkopo';

  @override
  String get noPercentagePenalty =>
      'Hakuna adhabu ya asilimia itakayotolewa kwa kuchelewesha mkopo.';

  @override
  String percentagePenaltyExample(String percentage, String amount) {
    return 'Kwa mfano mwanachama atachelewesha kulipa mkopo wake, kila mwezi atalipa $percentage% ya ziada ya kiasi cha mkopo kinachosalia. Ikiwa atakopa  10,000 lazima alipe ada ya kuchelewesha kwa  $amount kwa mwezi.';
  }

  @override
  String get noFixedAmountPenalty =>
      'Hakuna adhabu ya kiasi maalumu itakayotolewa kwa kuchelewesha mkopo.';

  @override
  String fixedAmountPenaltyExample(String amount) {
    return 'Kwa mfano mwanachama atachelewesha kulipa mkopo wake, atalipa  $amount kama adhabu maalumu ya kuchelewesha.';
  }

  @override
  String get addAmount => 'Ongeza Kiasi';

  @override
  String get cancel => 'Ghairi';

  @override
  String get save => 'Hifadhi';

  @override
  String get continue_ => 'Endelea';

  @override
  String get editRegistration => 'Hariri Usajili';

  @override
  String get registrationStatus => 'Hali ya Usajili';

  @override
  String get selectRegistrationStatus => 'Chagua Hali ya Usajili';

  @override
  String get pleaseSelectRegistrationStatus =>
      'Tafadhali chagua hali ya usajili';

  @override
  String get appVersionName => 'Toleo la Chapati 1.0.0';

  @override
  String get appVersionNumber => 'Toleo 0001';

  @override
  String get open => 'Fungua';

  @override
  String get demo => 'Mfano';

  @override
  String get exercise => 'Mazoezi';

  @override
  String get registrationNumber => 'Nambari ya Usajili';

  @override
  String get enterRegistrationNumber => 'Ingiza Nambari ya Usajili';

  @override
  String get pleaseEnterRegistrationNumber =>
      'Tafadhali ingiza nambari ya usajili';

  @override
  String get correct => 'Sahihisha';

  @override
  String get groupInstitution => 'Shirika la Kikundi';

  @override
  String get editInstitution => 'Hariri Shirika la Kikundi';

  @override
  String get selectOrganization => 'Chagua Shirika';

  @override
  String get pleaseSelectOrganization => 'Tafadhali chagua shirika';

  @override
  String get enterOrganizationName => 'Ingiza Jina la Shirika';

  @override
  String get organizationNameRequired => 'Jina la shirika ni lazima!';

  @override
  String get selectProject => 'Chagua Mradi';

  @override
  String get pleaseSelectProject => 'Tafadhali chagua mradi';

  @override
  String get enterProjectName => 'Ingiza Jina la Mradi';

  @override
  String get projectNameRequired => 'Jina la mradi ni lazima!';

  @override
  String get enterTeacherId => 'Ingiza Utambulisho wa Mwalimu';

  @override
  String get teacherIdRequired => 'Utambulisho wa mwalimu ni lazima!';

  @override
  String get continueText => 'Endelea';

  @override
  String get selectKeyToReset => 'Chagua funguo ya kurekebisha';

  @override
  String get keyHolderSecretQuestion =>
      'Mwanachama mwenye funguo aliyeyachaguliwa ataulizwa swali la siri wakati wa uwekaji wa funguo';

  @override
  String get resetKey1 => 'Rekebisha funguo ya 1';

  @override
  String get resetKey2 => 'Rekebisha funguo ya 2';

  @override
  String get resetKey3 => 'Rekebisha funguo ya 3';

  @override
  String get selectQuestion => 'Chagua Swali';

  @override
  String get answerToQuestion => 'Jibu la swali';

  @override
  String get enterAnswer => 'Weka Jibu la swali';

  @override
  String get incorrectQuestionOrAnswer => 'Swali au jibu si sahihi';

  @override
  String get pleaseSelectQuestionAndAnswer => 'Tafadhali chagua swali na jibu';

  @override
  String get passwordsDoNotMatchTryAgain =>
      'Funguo Hazifanani, Tafadhali jaribu tena';

  @override
  String get confirmPasswordTitle => 'Thibitisha Funguo ya';

  @override
  String get groupOverview => 'Muhtasari wa Kikundi';

  @override
  String get fundOverview => 'Muhtasari wa Mfuko';

  @override
  String get meetingSummary => 'Muhtasari wa Kikao';

  @override
  String get allocation => 'Mgao';

  @override
  String get registration => 'Usajili wa Kikundi';

  @override
  String get registrationType => 'Aina ya Usajili';

  @override
  String get institutionalInfo => 'Taarifa za Shirika';

  @override
  String get institutionName => 'Jina la Shirika';

  @override
  String get projectName => 'Jina la Mradi';

  @override
  String get teacherId => 'Utambulisho wa Mwalimu';

  @override
  String get location => 'Eneo';

  @override
  String get loanGuarantors => 'Wadhamini wa mkopo';

  @override
  String get doesLoanNeedGuarantor => 'Je, Mkopo unahitaji mdhamini?';

  @override
  String get numberOfGuarantors => 'Idadi ya Wadhamini';

  @override
  String get enterNumberOfGuarantors => 'Weka idadi ya wadhamini';

  @override
  String get numberOfGuarantorsRequired => 'Idadi ya wadhamini inahitajika';

  @override
  String get securityQuestion1 => 'Mwanao wa kwanza amezaliwa mwaka gani?';

  @override
  String get securityQuestion2 => 'Jina la kwanza la mwanao wa kwanza?';

  @override
  String get securityQuestion3 => 'Umezaliwa mwaka gani?';

  @override
  String get errorSelectQuestion => 'Tafadhali chagua swali la usalama.';

  @override
  String get errorEnterAnswer => 'Tafadhali jaza jibu la swali.';

  @override
  String get errorSaving =>
      'Kuna tatizo katika kuhifadhi. Tafadhali jaribu tena.';

  @override
  String resetQuestionPageTitle(int passwordNumber) {
    return 'Swali la Usalama kwa Funguo ya $passwordNumber';
  }

  @override
  String get selectQuestionLabel => 'Chagua Swali';

  @override
  String get selectQuestionHint => 'Chagua Swali';

  @override
  String get answerLabel => 'Jibu';

  @override
  String get answerHint => 'Weka Jibu';

  @override
  String get pleaseEnterValidNumber => 'Tafadhali ingiza namba sahihi';

  @override
  String get describeNumberOfGuarantors =>
      'Eleza Idadi ya Wadhamini wanaohitajika kuomba Mkopo';

  @override
  String get country => 'Nchi';

  @override
  String get region => 'Mkoa';

  @override
  String get district => 'Wilaya';

  @override
  String get ward => 'Kata';

  @override
  String get streetOrVillage => 'Mtaa au Kijiji';

  @override
  String get sendSummary => 'Tuma Muhtasari';

  @override
  String get completed => 'imekamilika';

  @override
  String members(Object count) {
    return 'Wanachama : $count';
  }

  @override
  String get noMembers => 'Hakuna wanachama waliopo.';

  @override
  String errorFetchingMembers(Object error) {
    return 'Hitilafu katika kupata wanachama: $error';
  }

  @override
  String get memberSummary => 'Muhtasari wa Mwanachama';

  @override
  String get memberIdentity => 'Utambulisho wa Mwanachama';

  @override
  String get fullName => 'Jina Kamili';

  @override
  String get memberNumber => 'Namba ya Mwanachama:';

  @override
  String get gender => 'Jinsia';

  @override
  String get dob => 'Tarehe ya Kuzaliwa';

  @override
  String get phoneNumber => 'Namba ya simu:';

  @override
  String get job => 'Kazi:';

  @override
  String get idType => 'Aina ya Kitambulisho';

  @override
  String get idNumber => 'Namba ya Kitambulisho';

  @override
  String get noPhoneNumber => 'Mwanachama hana namba ya simu';

  @override
  String summarySent(Object name) {
    return 'Muhtasari umetumwa kwa $name Kikamilifu';
  }

  @override
  String failedToSendSms(Object name) {
    return 'Imeshindikana kutuma SMS kwa $name';
  }

  @override
  String get totalSavings => 'Jumla ya Akiba';

  @override
  String get totalDebt => 'Jumla ya Madeni';

  @override
  String get totalShares => 'Jumla ya Hisa';

  @override
  String get communityFundBalance => 'Mfuko wa jamii salio';

  @override
  String get currentLoans => 'Mikopo ya Sasa';

  @override
  String get totalFinesCollected => 'Jumla ya faini zilizokusanywa';

  @override
  String get confirmDeleteUser =>
      'Je, una uhakika unataka kufuta mtumiaji huyu?';

  @override
  String get delete => 'Futa';

  @override
  String get enterMemberNumber => 'Ingiza Namba ya Mwanachama';

  @override
  String get memberNumberRequired => 'Tafadhali ingiza namba ya mwanachama';

  @override
  String get memberNumberDigitsOnly =>
      'Namba ya mwanachama inapaswa kuwa tarakimu pekee';

  @override
  String get enterFullName => 'Ingiza Jina Kamili';

  @override
  String get fullNameRequired => 'Tafadhali ingiza jina kamili la mwanachama';

  @override
  String get fullNameMinLength => 'Jina linapaswa kuwa na angalau herufi 3';

  @override
  String get selectYear => 'Chagua Mwaka';

  @override
  String get selectMonth => 'Chagua Mwezi';

  @override
  String get selectDay => 'Chagua Tarehe';

  @override
  String get dobRequired => 'Tafadhali chagua tarehe kamili ya kuzaliwa';

  @override
  String get uniqueMemberNumber =>
      'Namba ya mwanachama inapaswa kuwa ya kipekee';

  @override
  String get noActiveCycle =>
      'Hitilafu: Hakuna Mzunguko ulio hai uliopatikana!';

  @override
  String get appTagline => 'Tunakusaidia Kuimarisha Maendeleo';

  @override
  String get example => 'Mfano';

  @override
  String get mzungukoPendingNoNew =>
      'Mzunguko uliopo tayari ni wa \"pending\". Hakuna mzunguko mpya ulioanzishwa.';

  @override
  String get newMzungukoCreated => 'Mzunguko mpya umeanzishwa kikamilifu!';

  @override
  String errorSavingMzunguko(String error) {
    return 'Hitilafu katika kuhifadhi au kusasisha taarifa za Mzunguko: $error';
  }

  @override
  String get weekly => 'Kila Wiki';

  @override
  String get biWeekly => 'Kila Baada Ya Wiki Mbili';

  @override
  String get monthly => 'Kila Mwezi';

  @override
  String years(int count) {
    return 'Miaka $count';
  }

  @override
  String months(int count) {
    return 'miezi';
  }

  @override
  String weeks(int count) {
    return 'Wiki $count';
  }

  @override
  String get registered => 'Kimesajiliwa';

  @override
  String get notRegistered => 'Hakijasajiliwa';

  @override
  String get other => 'Mengineyo';

  @override
  String get memberPhoneNumber => 'Namba ya simu ya Mwanachama';

  @override
  String get enterMemberPhoneNumber => 'Ingiza Namba ya simu ya Mwanachama';

  @override
  String get selectJob => 'Chagua Kazi';

  @override
  String get enterJobName => 'Ingiza Jina la Kazi';

  @override
  String get pleaseSelectJob => 'Tafadhali chagua kazi';

  @override
  String get pleaseEnterJobName => 'Tafadhali ingiza jina la kazi';

  @override
  String get selectIdType => 'Chagua Kitambulisho';

  @override
  String get enterIdNumber => 'Ingiza Namba ya Kitambulisho';

  @override
  String get pleaseSelectIdType => 'Tafadhali chagua aina ya kitambulisho';

  @override
  String get pleaseEnterIdNumber => 'Tafadhali ingiza namba ya kitambulisho';

  @override
  String get idPhoto => 'Picha ya Kitambulisho';

  @override
  String get removePhoto => 'Ondoa Picha';

  @override
  String get takePhoto => 'Piga Picha';

  @override
  String get chooseFromGallery => 'Chagua Picha';

  @override
  String get farmer => 'Mkulima';

  @override
  String get teacher => 'Mwalimu';

  @override
  String get doctor => 'Daktari';

  @override
  String get entrepreneur => 'Mjasiliamali';

  @override
  String get engineer => 'Injinia';

  @override
  String get lawyer => 'Mwanasheria';

  @override
  String get none => 'Hakuna';

  @override
  String get voterCard => 'Kitambulisho cha mpiga kura';

  @override
  String get nationalId => 'Kitambulisho cha Taifa';

  @override
  String get zanzibarResidentCard => 'Kadi ya utambulisho wa makazi zanzibar';

  @override
  String get driversLicense => 'Leseni ya udereva';

  @override
  String get localGovernmentLetter => 'Barua ya serikali ya mtaa';

  @override
  String get errorSavingPhoto => 'Imeshindwa kuhifadhi picha ya mwanachama';

  @override
  String get errorRemovingPhoto => 'Imeshindwa kuondoa picha';

  @override
  String get errorLoadingPhoto => 'Imeshindwa kupakia picha ya mwanachama';

  @override
  String get memberInformation => 'Taarifa za Mwanachama';

  @override
  String get memberIdentification => 'Utambulisho wa Mwanachama';

  @override
  String get dateOfBirth => 'Tarehe ya Kuzaliwa';

  @override
  String get occupation => 'Kazi';

  @override
  String get mandatorySavings => 'Akiba Lazima';

  @override
  String get voluntarySavings => 'Akiba Hiari';

  @override
  String get communityFund => 'Mfuko wa Jamii';

  @override
  String get currentLoan => 'Mkopo wa Sasa';

  @override
  String get finish => 'Nimemaliza';

  @override
  String get enterKey1 => 'Ingiza Funguo ya 1';

  @override
  String get enterKey2 => 'Ingiza Funguo ya 2';

  @override
  String get enterKey3 => 'Ingiza Funguo ya 3';

  @override
  String get enterAllKeys => 'Tafadhali jaza funguo zote tatu.';

  @override
  String get invalidKeys => 'Funguo za siri sio sahihi. Tafadhali jaribu tena.';

  @override
  String get systemError =>
      'Tatizo limejitokeza. Tafadhali jaribu tena baadaye.';

  @override
  String get resetSecurityKeys => 'REKEBISHA NAMBA ZA SIRI';

  @override
  String get openButton => 'FUNGUA';

  @override
  String get pleaseEnterNewPassword => 'Tafadhali ingiza nywila mpya';

  @override
  String get passwordMustBeDigitsOnly => 'Nywila lazima iwe na tarakimu pekee';

  @override
  String get passwordMustBeLessThan4Digits =>
      'Nywila lazima iwe na tarakimu chini ya 4';

  @override
  String get pleaseConfirmNewPassword => 'Tafadhali thibitisha nywila mpya';

  @override
  String get passwordsDoNotMatch => 'Nywila hazifanani';

  @override
  String get errorOccurredTryAgain =>
      'Hitilafu imetokea. Tafadhali jaribu tena.';

  @override
  String editPasswordFor(String key) {
    return 'Hariri Nywila ya $key';
  }

  @override
  String get newPassword => 'Nywila Mpya';

  @override
  String get confirmNewPassword => 'Thibitisha Nywila Mpya';

  @override
  String get enterNewPassword => 'Ingiza nywila mpya';

  @override
  String get getHelp => 'Pata Msaada';

  @override
  String get welcomeChomokaPlus => 'Karibu Chomoka Plus';

  @override
  String groupOf(Object groupName) {
    return 'Kikundi cha: $groupName';
  }

  @override
  String get dashboardHelpText =>
      'Tunakusaidia kuweka kumbukumbu za kikundi chako kwa ufanisi.';

  @override
  String get groupServices => 'Huduma za Kikundi';

  @override
  String get startMeeting => 'Anza Kikao';

  @override
  String get continueExistingMeeting => 'Endelea na kikao kilichopo';

  @override
  String get openNewMeeting => 'Fungua kikao kipya cha kikundi';

  @override
  String get group => 'KIKUNDI';

  @override
  String get constitution => 'Katiba';

  @override
  String get shareCalculation => 'Mahesabu ya Mgao';

  @override
  String get systemFeedback => 'Tathmini ya Mfumo';

  @override
  String get groupActivities => 'Shughuli za Kikundi';

  @override
  String get moreServices => 'Huduma Zaidi';

  @override
  String get history => 'Historia';

  @override
  String get viewGroupHistory => 'Angalia historia ya shughuli za kikundi';

  @override
  String get backupRestore => 'Uhifadhi na Urejeshaji';

  @override
  String get backupRestoreDesc => 'Hifadhi na rejesha kumbukumbu za kikundi';

  @override
  String get chomokaPlusVersion => 'Chomoka Plus v2.0';

  @override
  String get finishShare => 'Maliza Mgao';

  @override
  String get finishShareDesc =>
      'Mzunguko wa mwisho umekamilika. Tafadhali maliza mgao.';

  @override
  String get ok => 'Sawa';

  @override
  String get meetingOptionsWelcome => 'Karibu Katika Kikao Kingine';

  @override
  String get midCycleInfo => 'Ni taarifa katikati \nya mzunguko';

  @override
  String get openMeetingButton => 'FUNGUA KIKAO';

  @override
  String get startNewCycleQuestion => 'Je mnaanza mzunguko mpya?';

  @override
  String get pressYesToStartFirstMeeting =>
      'BONYEZA NDIO KUFANYA KIKAO CHA KWANZA';

  @override
  String get pressNoForPastMeetings =>
      'BONYEZA HAPANA KUWEKA TAARIFA ZA VIKAO VILIVYOPITA';

  @override
  String get getHelpTitle => 'Pata Msaada';

  @override
  String get needHelpContact => 'Unahitaji msaada? Wasiliana nasi kupitia:';

  @override
  String get call => 'Piga Simu';

  @override
  String get whatsapp => 'WhatsApp';

  @override
  String get email => 'Barua Pepe';

  @override
  String get faq => 'Maswali na Majibu';

  @override
  String get close => 'Funga';

  @override
  String get failedToOpenPhone => 'Imeshindikana kufungua simu.';

  @override
  String get failedToOpenWhatsApp => 'WhatsApp haipo kwenye simu yako.';

  @override
  String get failedToOpenWhatsAppGeneric => 'Imeshindikana kufungua WhatsApp.';

  @override
  String get failedToOpenEmail => 'Imeshindikana kufungua barua pepe.';

  @override
  String get constitutionAppTitle => 'Taarifa za Katiba';

  @override
  String get constitutionGroupType => 'Aina ya Kikundi';

  @override
  String get kayaCmg => 'Kaya CMG';

  @override
  String get kayaCmgHint =>
      'Tunatumia akiba ya lazima na akiba ya hiari kwa kutoa mikopo';

  @override
  String get vsla => 'VSLA';

  @override
  String get vslaHint => 'Tunatumia hisa kwa kuweka akiba na tuna viongozi 5';

  @override
  String get shareSubtitle => 'Hisa';

  @override
  String get sharePrompt => 'Thamani ya Hisa Moja ni Shilingi Ngapi?';

  @override
  String get shareValueLabel => 'Thamani ya Hisa';

  @override
  String get shareValueHint => 'Ingiza thamani ya hisa';

  @override
  String get shareValueRequired => 'Thamani ya hisa inahitajika';

  @override
  String get invalidShareValue => 'Tafadhali ingiza kiasi halali';

  @override
  String get groupLeadersSubtitle => 'Viongozi wa Kikundi';

  @override
  String get editButton => 'Rekebisha';

  @override
  String get selectAllLeadersError => 'Tafadhali chagua viongozi wote';

  @override
  String positionLabel(Object position) {
    return '$position';
  }

  @override
  String selectPositionHint(Object position) {
    return 'Chagua $position';
  }

  @override
  String positionRequired(Object position) {
    return 'Tafadhali chagua $position';
  }

  @override
  String get jumlaYaHisa => 'Jumla ya Hisa';

  @override
  String get mfukoWaJamiiSalio => 'Mfuko wa Jamii Salio';

  @override
  String get salioLililolalaSandukuni => 'Salio Lililolala Sandukuni';

  @override
  String get failedToLoadSummaryData =>
      'Imeshindwa kupakia data ya muhtasari. Tafadhali jaribu tena.';

  @override
  String get jumlaYa => 'Jumla ya';

  @override
  String get wekaJumlaYa => 'Weka jumla ya';

  @override
  String get tafadhaliJazaJumlaYa => 'Tafadhali jaza jumla ya';

  @override
  String get tafadhaliIngizaNambariHalali => 'Tafadhali ingiza nambari halali.';

  @override
  String get jumlaLazimaIweIsiyoHasi => 'Jumla lazima iwe isiyo hasi.';

  @override
  String get loadingData => 'Inapakia taarifa...';

  @override
  String get taarifaKatikatiYaMzunguko => 'Taarifa Katikati ya Mzunguko';

  @override
  String get jumlaZaKikundi => 'Jumla za Kikundi';

  @override
  String get chairperson => 'Mwenyekiti';

  @override
  String get secretary => 'Katibu';

  @override
  String get treasurer => 'Mweka Hazina';

  @override
  String get counter1 => 'Mhesabu pesa namba 1';

  @override
  String get counter2 => 'Mhesabu pesa namba 2';

  @override
  String get finesTitle => 'Taarifa za Katiba';

  @override
  String get finesSubtitle => 'Faini';

  @override
  String get finesEmptyAmountNote =>
      'Faini ambazo hazina kiasi hazitoonekana wakati wa kikao';

  @override
  String get enterFineType => 'Ingiza Aina ya faini';

  @override
  String get enterAmount => 'Ingiza kiasi';

  @override
  String get phoneUseInMeeting => 'Matumizi ya simu wakati wa kikao';

  @override
  String get amountPlaceholder => 'kiasi';

  @override
  String get loanAmountTitle => 'Taarifa za Katiba';

  @override
  String get loanAmountSubtitle => 'Mwanachama anaweza kukopa kiasi gani';

  @override
  String get loanAmountVSLAPrompt =>
      'Je, mwanachama anaweza kukopa mara ngapi kulingana na hisa zake za sasa?';

  @override
  String get loanAmountCMGPrompt =>
      'Je, mwanachama anaweza kukopa mara ngapi kulingana na akiba yake ya sasa?';

  @override
  String get loanAmountVSLAHint => 'Weka kwa hisa zao za sasa';

  @override
  String get loanAmountCMGHint => 'Weka kwa akiba zao za sasa';

  @override
  String get loanAmountRequired => 'Tafadhali weka thamani (namba) sahihi!';

  @override
  String get loanAmountInvalidNumber =>
      'Tafadhali weka thamani ya namba sahihi!';

  @override
  String get loanAmountMustBePositive => 'Thamani lazima iwe zaidi ya sifuri!';

  @override
  String loanAmountExample(String amount, String type, String multiplier) {
    return 'Kwa mfano mwanachama anaweza kukopa kiasi cha  $amount akiwa na $type zenye thamani cha  10,000 ambacho ni mara $multiplier ya $type yake.';
  }

  @override
  String get interestDescription =>
      'Eleza jinsi gharama za huduma zinavyotumika kwa mikopo yako';

  @override
  String get yes => 'Ndio';

  @override
  String get no => 'Hapana';

  @override
  String get selectFund => 'Chagua Mifuko';

  @override
  String get fundWithoutName => 'Mfuko Bila Jina';

  @override
  String get addAnotherFund => 'Ongeza Mfuko Mwingine';

  @override
  String get communityFundInfo => 'Taarifa za Mfuko wa Jamii';

  @override
  String get fundName => 'Jina la Mfuko';

  @override
  String get enterFundName => 'Ingiza Jina la Mfuko';

  @override
  String get fundNameRequired => 'Jina la mfuko linahitajika!';

  @override
  String get contributionAmount => 'Kiasi cha Kuchangia';

  @override
  String get enterContributionAmount => 'Ingiza Kiasi cha Kuchangia';

  @override
  String get contributionAmountRequired => 'Kiasi cha michango kinahitajika!';

  @override
  String get edit => 'Hariri';

  @override
  String get withdrawalReasons => 'Sababu za Kutoa';

  @override
  String get noReasonsRecorded => 'Hakuna sababu zilizorekodiwa';

  @override
  String get equalAmount => 'Kiwango sawa';

  @override
  String get anyAmount => 'Kiwango chochote';

  @override
  String get notWithdrawableMidCycle => 'Haiwezi kutolewa katikati ya Mzunguko';

  @override
  String get withdrawByMemberName => 'Kutoa kwa jina la mwanachama';

  @override
  String get withdrawAsGroup => 'kutoa kama kikundi';

  @override
  String get select => 'Chagua';

  @override
  String get education => 'Elimu';

  @override
  String get agriculture => 'Kilimo';

  @override
  String get communityProject => 'Mradi jamii';

  @override
  String get cocoa => 'Cocoa';

  @override
  String get otherGoals => 'Mengineyo';

  @override
  String get pleaseSelectContributionProcedure =>
      'Tafadhali chagua Utaratibu wa Uchangiaji';

  @override
  String get pleaseSelectWithdrawalProcedure =>
      'Tafadhali chagua Taratibu za Utoaji';

  @override
  String get dataUpdatedSuccessfully => 'Taarifa zimesahihishwa!';

  @override
  String get errorSavingDataGeneric =>
      'Kuna tatizo la kuhifadhi data. Tafadhali jaribu tena.';

  @override
  String get fundInformation => 'Taarifa za Mifuko';

  @override
  String get fundProcedures => 'Taratibu za Mifuko';

  @override
  String get pleaseEnterFundName => 'Tafadhali ingiza Jina la Mfuko';

  @override
  String get fundGoals => 'Malengo ya mfuko';

  @override
  String get pleaseSelectFundGoal => 'Tafadhali chagua Malengo ya mfuko';

  @override
  String get enterOtherGoals => 'Ingiza Malengo mengine';

  @override
  String get pleaseEnterOtherGoals => 'Tafadhali ingiza Malengo mengine';

  @override
  String get contributionProcedure => 'Utaratibu wa Uchangiaji';

  @override
  String get pleaseEnterContributionAmount =>
      'Tafadhali ingiza Kiasi cha Kuchangia';

  @override
  String get loanable => 'Zinakopesheka';

  @override
  String get withdrawalProcedures => 'Taratibu za Utoaji';

  @override
  String get fundProcedure => 'Taratibu za mfuko';

  @override
  String get withdrawalProcedure => 'Taratibu za Utoaji';

  @override
  String get notWithdrawableDuringCycle =>
      'Haiwezi kutolewa katikati ya mzunguko';

  @override
  String get selectOption => 'Chagua';

  @override
  String get fundSummarySubtitle => 'Muhtasari wa Mfuko';

  @override
  String get withdrawalType => 'Aina ya Uchangiaji';

  @override
  String get deleteFundTitle => 'Futa Mfuko?';

  @override
  String get thisFund => 'Mfuko huu';

  @override
  String get deleteFundWarning => 'Hatua hii haiwezi kubatilishwa.';

  @override
  String setPasswordTitle(Object step) {
    return 'Weka funguo ya $step';
  }

  @override
  String get allPasswordsSetTitle => 'Funguo Tume';

  @override
  String get backupCompleted => 'Uhifadhi umekamilika kikamilifu!';

  @override
  String get uhifadhiKumbukumbu => 'Uhifadhi Kumbukumbu';

  @override
  String get tumaTaarifa => 'Tuma Taarifa';

  @override
  String get chaguaMahaliNaHifadhi => 'Chagua Mahali na Hifadhi';

  @override
  String get hifadhiNakala => 'Hifadhi Nakala';

  @override
  String get hifadhiNakalaRafiki => 'Hifadhi Nakala kwa Rafiki';

  @override
  String get hifadhiNakalaRafikiDescription =>
      'Tuma nakala ya data ya Chomoka kwa rafiki yako kwa usalama zaidi.';

  @override
  String get uhifadhiKumbukumbuDescription =>
      'Hifadhi nakala ya data yako ya Chomoka kwenye faili ya ZIP. Unaweza kurejesha data hii wakati wowote.';

  @override
  String get error => 'Hitilafu';

  @override
  String errorSharingBackup(Object error) {
    return 'Hitilafu katika kushiriki nakala: $error';
  }

  @override
  String get uwekaji_taarifa_katikati_mzunguko =>
      'Uwekaji wa Taarifa Katikati ya Mzunguko';

  @override
  String get loading_group_data => 'Inapakia taarifa za kikundi...';

  @override
  String get kikundi_mzunguko => 'Kikundi Kipo mzunguko wa ngapi?';

  @override
  String get taarifa_zimehifadhiwa => 'Taarifa zimehifadhiwa kikamilifu!';

  @override
  String imeshindwa_kuhifadhi(Object error) {
    return 'Imeshindwa kuhifadhi taarifa: $error';
  }

  @override
  String get thibitisha_ingizo => 'Uhakiki wa ingizo umeshindikana.';

  @override
  String get namba_kikao => 'Namba ya Kikao';

  @override
  String get ingiza_namba_kikao => 'Ingiza namba ya kikao';

  @override
  String get namba_kikao_inahitajika => 'Namba ya kikao inahitajika';

  @override
  String get namba_kikao_halali => 'Tafadhali ingiza namba halali ya kikao';

  @override
  String get endelea => 'Endelea';

  @override
  String get taarifa_kikao_kilichopita => 'Taarifa za Kikao Kilichopita';

  @override
  String get hisa_wanachama => 'Hisa za Wanachama';

  @override
  String get muhtasari_kikao => 'Muhtasari wa Kikao';

  @override
  String get jumla_kikundi => 'Jumla ya Kikundi';

  @override
  String get akiba_wanachama => 'Akiba za Wanachama';

  @override
  String get akiba_binafsi => 'Akiba Binafsi';

  @override
  String get wadaiwa_mikopo => 'Wadaiwa wa Mikopo';

  @override
  String get mchango_haujalipwa => 'Michango Ambayo Haijalipwa';

  @override
  String get jumla_hisa => 'Jumla ya Hisa';

  @override
  String get jumla_akiba => 'Jumla ya Akiba';

  @override
  String get jumla_mikopo => 'Jumla ya Mikopo';

  @override
  String get jumla_riba => 'Jumla ya Riba';

  @override
  String get jumla_adhabu => 'Jumla ya Adhabu';

  @override
  String get jumla_mfuko_jamii => 'Jumla ya Mfuko wa Jamii';

  @override
  String get chaguaNjiaUhifadhi => 'Chagua Njia ya Uhifadhi';

  @override
  String get taarifaZimehifadhiwa => 'Taarifa zimehifadhiwa kikamilifu!';

  @override
  String get sawa => 'Sawa';

  @override
  String uhifadhiProgress(Object progress) {
    return 'Maendeleo ya Uhifadhi: $progress%';
  }

  @override
  String get midCycleMeetingInfo => 'Taarifa katikati ya Mzunguko';

  @override
  String get groupTotals => 'Jumla za Kikundi';

  @override
  String get groupTotalsSummary => 'Muhtasari wa Jumla za Kikundi';

  @override
  String get enterTotalShares => 'Ingiza jumla ya hisa';

  @override
  String get pleaseEnterTotalShares => 'Tafadhali ingiza jumla ya hisa';

  @override
  String get shareValue => 'Thamani ya Hisa:';

  @override
  String get enterShareValue => 'Ingiza thamani ya hisa';

  @override
  String get pleaseEnterShareValue => 'Tafadhali ingiza thamani ya hisa';

  @override
  String get enterTotalSavings => 'Ingiza jumla ya akiba';

  @override
  String get pleaseEnterTotalSavings => 'Tafadhali ingiza jumla ya akiba';

  @override
  String get enterCommunityFundBalance => 'Ingiza salio la mfuko wa jamii';

  @override
  String get pleaseEnterCommunityFundBalance =>
      'Tafadhali ingiza salio la mfuko wa jamii';

  @override
  String get pleaseEnterValidPositiveNumber =>
      'Thamani lazima iwe nambari chanya';

  @override
  String get memberShares => 'Hisa za Wanachama';

  @override
  String get unpaidContributions => 'Michango Ambayo Haijalipwa';

  @override
  String get memberContributions => 'Michango ya mwanachama';

  @override
  String get fineOwed => 'Faini Anazodaiwa';

  @override
  String get enterFineOwed => 'Ingiza faini anazodaiwa';

  @override
  String get pleaseEnterFineOwed => 'Tafadhali ingiza faini anazodaiwa';

  @override
  String get communityFundOwed => 'Mfuko wa Jamii Anachodaiwa';

  @override
  String get enterCommunityFundOwed =>
      'Ingiza kiasi cha mfuko wa jamii anachodaiwa';

  @override
  String get pleaseEnterCommunityFundOwed =>
      'Tafadhali ingiza kiasi cha mfuko wa jamii anachodaiwa';

  @override
  String get loanInformation => 'Taarifa za Mkopo';

  @override
  String get memberLoanInfo => 'Taarifa za Mkopo wa Mwanachama';

  @override
  String get selectReason => 'Chagua Sababu';

  @override
  String get reasonForLoan => 'Sababu ya Kukopa';

  @override
  String get pleaseSelectReason => 'Tafadhali chagua sababu';

  @override
  String get houseRenovation => 'Maboresho ya Nyumba';

  @override
  String get business => 'Biashara';

  @override
  String get enterOtherReason => 'Ingiza Sababu Nyingine';

  @override
  String get otherReason => 'Sababu Nyingine';

  @override
  String get pleaseEnterOtherReason => 'Tafadhali jaza sababu nyingine';

  @override
  String get loanAmount => 'Kiasi cha Mkopo';

  @override
  String get enterLoanAmount => 'Ingiza kiasi cha mkopo';

  @override
  String get pleaseEnterLoanAmount => 'Tafadhali jaza kiasi cha mkopo';

  @override
  String get pleaseEnterValidAmount => 'Tafadhali ingiza kiasi halali';

  @override
  String get amountPaid => 'Kiasi Alicholipa:';

  @override
  String get enterAmountPaid => 'Ingiza kiasi kilicholipwa';

  @override
  String get pleaseEnterAmountPaid => 'Tafadhali jaza kiasi kilicholipwa';

  @override
  String get outstandingBalance => 'Salio Linalodaiwa';

  @override
  String get calculatedAutomatically => 'Inajazwa kiotomatiki';

  @override
  String get pleaseEnterOutstandingAmount => 'Tafadhali jaza salio linalodaiwa';

  @override
  String get loanMeeting => 'Kikao cha Mkopo';

  @override
  String get enterLoanMeeting => 'Ingiza namba ya kikao cha mkopo';

  @override
  String get pleaseEnterLoanMeeting =>
      'Tafadhali jaza namba ya kikao cha mkopo';

  @override
  String get loanDuration => 'Muda wa Mkopo (Miezi)';

  @override
  String get enterLoanDuration => 'Ingiza muda kwa miezi';

  @override
  String get pleaseEnterLoanDuration => 'Tafadhali jaza muda wa mkopo';

  @override
  String get loading => 'Inapakia...';

  @override
  String get noMembersFound => 'Hakuna wanachama waliopo.';

  @override
  String get searchByNameOrPhone => 'Tafuta kwa jina au simu';

  @override
  String get memberList => 'Orodha ya Wanachama';

  @override
  String get validate => 'Thibitisha';

  @override
  String get dataValidationFailed => 'Uhakiki wa data umeshindikana.';

  @override
  String get shareInformation => 'Taarifa za Hisa';

  @override
  String get saveShares => 'Hifadhi Hisa';

  @override
  String get shares => 'Hisa';

  @override
  String get enterShares => 'Ingiza idadi ya hisa';

  @override
  String get loanSummary => 'Muhtasari wa Mkopo';

  @override
  String get memberLoanSummary => 'Muhtasari wa Mkopo wa Mwanachama';

  @override
  String get loanDetails => 'TAARIFA ZA MKOPO';

  @override
  String get vslaMemberShares => 'Hisa za Wanachama';

  @override
  String get vslaShareInformation => 'Taarifa za Hisa';

  @override
  String get vslaShareValue => 'Thamani ya Hisa';

  @override
  String get vslaTotalShares => 'Jumla ya Hisa';

  @override
  String get vslaShareValuePerShare => 'Thamani ya Hisa Moja';

  @override
  String get vslaEnterShareCount => 'Ingiza idadi ya hisa';

  @override
  String get vslaShareCountRequired => 'Idadi ya hisa inahitajika';

  @override
  String get vslaEnterValidShareCount =>
      'Tafadhali ingiza idadi halali ya hisa';

  @override
  String get vslaSaveShares => 'Hifadhi Hisa';

  @override
  String get vslaSharesSavedSuccessfully =>
      'Hisa za wanachama zimehifadhiwa kikamilifu!';

  @override
  String vslaTotalSharesMustMatch(String total, String current) {
    return 'Jumla ya hisa inapaswa kuwa $total. Hivi sasa $current. Tafadhali rekebisha.';
  }

  @override
  String get vslaGroupTotals => 'Jumla za Kikundi';

  @override
  String get vslaGroupTotalsSummary => 'Muhtasari wa Jumla za Kikundi';

  @override
  String get vslaCommunityFundBalance => 'Salio la Mfuko wa Jamii';

  @override
  String get vslaBoxBalance => 'Salio la Sanduku';

  @override
  String get vslaCurrentLoanBalance => 'Salio la Mkopo wa Sasa';

  @override
  String get vslaMembers => 'Wanachama';

  @override
  String get vslaUnpaidContributions => 'Michango Ambayo Haijalipwa';

  @override
  String get vslaTotalFinesOwed => 'Jumla ya Faini Zinazokusanywa';

  @override
  String get vslaEnterTotalShares => 'Ingiza Jumla ya Hisa';

  @override
  String get vslaEnterCommunityFundBalance => 'Ingiza Salio la Mfuko wa Jamii';

  @override
  String get vslaEnterBoxBalance => 'Ingiza Salio la Sanduku';

  @override
  String get vslaPleaseEnterTotalShares => 'Tafadhali ingiza jumla ya hisa';

  @override
  String get vslaPleaseEnterCommunityFundBalance =>
      'Tafadhali ingiza salio la mfuko wa jamii';

  @override
  String get vslaPleaseEnterBoxBalance => 'Tafadhali ingiza salio la sanduku';

  @override
  String get vslaPleaseEnterValidPositiveNumber =>
      'Thamani lazima iwe nambari chanya';

  @override
  String get vslaMidCycleInformation => 'Taarifa katikati ya Mzunguko';

  @override
  String get vslaMemberShareTitle => 'Hisa za Wanachama';

  @override
  String get vslaMemberShareSubtitle => 'Ingiza taarifa za hisa za wanachama';

  @override
  String get vslaMemberNumber => 'Namba ya Mwanachama';

  @override
  String get vslaShareCount => 'Idadi ya Hisa';

  @override
  String get vslaNoMembersFound => 'Hakuna wanachama waliopo';

  @override
  String get vslaErrorLoadingData =>
      'Hitilafu katika kupakia data. Tafadhali jaribu tena.';

  @override
  String vslaErrorSavingData(String error) {
    return 'Hitilafu katika kuhifadhi data: $error';
  }

  @override
  String get uwekajiTaarifaKatikaMzunguko =>
      'Uwekaji wa Taarifa katika Mzunguko';

  @override
  String get jumlaYaKikundi => 'Jumla ya Kikundi';

  @override
  String get hisaZaWanachama => 'Hisa za Wanachama';

  @override
  String get taarifaZaKikundi => 'Taarifa za Kikundi';

  @override
  String get jumlaYaTaarifaZaKikundi => 'Jumla ya Taarifa za Kikundi';

  @override
  String get inapakiaTaarifa => 'Inapakia taarifa...';

  @override
  String get hakunaTaarifaZilizopo => 'Hakuna taarifa zilizopo kwa sasa.';

  @override
  String get taarifaZaHisa => 'Taarifa za Hisa';

  @override
  String get thamaniYaHisaMoja => 'Thamani ya Hisa Moja';

  @override
  String get wekaMfukoWaJamiiSalio => 'Weka Mfuko wa Jamii Salio';

  @override
  String get tafadhaliJazaMfukoWaJamiiSalio =>
      'Tafadhali jaza Mfuko wa Jamii salio.';

  @override
  String get wekaSalioLililolalaSandukuni => 'Weka Salio Lililolala Sandukuni';

  @override
  String get tafadhaliJazaSalioLililolalaSandukuni =>
      'Tafadhali jaza Salio Lililolala sandukuni.';

  @override
  String get salioLazimaIweIsiyoHasi => 'Salio lazima iwe isiyo hasi.';

  @override
  String get jumlaYaThamaniYaHisa => 'Jumla ya Thamani ya Hisa';

  @override
  String get tafadhaliJazaJumlaYaHisa => 'Tafadhali jaza Jumla ya Hisa.';

  @override
  String get salioLililolalaSandukuniError =>
      'Salio Lililolala Sandukuni lazima liwe kubwa kuliko Jumla ya Hisa na Mfuko wa Jamii Salio.';

  @override
  String get jumlaYaHisaZote => 'Jumla ya Hisa Zote';

  @override
  String get mchangoHaujalipwa => 'Mchango ambao haujalipwa';

  @override
  String get wadaiwaMikopo => 'Taarifa za wadaiwa wa mikopo ya kikundi';

  @override
  String get muhtasari => 'Muhtasari';

  @override
  String get pending => 'inasubiri';

  @override
  String get uhifadhiKumbukumbuTitle => 'Uhifadhi Kumbukumbu';

  @override
  String get utunzajiKumbukumbuSmsTab => 'Uhifadhi kwa SMS';

  @override
  String get kanzidataUhifadhiTab => 'Uhifadhi Kanzidata';

  @override
  String get tumaTaarifaButton => 'Tuma Taarifa';

  @override
  String get uhifadhiKumbukumbuCardTitle => 'Uhifadhi Kanzidata';

  @override
  String get uhifadhiKumbukumbuCardDesc =>
      'Hifadhi nakala ya data yako ya Chomoka kwenye faili la SQL. Unaweza kurejesha data hii wakati wowote.';

  @override
  String get chaguaMahaliNaHifadhiButton => 'Chagua Mahali na Hifadhi';

  @override
  String sqlDumpSaved(String filePath) {
    return 'SQL dump imehifadhiwa kwa: $filePath';
  }

  @override
  String errorWithMessage(String message) {
    return 'Hitilafu: $message';
  }

  @override
  String get hifadhiNakalaRafikiCardTitle => 'Kushiriki Data na Rafiki';

  @override
  String get hifadhiNakalaRafikiCardDesc =>
      'Tuma kopio ya data yako ya Chomoka kwa rafiki yako kwa usalama zaidi.';

  @override
  String get hifadhiNakalaButton => 'Kushiriki Data';

  @override
  String get loanInterest => 'Riba ya mkopo:';

  @override
  String get interestType => 'Aina ya Riba';

  @override
  String get monthlyCalculation => 'Hesabu ya Kila Mwezi';

  @override
  String get equalAmountAllMonths => 'Kiasi Sawa Kila Mwezi';

  @override
  String get enterInterestRate => 'Weka kiwango cha riba';

  @override
  String loanInterestExample(Object rate) {
    return 'Kwa mfano, ikiwa mwanachama atakopa 10,000 atalipa $rate% ya kiasi kilichobaki cha mkopo kila mwezi. Ikiwa atalipa mkopo wake mapema, ataepuka kulipa riba.';
  }

  @override
  String loanInterestExampleEqual(Object amount, Object rate) {
    return 'Kwa mfano, ikiwa mwanachama atakopa 10,000 atalipa $amount% ya kiasi halisi cha mkopo. Atalipa $rate kila mwezi.';
  }

  @override
  String loanInterestExampleOnce(Object amount, Object rate) {
    return 'Kwa mfano, ikiwa mwanachama atakopa 10,000 atarejesha kwa riba ya $amount% ya kiasi halisi cha mkopo. Atalipa $rate kama riba wakati wa kurejesha mkopo wake.';
  }

  @override
  String get constitutionTitle => 'Katiba';

  @override
  String get membershipRules => 'Kanuni za Uanachama';

  @override
  String get method => 'Njia:';

  @override
  String get savings => 'Akiba';

  @override
  String get mandatorySavingsValue => 'Thamani ya akiba ya lazima:';

  @override
  String get groupLeaders => 'Viongozi wa Kikundi';

  @override
  String get cashCounter1 => 'Mhesabu Fedha Na. 1:';

  @override
  String get cashCounter2 => 'Mhesabu Fedha Na. 2:';

  @override
  String get auditor => 'Mkaguzi:';

  @override
  String get contributions => 'Michango';

  @override
  String get communityFundAmount => 'Kiasi cha Mfuko wa Jamii:';

  @override
  String get otherFunds => 'Mifuko Mengine';

  @override
  String get noFines => 'Hakuna faini zilizohifadhiwa kwa mwanachama huyu.';

  @override
  String get loan => 'Mkopo';

  @override
  String get loanMultiplier =>
      'Mwanachama anaruhusiwa kukopa mara ngapi ya hisa zake:';

  @override
  String get loanInterestType => 'Njia ya kukokotoa riba ya mkopo:';

  @override
  String get guarantorCount => 'Idadi ya wadhamini';

  @override
  String get penaltyCalculation =>
      'Njia ya kukokotoa adhabu ya kuchelewa kulipa mkopo:';

  @override
  String get lateLoanPenalty => 'Adhabu ya kuchelewa kulipa mkopo:';

  @override
  String get fundInfoTitle => 'Taarifa za Mfuko';

  @override
  String get illness => 'Ugonjwa';

  @override
  String get death => 'Kifo';

  @override
  String get addNewReason => 'Ongeza Sababu Mpya';

  @override
  String get reasonsWithoutAmountWarning =>
      'Sababu zisizo na kiasi hazitaonekana wakati wa kikao';

  @override
  String get reason => 'Sababu';

  @override
  String get enterReason => 'Weka Sababu';

  @override
  String get reasonsForGiving => 'Sababu za Kutoa';

  @override
  String get reasonsForGivingInFund => 'Sababu za kutoa kwenye mfuko wa jamii';

  @override
  String get addNewReasonToReceiveMoney =>
      'Ongeza sababu mpya ya kupokea fedha';

  @override
  String get loadingGroupData => 'Inapakia data za kikundi...';

  @override
  String get kikundiKipoMzunguko => 'Kikundi kipo kwenye mzunguko gani?';

  @override
  String mzunguko(Object mzungukoId) {
    return 'Mzunguko $mzungukoId';
  }

  @override
  String get invalidGroupDataReceived => 'Data batili za kikundi zimepokelewa';

  @override
  String get historia => 'Historia';

  @override
  String historiaYa(String name) {
    return 'Historia ya $name';
  }

  @override
  String get hakuna_vikao =>
      'Hakuna vikao vilivyokamilika katika mzunguko huu!';

  @override
  String get tafutaJinaSimu => 'Tafuta kwa jina au namba ya simu';

  @override
  String get hakunaWanachama => 'Hakuna wanachama waliopatikana.';

  @override
  String get muhtasariKikao => 'Muhtasari wa Kikao';

  @override
  String get funga => 'Funga';

  @override
  String get tumaMuhtasari => 'Tuma Muhtasari';

  @override
  String get mwanachamaSiSimu => 'Mwanachama hana namba ya simu';

  @override
  String muhtasariUmetumwa(String name) {
    return 'Muhtasari umetumwa kwa $name kwa mafanikio';
  }

  @override
  String get imeshindwaTumaSMS =>
      'Imeshindikana kutuma SMS, tafadhali jaribu tena';

  @override
  String get kikao => 'Kikao';

  @override
  String kikao_ya(String name) {
    return 'Kikao cha $name';
  }

  @override
  String get mipangilio => 'Mipangilio';

  @override
  String get badiliLugha => 'Badili Lugha';

  @override
  String get chaguaLughaYaProgramu => 'Chagua Lugha ya Programu';

  @override
  String get kiswahili => 'Kiswahili';

  @override
  String get english => 'English';

  @override
  String get french => 'Français';

  @override
  String get rekebishaFunguo => 'Rekebisha funguo';

  @override
  String get badilishaNenoLaSiri => 'Badilisha neno la siri';

  @override
  String get kifo => 'Kifo';

  @override
  String get futazoteZaMzungukoHuuKishaAnzaMzungukoMpya =>
      'Futa taarifa zote za mzunguko huu kisha anza mzunguko mpya';

  @override
  String get rekebishaMzunguko => 'Rekebisha mzunguko';

  @override
  String get thibitisha => 'Thibitisha';

  @override
  String get jeUnaHitajiKufutaTaarifaZoteNaKuanzaMzungukoMpya =>
      'Je, unahitaji kufuta taarifa zote na kuanza mzunguko mpya?';

  @override
  String get ndio => 'Ndio';

  @override
  String imeshindwaKuHifadhi(String error) {
    return 'Imeshindikana kuhifadhi taarifa: $error';
  }

  @override
  String get hapana => 'Hapana';

  @override
  String get kuhusuChomoka => 'Kuhusu chomoka';

  @override
  String get toleoLaChapa100 => 'Toleo la chapa 1.0.0';

  @override
  String get toleo4684 => 'Toleo 4684';

  @override
  String get mkataba => 'Mkataba';

  @override
  String get vigezoNaMasharti => 'Vigezo na masharti';

  @override
  String get somaVigezoNaMashartiYaChomoka =>
      'Soma vigezo na masharti ya chomoka';

  @override
  String get msaadaWaKitaalamu => 'Msaada wa Kitaalamu';

  @override
  String get chomokaItajaribuKutumaBaadhiYaIliKikundiKipateMsaadaZaidiWaKitalaamu =>
      'Chomoka itajaribu kutuma baadhi ya ili kikundi kipate msaada zaidi wa kitalaamu';

  @override
  String get vslaPreviousMeetingSummary => 'Muhtasari wa Kikao';

  @override
  String get nimemaliza => 'Nimemaliza';

  @override
  String get idleBalanceInBox => 'Salio lililolala sandukuni';

  @override
  String get currentLoanBalance => 'Salio la mkopo wa sasa';

  @override
  String get remainingCommunityContribution =>
      'Mchango Uliosalia wa Mfuko wa jamii';

  @override
  String get totalOutstandingFines => 'Jumla ya Faini zinazodaiwa';

  @override
  String get kikundi => 'Kikundi';

  @override
  String get nunuaHisa => 'Nunua Hisa';

  @override
  String get sasaUtaanzaMchakatoWaKununuaHisaKwaKilaMwanachama =>
      'Sasa utaanza mchakato wa kununua hisa kwa kila mwanachama';

  @override
  String get anzaSasa => 'ANZA SASA';

  @override
  String get rudiNymba => 'RUDI NYUMA';

  @override
  String get hisa => 'Hisa';

  @override
  String get hesabuYaHisa => 'Hesabu ya hisa';

  @override
  String get jumlaYaAkiba => 'Jumla ya akiba';

  @override
  String get hisaAlizonunuaLeo => 'Hisa alizonunua Leo';

  @override
  String get chaguaIdadiYaHisaZaKununua => 'Chagua idadi ya hisa za kununua';

  @override
  String get chaguaZote => 'Chagua Zote';

  @override
  String get ruka => 'Ruka';

  @override
  String get hisaZilizochaguliwa => 'Hisa zilizochaguliwa';

  @override
  String get badilishaHisa => 'Badilisha Hisa';

  @override
  String get ongezaHisa => 'Ongeza Hisa';

  @override
  String get ongezaHisaZaidiKwaMwanachama => 'Ongeza hisa zaidi kwa mwanachama';

  @override
  String get punguzaHisa => 'Punguza Hisa';

  @override
  String get punguzaIdadiYaHisaZaMwanachama =>
      'Punguza idadi ya hisa za mwanachama';

  @override
  String get futaZote => 'Futa Zote';

  @override
  String get futaHisaZoteZaLeo => 'Futa hisa zote za leo';

  @override
  String get ongeza => 'Ongeza';

  @override
  String get punguza => 'Punguza';

  @override
  String get futa => 'Futa';

  @override
  String get ingizaIdadiYaHisaUnezotakaKununua =>
      'Ingiza idadi ya hisa unazotaka kuongeza';

  @override
  String get ingizaIdadiYaHisaUnezotakaKupunguza =>
      'Ingiza idadi ya hisa unazotaka kupunguza';

  @override
  String get ghairi => 'Ghairi';

  @override
  String get idadiYaHisa => 'Idadi ya hisa';

  @override
  String get tafadhaliIngizaNambaSahihi => 'Tafadhali ingiza namba sahihi';

  @override
  String get muhtasariWaHisa => 'Muhtasari wa Hisa';

  @override
  String get jumlaYaFedha => 'Jumla ya Fedha';

  @override
  String contributeToFund(String fundName) {
    return 'Changia $fundName';
  }

  @override
  String get amountToContribute => 'Kiasi ambacho mwanachama alipie:';

  @override
  String get totalCollected => 'Kilichopatikana:';

  @override
  String shareNote(Object amount) {
    return 'Kumbuka: Mwanachama anaweza kununua hisa moja yenye thamani ya  $amount kwa kila kikao';
  }

  @override
  String get help => 'Msaada';

  @override
  String get welcome => 'Karibu';

  @override
  String get helpDescription =>
      'Tunakusaidia kuweka kumbukumbu za kikundi chako kwa ufanisi.';

  @override
  String get continueMeeting => 'Endelea na Kikao';

  @override
  String get wanachama => 'Wanachama';

  @override
  String get fund => 'Mgao wa Kikundi';

  @override
  String get feedback => 'Maoni';

  @override
  String get groupsActivities => 'Shughuli za Kikundi';

  @override
  String get historyDescription => 'Angalia historia ya shughuli za kikundi';

  @override
  String get backupAndRestore => 'Uhifadhi na Urejeshaji';

  @override
  String get backupDescription => 'Hifadhi na rejesha kumbukumbu za kikundi';

  @override
  String get serviceMore => 'Huduma Zaidi';

  @override
  String get historyHints => 'Angalia historia ya shughuli za kikundi';

  @override
  String get sendData => 'Uhifadhi na Urejeshaji';

  @override
  String get sendDataHint => 'Hifadhi na rejesha kumbukumbu za kikundi';

  @override
  String get whatsappNotInstalled => 'WhatsApp haipo kwenye simu yako';

  @override
  String get whatsappFailed => 'Imeshindikana kufungua WhatsApp';

  @override
  String get helpEmailSubject => 'Msaada - Chomoka Plus App';

  @override
  String get welcomeNextMeeting => 'Karibu Katika Kikao Kingine';

  @override
  String get midCycleReport => 'Taarifa katikati ya Mzunguko';

  @override
  String get tapToOpenMeeting => 'Bonyeza Kitufe hapo chini Kufungua Kikao';

  @override
  String get tapYesToStartFirstMeeting =>
      'BONYEZA NDIO KUFANYA KIKAO CHA KWANZA';

  @override
  String get openMeeting => 'FUNGUA KIKAO';

  @override
  String get tapNoToEnterPastMeetings =>
      'BONYEZA HAPANA KUWEKA TAARIFA ZA VIKAO VILIVYOPITA';

  @override
  String meetingTitle(Object meetingNumber) {
    return 'Kikao cha $meetingNumber';
  }

  @override
  String get groupAttendance => 'Kagua mahudhurio';

  @override
  String get contributeMfukoJamii => 'Changia mfuko wa jamii';

  @override
  String get buyShares => 'Nunua Hisa';

  @override
  String contributeOtherFund(Object mfukoName) {
    return 'Changia $mfukoName';
  }

  @override
  String get repayLoan => 'Rejesha Mkopo';

  @override
  String get payFine => 'Lipa Faini';

  @override
  String get withdrawFromMfukoJamii => 'Toa kutoka mfuko wa jamii';

  @override
  String get giveLoan => 'Toa Mkopo';

  @override
  String get markCompleted => 'completed';

  @override
  String get markPending => 'pending';

  @override
  String get menuBulkSaving => 'Uwekaji kwa mkupuo';

  @override
  String get menuExpense => 'Weka taarifa za matumizi';

  @override
  String get menuLogout => 'Ondoka';

  @override
  String get snackbarLoggedOut => 'Umetoka kwenye mfumo';

  @override
  String get attendance => 'Mahudhurio';

  @override
  String get attendanceSummary => 'Muhtasari wa Mahudhurio';

  @override
  String get totalMembers => 'Jumla ya Wanachama';

  @override
  String get present => 'Yupo';

  @override
  String get onTime => 'Na Kuwahi';

  @override
  String get lates => 'Kwa Kachelewa';

  @override
  String get sentRepresentative => 'Na Katuma Mwakilishi';

  @override
  String get absent => 'Hayupo';

  @override
  String get withPermission => 'Kwa Ruhusa';

  @override
  String get withoutPermission => 'Bila Ruhusa';

  @override
  String get reasonForAbsence => 'Sababu ya Kutokuwepo';

  @override
  String get amountToPaid => 'Kiasi ambacho mwanachama alipie:';

  @override
  String get whatWasCollected => 'Kilichopatikana:';

  @override
  String get hasPaid => 'Amelipa';

  @override
  String get hasNotPaid => 'Ajalipia';

  @override
  String get compulsorySavingsTitle => 'Taarifa za Akiba Lazima';

  @override
  String get compulsorySavingsSubtitle => 'Michango ya mwanachama';

  @override
  String get loadingMessage => 'Inapakia taarifa...';

  @override
  String get doneButton => 'Nimemaliza';

  @override
  String get noCompulsorySavings =>
      'Hakuna Kiasi cha Akiba Lazima anachodaiwa mwanachama';

  @override
  String get phone => 'Simu';

  @override
  String get dueMeeting => 'Akulipa kikao cha';

  @override
  String owedAmount(Object amount) {
    return 'Kiasi cha Akiba Lazima Anachodaiwa:  $amount';
  }

  @override
  String get pay => 'Lipia';

  @override
  String get alreadyPaid => 'Ameshailipia';

  @override
  String get socialFundTitle => 'Taarifa za Mfuko wa Jamii';

  @override
  String socialFundDueAmount(Object amount) {
    return 'Kiasi cha Uchangiaji wa Mfuko Jamii Anachodaiwa:  $amount';
  }

  @override
  String get contributionSummary => 'Muhtasari wa Michango';

  @override
  String memberName(Object name) {
    return 'Mwanachama: $name';
  }

  @override
  String get paid => 'Aliyolipa';

  @override
  String get unpaid => 'Asiyolipa';

  @override
  String get noSocialFundDue =>
      'Hakuna Kiasi cha Mfuko jamii anachodaiwa mwanachama';

  @override
  String get totalLoan => 'Jumla ya Madeni';

  @override
  String get noUnpaidMemberJamii =>
      'Hakuna Mwanachama Anaedaiwa wa Mfuko Jamii';

  @override
  String get unpaidContributionsTitle => 'Michango Ambayo Haijalipwa';

  @override
  String get unpaidContributionsSubtitle => 'Uchangiaji wa Mfuko Jamii';

  @override
  String get loanDebtorsTitle => 'Wanaodaiwa Mikopo';

  @override
  String get loanSummaryTitle => 'Muhtasari wa Mikopo';

  @override
  String get loanIssuedAmount => 'Kiasi cha Mikopo Kilichotolewa:';

  @override
  String get loanRepaidAmount => 'Kiasi cha Mikopo Kilicholudishwa:';

  @override
  String get loanRemainingAmount => 'Kiasi cha Mikopo Kilichobakia:';

  @override
  String get noUnpaidLoans => 'Hakuna wanachama wenye mikopo isiyolipwa.';

  @override
  String get loanDebtors => 'Wadaiwa mikopo';

  @override
  String get memberLabel => 'Mwanachama:';

  @override
  String get unpaidLoanAmount => 'Kiasi kisicholipwa \ncha mkopo';

  @override
  String get loanDetailsTitle => 'Maelezo ya Mkopo';

  @override
  String get makePayment => 'Fanya Malipo';

  @override
  String remainingAmount(Object amount) {
    return 'Kiasi Kilichobakia:  $amount';
  }

  @override
  String get choosePaymentType => 'Chagua Aina ya Malipo:';

  @override
  String get payAll => 'Lipa Yote';

  @override
  String get reduceLoan => 'Punguza Deni';

  @override
  String get enterPaymentAmount => 'Ingiza Kiasi cha Malipo';

  @override
  String get payLoan => 'Lipa Mkopo';

  @override
  String get member => 'WANACHAMA';

  @override
  String get loanTaken => 'Kiasi Alichokopa:';

  @override
  String get loanToPay => 'Kiasi Anachotakiwa Kulipa:';

  @override
  String get loanRemaining => 'Kiasi Kilichobakia:';

  @override
  String get paymentHistory => 'Historia ya Malipo:';

  @override
  String get noPaymentsMade => 'Hakuna malipo yaliyofanywa bado.';

  @override
  String youPaid(Object amount) {
    return 'Umelipa:  $amount';
  }

  @override
  String date(Object date) {
    return 'Tarehe';
  }

  @override
  String get fainiPageTitle => 'Piga Faini';

  @override
  String get pageSubtitle => 'Chagua Faini';

  @override
  String get undefinedFine => 'Faini isiyoelezwa';

  @override
  String priceLabel(Object price) {
    return 'Bei: $price Tsh';
  }

  @override
  String get saveFine => 'Hifadhi Faini';

  @override
  String get payFineTitle => 'Lipa Faini';

  @override
  String remainingFineAmount(Object amount) {
    return 'Kiasi Kilichobakia:  $amount';
  }

  @override
  String get payAllFines => 'Lipa Faini Zote';

  @override
  String get payCustomAmount => 'Lipa Kiasi';

  @override
  String get confirmFinePayment => 'Lipa Faini';

  @override
  String get fineTitle => 'Faini za Mwanachama';

  @override
  String get fineSubtitle => 'Lipa Faini';

  @override
  String totalFines(Object amount) {
    return 'Jumla ya Faini Anazodaiwa:  $amount';
  }

  @override
  String paidFines(Object amount) {
    return 'Faini Alizolipa:  $amount';
  }

  @override
  String remainingFines(Object amount) {
    return 'Kiasi Kilichobakia:  $amount';
  }

  @override
  String get pigaFainiTitle => 'Piga Faini';

  @override
  String get pigaFainiSubtitle => 'Chagua Mwanachama';

  @override
  String get searchHint => 'Tafuta kwa jina au namba ya mwanachama';

  @override
  String get fainiSummarySubtitle => 'Muhtasari wa Faini';

  @override
  String get unknownName => 'Hakuna jina';

  @override
  String get unknownPhone => 'Simu haijulikani';

  @override
  String get backToFines => 'Rudi kwa Faini';

  @override
  String get lipaFainiTitle => 'Lipa Faini';

  @override
  String get totalFinesDue => 'Jumla ya Faini Zinazodaiwa';

  @override
  String get totalFinesPaid => 'Jumla ya Faini Zilizolipwa';

  @override
  String get noFineMembers => 'Hakuna wanachama wenye faini.';

  @override
  String get unpaidFinesTitle => 'Faini ambazo hazijalipwa';

  @override
  String memberTotalFines(Object amount) {
    return 'Jumla ya Faini:  $amount';
  }

  @override
  String get navigationError =>
      'Kuna tatizo la kusonga mbele. Tafadhali jaribu tena.';

  @override
  String get memberFinesTitle => 'Faini za Mwanachama';

  @override
  String memberNameLabel(Object name) {
    return 'Mwanachama: $name';
  }

  @override
  String memberNumberLabel(Object number) {
    return 'Namba ya Mwanachama: $number';
  }

  @override
  String totalFinesLabel(Object amount) {
    return 'Jumla ya Faini Anazodaiwa:  $amount';
  }

  @override
  String totalPaidLabel(Object amount) {
    return 'Faini Alizolipa:  $amount';
  }

  @override
  String totalUnpaidLabel(Object amount) {
    return 'Kiasi Kilichobakia:  $amount';
  }

  @override
  String memberPhone(Object phone) {
    return 'Simu: $phone';
  }

  @override
  String fineTypes(Object fineName) {
    return 'Aina ya Faini: $fineName';
  }

  @override
  String fineAmount(Object amount) {
    return 'Kiasi cha faini: $amount ';
  }

  @override
  String meetingNumber(Object meeting, Object meetings) {
    return 'Kikao cha : $meetings';
  }

  @override
  String get toa_mfuko_jamii => 'Toa Mfuko Jamii';

  @override
  String get sababu_ya_kutoa_mfuko => 'Sababu ya Kutoa Mfuko Jamii';

  @override
  String get hakuna_sababu => 'Hakuna sababu zilizojazwa bado.';

  @override
  String kiasi_cha_juu(Object amount) {
    return 'Kiasi cha juu cha Kutoa:  $amount';
  }

  @override
  String get jina => 'Jina:';

  @override
  String get jina_lisiloeleweka => 'Jina Lisiloeleweka';

  @override
  String get namba_haijapatikana => 'Namba Haijapatikana';

  @override
  String get chagua_sababu => 'Chagua Sababu ya Kutoa Mfuko Jamii';

  @override
  String get tatizo_katika_kupakia =>
      'Tatizo limejitokeza, tafadhali jaribu tena.';

  @override
  String get chagua_kiwango_kutoa => 'Chagua Kiwango cha Utoaji';

  @override
  String get namba_ya_mwanachama => 'Namba ya Mwanachama:';

  @override
  String get sababu_ya_kutoa => 'Sababu ya kutoa Mfuko jamii:';

  @override
  String get kiwango_cha_juu => 'Kiwango cha juu cha kutoa:';

  @override
  String get salio_la_sasa => 'Salio la sasa:';

  @override
  String get salio_la_kikao_kilichopita =>
      'Salio la Mfuko Jamii (Kikao kilichopita):';

  @override
  String get toa_kiasi_chote => 'Toa kiasi chote';

  @override
  String get toa_kiasi_kingine => 'Toa kiasi kingine';

  @override
  String get ingiza_kiasi => 'Ingiza kiasi';

  @override
  String get thibitisha_utoaji_pesa => 'Thibitisha utoaji pesa';

  @override
  String get kiasi_cha_kutoa => 'Kiasi cha kutoa:';

  @override
  String get salio_jipya => 'Salio la jipya:';

  @override
  String get toa_mkopo => 'Toa Mkopo';

  @override
  String get tahadhari => 'Tahadhari !';

  @override
  String get hawezi_kukopa =>
      'Mwanachama hawezai kukopa hadi atakapomaliza mkopo wake wa sasa.';

  @override
  String get sababu_ya_kutoa_mkopo => 'Sababu ya kutoa mkopo';

  @override
  String weka_sababu(Object name) {
    return 'Weka sababu ya ndugu $name kuchukua mkopo huu :';
  }

  @override
  String get kilimo => 'Kilimo';

  @override
  String get maboresho_nyumba => 'Maboresho ya Nyumba';

  @override
  String get elimu => 'Elimu';

  @override
  String get biashara => 'Biashara';

  @override
  String get sababu_nyingine => 'Sababu Nyingine';

  @override
  String get weka_sababu_nyingine => 'Weka Sababu Nyingine';

  @override
  String get thibitisha_sababu => 'Thibitisha Sababu';

  @override
  String get tafadhali_weka_sababu_nyingine =>
      'Tafadhali weka sababu nyingine.';

  @override
  String get jumla_ya_akiba => 'Jumla ya Akiba yake:';

  @override
  String get kiwango_cha_juu_mkopo => 'Kiwango cha Juu cha Mkopo:';

  @override
  String get fedha_zilizopo_mkopo => 'Fedha Zilizopo \nkwa Ajili ya Mkopo:';

  @override
  String chukua_mkopo_wote(Object amount) {
    return 'Chukua Mkopo Wote  $amount';
  }

  @override
  String get kiasi_kingine => 'Kiasi Kingine';

  @override
  String get kiasi => 'Kiasi';

  @override
  String get weka_kiasi => 'Weka Kiasi';

  @override
  String get thibitisha_kiasi => 'Thibitisha Kiasi';

  @override
  String get tafadhali_chagua_chaguo => 'Tafadhali chagua chaguo la mkopo.';

  @override
  String get kiasi_cha_mkopo_wa_mwanachama => 'Kiasi cha mkopo wa mwanachama';

  @override
  String get tafadhali_ingiza_kiasi_sahihi => 'Tafadhali ingiza kiasi sahihi.';

  @override
  String get hakuna_kiasi_cha_kutosha =>
      'Hakuna kiasi cha kutosha kutoa mkopo huu.';

  @override
  String get kiasi_hakiruhusiwi => 'Kiasi kilichochaguliwa hakiruhusiwi.';

  @override
  String get kiasi_na_riba_vimehifadhiwa =>
      'Kiasi cha Mkopo na Riba vimehifadhiwa.';

  @override
  String get hitilafu_imetokea => 'Hitilafu imetokea. Tafadhali jaribu tena.';

  @override
  String get muda_wa_marejesho => 'Muda wa Marejesho';

  @override
  String kiasi_cha_mkopo_wake_ni(Object amount) {
    return 'Kiasi cha Mkopo Wake Ni:\n $amount';
  }

  @override
  String get mkopo_wa_miezi_mingapi => 'Mkopo wa Miezi Mingapi?';

  @override
  String get mwezi_1 => 'Mwezi 1';

  @override
  String get miezi_2 => 'Miezi 2';

  @override
  String get miezi_3 => 'Miezi 3';

  @override
  String get miezi_6 => 'Miezi 6';

  @override
  String get nyingine => 'Nyingine';

  @override
  String get ingiza_miezi => 'Ingiza Miezi';

  @override
  String get thibitisha_muda => 'Thibitisha Muda';

  @override
  String get tafadhali_chagua_muda => 'Tafadhali chagua muda wa marejesho.';

  @override
  String get tafadhali_ingiza_muda_sahihi => 'Tafadhali ingiza muda sahihi.';

  @override
  String muda_wa_marejesho_umehifadhiwa(Object months) {
    return 'Muda wa Marejesho umehifadhiwa: Miezi $months';
  }

  @override
  String get wadhamini => 'Wadhamini';

  @override
  String jinas(Object name) {
    return 'Jina: $name';
  }

  @override
  String chagua_wadhamini(Object count) {
    return 'Chagua Wadhamini $count:';
  }

  @override
  String get haidhibiti_idadi =>
      'Tafadhali chagua wadhamini wote wanaohitajika.';

  @override
  String get haijulikani => 'Haijulikani';

  @override
  String get muhtasari_wa_mkopo => 'Muhtasari wa Mkopo';

  @override
  String get thibitisha_mkopo => 'Thibitisha Mkopo';

  @override
  String get maelezo_ya_mkopo => 'Maelezo ya Mkopo';

  @override
  String get kiasi_cha_mkopo => 'Kiasi cha Mkopo';

  @override
  String get riba_ya_mkopo => 'Riba ya Mkopo';

  @override
  String get maelezo_ya_riba => 'Maelezo \nya Riba';

  @override
  String get salio_la_mkopo => 'Salio la Mkopo';

  @override
  String get tarehe_ya_mwisho => 'Tarehe ya Mwisho';

  @override
  String miezi(Object miezi) {
    return 'Months $miezi';
  }

  @override
  String get oneTimeInterest => 'Ziada inalipwa mara moja tu';

  @override
  String guarantorExample(int count, String amount) {
    return 'Kwa mfano ikiwa Pili hawezi kulipa deni lake la  150,000 la mkopo wakati wa kugawana, akiba ya wanachama $count waliomdhamini mkopo wake, itapunguzwa kwa  $amount kwa kila mmoja.';
  }

  @override
  String get communityFundTitle => 'Mfuko jamii';

  @override
  String get unpaidContribution => 'Mchango ambao haujalipwa';

  @override
  String get expense => 'Matumizi';

  @override
  String get chooseUsageType => 'Chagua aina ya matumizi';

  @override
  String usageType(Object type) {
    return '$type';
  }

  @override
  String get matumziStationery => 'Shajara';

  @override
  String get matumziRefreshment => 'Viburudisho';

  @override
  String get matumziLoanPayment => 'Malipo ya Mkopo';

  @override
  String get matumziCallTime => 'Muda wa Maongezi (Vocha)';

  @override
  String get matumziTechnology => 'Teknolojia';

  @override
  String get matumiziMerchandise => 'Bidhaa za Biashara';

  @override
  String get matumziTransport => 'Usafiri';

  @override
  String get matumiziBackCharges => 'Gharama za Benki';

  @override
  String get matumziOther => 'Mengineyo';

  @override
  String get specificUsage => 'Matumizi Husika';

  @override
  String get enterSpecificUsage => 'Ingiza matumizi husika';

  @override
  String get pleaseEnterSpecificUsage => 'Tafadhali ingiza matumizi husika.';

  @override
  String get pleaseEnterAmount => 'Tafadhali ingiza kiasi';

  @override
  String get next => 'Endelea';

  @override
  String get expenseSummary => 'Muhtasari wa Matumizi';

  @override
  String get totalAmountSpent => 'Jumla ya Kiasi Kilichotumika';

  @override
  String get totalExpenses => 'Matumizi mengine ya kikundi';

  @override
  String get noExpensesRecorded => 'Hakuna matumizi yaliyorekodiwa.';

  @override
  String expenseLabel(Object label) {
    return 'Matumizi: $label';
  }

  @override
  String get unknown => 'Halijulikani';

  @override
  String expenseType(Object type) {
    return 'Aina: $type';
  }

  @override
  String amountLabel(Object amount) {
    return 'Kiasi:  $amount';
  }

  @override
  String fundLabel(Object fund) {
    return 'Mfuko: $fund';
  }

  @override
  String get done => 'Nimemaliza';

  @override
  String get confirmExpense => 'Thibitisha Matumizi';

  @override
  String get expenseFund => 'Mfuko wa Matumizi';

  @override
  String get expenseTypeLabel => 'Aina ya Matumizi';

  @override
  String get chooseFund => 'Chagua Mfuko';

  @override
  String get chooseFundToContribute => 'Chagua mfuko wa kuchangia';

  @override
  String get mainGroupFund => 'Mfuko Mkuu wa Kikundi';

  @override
  String get socialFund => 'Jamii';

  @override
  String get pleaseChooseFund => 'Tafadhali chagua mfuko.';

  @override
  String get bulkSaving => 'Uwekaji wa Mkupuo';

  @override
  String get chooseContributionType => 'Chagua Aina ya Uchangiaji';

  @override
  String get donationContribution => 'Mchango wa hisani';

  @override
  String get businessProfit => 'Faida za Biashara';

  @override
  String get loanDisbursement => 'Utoaji wa mkopo';

  @override
  String enterAmountFor(Object type) {
    return 'Ingiza Kiasi cha $type:';
  }

  @override
  String get totalContributionsForCycle => 'Jumla ya michango kwa mzunguko huu';

  @override
  String get contributionsList => 'Orodha ya Michango';

  @override
  String get noContributionsCompleted => 'Hakuna michango iliyokamilika.';

  @override
  String get noFund => 'Hakuna Mfuko';

  @override
  String contributionType(Object type) {
    return 'Aina: $type';
  }

  @override
  String get confirmContribution => 'Thibitisha Uchangiaji';

  @override
  String get fundBalance => 'Salio la Mfuko';

  @override
  String get currentContribution => 'Salio la Sasa';

  @override
  String get newFundBalance => 'Salio Jipya la Mfuko';

  @override
  String meetingSummaryTitle(Object meetingNumber) {
    return 'Muhtasari wa Kikao $meetingNumber';
  }

  @override
  String get sharePurchaseSection => 'Ununuzi wa Hisa';

  @override
  String get totalSharesDeposited => 'Jumla ya Hisa Zilizowekwa';

  @override
  String get totalShareValue => 'Jumla ya Thamani ya Hisa';

  @override
  String get amountDeposited => 'Kiasi kilichowekwa';

  @override
  String get amountWithdrawn => 'Kiasi kilichotolewa';

  @override
  String get loansSection => 'Mikopo';

  @override
  String get loansIssued => 'Mikopo Iliyotolewa';

  @override
  String get loanAmountRepaid => 'Kiasi cha mkopo Kilicholipwa';

  @override
  String get loanAmountOutstanding => 'Kiasi cha mkopo Kilichobakia';

  @override
  String get finesSection => 'Faini';

  @override
  String get totalBulkSaving => 'Jumla ya Uwekaji wa Mkupuo';

  @override
  String get expensesSection => 'Matumizi';

  @override
  String get loadingAttendanceSummary => 'Inapakia muhtasari wa mahudhurio...';

  @override
  String get presentMembers => 'Waliohudhuria';

  @override
  String get earlyMembers => 'Kawahi';

  @override
  String get lateMembers => 'Kachelewa';

  @override
  String get representative => 'Katuma Mwakilishi';

  @override
  String get absentMembers => 'Hawakuhudhuria';

  @override
  String get closeMeeting => 'Funga Kikao';

  @override
  String get sendSmsTitle => 'Tuma SMS';

  @override
  String get sendSmsSubtitle => 'Tuma SMS kwa Wanachama';

  @override
  String get chooseSmsSendType => 'Chagua Namna ya Kutuma SMS';

  @override
  String get sendToAll => 'Tuma kwa Wote';

  @override
  String get chooseMembers => 'Chagua Wanachama';

  @override
  String get selected => 'Waliochaguliwa';

  @override
  String get sendSms => 'Tuma SMS';

  @override
  String sendSmsWithCount(Object count) {
    return 'Tuma SMS ($count)';
  }

  @override
  String get selectMembersToSendSms =>
      'Tafadhali chagua wanachama wa kutumiwa SMS';

  @override
  String get noMembersToSendSms => 'Hakuna wanachama wa kutumiwa SMS';

  @override
  String smsGreeting(Object name) {
    return 'Ndugu $name,';
  }

  @override
  String get smsSummaryHeader => 'Muhtasari wa kikao ni:-';

  @override
  String smsTotalShares(Object shares, Object value) {
    return 'Jumla ya Hisa: $shares ( $value)';
  }

  @override
  String smsSocialFund(Object amount) {
    return 'Mfuko Jamii:  $amount';
  }

  @override
  String smsCurrentLoan(Object amount) {
    return 'Mkopo wa Sasa:  $amount';
  }

  @override
  String smsFine(Object amount) {
    return 'Faini:  $amount';
  }

  @override
  String get failedToCloseMeeting => 'Imeshindikana kufunga kikao';

  @override
  String get meetingNotFound => 'Kikao hakikupatikana';

  @override
  String failedToCloseMeetingWithError(Object error) {
    return 'Imeshindikana kufunga kikao: $error';
  }

  @override
  String get agentPreparedAndOnTime =>
      'Je wakala alijiandaa vema na aliwahi kufika?';

  @override
  String get agentExplainedChomoka =>
      'Je wakala alieleza jinsi ya kutumia mfumo wa Chomoka?';

  @override
  String get pleaseAnswerThisQuestion => 'Tafadhali jibu swali hili.';

  @override
  String get agentExplainedCosts =>
      'Je wakala alieleza vema na kwa uwazi juu ya gharama?';

  @override
  String get agentRating => 'Unampa maksi ngapi wakala wa Chomoka?';

  @override
  String get agentRatingLevel1 => '1. Mbaya';

  @override
  String get agentRatingLevel2 => '2. Wastani';

  @override
  String get agentRatingLevel3 => '3. Nzuri kiasi';

  @override
  String get agentRatingLevel4 => '4. Nzuri sana';

  @override
  String get agentRatingLevel5 => '5. Nzuri kabisa';

  @override
  String get pleaseChooseRating => 'Tafadhali chagua kiwango cha maksi.';

  @override
  String get unansweredQuestion =>
      'Una swali lolote ambalo wakala hakulijibu au haukuridhika na majibu yake?';

  @override
  String get question => 'Swali';

  @override
  String get pleaseWriteQuestion => 'Tafadhali andika swali.';

  @override
  String get suggestionForChomoka =>
      'Je unapendekeza mabadiliko gani kwenye mfumo wa Chomoka?';

  @override
  String get suggestion => 'Mrejesho';

  @override
  String get pleaseWriteSuggestion => 'Tafadhali andika mapendekezo.';

  @override
  String get noMeeting => 'Hakuna Kikao';

  @override
  String get noMeetingDesc =>
      'Hakuna kikao kilichofanyika katika mzunguko huu, tafadhali fanya kikao ili kuendelea na mgao.';

  @override
  String get meetingInProgress => 'Kikao Kinaendelea';

  @override
  String get meetingInProgressDesc =>
      'Tafadhali maliza kikao ili kuendelea na mgao.';

  @override
  String get shareout => 'Mgao';

  @override
  String get chooseShareoutType => 'Chagua Aina ya Mgao';

  @override
  String get groupShareout => 'Mgao wa Kikundi';

  @override
  String get groupShareoutDesc =>
      'Tumekamilisha mzunguko wetu na tunataka kufanya mgao. Tunataka kuchunguza hali yetu ya kushiriki katika kikundi.';

  @override
  String get memberShareout => 'Mgao wa Mwanachama';

  @override
  String get memberShareoutDesc =>
      'Tunataka kuondoa kabisa mwanachama kutoka kwa kikundi chetu na mwanachama hawezi kufanya kikao chochote na kikundi. Tunataka kutazama hali ya kushiriki kwa mwanachama.';

  @override
  String get returnToHome => 'Rudi Ukurasa Mkuu';

  @override
  String get summary => 'Muhtasari';

  @override
  String get chooseMember => 'Chagua Mwanachama';

  @override
  String phoneNumberLabel(Object phone) {
    return 'Phone: $phone';
  }

  @override
  String get totalMandatorySavings => 'Jumla ya akiba lazima';

  @override
  String get totalVoluntarySavings => 'Jumla ya akiba binafsi';

  @override
  String get unpaidFineAmount => 'Kiasi kisicholipwa \ncha faini';

  @override
  String get memberOwesAmount => 'Mwanachama anadaiwa \nkiasi cha';

  @override
  String get totalShareoutAmount => 'Jumla ya fedha za mgao';

  @override
  String get confirmShareout => 'Thibitisha Mgao';

  @override
  String get mandatorySavingsToBeWithdrawn => 'Akiba lazima itakayouzwa';

  @override
  String get voluntarySavingsToBeWithdrawn => 'Akiba binafsi itakayouzwa';

  @override
  String get memberMustPayAmount => 'Mwanachama anatakiwa \nalipe kiasi';

  @override
  String get cashPayment => 'Malipo Taslimu';

  @override
  String get noPaymentToMember => 'Mwanachama hatapokea \nmalipo yoyote';

  @override
  String get totalSharesCount => 'Idadi ya hisa';

  @override
  String get totalSharesValue => 'Jumla ya thamani ya hisa';

  @override
  String get enterKeysToContinue => 'Weka funguo kuendelea';

  @override
  String get smsSummaryTitle => 'Tuma muhtasari kwa SMS';

  @override
  String get smsYes => 'Ndiyo';

  @override
  String get smsNo => 'Hapana';

  @override
  String get groupShareTitle => 'Mgao wa Kikundi';

  @override
  String get noMembersInGroup => 'Hakuna wanachama katika kikundi hiki.';

  @override
  String get selectMember => 'Chagua mwanachama';

  @override
  String get totalFine => 'Jumla ya faini zilizokusanywa';

  @override
  String get totalSocialFund => 'Jumla ya Mfuko Jamii';

  @override
  String totalShareAmount(Object percentage, Object shares) {
    return 'Hisa: $shares ($percentage%)';
  }

  @override
  String get unpaidLoanMsg =>
      'Kuna malipo ya mkopo yasiyolipwa. Tafadhali lipa mikopo yote kabla ya kuendelea.';

  @override
  String get unpaidFineMsg =>
      'Kuna malipo ya faini yasiyolipwa. Tafadhali lipa faini zote kabla ya kuendelea.';

  @override
  String get unpaidSocialFundMsg =>
      'Kuna malipo ya mfuko jamii yasiyolipwa. Tafadhali lipa malipo yote kabla ya kuendelea.';

  @override
  String get unpaidCompulsorySavingsMsg =>
      'Kuna malipo ya akiba Lazima yasiyolipwa. Tafadhali lipa malipo yote kabla ya kuendelea.';

  @override
  String get warning => 'Tahadhali';

  @override
  String get profit => 'Faida';

  @override
  String get totalExtraCollected => 'Jumla ya ziada zilizokusanywa';

  @override
  String totalUnpaidAmount(Object amount) {
    return 'Jumla ya kiasi ambacho hakijalipwa:  $amount';
  }

  @override
  String get totalWithdrawnFromSocialFund =>
      'Jumla ya kiasi kilichotolewa katika Mfuko Jamii';

  @override
  String get totalFunds => 'Jumla ya fedha zote';

  @override
  String get expenses => 'Matumizi';

  @override
  String get otherGroupExpenses => 'Matumizi mengine ya kikundi';

  @override
  String get amountRemaining => 'Kiasi kilichobaki';

  @override
  String get socialFundCarriedForward =>
      'Mfuko Jamii kilichopelekwa Mzunguko ujao';

  @override
  String get totalShareFunds => 'Jumla ya fedha za mgao';

  @override
  String get amountNextCycleSubtitle => 'Kiasi kinachopelekwa mzunguko ujao';

  @override
  String get sendToNextCycle => 'Peleka kwenye mzunguko ujao';

  @override
  String get enterAmountNextCycle =>
      'Weka kiasi unachopeleka mzunguko ujao kwa kila mfuko';

  @override
  String availableAmount(Object amount) {
    return 'Inapatikana  $amount';
  }

  @override
  String amountMustBeLessThanOrEqual(Object amount) {
    return 'Kiasi lazima kiwe chini au sawa na $amount';
  }

  @override
  String get memberShareDistributionTitle => 'Mgao wa Wanachama';

  @override
  String shareValueAmount(Object amount) {
    return 'Thamani ya Hisa:  $amount';
  }

  @override
  String totalDistributionAmount(Object amount) {
    return 'Jumla ya Mgao:  $amount';
  }

  @override
  String get groupShareDistributionTitle => 'Mgao wa Kiikundi';

  @override
  String get noProfitEmoji => '😢';

  @override
  String get profitEmoji => '😊';

  @override
  String get noProfitMessage => 'Kikundi chenu hakijapata faida yoyote';

  @override
  String profitMessage(Object amount) {
    return 'Hongera! Kikundi chenu kimapata  $amount kama faida';
  }

  @override
  String get totalDistributionFunds => 'Jumla ya pesa za mgao';

  @override
  String amountTzs(Object amount) {
    return ' $amount';
  }

  @override
  String get nextCycleSocialFund =>
      'Kiasi cha mfuko jamii kilichopelekwa mzunguko ujao';

  @override
  String get nextCycleMemberSavings =>
      'Jumla ya akiba za mwanachama zilizopelekwa mzunguko ujao';

  @override
  String get finishCycle => 'Maliza Mzunguko';

  @override
  String get memberShareSummaryTitle => 'Muhtasari wa Mgao wa Mwanachama';

  @override
  String get memberShareSummarySubtitle => 'Muhtasari wa Mgao';

  @override
  String get giveToNextCycle => 'Toa kwenda mzunguko ujao';

  @override
  String get shareInfoSection => 'Taarifa za Hisa';

  @override
  String get numberOfShares => 'Idadi ya Hisa:';

  @override
  String get sharePercentage => 'Asilimia ya Hisa:';

  @override
  String get profitInfoSection => 'Taarifa za Faida';

  @override
  String get profitShare => 'Mgao wa Faida (kulingana na hisa):';

  @override
  String get socialFundShare => 'Mgao wa Mfuko Jamii:';

  @override
  String get distributionSummarySection => 'Muhtasari wa Mgao';

  @override
  String get summaryShareValue => 'Thamani ya Hisa:';

  @override
  String get summaryProfit => 'Faida:';

  @override
  String get summarySocialFund => 'Mfuko Jamii:';

  @override
  String get summaryTotalDistribution => 'Jumla ya Mgao:';

  @override
  String get paymentInfoSection => 'Taarifa za Malipo';

  @override
  String get amountToNextCycle => 'Kiasi cha akiba kwenda mzunguko ujao:';

  @override
  String get paymentAmount => 'Kiasi cha Malipo:';

  @override
  String get inputAmountForNextCycle => 'Weka kiasi kwa ajili ya mzunguko ujao';

  @override
  String get confirmButton => 'Thibitisha';

  @override
  String get amountMustBeLessThanOrEqualTotal =>
      'Kiasi kinachowekwa lazima kiwe kidogo au sawa na jumla ya mgao.';

  @override
  String get successfullyPaid => 'Imelipwa kikamilifu';

  @override
  String get groupActivitiesTitle => 'Shughuli za Kikundi';

  @override
  String get groupBusiness => 'Biashara ya kikundi';

  @override
  String get otherActivities => 'Shughuli za mbalimbali';

  @override
  String get training => 'Mafunzo';

  @override
  String get backToHome => 'Rudi Nyumbani';

  @override
  String get addTrainingTitle => 'Ongeza Mafunzo';

  @override
  String get editTrainingTitle => 'Hariri Mafunzo';

  @override
  String get trainingType => 'Aina ya Mafunzo';

  @override
  String get enterTrainingType => 'Ingiza aina ya mafunzo';

  @override
  String get organization => 'Shirika';

  @override
  String get enterOrganization => 'Ingiza jina la shirika';

  @override
  String get chooseDate => 'Chagua tarehe';

  @override
  String get membersCount => 'Idadi ya Wanachama';

  @override
  String get enterMembersCount => 'Ingiza idadi ya wanachama';

  @override
  String get trainer => 'Mwezeshaji';

  @override
  String get enterTrainer => 'Ingiza jina la mwezeshaji';

  @override
  String get saveTraining => 'Hifadhi Mafunzo';

  @override
  String get saveChanges => 'Hifadhi Mabadiliko';

  @override
  String get trainingSaved => 'Mafunzo yamehifadhiwa kwa mafanikio';

  @override
  String get trainingUpdated => 'Mafunzo yamehaririwa kwa mafanikio';

  @override
  String get pleaseFillAllFields => 'Tafadhali jaza sehemu zote';

  @override
  String get pleaseEnterTrainingType => 'Tafadhali ingiza aina ya mafunzo';

  @override
  String get pleaseEnterOrganization => 'Tafadhali ingiza jina la shirika';

  @override
  String get pleaseEnterMembersCount => 'Tafadhali ingiza idadi ya wanachama';

  @override
  String get pleaseEnterTrainer => 'Tafadhali ingiza jina la mwezeshaji';

  @override
  String get trainingListTitle => 'Orodha ya Mafunzo';

  @override
  String totalTrainings(Object count) {
    return 'Jumla ya mafunzo: $count';
  }

  @override
  String get noTrainingsSaved => 'Hakuna mafunzo yaliyohifadhiwa';

  @override
  String get addNewTraining => 'Ongeza Mafunzo';

  @override
  String get deleteTrainingTitle => 'Futa Mafunzo';

  @override
  String get deleteTrainingConfirm =>
      'Una uhakika unataka kufuta mafunzo haya?';

  @override
  String get trainingDeleted => 'Training deleted successfully';

  @override
  String get addOtherActivityTitle => 'Shughuli Nyingine';

  @override
  String get editOtherActivityTitle => 'Hariri Shughuli';

  @override
  String get activityDate => 'Tarehe';

  @override
  String get chooseActivityDate => 'Chagua tarehe';

  @override
  String get activityName => 'Shughuli Iliyofanyika';

  @override
  String get enterActivityName => 'Ingiza shughuli iliyofanyika';

  @override
  String get beneficiariesCount => 'Idadi ya Walengwa';

  @override
  String get enterBeneficiariesCount => 'Ingiza idadi ya walengwa';

  @override
  String get enterLocation => 'Ingiza eneo la shughuli';

  @override
  String get saveActivity => 'Hifadhi Shughuli';

  @override
  String get saveActivityChanges => 'Hifadhi Mabadiliko';

  @override
  String get activitySaved => 'Shughuli imehifadhiwa kwa mafanikio';

  @override
  String get activityUpdated => 'Shughuli imehaririwa kwa mafanikio';

  @override
  String get pleaseFillAllActivityFields => 'Tafadhali jaza sehemu zote';

  @override
  String get pleaseEnterActivityName =>
      'Tafadhali ingiza shughuli iliyofanyika';

  @override
  String get pleaseEnterBeneficiariesCount =>
      'Tafadhali ingiza idadi ya walengwa';

  @override
  String get pleaseEnterLocation => 'Tafadhali ingiza eneo';

  @override
  String get activityListTitle => 'Orodha ya Shughuli Nyingine';

  @override
  String totalActivities(Object count) {
    return 'Jumla ya shughuli: $count';
  }

  @override
  String get noActivitiesSaved => 'Hakuna shughuli zilizohifadhiwa';

  @override
  String get addNewActivity => 'Ongeza Shughuli';

  @override
  String get editActivity => 'Hariri';

  @override
  String get deleteActivity => 'Futa';

  @override
  String get deleteActivityTitle => 'Futa Shughuli';

  @override
  String get deleteActivityConfirm =>
      'Una uhakika unataka kufuta shughuli hii?';

  @override
  String get activityDeleted => 'Shughuli imefutwa kwa mafanikio';

  @override
  String get orderListTitle => 'Maombi ya Pembejeo';

  @override
  String get orderListSubtitle => 'Orodha ya maombi';

  @override
  String get orderListTotalRequests => 'Jumla ya Maombi';

  @override
  String get orderListPending => 'Zinazosubiri';

  @override
  String get orderListApproved => 'Zimeidhinishwa';

  @override
  String get orderListRejected => 'Zimekataliwa';

  @override
  String orderListRequests(Object count) {
    return 'Maombi $count';
  }

  @override
  String get orderListRefresh => 'Onyesha upya';

  @override
  String get orderListNoRequests => 'Hakuna maombi yaliyohifadhiwa';

  @override
  String get orderListAddNewPrompt => 'Bonyeza kitufe cha kuongeza ombi jipya';

  @override
  String get orderListDone => 'Nimemaliza';

  @override
  String get orderListUnknownInput => 'Pembejeo';

  @override
  String get orderListUnknownCompany => 'Kampuni haijulikani';

  @override
  String get orderListStatusApproved => 'Imeidhinishwa';

  @override
  String get orderListStatusRejected => 'Imekataliwa';

  @override
  String get orderListStatusPending => 'Inasubiri';

  @override
  String orderListAmount(Object amount) {
    return 'Idadi: $amount';
  }

  @override
  String get orderListUnknownAmount => 'Haijulikani';

  @override
  String get orderListUnknownDate => 'Tarehe haijulikani';

  @override
  String get orderListPrice => 'Bei';

  @override
  String get orderListUnknownPrice => 'Haijulikani';

  @override
  String get orderListFinish => 'Nimemaliza';

  @override
  String get orderListShowAgain => 'Onyesha upya';

  @override
  String get requestSummaryTitle => 'Maelezo ya Ombi la Pembejeo';

  @override
  String get requestSummaryListTitle => 'Orodha ya Maombi ya Pembejeo';

  @override
  String requestSummaryTotal(Object count) {
    return 'Jumla ya maombi: $count';
  }

  @override
  String get requestSummaryStatus => 'Hali ya Ombi';

  @override
  String get requestSummaryStatusApproved => 'Imeidhinishwa';

  @override
  String get requestSummaryStatusRejected => 'Imekataliwa';

  @override
  String get requestSummaryStatusPending => 'Inasubiri';

  @override
  String get requestSummaryStatusMessageApproved =>
      'Ombi lako la pembejeo limeidhinishwa. Unaweza kuendelea na mchakato wa ununuzi.';

  @override
  String get requestSummaryStatusMessageRejected =>
      'Samahani, ombi lako la pembejeo limekataliwa. Tafadhali wasiliana na msimamizi kwa maelezo zaidi.';

  @override
  String get requestSummaryStatusMessagePending =>
      'Ombi lako la pembejeo limepokelewa na linasubiri kuidhinishwa. Utaarifiwa mara tu linapoidhinishwa.';

  @override
  String get requestSummaryUserInfo => 'Taarifa za Mtumiaji';

  @override
  String get requestSummaryUserName => 'Jina la Mtumiaji';

  @override
  String get requestSummaryMemberNumber => 'Namba ya Mwanachama';

  @override
  String get requestSummaryPhone => 'Namba ya Simu';

  @override
  String get requestSummaryInputType => 'Aina ya Pembejeo';

  @override
  String get requestSummaryAmount => 'Kiasi';

  @override
  String get requestSummaryRequestDate => 'Tarehe ya Ombi';

  @override
  String get requestSummaryCompany => 'Kampuni';

  @override
  String get requestSummaryPrice => 'Bei';

  @override
  String get requestSummaryCost => 'Gharama';

  @override
  String get requestSummaryUnknown => 'Haijulikani';

  @override
  String get requestSummaryBack => 'Rudi';

  @override
  String get requestSummaryEdit => 'Hariri';

  @override
  String get requestSummaryAddRequest => 'Ongeza Ombi';

  @override
  String get requestSummaryNoRequests => 'Hakuna maombi yaliyohifadhiwa';

  @override
  String get requestSummaryAddNewPrompt =>
      'Bonyeza kitufe cha kuongeza ombi jipya';

  @override
  String get requestInputTitle => 'Agiza Pembejeo';

  @override
  String get requestInputEditTitle => 'Hariri Ombi la Pembejeo';

  @override
  String get requestInputType => 'Aina ya Pembejeo';

  @override
  String get requestInputTypeHint => 'Ingiza aina ya pembejeo';

  @override
  String get requestInputTypeError => 'Tafadhali ingiza aina ya pembejeo';

  @override
  String get requestInputCompany => 'Kampuni';

  @override
  String get requestInputCompanyHint => 'Ingiza jina la kampuni';

  @override
  String get requestInputCompanyError => 'Tafadhali ingiza jina la kampuni';

  @override
  String get requestInputAmount => 'Idadi';

  @override
  String get requestInputAmountHint => 'Ingiza Idadi';

  @override
  String get requestInputAmountError => 'Tafadhali ingiza Idadi';

  @override
  String get requestInputPrice => 'Bei';

  @override
  String get requestInputPriceHint => 'Ingiza bei';

  @override
  String get requestInputPriceError => 'Tafadhali ingiza bei';

  @override
  String get requestInputDate => 'Tarehe';

  @override
  String get requestInputDateHint => 'Chagua tarehe';

  @override
  String get requestInputStatus => 'Hali ya Ombi';

  @override
  String get requestInputStatusHint => 'Chagua hali ya ombi';

  @override
  String get requestInputSubmit => 'Tuma Ombi';

  @override
  String get requestInputSaveChanges => 'Hifadhi Mabadiliko';

  @override
  String get requestInputSuccess => 'Ombi lako limetumwa kikamilifu';

  @override
  String get requestInputUpdateSuccess => 'Ombi limesasishwa kikamilifu';

  @override
  String requestInputError(Object error) {
    return 'Hitilafu: $error';
  }

  @override
  String get requestInputFillAll => 'Tafadhali jaza taarifa zote';

  @override
  String get businessDashboardTitle => 'Dashboard ya Biashara';

  @override
  String get businessDashboardDefaultTitle => 'Dashboard ya Biashara';

  @override
  String get businessDashboardLocationUnknown => 'Hakuna mahali';

  @override
  String get businessDashboardProductType => 'Aina ya Bidhaa';

  @override
  String get businessDashboardProductTypeUnknown => 'Hakuna bidhaa';

  @override
  String get businessDashboardStartDate => 'Tarehe ya Kuanza';

  @override
  String get businessDashboardDateUnknown => 'Hakuna tarehe';

  @override
  String get businessDashboardStats => 'Takwimu za Biashara';

  @override
  String get businessDashboardPurchases => 'Manunuzi';

  @override
  String get businessDashboardSales => 'Mauzo';

  @override
  String get businessDashboardExpenses => 'Matumizi';

  @override
  String get businessDashboardProfit => 'Faida';

  @override
  String get businessDashboardActions => 'Vitendo';

  @override
  String get businessDashboardProfitShare => 'Mgao wa Faida';

  @override
  String get businessDashboardActive => 'Inafanya kazi';

  @override
  String get businessDashboardInactive => 'Haifanyi kazi';

  @override
  String get businessDashboardPending => 'Inasubiri';

  @override
  String get businessDashboardStatus => 'Hali';

  @override
  String businessDashboardError(Object error) {
    return 'Hitilafu: $error';
  }

  @override
  String get businessListTitle => 'Orodha ya Biashara';

  @override
  String businessListCount(Object count) {
    return 'Biashara $count';
  }

  @override
  String get businessListRefresh => 'Onyesha upya';

  @override
  String get businessListNoBusinesses => 'Hakuna biashara zilizosajiliwa';

  @override
  String get businessListAddPrompt => 'Bofya kitufe cha + kuongeza biashara';

  @override
  String get businessListViewMore => 'Angalia Zaidi';

  @override
  String get businessListLocationUnknown => 'Hakuna mahali';

  @override
  String get businessListProductTypeUnknown => 'Hakuna bidhaa';

  @override
  String get businessListStatusActive => 'Inafanya kazi';

  @override
  String get businessListStatusInactive => 'Haifanyi kazi';

  @override
  String get businessListStatusPending => 'Inasubiri';

  @override
  String get businessListDateUnknown => 'Hakuna tarehe';

  @override
  String get businessInformationTitle => 'Taarifa za Biashara';

  @override
  String get businessInformationName => 'Jina la Biashara';

  @override
  String get businessInformationNameHint => 'Ingiza jina la biashara';

  @override
  String get businessInformationNameAbove => 'Jina la Biashara:';

  @override
  String get businessInformationNameError =>
      'Tafadhali ingiza jina la biashara';

  @override
  String get businessInformationLocation => 'Mahali Biashara Inapofanyika';

  @override
  String get businessInformationLocationHint =>
      'Ingiza mahali biashara inapofanyika';

  @override
  String get businessInformationLocationAbove =>
      'Mahali Biashara Inapofanyika:';

  @override
  String get businessInformationLocationError =>
      'Tafadhali ingiza mahali biashara inapofanyika';

  @override
  String get businessInformationStartDate => 'Tarehe ya Kuanza Biashara';

  @override
  String get businessInformationStartDateHint => 'Chagua tarehe';

  @override
  String get businessInformationStartDateAbove => 'Tarehe ya Kuanza Biashara:';

  @override
  String get businessInformationProductTypeAbove => 'Aina ya Bidhaa:';

  @override
  String get businessInformationProductType => 'Aina ya Bidhaa';

  @override
  String get businessInformationProductTypeError =>
      'Tafadhali chagua aina ya bidhaa';

  @override
  String get businessInformationOtherProductType => 'Taja Aina ya Bidhaa';

  @override
  String get businessInformationOtherProductTypeHint => 'Ingiza aina ya bidhaa';

  @override
  String get businessInformationOtherProductTypeAbove => 'Taja Aina ya Bidhaa:';

  @override
  String get businessInformationOtherProductTypeError =>
      'Tafadhali ingiza aina ya bidhaa';

  @override
  String get businessInformationSave => 'Hifadhi Taarifa';

  @override
  String get businessInformationSaved =>
      'Taarifa za biashara zimehifadhiwa kikamilifu';

  @override
  String get businessSummaryTitle => 'Muhtasari wa Biashara';

  @override
  String get businessSummaryNoInfo => 'Hakuna taarifa za biashara';

  @override
  String get businessSummaryRegisterPrompt =>
      'Tafadhali sajili biashara kwanza ili kuona muhtasari';

  @override
  String get businessSummaryRegister => 'Sajili Biashara';

  @override
  String get businessSummaryDone => 'Nimemaliza';

  @override
  String get businessSummaryInfo => 'Taarifa za Biashara';

  @override
  String get businessSummaryName => 'Jina la Biashara:';

  @override
  String get businessSummaryLocation => 'Mahali Biashara Inapofanyika:';

  @override
  String get businessSummaryStartDate => 'Tarehe ya Kuanza:';

  @override
  String get businessSummaryProductType => 'Aina ya Bidhaa:';

  @override
  String get businessSummaryOtherProductType => 'Aina Nyingine ya Bidhaa:';

  @override
  String get businessSummaryEdit => 'Hariri Taarifa';

  @override
  String get expensesListTitle => 'Orodha ya Matumizi';

  @override
  String get expensesListNoExpenses => 'Hakuna matumizi yaliyorekodiwa';

  @override
  String get expensesListAddPrompt => 'Bonyeza kitufe cha + kuongeza matumizi';

  @override
  String get expensesListAddExpense => 'Ongeza Matumizi';

  @override
  String expensesListAmount(Object amount) {
    return 'TSh $amount';
  }

  @override
  String expensesListReason(Object reason) {
    return 'Sababu: $reason';
  }

  @override
  String expensesListPayer(Object payer) {
    return 'Mlipaji: $payer';
  }

  @override
  String get expensesListUnknown => 'Haijulikani';

  @override
  String get expensesListNoDate => 'Hakuna tarehe';

  @override
  String get purchaseListTitle => 'Orodha ya Manunuzi';

  @override
  String get purchaseListNoPurchases => 'Hakuna manunuzi yaliyorekodiwa';

  @override
  String get purchaseListAddPrompt => 'Bonyeza kitufe cha + kuongeza manunuzi';

  @override
  String get purchaseListAddPurchase => 'Ongeza Manunuzi';

  @override
  String purchaseListAmount(Object amount) {
    return 'TSh $amount';
  }

  @override
  String purchaseListBuyer(Object buyer) {
    return 'Mnunuzi: $buyer';
  }

  @override
  String get purchaseListUnknown => 'Haijulikani';

  @override
  String get purchaseListNoDate => 'Hakuna tarehe';

  @override
  String get saleListTitle => 'Orodha ya Mauzo';

  @override
  String get saleListNoSales => 'Hakuna mauzo yaliyorekodiwa';

  @override
  String get saleListAddPrompt => 'Bonyeza kitufe cha + kuongeza mauzo';

  @override
  String get saleListAddSale => 'Ongeza Mauzo';

  @override
  String saleListAmount(Object amount) {
    return 'TSh $amount';
  }

  @override
  String saleListCustomer(Object customer) {
    return 'Mteja: $customer';
  }

  @override
  String saleListSeller(Object seller) {
    return 'Muuzaji: $seller';
  }

  @override
  String get saleListUnknown => 'Haijulikani';

  @override
  String get saleListNoDate => 'Hakuna tarehe';

  @override
  String get expensesTitle => 'Rekodi Matumizi';

  @override
  String get expensesBusinessName => 'Biashara';

  @override
  String get expensesBusinessLocationUnknown => 'Hakuna mahali';

  @override
  String get expensesInfo => 'Taarifa za Matumizi';

  @override
  String get expensesDate => 'Tarehe';

  @override
  String get expensesDateHint => 'dd/mm/yyyy';

  @override
  String get expensesDateError => 'Tafadhali chagua tarehe';

  @override
  String get expensesDateAbove => 'Tarehe ya Matumizi';

  @override
  String get expensesReason => 'Sababu ya Matumizi';

  @override
  String get expensesReasonHint => 'Ingiza sababu ya matumizi';

  @override
  String get expensesReasonError => 'Tafadhali ingiza sababu ya matumizi';

  @override
  String get expensesReasonAbove => 'Sababu ya Matumizi';

  @override
  String get expensesAmount => 'Kiasi cha Matumizi';

  @override
  String get expensesAmountHint => 'Ingiza kiasi kwa TSh';

  @override
  String get expensesAmountError => 'Tafadhali ingiza kiasi';

  @override
  String get expensesAmountInvalidError => 'Tafadhali ingiza namba halali';

  @override
  String get expensesAmountAbove => 'Kiasi (TSh)';

  @override
  String get expensesPayer => 'Jina la Mlipaji';

  @override
  String get expensesPayerHint => 'Ingiza jina la mlipaji';

  @override
  String get expensesPayerError => 'Tafadhali ingiza jina la mlipaji';

  @override
  String get expensesPayerAbove => 'Mlipaji';

  @override
  String get expensesDescription => 'Maelezo ya Matumizi';

  @override
  String get expensesDescriptionHint =>
      'Ingiza maelezo ya ziada kuhusu matumizi';

  @override
  String get expensesDescriptionAbove => 'Maelezo';

  @override
  String get expensesSave => 'Hifadhi Taarifa';

  @override
  String get purchasesTitle => 'Rekodi Manunuzi';

  @override
  String get purchasesBusinessName => 'Biashara';

  @override
  String get purchasesBusinessLocationUnknown => 'Hakuna mahali';

  @override
  String get purchasesInfo => 'Taarifa za Manunuzi';

  @override
  String get purchasesDate => 'Tarehe';

  @override
  String get purchasesDateHint => 'dd/mm/yyyy';

  @override
  String get purchasesDateError => 'Tafadhali chagua tarehe';

  @override
  String get purchasesDateAbove => 'Tarehe ya Manunuzi';

  @override
  String get purchasesAmount => 'Kiasi cha Manunuzi';

  @override
  String get purchasesAmountHint => 'Ingiza kiasi kwa TSh';

  @override
  String get purchasesAmountError => 'Tafadhali ingiza kiasi';

  @override
  String get purchasesAmountInvalidError => 'Tafadhali ingiza namba halali';

  @override
  String get purchasesAmountAbove => 'Gharama za Manunuzi';

  @override
  String get purchasesBuyer => 'Jina la Mnunuzi';

  @override
  String get purchasesBuyerHint => 'Ingiza jina la aliyenunua';

  @override
  String get purchasesBuyerError => 'Tafadhali ingiza jina la mnunuzi';

  @override
  String get purchasesBuyerAbove => 'Aliyenunua';

  @override
  String get purchasesDescription => 'Maelezo ya Manunuzi';

  @override
  String get purchasesDescriptionHint =>
      'Ingiza maelezo ya ziada kuhusu manunuzi';

  @override
  String get purchasesDescriptionAbove => 'Maelezo';

  @override
  String get purchasesSave => 'Hifadhi Taarifa';

  @override
  String get salesTitle => 'Rekodi Mauzo';

  @override
  String get salesBusinessName => 'Biashara';

  @override
  String get salesBusinessLocationUnknown => 'Hakuna mahali';

  @override
  String get salesInfo => 'Taarifa za Mauzo';

  @override
  String get salesDate => 'Tarehe';

  @override
  String get salesDateHint => 'dd/mm/yyyy';

  @override
  String get salesDateError => 'Tafadhali chagua tarehe';

  @override
  String get salesDateAbove => 'Tarehe ya Mauzo';

  @override
  String get salesCustomer => 'Jina la Mteja';

  @override
  String get salesCustomerHint => 'Ingiza jina la mteja';

  @override
  String get salesCustomerError => 'Tafadhali ingiza jina la mteja';

  @override
  String get salesCustomerAbove => 'Mteja';

  @override
  String get salesRevenue => 'Kiasi cha Mapato';

  @override
  String get salesRevenueHint => 'Ingiza kiasi kwa TSh';

  @override
  String get salesRevenueError => 'Tafadhali ingiza kiasi';

  @override
  String get salesRevenueInvalidError => 'Tafadhali ingiza namba halali';

  @override
  String get salesRevenueAbove => 'Mapato';

  @override
  String get salesSeller => 'Jina la Muuzaji';

  @override
  String get salesSellerHint => 'Ingiza jina la aliyeuza';

  @override
  String get salesSellerError => 'Tafadhali ingiza jina la muuzaji';

  @override
  String get salesSellerAbove => 'Aliyeuza';

  @override
  String get salesDescription => 'Maelezo ya Mauzo';

  @override
  String get salesDescriptionHint => 'Ingiza maelezo ya ziada kuhusu mauzo';

  @override
  String get salesDescriptionAbove => 'Maelezo';

  @override
  String get salesSave => 'Hifadhi Taarifa';

  @override
  String get badiliSarafu => 'Badili Sarafu';

  @override
  String get chaguaSarafuYaProgramu => 'Chagua sarafu ya programu';

  @override
  String get male => 'Mke';

  @override
  String get female => 'Mme';
}
