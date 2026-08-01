// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get selectCountry => 'اختر الدولة';

  @override
  String get pleaseSelectCountry => 'يرجى اختيار دولتك';

  @override
  String get pleaseSelectCountryError => 'يرجى اختيار دولة قبل المتابعة.';

  @override
  String get locationInformation => 'معلومات الموقع';

  @override
  String get selectLanguage => 'اختر اللغة';

  @override
  String get pleaseSelectLanguage => 'يرجى اختيار اللغة';

  @override
  String get selectRegion => 'اختر المنطقة';

  @override
  String get pleaseSelectRegion => 'يرجى اختيار المنطقة';

  @override
  String get loan_based_on_shares =>
      'حدد عدد المرات (x) التي يمكن للعضو الاقتراض فيها بناءً على حصصه';

  @override
  String get loan_based_on_savings =>
      'حدد عدد المرات (x) التي يمكن للعضو الاقتراض فيها بناءً على مدخراته';

  @override
  String get selectDistrict => 'اختر المقاطعة';

  @override
  String get pleaseSelectDistrict => 'يرجى اختيار المقاطعة';

  @override
  String get selectWard => 'اختر الحي';

  @override
  String get pleaseSelectWard => 'يرجى اختيار الحي';

  @override
  String get enterStreetOrVillage => 'أدخل اسم الشارع أو القرية';

  @override
  String get pleaseEnterStreetOrVillage => 'يرجى إدخال اسم الشارع أو القرية';

  @override
  String get dataSavedSuccessfully => 'تم حفظ البيانات بنجاح';

  @override
  String errorSavingData(String error) {
    return 'حدث خطأ أثناء حفظ البيانات: $error';
  }

  @override
  String get permissions => 'الأذونات';

  @override
  String get permissionsDescription =>
      'يتطلب تطبيق Chomoka عدة أذونات للعمل بشكل صحيح وفعال.';

  @override
  String get permissionsRequest =>
      'يرجى قبول جميع طلبات الأذونات لمتابعة استخدام Chomoka بسهولة.';

  @override
  String get smsPermission => 'الرسائل القصيرة (SMS)';

  @override
  String get smsDescription =>
      'يستخدم Chomoka الرسائل القصيرة كنسخة احتياطية لتخزين المعلومات عند عدم توفر الإنترنت.';

  @override
  String get locationPermission => 'موقعك';

  @override
  String get locationDescription =>
      'لتحسين كفاءة النظام، سيستخدم Chomoka معلومات موقعك.';

  @override
  String get mediaPermission => 'الصور والمستندات';

  @override
  String get mediaDescription =>
      'يمكنك حفظ الصور والمعلومات والمستندات ذات الصلة للتحقق.';

  @override
  String get termsAndConditions => 'الشروط والأحكام';

  @override
  String get aboutChomoka => 'حول Chomoka';

  @override
  String get aboutChomokaContent =>
      'لاستخدام Chomoka، يجب الموافقة على الشروط والأحكام وسياسة الخصوصية.';

  @override
  String get dataManagement => 'إدارة البيانات';

  @override
  String get dataManagementContent =>
      'باستخدام Chomoka، فإنك توافق على جمع بياناتك وتخزينها. قد يستخدم النظام معلومات موقعك ويرسل رسائل من هاتفك.';

  @override
  String get namedData => 'البيانات المسماة';

  @override
  String get namedDataContent =>
      'سيتم تخزين معلومات المجموعة والأعضاء لأغراض السجلات. لن نشارك هذه المعلومات مع أي شخص دون إذن المجموعة.';

  @override
  String get generalData => 'البيانات العامة';

  @override
  String get generalDataContent =>
      'سنستخدم البيانات العامة دون ذكر أسماء الأعضاء أو المجموعات لفهم التطورات بشكل أفضل.';

  @override
  String get acceptTerms => 'أوافق على الشروط والأحكام';

  @override
  String get confirm => 'تأكيد';

  @override
  String get setupChomoka => 'إعداد Chomoka';

  @override
  String get groupInfo => 'معلومات المجموعة';

  @override
  String get memberInfo => 'معلومات العضو';

  @override
  String get constitutionInfo => 'معلومات النظام الأساسي';

  @override
  String get fundInfo => 'معلومات الصندوق';

  @override
  String get passwordSetup => 'إعداد كلمة المرور';

  @override
  String get passwordSetupComplete => 'تم إعداد كلمة المرور بنجاح!';

  @override
  String get completePreviousStepFirst => 'يرجى إكمال الخطوة السابقة أولاً.';

  @override
  String get finished => 'انتهى';

  @override
  String get groupInformation => 'أدخل معلومات المجموعة';

  @override
  String get editGroupInformation => 'تعديل معلومات المجموعة';

  @override
  String get groupName => 'اسم المجموعة';

  @override
  String get enterGroupName => 'أدخل اسم المجموعة';

  @override
  String get groupNameRequired => 'اسم المجموعة مطلوب!';

  @override
  String get yearEstablished => 'سنة التأسيس';

  @override
  String get enterYearEstablished => 'أدخل سنة التأسيس';

  @override
  String get yearEstablishedRequired => 'سنة التأسيس مطلوبة!';

  @override
  String get enterValidYear => 'يرجى إدخال سنة صحيحة!';

  @override
  String enterYearRange(Object currentYear) {
    return 'يرجى إدخال سنة بين 1999 و $currentYear!';
  }

  @override
  String get currentRound => 'في أي جولة تتواجد المجموعة';

  @override
  String get enterCurrentRound => 'أدخل الجولة الحالية للمجموعة';

  @override
  String get currentRoundRequired => 'الجولة الحالية مطلوبة!';

  @override
  String get enterValidRound => 'يرجى إدخال رقم صحيح للجولة!';

  @override
  String get update => 'تحديث';

  @override
  String errorUpdatingData(Object error) {
    return 'حدث خطأ أثناء تحديث البيانات: $error';
  }

  @override
  String get groupSummary => 'ملخص المجموعة';

  @override
  String get sessionSummary => 'ملخص الجلسة';

  @override
  String get meetingFrequency => 'كم مرة تجتمعون؟';

  @override
  String get pleaseSelectFrequency => 'يرجى اختيار تكرار الاجتماعات!';

  @override
  String get sessionCount => 'عدد الجلسات في الجولة:';

  @override
  String get enterSessionCount => 'أدخل عدد الجلسات';

  @override
  String get sessionCountRequired => 'يرجى إدخال عدد الجلسات';

  @override
  String get enterValidSessionCount => 'يرجى إدخال عدد صحيح للجلسات';

  @override
  String get pleaseNote => 'يرجى الملاحظة:';

  @override
  String allocationDescription(String allocationDescription) {
    return 'التخصيص كل $allocationDescription';
  }

  @override
  String errorOccurred(Object error) {
    return 'خطأ: $error';
  }

  @override
  String get groupRegistration => 'تسجيل المجموعة';

  @override
  String get fines => 'الغرامات';

  @override
  String get meeting_completed_title => 'تم إتمام الاجتماع';

  @override
  String get meeting_completed_message =>
      'تم إتمام الاجتماع. أعد تشغيل نظام Chomoka لبدء جلسة جديدة.';

  @override
  String get meeting_completed_button => 'تسجيل الدخول مرة أخرى';

  @override
  String get lateness => 'التأخر في الحضور';

  @override
  String get absentWithoutPermission => 'الغياب بدون إذن';

  @override
  String get sendingRepresentative => 'إرسال ممثل';

  @override
  String get speakingWithoutPermission => 'الكلام بدون إذن';

  @override
  String get phoneUsageDuringMeeting => 'استخدام الهاتف أثناء الاجتماع';

  @override
  String get leadershipMisconduct => 'سوء تصرف القيادة';

  @override
  String get forgettingRules => 'نسيان القواعد';

  @override
  String get addNewFine => 'إضافة غرامة جديدة';

  @override
  String get finesWithoutAmountWontShow =>
      'لن تظهر الغرامات بدون مبالغ أثناء الاجتماعات';

  @override
  String get fineType => 'نوع الغرامة';

  @override
  String get addFineType => 'إضافة نوع غرامة';

  @override
  String get amount => 'المبلغ';

  @override
  String get percentage => 'النسبة المئوية';

  @override
  String get memberShareTitle => 'توزيع العضو';

  @override
  String get shareCount => 'عدد الحصص';

  @override
  String get saveButton => 'حفظ';

  @override
  String get unnamed => 'غير مسمى';

  @override
  String get noPhone => 'لا يوجد رقم هاتف';

  @override
  String errorLoadingData(Object error) {
    return 'خطأ في تحميل البيانات: $error';
  }

  @override
  String failedToUpdateStatus(Object error) {
    return 'فشل في تحديث الحالة: $error';
  }

  @override
  String get fixedAmount => 'مبلغ ثابت';

  @override
  String get enterPenaltyPercentage => 'أدخل نسبة الغرامة';

  @override
  String get percentageRequired => 'النسبة المئوية مطلوبة';

  @override
  String get enterValidPercentage => 'يرجى إدخال نسبة صحيحة';

  @override
  String get enterFixedAmount => 'أدخل المبلغ الثابت';

  @override
  String get fixedAmountRequired => 'المبلغ الثابت مطلوب';

  @override
  String get enterValidAmount => 'يرجى إدخال مبلغ صحيح!';

  @override
  String get explainPenaltyUsage =>
      'اشرح كيفية استخدام الغرامات على القروض عند عدم قيام العضو بسداد جميع المدفوعات في الوقت المحدد.';

  @override
  String get loanDelayPenalty => 'غرامة تأخير القرض';

  @override
  String get noPercentagePenalty =>
      'لن يتم فرض غرامة نسبة مئوية على التأخيرات.';

  @override
  String percentagePenaltyExample(String percentage, String amount) {
    return 'على سبيل المثال، إذا تأخر العضو في سداد قرضه، سيدفع $percentage% إضافية شهريًا على المبلغ المتبقي. إذا اقترض 10,000، يجب أن يدفع رسوم تأخير قدرها $amount شهريًا.';
  }

  @override
  String get noFixedAmountPenalty =>
      'لن يتم فرض غرامة مبلغ ثابت على التأخيرات.';

  @override
  String fixedAmountPenaltyExample(String amount) {
    return 'على سبيل المثال، إذا تأخر العضو في سداد قرضه، سيدفع $amount كغرامة تأخير ثابتة.';
  }

  @override
  String get addAmount => 'إضافة المبلغ';

  @override
  String get cancel => 'إلغاء';

  @override
  String get save => 'حفظ';

  @override
  String get continue_ => 'متابعة';

  @override
  String get editRegistration => 'تعديل التسجيل';

  @override
  String get registrationStatus => 'حالة التسجيل';

  @override
  String get selectRegistrationStatus => 'اختر حالة التسجيل';

  @override
  String get pleaseSelectRegistrationStatus => 'يرجى اختيار حالة التسجيل';

  @override
  String get appVersionName => 'نسخة تشباتي 1.0.0';

  @override
  String get appVersionNumber => 'الإصدار 0001';

  @override
  String get open => 'فتح';

  @override
  String get demo => 'عرض تجريبي';

  @override
  String get exercise => 'تمرين';

  @override
  String get registrationNumber => 'رقم التسجيل';

  @override
  String get enterRegistrationNumber => 'أدخل رقم التسجيل';

  @override
  String get pleaseEnterRegistrationNumber => 'يرجى إدخال رقم التسجيل';

  @override
  String get correct => 'صحيح';

  @override
  String get groupInstitution => 'مؤسسة المجموعة';

  @override
  String get editInstitution => 'تعديل مؤسسة المجموعة';

  @override
  String get selectOrganization => 'اختر المنظمة';

  @override
  String get pleaseSelectOrganization => 'يرجى اختيار المنظمة';

  @override
  String get enterOrganizationName => 'أدخل اسم المنظمة';

  @override
  String get organizationNameRequired => 'اسم المنظمة مطلوب!';

  @override
  String get selectProject => 'اختر المشروع';

  @override
  String get pleaseSelectProject => 'يرجى اختيار المشروع';

  @override
  String get enterProjectName => 'أدخل اسم المشروع';

  @override
  String get projectNameRequired => 'اسم المشروع مطلوب!';

  @override
  String get enterTeacherId => 'أدخل معرف المعلم';

  @override
  String get teacherIdRequired => 'معرف المعلم مطلوب!';

  @override
  String get continueText => 'متابعة';

  @override
  String get selectKeyToReset => 'اختر المفتاح لإعادة التعيين';

  @override
  String get keyHolderSecretQuestion =>
      'سيُطلب من العضو الحامل للمفتاح المختار سؤال سري أثناء إعداد المفتاح';

  @override
  String get resetKey1 => 'إعادة تعيين المفتاح 1';

  @override
  String get resetKey2 => 'إعادة تعيين المفتاح 2';

  @override
  String get resetKey3 => 'إعادة تعيين المفتاح 3';

  @override
  String get selectQuestion => 'اختر السؤال';

  @override
  String get answerToQuestion => 'إجابة السؤال';

  @override
  String get enterAnswer => 'أدخل الإجابة على السؤال';

  @override
  String get incorrectQuestionOrAnswer => 'السؤال أو الإجابة غير صحيحة';

  @override
  String get pleaseSelectQuestionAndAnswer => 'يرجى اختيار السؤال والإجابة';

  @override
  String get passwordsDoNotMatchTryAgain =>
      'كلمات المرور غير متطابقة، يرجى المحاولة مرة أخرى';

  @override
  String get confirmPasswordTitle => 'تأكيد كلمة المرور لـ';

  @override
  String get groupOverview => 'نظرة عامة على المجموعة';

  @override
  String get fundOverview => 'نظرة عامة على الصندوق';

  @override
  String get meetingSummary => 'ملخص الاجتماع';

  @override
  String get allocation => 'التخصيص';

  @override
  String get registration => 'تسجيل المجموعة';

  @override
  String get registrationType => 'نوع التسجيل';

  @override
  String get institutionalInfo => 'معلومات مؤسسية';

  @override
  String get institutionName => 'اسم المؤسسة';

  @override
  String get projectName => 'اسم المشروع';

  @override
  String get teacherId => 'معرف المعلم';

  @override
  String get location => 'الموقع';

  @override
  String get loanGuarantors => 'ضامنو القرض';

  @override
  String get doesLoanNeedGuarantor => 'هل يحتاج القرض إلى ضامن؟';

  @override
  String get numberOfGuarantors => 'عدد الضامنين';

  @override
  String get enterNumberOfGuarantors => 'أدخل عدد الضامنين';

  @override
  String get numberOfGuarantorsRequired => 'عدد الضامنين مطلوب';

  @override
  String get securityQuestion1 => 'في أي سنة وُلِد طفلك الأول؟';

  @override
  String get securityQuestion2 => 'ما هو الاسم الأول لطفلك الأول؟';

  @override
  String get securityQuestion3 => 'في أي سنة وُلِدت؟';

  @override
  String get errorSelectQuestion => 'يرجى اختيار سؤال أمني.';

  @override
  String get errorEnterAnswer => 'يرجى إدخال الإجابة على السؤال.';

  @override
  String get errorSaving => 'حدثت مشكلة أثناء الحفظ. يرجى المحاولة مرة أخرى.';

  @override
  String resetQuestionPageTitle(int passwordNumber) {
    return 'السؤال الأمني للمفتاح $passwordNumber';
  }

  @override
  String get selectQuestionLabel => 'اختر السؤال';

  @override
  String get selectQuestionHint => 'اختر السؤال';

  @override
  String get answerLabel => 'الإجابة';

  @override
  String get answerHint => 'أدخل الإجابة';

  @override
  String get pleaseEnterValidNumber => 'يرجى إدخال رقم صحيح';

  @override
  String get describeNumberOfGuarantors =>
      'حدد عدد الضامنين المطلوبين لتقديم طلب قرض';

  @override
  String get country => 'الدولة';

  @override
  String get region => 'المنطقة';

  @override
  String get district => 'المقاطعة';

  @override
  String get ward => 'الحي';

  @override
  String get streetOrVillage => 'الشارع أو القرية';

  @override
  String get sendSummary => 'إرسال الملخص';

  @override
  String get completed => 'مكتمل';

  @override
  String members(Object count) {
    return 'الأعضاء: $count';
  }

  @override
  String get noMembers => 'لا يوجد أعضاء.';

  @override
  String errorFetchingMembers(Object error) {
    return 'حدث خطأ أثناء جلب الأعضاء: $error';
  }

  @override
  String get memberSummary => 'ملخص العضو';

  @override
  String get memberIdentity => 'هوية العضو';

  @override
  String get fullName => 'الاسم الكامل:';

  @override
  String get memberNumber => 'رقم العضو';

  @override
  String get gender => 'الجنس:';

  @override
  String get dob => 'تاريخ الميلاد:';

  @override
  String get phoneNumber => 'رقم الهاتف:';

  @override
  String get job => 'الوظيفة:';

  @override
  String get idType => 'نوع الهوية:';

  @override
  String get idNumber => 'رقم الهوية:';

  @override
  String get noPhoneNumber => 'العضو لا يملك رقم هاتف';

  @override
  String summarySent(Object name) {
    return 'تم إرسال الملخص إلى $name بنجاح';
  }

  @override
  String failedToSendSms(Object name) {
    return 'فشل إرسال الرسالة القصيرة إلى $name';
  }

  @override
  String get totalSavings => 'إجمالي المدخرات';

  @override
  String get totalDebt => 'إجمالي الديون';

  @override
  String get totalShares => 'إجمالي الحصص';

  @override
  String get communityFundBalance => 'رصيد الصندوق الاجتماعي';

  @override
  String get currentLoans => 'القروض الحالية';

  @override
  String get totalFinesCollected => 'إجمالي الغرامات المحصّلة';

  @override
  String get confirmDeleteUser => 'هل أنت متأكد أنك تريد حذف هذا المستخدم؟';

  @override
  String get delete => 'حذف';

  @override
  String get enterMemberNumber => 'أدخل رقم العضو';

  @override
  String get memberNumberRequired => 'يرجى إدخال رقم العضو';

  @override
  String get memberNumberDigitsOnly => 'رقم العضو يجب أن يكون أرقامًا فقط';

  @override
  String get enterFullName => 'أدخل الاسم الكامل';

  @override
  String get fullNameRequired => 'يرجى إدخال الاسم الكامل للعضو';

  @override
  String get fullNameMinLength => 'يجب أن يحتوي الاسم على 3 أحرف على الأقل';

  @override
  String get selectYear => 'اختر السنة';

  @override
  String get selectMonth => 'اختر الشهر';

  @override
  String get selectDay => 'اختر اليوم';

  @override
  String get dobRequired => 'يرجى اختيار تاريخ الميلاد بالكامل';

  @override
  String get uniqueMemberNumber => 'رقم العضو يجب أن يكون فريدًا';

  @override
  String get noActiveCycle => 'خطأ: لا يوجد دورة نشطة!';

  @override
  String get appTagline => 'نساعدك على تعزيز التنمية';

  @override
  String get example => 'مثال';

  @override
  String get mzungukoPendingNoNew =>
      'الدورة الحالية \"قيد الانتظار\" بالفعل. لم تبدأ دورة جديدة.';

  @override
  String get newMzungukoCreated => 'تم بدء دورة جديدة بنجاح!';

  @override
  String errorSavingMzunguko(String error) {
    return 'حدث خطأ أثناء حفظ أو تحديث معلومات الدورة: $error';
  }

  @override
  String get weekly => 'أسبوعي';

  @override
  String get biWeekly => 'كل أسبوعين';

  @override
  String get monthly => 'شهري';

  @override
  String years(int count) {
    return '$count سنوات';
  }

  @override
  String months(int count) {
    return 'أشهر';
  }

  @override
  String weeks(int count) {
    return '$count أسابيع';
  }

  @override
  String get registered => 'مسجل';

  @override
  String get notRegistered => 'غير مسجل';

  @override
  String get other => 'أخرى';

  @override
  String get memberPhoneNumber => 'رقم هاتف العضو';

  @override
  String get enterMemberPhoneNumber => 'أدخل رقم هاتف العضو';

  @override
  String get selectJob => 'اختر الوظيفة';

  @override
  String get enterJobName => 'أدخل اسم الوظيفة';

  @override
  String get pleaseSelectJob => 'يرجى اختيار الوظيفة';

  @override
  String get pleaseEnterJobName => 'يرجى إدخال اسم الوظيفة';

  @override
  String get selectIdType => 'اختر نوع الهوية';

  @override
  String get enterIdNumber => 'أدخل رقم الهوية';

  @override
  String get pleaseSelectIdType => 'يرجى اختيار نوع الهوية';

  @override
  String get pleaseEnterIdNumber => 'يرجى إدخال رقم الهوية';

  @override
  String get idPhoto => 'صورة الهوية';

  @override
  String get removePhoto => 'إزالة الصورة';

  @override
  String get takePhoto => 'التقاط صورة';

  @override
  String get chooseFromGallery => 'اختر من المعرض';

  @override
  String get farmer => 'مزارع';

  @override
  String get teacher => 'معلم';

  @override
  String get doctor => 'طبيب';

  @override
  String get entrepreneur => 'رائد أعمال';

  @override
  String get engineer => 'مهندس';

  @override
  String get lawyer => 'محامٍ';

  @override
  String get none => 'لا شيء';

  @override
  String get voterCard => 'بطاقة الناخب';

  @override
  String get nationalId => 'الهوية الوطنية';

  @override
  String get zanzibarResidentCard => 'بطاقة إقامة زنجبار';

  @override
  String get driversLicense => 'رخصة قيادة';

  @override
  String get localGovernmentLetter => 'خطاب الحكومة المحلية';

  @override
  String get errorSavingPhoto => 'فشل حفظ صورة العضو';

  @override
  String get errorRemovingPhoto => 'فشل إزالة الصورة';

  @override
  String get errorLoadingPhoto => 'فشل تحميل صورة العضو';

  @override
  String get memberInformation => 'معلومات العضو';

  @override
  String get memberIdentification => 'هوية العضو';

  @override
  String get dateOfBirth => 'تاريخ الميلاد';

  @override
  String get occupation => 'المهنة';

  @override
  String get mandatorySavings => 'المدخرات الإلزامية';

  @override
  String get voluntarySavings => 'المدخرات الطوعية';

  @override
  String get communityFund => 'الصندوق الاجتماعي';

  @override
  String get currentLoan => 'القرض الحالي';

  @override
  String get finish => 'إنهاء';

  @override
  String get enterKey1 => 'أدخل المفتاح 1';

  @override
  String get enterKey2 => 'أدخل المفتاح 2';

  @override
  String get enterKey3 => 'أدخل المفتاح 3';

  @override
  String get enterAllKeys => 'يرجى إدخال جميع المفاتيح الثلاثة.';

  @override
  String get invalidKeys =>
      'المفاتيح السرية غير صحيحة. يرجى المحاولة مرة أخرى.';

  @override
  String get systemError => 'حدثت مشكلة. يرجى المحاولة لاحقًا.';

  @override
  String get resetSecurityKeys => 'إعادة تعيين المفاتيح الأمنية';

  @override
  String get openButton => 'فتح';

  @override
  String get pleaseEnterNewPassword => 'يرجى إدخال كلمة مرور جديدة';

  @override
  String get passwordMustBeDigitsOnly => 'يجب أن تكون كلمة المرور أرقامًا فقط';

  @override
  String get passwordMustBeLessThan4Digits =>
      'يجب أن تكون كلمة المرور أقل من 4 أرقام';

  @override
  String get pleaseConfirmNewPassword => 'يرجى تأكيد كلمة المرور الجديدة';

  @override
  String get passwordsDoNotMatch => 'كلمات المرور غير متطابقة';

  @override
  String get errorOccurredTryAgain => 'حدث خطأ. يرجى المحاولة مرة أخرى.';

  @override
  String editPasswordFor(String key) {
    return 'تعديل كلمة المرور لـ $key';
  }

  @override
  String get newPassword => 'كلمة المرور الجديدة';

  @override
  String get confirmNewPassword => 'تأكيد كلمة المرور الجديدة';

  @override
  String get enterNewPassword => 'أدخل كلمة المرور الجديدة';

  @override
  String get getHelp => 'الحصول على المساعدة';

  @override
  String get welcomeChomokaPlus => 'مرحبًا بك في تشوموكا بلس';

  @override
  String groupOf(Object groupName) {
    return 'مجموعة: $groupName';
  }

  @override
  String get dashboardHelpText => 'نساعدك على الاحتفاظ بسجلات مجموعتك بكفاءة.';

  @override
  String get groupServices => 'خدمات المجموعة';

  @override
  String get startMeeting => 'بدء الاجتماع';

  @override
  String get continueExistingMeeting => 'متابعة الاجتماع الحالي';

  @override
  String get openNewMeeting => 'فتح اجتماع مجموعة جديد';

  @override
  String get group => 'المجموعة';

  @override
  String get constitution => 'النظام الأساسي';

  @override
  String get shareCalculation => 'حساب الحصص';

  @override
  String get systemFeedback => 'تعليقات النظام';

  @override
  String get groupActivities => 'أنشطة المجموعة';

  @override
  String get moreServices => 'خدمات إضافية';

  @override
  String get history => 'السجل';

  @override
  String get viewGroupHistory => 'عرض تاريخ نشاط المجموعة';

  @override
  String get backupRestore => 'النسخ الاحتياطي والاستعادة';

  @override
  String get backupRestoreDesc => 'النسخ الاحتياطي واستعادة سجلات المجموعة';

  @override
  String get chomokaPlusVersion => 'تشوموكا بلس الإصدار 2.0';

  @override
  String get finishShare => 'إنهاء الحصة';

  @override
  String get finishShareDesc => 'تم اكتمال الدورة الأخيرة. يرجى إنهاء الحصة.';

  @override
  String get ok => 'حسنًا';

  @override
  String get meetingOptionsWelcome => 'مرحبًا بك في اجتماع آخر';

  @override
  String get midCycleInfo => 'هذه معلومات منتصف الدورة';

  @override
  String get openMeetingButton => 'فتح الاجتماع';

  @override
  String get startNewCycleQuestion => 'هل تبدأ دورة جديدة؟';

  @override
  String get pressYesToStartFirstMeeting => 'اضغط نعم لعقد الاجتماع الأول';

  @override
  String get pressNoForPastMeetings => 'اضغط لا لتسجيل الاجتماعات السابقة';

  @override
  String get getHelpTitle => 'الحصول على المساعدة';

  @override
  String get needHelpContact => 'هل تحتاج إلى مساعدة؟ تواصل معنا عبر:';

  @override
  String get call => 'الاتصال';

  @override
  String get whatsapp => 'واتساب';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get faq => 'الأسئلة الشائعة';

  @override
  String get close => 'إغلاق';

  @override
  String get failedToOpenPhone => 'فشل في فتح الهاتف.';

  @override
  String get failedToOpenWhatsApp => 'واتساب غير متوفر على هاتفك.';

  @override
  String get failedToOpenWhatsAppGeneric => 'فشل في فتح واتساب.';

  @override
  String get failedToOpenEmail => 'فشل في فتح البريد الإلكتروني.';

  @override
  String get constitutionAppTitle => 'معلومات النظام الأساسي';

  @override
  String get constitutionGroupType => 'نوع المجموعة';

  @override
  String get kayaCmg => 'كايا CMG';

  @override
  String get kayaCmgHint => 'نستخدم المدخرات الإلزامية والطوعية للإقراض';

  @override
  String get vsla => 'VSLA';

  @override
  String get vslaHint => 'نستخدم الحصص لتوفير المال ولدينا 5 قادة';

  @override
  String get shareSubtitle => 'الحصص';

  @override
  String get sharePrompt => 'ما قيمة الحصة الواحدة بالشيلينغ؟';

  @override
  String get shareValueLabel => 'قيمة الحصة';

  @override
  String get shareValueHint => 'أدخل قيمة الحصة';

  @override
  String get shareValueRequired => 'قيمة الحصة مطلوبة';

  @override
  String get invalidShareValue => 'يرجى إدخال قيمة صحيحة';

  @override
  String get groupLeadersSubtitle => 'قادة المجموعة';

  @override
  String get editButton => 'تعديل';

  @override
  String get selectAllLeadersError => 'يرجى اختيار جميع القادة';

  @override
  String positionLabel(Object position) {
    return '$position';
  }

  @override
  String selectPositionHint(Object position) {
    return 'اختر $position';
  }

  @override
  String positionRequired(Object position) {
    return 'يرجى اختيار $position';
  }

  @override
  String get jumlaYaHisa => 'إجمالي الحصص';

  @override
  String get mfukoWaJamiiSalio => 'رصيد الصندوق الاجتماعي';

  @override
  String get salioLililolalaSandukuni => 'الرصيد في الصندوق';

  @override
  String get failedToLoadSummaryData =>
      'فشل تحميل بيانات الملخص. يرجى المحاولة مرة أخرى.';

  @override
  String get jumlaYa => 'إجمالي';

  @override
  String get wekaJumlaYa => 'أدخل الإجمالي';

  @override
  String get tafadhaliJazaJumlaYa => 'يرجى ملء الإجمالي';

  @override
  String get tafadhaliIngizaNambariHalali => 'يرجى إدخال رقم صحيح.';

  @override
  String get jumlaLazimaIweIsiyoHasi => 'يجب ألا يكون الإجمالي سالباً.';

  @override
  String get loadingData => 'جارٍ تحميل البيانات...';

  @override
  String get taarifaKatikatiYaMzunguko => 'معلومات منتصف الدورة';

  @override
  String get jumlaZaKikundi => 'إجماليات المجموعة';

  @override
  String get chairperson => 'رئيس المجلس';

  @override
  String get secretary => 'الأمين';

  @override
  String get treasurer => 'أمين الصندوق';

  @override
  String get counter1 => 'العداد رقم 1';

  @override
  String get counter2 => 'العداد رقم 2';

  @override
  String get finesTitle => 'معلومات النظام الأساسي';

  @override
  String get finesSubtitle => 'الغرامات';

  @override
  String get finesEmptyAmountNote =>
      'الغرامات التي لا تحتوي على مبلغ لن تظهر خلال الاجتماع';

  @override
  String get enterFineType => 'أدخل نوع الغرامة';

  @override
  String get enterAmount => 'أدخل المبلغ';

  @override
  String get phoneUseInMeeting => 'استخدام الهاتف خلال الاجتماع';

  @override
  String get amountPlaceholder => 'المبلغ';

  @override
  String get loanAmountTitle => 'معلومات النظام الأساسي';

  @override
  String get loanAmountSubtitle => 'المبلغ الذي يمكن للعضو اقتراضه';

  @override
  String get loanAmountVSLAPrompt =>
      'كم مرة يمكن للعضو الاقتراض بناءً على حصصه الحالية؟';

  @override
  String get loanAmountCMGPrompt =>
      'كم مرة يمكن للعضو الاقتراض بناءً على مدخراته الحالية؟';

  @override
  String get loanAmountVSLAHint => 'يُحدَّد وفقاً للحصص الحالية';

  @override
  String get loanAmountCMGHint => 'يُحدَّد وفقاً للمدخرات الحالية';

  @override
  String get loanAmountRequired => 'يرجى إدخال قيمة صحيحة (رقمية)!';

  @override
  String get loanAmountInvalidNumber => 'يرجى إدخال رقم صحيح!';

  @override
  String get loanAmountMustBePositive => 'يجب أن تكون القيمة أكبر من الصفر!';

  @override
  String loanAmountExample(String amount, String type, String multiplier) {
    return 'على سبيل المثال، يمكن للعضو اقتراض $amount إذا كان لديه $type بقيمة 10,000، وهو $multiplier أضعاف $type.';
  }

  @override
  String get interestDescription => 'صِف كيفية تطبيق رسوم الخدمة على قروضك';

  @override
  String get yes => 'نعم';

  @override
  String get no => 'لا';

  @override
  String get selectFund => 'اختر الصندوق';

  @override
  String get fundWithoutName => 'صندوق بدون اسم';

  @override
  String get addAnotherFund => 'إضافة صندوق آخر';

  @override
  String get communityFundInfo => 'معلومات الصندوق الاجتماعي';

  @override
  String get fundName => 'اسم الصندوق';

  @override
  String get enterFundName => 'أدخل اسم الصندوق';

  @override
  String get fundNameRequired => 'اسم الصندوق مطلوب!';

  @override
  String get contributionAmount => 'مبلغ المساهمة';

  @override
  String get enterContributionAmount => 'أدخل مبلغ المساهمة';

  @override
  String get contributionAmountRequired => 'مبلغ المساهمة مطلوب!';

  @override
  String get edit => 'تعديل';

  @override
  String get withdrawalReasons => 'أسباب السحب';

  @override
  String get noReasonsRecorded => 'لا توجد أسباب مسجلة';

  @override
  String get equalAmount => 'مبلغ متساوٍ';

  @override
  String get anyAmount => 'أي مبلغ';

  @override
  String get notWithdrawableMidCycle => 'لا يمكن السحب في منتصف الدورة';

  @override
  String get withdrawByMemberName => 'السحب باسم العضو';

  @override
  String get withdrawAsGroup => 'السحب كمجموعة';

  @override
  String get select => 'اختر';

  @override
  String get education => 'التعليم';

  @override
  String get agriculture => 'الزراعة';

  @override
  String get communityProject => 'مشروع مجتمعي';

  @override
  String get cocoa => 'الكاكاو';

  @override
  String get otherGoals => 'أهداف أخرى';

  @override
  String get pleaseSelectContributionProcedure => 'يرجى اختيار إجراء المساهمة';

  @override
  String get pleaseSelectWithdrawalProcedure => 'يرجى اختيار إجراءات السحب';

  @override
  String get dataUpdatedSuccessfully => 'تم تحديث البيانات بنجاح!';

  @override
  String get errorSavingDataGeneric =>
      'حدث خطأ أثناء حفظ البيانات. يرجى المحاولة مرة أخرى.';

  @override
  String get fundInformation => 'معلومات الصندوق';

  @override
  String get fundProcedures => 'إجراءات الصندوق';

  @override
  String get pleaseEnterFundName => 'يرجى إدخال اسم الصندوق';

  @override
  String get fundGoals => 'أهداف الصندوق';

  @override
  String get pleaseSelectFundGoal => 'يرجى اختيار هدف الصندوق';

  @override
  String get enterOtherGoals => 'أدخل أهدافاً أخرى';

  @override
  String get pleaseEnterOtherGoals => 'يرجى إدخال أهداف أخرى';

  @override
  String get contributionProcedure => 'إجراء المساهمة';

  @override
  String get pleaseEnterContributionAmount => 'يرجى إدخال مبلغ المساهمة';

  @override
  String get loanable => 'قابل للإقراض';

  @override
  String get withdrawalProcedures => 'إجراءات السحب';

  @override
  String get fundProcedure => 'إجراء الصندوق';

  @override
  String get withdrawalProcedure => 'إجراء السحب';

  @override
  String get notWithdrawableDuringCycle => 'لا يمكن السحب خلال الدورة';

  @override
  String get selectOption => 'اختر';

  @override
  String get fundSummarySubtitle => 'ملخص الصندوق';

  @override
  String get withdrawalType => 'نوع المساهمة';

  @override
  String get deleteFundTitle => 'حذف الصندوق؟';

  @override
  String get thisFund => 'هذا الصندوق';

  @override
  String get deleteFundWarning => 'لا يمكن التراجع عن هذا الإجراء.';

  @override
  String setPasswordTitle(Object step) {
    return 'تعيين كلمة المرور لـ $step';
  }

  @override
  String get allPasswordsSetTitle => 'تم تعيين جميع كلمات المرور';

  @override
  String get backupCompleted => 'اكتمل النسخ الاحتياطي بنجاح!';

  @override
  String get uhifadhiKumbukumbu => 'نسخ البيانات احتياطياً';

  @override
  String get tumaTaarifa => 'إرسال المعلومات';

  @override
  String get chaguaMahaliNaHifadhi => 'اختر الموقع والحفظ';

  @override
  String get hifadhiNakala => 'حفظ نسخة';

  @override
  String get hifadhiNakalaRafiki => 'إرسال نسخة احتياطية إلى صديق';

  @override
  String get hifadhiNakalaRafikiDescription =>
      'أرسل نسخة من بيانات تشوموكا إلى صديقك لضمان أمان أفضل.';

  @override
  String get uhifadhiKumbukumbuDescription =>
      'احفظ بيانات تشوموكا في ملف ZIP. يمكنك استعادة هذه البيانات في أي وقت.';

  @override
  String get error => 'خطأ';

  @override
  String errorSharingBackup(Object error) {
    return 'خطأ في مشاركة النسخة الاحتياطية: $error';
  }

  @override
  String get uwekaji_taarifa_katikati_mzunguko =>
      'إدخال البيانات في منتصف الدورة';

  @override
  String get loading_group_data => 'جارٍ تحميل بيانات المجموعة...';

  @override
  String get kikundi_mzunguko => 'في أي دورة توجد المجموعة؟';

  @override
  String get taarifa_zimehifadhiwa => 'تم حفظ البيانات بنجاح!';

  @override
  String imeshindwa_kuhifadhi(Object error) {
    return 'فشل في حفظ البيانات: $error';
  }

  @override
  String get thibitisha_ingizo => 'فشل التحقق من صحة الإدخال.';

  @override
  String get namba_kikao => 'رقم الجلسة';

  @override
  String get ingiza_namba_kikao => 'أدخل رقم الجلسة';

  @override
  String get namba_kikao_inahitajika => 'رقم الجلسة مطلوب';

  @override
  String get namba_kikao_halali => 'يرجى إدخال رقم جلسة صحيح';

  @override
  String get endelea => 'متابعة';

  @override
  String get taarifa_kikao_kilichopita => 'معلومات الجلسة السابقة';

  @override
  String get hisa_wanachama => 'حصص الأعضاء';

  @override
  String get muhtasari_kikao => 'ملخص الجلسة';

  @override
  String get jumla_kikundi => 'إجمالي المجموعة';

  @override
  String get akiba_wanachama => 'مدخرات الأعضاء';

  @override
  String get akiba_binafsi => 'المدخرات الشخصية';

  @override
  String get wadaiwa_mikopo => 'المدينون بالقروض';

  @override
  String get mchango_haujalipwa => 'المساهمات غير المدفوعة';

  @override
  String get jumla_hisa => 'إجمالي الحصص';

  @override
  String get jumla_akiba => 'إجمالي المدخرات';

  @override
  String get jumla_mikopo => 'إجمالي القروض';

  @override
  String get jumla_riba => 'إجمالي الفوائد';

  @override
  String get jumla_adhabu => 'إجمالي الغرامات';

  @override
  String get jumla_mfuko_jamii => 'إجمالي الصندوق الاجتماعي';

  @override
  String get chaguaNjiaUhifadhi => 'اختر طريقة النسخ الاحتياطي';

  @override
  String get taarifaZimehifadhiwa => 'تم حفظ المعلومات بنجاح!';

  @override
  String get sawa => 'موافق';

  @override
  String uhifadhiProgress(Object progress) {
    return 'تقدم النسخ الاحتياطي: $progress%';
  }

  @override
  String get midCycleMeetingInfo => 'معلومات اجتماع منتصف الدورة';

  @override
  String get groupTotals => 'إجماليات المجموعة';

  @override
  String get groupTotalsSummary => 'ملخص إجماليات المجموعة';

  @override
  String get enterTotalShares => 'أدخل إجمالي الحصص';

  @override
  String get pleaseEnterTotalShares => 'يرجى إدخال إجمالي الحصص';

  @override
  String get shareValue => 'قيمة الحصة';

  @override
  String get enterShareValue => 'أدخل قيمة الحصة';

  @override
  String get pleaseEnterShareValue => 'يرجى إدخال قيمة الحصة';

  @override
  String get enterTotalSavings => 'أدخل إجمالي المدخرات';

  @override
  String get pleaseEnterTotalSavings => 'يرجى إدخال إجمالي المدخرات';

  @override
  String get enterCommunityFundBalance => 'أدخل رصيد الصندوق الاجتماعي';

  @override
  String get pleaseEnterCommunityFundBalance =>
      'يرجى إدخال رصيد الصندوق الاجتماعي';

  @override
  String get pleaseEnterValidPositiveNumber =>
      'يجب أن تكون القيمة رقماً موجباً';

  @override
  String get memberShares => 'حصص العضو';

  @override
  String get unpaidContributions => 'المساهمات غير المدفوعة';

  @override
  String get memberContributions => 'مساهمات الأعضاء';

  @override
  String get fineOwed => 'الغرامات المستحقة';

  @override
  String get enterFineOwed => 'أدخل الغرامات المستحقة';

  @override
  String get pleaseEnterFineOwed => 'يرجى إدخال الغرامات المستحقة';

  @override
  String get communityFundOwed => 'المبلغ المستحق للصندوق الاجتماعي';

  @override
  String get enterCommunityFundOwed => 'أدخل المبلغ المستحق للصندوق الاجتماعي';

  @override
  String get pleaseEnterCommunityFundOwed =>
      'يرجى إدخال المبلغ المستحق للصندوق الاجتماعي';

  @override
  String get loanInformation => 'معلومات القرض';

  @override
  String get memberLoanInfo => 'معلومات قرض العضو';

  @override
  String get selectReason => 'اختر السبب';

  @override
  String get reasonForLoan => 'سبب القرض';

  @override
  String get pleaseSelectReason => 'يرجى اختيار سبب';

  @override
  String get houseRenovation => 'تجديد المنزل';

  @override
  String get business => 'الأعمال التجارية';

  @override
  String get enterOtherReason => 'أدخل سبباً آخر';

  @override
  String get otherReason => 'سبب آخر';

  @override
  String get pleaseEnterOtherReason => 'يرجى إدخال السبب الآخر';

  @override
  String get loanAmount => 'مبلغ القرض';

  @override
  String get enterLoanAmount => 'أدخل مبلغ القرض';

  @override
  String get pleaseEnterLoanAmount => 'يرجى إدخال مبلغ القرض';

  @override
  String get pleaseEnterValidAmount => 'يرجى إدخال مبلغ صحيح';

  @override
  String get amountPaid => 'المبلغ المدفوع';

  @override
  String get enterAmountPaid => 'أدخل المبلغ المدفوع';

  @override
  String get pleaseEnterAmountPaid => 'يرجى إدخال المبلغ المدفوع';

  @override
  String get outstandingBalance => 'الرصيد المتبقي';

  @override
  String get calculatedAutomatically => 'يُحسب تلقائياً';

  @override
  String get pleaseEnterOutstandingAmount => 'يرجى إدخال الرصيد المتبقي';

  @override
  String get loanMeeting => 'اجتماع القرض';

  @override
  String get enterLoanMeeting => 'أدخل رقم اجتماع القرض';

  @override
  String get pleaseEnterLoanMeeting => 'يرجى إدخال رقم اجتماع القرض';

  @override
  String get loanDuration => 'مدة القرض (بالأشهر)';

  @override
  String get enterLoanDuration => 'أدخل المدة بالأشهر';

  @override
  String get pleaseEnterLoanDuration => 'يرجى إدخال مدة القرض';

  @override
  String get loading => 'جارٍ التحميل...';

  @override
  String get noMembersFound => 'لم يُعثر على أعضاء';

  @override
  String get searchByNameOrPhone => 'البحث بالاسم أو رقم الهاتف';

  @override
  String get memberList => 'قائمة الأعضاء';

  @override
  String get validate => 'التحقق';

  @override
  String get dataValidationFailed => 'فشل التحقق من صحة البيانات.';

  @override
  String get shareInformation => 'معلومات الحصص';

  @override
  String get saveShares => 'حفظ الحصص';

  @override
  String get shares => 'الحصص';

  @override
  String get enterShares => 'أدخل عدد الحصص';

  @override
  String get loanSummary => 'ملخص القرض';

  @override
  String get memberLoanSummary => 'ملخص قرض العضو';

  @override
  String get loanDetails => 'تفاصيل القرض';

  @override
  String get vslaMemberShares => 'حصص الأعضاء';

  @override
  String get vslaShareInformation => 'معلومات الحصص';

  @override
  String get vslaShareValue => 'قيمة الحصة';

  @override
  String get vslaTotalShares => 'إجمالي الحصص';

  @override
  String get vslaShareValuePerShare => 'قيمة الحصة الواحدة';

  @override
  String get vslaEnterShareCount => 'أدخل عدد الحصص';

  @override
  String get vslaShareCountRequired => 'عدد الحصص مطلوب';

  @override
  String get vslaEnterValidShareCount => 'يرجى إدخال عدد حصص صحيح';

  @override
  String get vslaSaveShares => 'حفظ الحصص';

  @override
  String get vslaSharesSavedSuccessfully => 'تم حفظ حصص الأعضاء بنجاح!';

  @override
  String vslaTotalSharesMustMatch(String total, String current) {
    return 'يجب أن يكون إجمالي الحصص $total. الحالي $current. يرجى التعديل.';
  }

  @override
  String get vslaGroupTotals => 'إجماليات المجموعة';

  @override
  String get vslaGroupTotalsSummary => 'ملخص إجماليات المجموعة';

  @override
  String get vslaCommunityFundBalance => 'رصيد الصندوق الاجتماعي';

  @override
  String get vslaBoxBalance => 'رصيد الصندوق';

  @override
  String get vslaCurrentLoanBalance => 'رصيد القرض الحالي';

  @override
  String get vslaMembers => 'الأعضاء';

  @override
  String get vslaUnpaidContributions => 'المساهمات غير المدفوعة';

  @override
  String get vslaTotalFinesOwed => 'إجمالي الغرامات المستحقة';

  @override
  String get vslaEnterTotalShares => 'أدخل إجمالي الحصص';

  @override
  String get vslaEnterCommunityFundBalance => 'أدخل رصيد الصندوق الاجتماعي';

  @override
  String get vslaEnterBoxBalance => 'أدخل رصيد الصندوق';

  @override
  String get vslaPleaseEnterTotalShares => 'يرجى إدخال إجمالي الحصص';

  @override
  String get vslaPleaseEnterCommunityFundBalance =>
      'يرجى إدخال رصيد الصندوق الاجتماعي';

  @override
  String get vslaPleaseEnterBoxBalance => 'يرجى إدخال رصيد الصندوق';

  @override
  String get vslaPleaseEnterValidPositiveNumber =>
      'يجب أن تكون القيمة رقماً موجباً';

  @override
  String get vslaMidCycleInformation => 'معلومات منتصف الدورة';

  @override
  String get vslaMemberShareTitle => 'حصص الأعضاء';

  @override
  String get vslaMemberShareSubtitle => 'أدخل معلومات حصة العضو';

  @override
  String get vslaMemberNumber => 'رقم العضو';

  @override
  String get vslaShareCount => 'عدد الحصص';

  @override
  String get vslaNoMembersFound => 'لم يُعثر على أعضاء';

  @override
  String get vslaErrorLoadingData =>
      'خطأ في تحميل البيانات. يرجى المحاولة مرة أخرى.';

  @override
  String vslaErrorSavingData(String error) {
    return 'خطأ في حفظ البيانات: $error';
  }

  @override
  String get uwekajiTaarifaKatikaMzunguko => 'إدخال البيانات في منتصف الدورة';

  @override
  String get jumlaYaKikundi => 'إجمالي المجموعة';

  @override
  String get hisaZaWanachama => 'حصص الأعضاء';

  @override
  String get taarifaZaKikundi => 'معلومات المجموعة';

  @override
  String get jumlaYaTaarifaZaKikundi => 'إجمالي معلومات المجموعة';

  @override
  String get inapakiaTaarifa => 'جارٍ تحميل المعلومات...';

  @override
  String get hakunaTaarifaZilizopo => 'لا تتوفر بيانات في الوقت الحالي.';

  @override
  String get taarifaZaHisa => 'معلومات الحصص';

  @override
  String get thamaniYaHisaMoja => 'قيمة الحصة الواحدة';

  @override
  String get wekaMfukoWaJamiiSalio => 'تعيين رصيد الصندوق الاجتماعي';

  @override
  String get tafadhaliJazaMfukoWaJamiiSalio =>
      'يرجى ملء رصيد الصندوق الاجتماعي.';

  @override
  String get wekaSalioLililolalaSandukuni => 'تعيين الرصيد في الصندوق';

  @override
  String get tafadhaliJazaSalioLililolalaSandukuni =>
      'يرجى ملء الرصيد في الصندوق.';

  @override
  String get salioLazimaIweIsiyoHasi => 'يجب ألا يكون الرصيد سالباً.';

  @override
  String get jumlaYaThamaniYaHisa => 'إجمالي قيمة الحصص';

  @override
  String get tafadhaliJazaJumlaYaHisa => 'يرجى ملء إجمالي الحصص.';

  @override
  String get salioLililolalaSandukuniError =>
      'يجب أن يكون رصيد الصندوق أكبر من مجموع الحصص والصندوق الاجتماعي.';

  @override
  String get jumlaYaHisaZote => 'إجمالي عدد الحصص';

  @override
  String get mchangoHaujalipwa => 'مساهمة غير مدفوعة';

  @override
  String get wadaiwaMikopo => 'مدينو القروض في المجموعة';

  @override
  String get muhtasari => 'ملخص';

  @override
  String get pending => 'قيد الانتظار';

  @override
  String get uhifadhiKumbukumbuTitle => 'نسخ البيانات احتياطياً';

  @override
  String get utunzajiKumbukumbuSmsTab => 'نسخ احتياطي عبر الرسائل القصيرة';

  @override
  String get kanzidataUhifadhiTab => 'نسخ احتياطي لقاعدة البيانات';

  @override
  String get tumaTaarifaButton => 'إرسال البيانات';

  @override
  String get uhifadhiKumbukumbuCardTitle => 'نسخ احتياطي لقاعدة البيانات';

  @override
  String get uhifadhiKumbukumbuCardDesc =>
      'احفظ نسخة احتياطية من بيانات تشوموكا في ملف SQL. يمكنك استعادة هذه البيانات في أي وقت.';

  @override
  String get chaguaMahaliNaHifadhiButton => 'اختر الموقع والحفظ';

  @override
  String sqlDumpSaved(String filePath) {
    return 'تم حفظ تفريغ SQL في: $filePath';
  }

  @override
  String errorWithMessage(String message) {
    return 'خطأ: $message';
  }

  @override
  String get hifadhiNakalaRafikiCardTitle => 'مشاركة البيانات مع صديق';

  @override
  String get hifadhiNakalaRafikiCardDesc =>
      'أرسل نسخة من بيانات تشوموكا إلى صديقك بشكل آمن.';

  @override
  String get hifadhiNakalaButton => 'مشاركة البيانات';

  @override
  String get loanInterest => 'فائدة القرض';

  @override
  String get interestType => 'نوع الفائدة';

  @override
  String get monthlyCalculation => 'الحساب الشهري';

  @override
  String get equalAmountAllMonths => 'مبلغ متساوٍ لجميع الأشهر';

  @override
  String get enterInterestRate => 'أدخل معدل الفائدة';

  @override
  String loanInterestExample(Object rate) {
    return 'على سبيل المثال، إذا اقترض أحد الأعضاء 10,000 فسيدفع $rate% من رصيد القرض المتبقي كل شهر. وإذا سدّد القرض مبكراً، فسيتجنب دفع الفائدة.';
  }

  @override
  String loanInterestExampleEqual(Object amount, Object rate) {
    return 'على سبيل المثال، إذا اقترض أحد الأعضاء 10,000 فسيدفع $amount% من مبلغ القرض الفعلي. وسيدفع $rate كل شهر.';
  }

  @override
  String loanInterestExampleOnce(Object amount, Object rate) {
    return 'على سبيل المثال، إذا اقترض أحد الأعضاء 10,000 فسيسدّد بفائدة $amount% من مبلغ القرض الفعلي. وسيدفع $rate كفائدة عند سداد القرض.';
  }

  @override
  String get constitutionTitle => 'النظام الأساسي';

  @override
  String get membershipRules => 'قواعد العضوية';

  @override
  String get method => 'الطريقة:';

  @override
  String get savings => 'المدخرات';

  @override
  String get mandatorySavingsValue => 'قيمة الادخار الإلزامي:';

  @override
  String get groupLeaders => 'قادة المجموعة';

  @override
  String get cashCounter1 => 'عدّاد النقد رقم 1:';

  @override
  String get cashCounter2 => 'عدّاد النقد رقم 2:';

  @override
  String get auditor => 'المراجع:';

  @override
  String get contributions => 'المساهمات';

  @override
  String get communityFundAmount => 'مبلغ الصندوق الاجتماعي:';

  @override
  String get otherFunds => 'الصناديق الأخرى';

  @override
  String get noFines => 'لا توجد غرامات';

  @override
  String get loan => 'القرض';

  @override
  String get loanMultiplier => 'عدد المرات المسموح للعضو بالاقتراض بحسب حصصه:';

  @override
  String get loanInterestType => 'طريقة احتساب فائدة القرض:';

  @override
  String get guarantorCount => 'عدد الضامنين';

  @override
  String get penaltyCalculation => 'احتساب غرامة تأخر القرض:';

  @override
  String get lateLoanPenalty => 'غرامة تأخر القرض:';

  @override
  String get fundInfoTitle => 'معلومات الصندوق';

  @override
  String get illness => 'المرض';

  @override
  String get death => 'الوفاة';

  @override
  String get addNewReason => 'إضافة سبب جديد';

  @override
  String get reasonsWithoutAmountWarning =>
      'الأسباب التي لا تحتوي على مبلغ لن تظهر خلال الاجتماع';

  @override
  String get reason => 'السبب';

  @override
  String get enterReason => 'أدخل السبب';

  @override
  String get reasonsForGiving => 'أسباب التبرع';

  @override
  String get reasonsForGivingInFund => 'أسباب التبرع في الصندوق الاجتماعي';

  @override
  String get addNewReasonToReceiveMoney => 'إضافة سبب جديد لاستلام المال';

  @override
  String get loadingGroupData => 'جارٍ تحميل بيانات المجموعة...';

  @override
  String get kikundiKipoMzunguko => 'في أي دورة توجد المجموعة؟';

  @override
  String mzunguko(Object mzungukoId) {
    return 'الدورة $mzungukoId';
  }

  @override
  String get invalidGroupDataReceived => 'تم استلام بيانات مجموعة غير صحيحة';

  @override
  String get historia => 'السجل';

  @override
  String historiaYa(String name) {
    return 'سجل $name';
  }

  @override
  String get hakuna_vikao => 'لا توجد اجتماعات مكتملة في هذه الدورة!';

  @override
  String get tafutaJinaSimu => 'البحث بالاسم أو الهاتف';

  @override
  String get hakunaWanachama => 'لم يُعثر على أعضاء.';

  @override
  String get muhtasariKikao => 'ملخص الاجتماع';

  @override
  String get funga => 'إغلاق';

  @override
  String get tumaMuhtasari => 'إرسال الملخص';

  @override
  String get mwanachamaSiSimu => 'العضو لا يملك رقم هاتف';

  @override
  String muhtasariUmetumwa(String name) {
    return 'تم إرسال الملخص إلى $name بنجاح';
  }

  @override
  String get imeshindwaTumaSMS =>
      'فشل إرسال الرسالة القصيرة، يرجى المحاولة مرة أخرى';

  @override
  String get kikao => 'الاجتماع';

  @override
  String kikao_ya(String name) {
    return 'اجتماع $name';
  }

  @override
  String get mipangilio => 'الإعدادات';

  @override
  String get badiliLugha => 'تغيير اللغة';

  @override
  String get chaguaLughaYaProgramu => 'اختر لغة التطبيق';

  @override
  String get kiswahili => 'السواحيلية';

  @override
  String get english => 'الإنجليزية';

  @override
  String get french => 'الفرنسية';

  @override
  String get rekebishaFunguo => 'ضبط المفاتيح';

  @override
  String get badilishaNenoLaSiri => 'تغيير كلمة المرور';

  @override
  String get kifo => 'الوفاة';

  @override
  String get futazoteZaMzungukoHuuKishaAnzaMzungukoMpya =>
      'حذف جميع سجلات هذه الدورة وبدء دورة جديدة';

  @override
  String get rekebishaMzunguko => 'تعديل الدورة';

  @override
  String get thibitisha => 'تأكيد';

  @override
  String get jeUnaHitajiKufutaTaarifaZoteNaKuanzaMzungukoMpya =>
      'هل تريد حذف جميع السجلات وبدء دورة جديدة؟';

  @override
  String get ndio => 'نعم';

  @override
  String imeshindwaKuHifadhi(String error) {
    return 'فشل في حفظ المعلومات: $error';
  }

  @override
  String get hapana => 'لا';

  @override
  String get kuhusuChomoka => 'حول تشوموكا';

  @override
  String get toleoLaChapa100 => 'الإصدار 1.0.0';

  @override
  String get toleo4684 => 'الإصدار 4684';

  @override
  String get mkataba => 'العقد';

  @override
  String get vigezoNaMasharti => 'الشروط والأحكام';

  @override
  String get somaVigezoNaMashartiYaChomoka => 'اقرأ شروط وأحكام تشوموكا';

  @override
  String get msaadaWaKitaalamu => 'الدعم الفني';

  @override
  String
      get chomokaItajaribuKutumaBaadhiYaIliKikundiKipateMsaadaZaidiWaKitalaamu =>
          'ستحاول تشوموكا إرسال بعض البيانات لكي تحصل المجموعة على دعم فني أكثر';

  @override
  String get vslaPreviousMeetingSummary => 'ملخص الاجتماع';

  @override
  String get nimemaliza => 'إرسال';

  @override
  String get idleBalanceInBox => 'الرصيد الخامل في الصندوق';

  @override
  String get currentLoanBalance => 'رصيد القرض الحالي';

  @override
  String get remainingCommunityContribution =>
      'المساهمة المتبقية للصندوق الاجتماعي';

  @override
  String get totalOutstandingFines => 'إجمالي الغرامات المتبقية';

  @override
  String get kikundi => 'المجموعة';

  @override
  String get nunuaHisa => 'شراء حصص';

  @override
  String get sasaUtaanzaMchakatoWaKununuaHisaKwaKilaMwanachama =>
      'ابدأ عملية شراء الحصص لكل عضو';

  @override
  String get anzaSasa => 'ابدأ الآن';

  @override
  String get rudiNymba => 'العودة';

  @override
  String get hisa => 'الحصص';

  @override
  String get hesabuYaHisa => 'حساب الحصص';

  @override
  String get jumlaYaAkiba => 'إجمالي الحصص';

  @override
  String get hisaAlizonunuaLeo => 'الحصص المراد شراؤها';

  @override
  String get chaguaIdadiYaHisaZaKununua => 'اختر عدد الحصص للشراء';

  @override
  String get chaguaZote => 'اختر الكل';

  @override
  String get ruka => 'تخطي';

  @override
  String get hisaZilizochaguliwa => 'الحصص المختارة';

  @override
  String get badilishaHisa => 'تعديل الحصص';

  @override
  String get ongezaHisa => 'إضافة حصص';

  @override
  String get ongezaHisaZaidiKwaMwanachama => 'إضافة المزيد من الحصص لكل عضو';

  @override
  String get punguzaHisa => 'إزالة حصص';

  @override
  String get punguzaIdadiYaHisaZaMwanachama => 'إزالة حصص لكل عضو';

  @override
  String get futaZote => 'حذف الكل';

  @override
  String get futaHisaZoteZaLeo => 'حذف جميع حصص هذه الدورة';

  @override
  String get ongeza => 'إضافة';

  @override
  String get punguza => 'إزالة';

  @override
  String get futa => 'حذف';

  @override
  String get ingizaIdadiYaHisaUnezotakaKununua =>
      'أدخل عدد الحصص التي تريد إضافتها';

  @override
  String get ingizaIdadiYaHisaUnezotakaKupunguza =>
      'أدخل عدد الحصص التي تريد إزالتها';

  @override
  String get ghairi => 'إلغاء';

  @override
  String get idadiYaHisa => 'عدد الحصص';

  @override
  String get tafadhaliIngizaNambaSahihi => 'يرجى إدخال رقم صحيح';

  @override
  String get muhtasariWaHisa => 'ملخص الحصص';

  @override
  String get jumlaYaFedha => 'المبلغ الإجمالي';

  @override
  String contributeToFund(String fundName) {
    return 'المساهمة في $fundName';
  }

  @override
  String get amountToContribute => 'المبلغ للمساهمة';

  @override
  String get totalCollected => 'المجموع المحصّل';

  @override
  String shareNote(Object amount) {
    return 'ملاحظة: يمكن للعضو شراء حصة واحدة بقيمة $amount لكل اجتماع';
  }

  @override
  String get help => 'المساعدة';

  @override
  String get welcome => 'أهلاً وسهلاً';

  @override
  String get helpDescription => 'نساعدك في الحفاظ على سجلات مجموعتك بكفاءة';

  @override
  String get continueMeeting => 'متابعة الاجتماع';

  @override
  String get wanachama => 'الأعضاء';

  @override
  String get fund => 'توزيع المجموعة';

  @override
  String get feedback => 'الملاحظات';

  @override
  String get groupsActivities => 'أنشطة المجموعة';

  @override
  String get historyDescription => 'عرض سجل أنشطة المجموعة';

  @override
  String get backupAndRestore => 'النسخ الاحتياطي والاستعادة';

  @override
  String get backupDescription => 'نسخ سجلات المجموعة احتياطياً واستعادتها';

  @override
  String get serviceMore => 'خدمات إضافية';

  @override
  String get historyHints => 'عرض سجل أنشطة المجموعة';

  @override
  String get sendData => 'النسخ الاحتياطي والاستعادة';

  @override
  String get sendDataHint => 'نسخ سجلات المجموعة احتياطياً واستعادتها';

  @override
  String get whatsappNotInstalled => 'واتساب غير مثبت على هاتفك';

  @override
  String get whatsappFailed => 'فشل فتح واتساب';

  @override
  String get helpEmailSubject => 'المساعدة - تطبيق تشوموكا بلس';

  @override
  String get welcomeNextMeeting => 'أهلاً بك في الاجتماع القادم';

  @override
  String get midCycleReport => 'تقرير منتصف الدورة';

  @override
  String get tapToOpenMeeting => 'انقر الزر أدناه لفتح الاجتماع';

  @override
  String get tapYesToStartFirstMeeting => 'انقر نعم لبدء الاجتماع الأول';

  @override
  String get openMeeting => 'فتح الاجتماع';

  @override
  String get tapNoToEnterPastMeetings =>
      'انقر لا لإدخال بيانات الاجتماعات السابقة';

  @override
  String meetingTitle(Object meetingNumber) {
    return 'الاجتماع رقم $meetingNumber';
  }

  @override
  String get groupAttendance => 'التحقق من الحضور';

  @override
  String get contributeMfukoJamii => 'المساهمة في الصندوق الاجتماعي';

  @override
  String get buyShares => 'شراء حصص';

  @override
  String contributeOtherFund(Object mfukoName) {
    return 'المساهمة في $mfukoName';
  }

  @override
  String get repayLoan => 'سداد القرض';

  @override
  String get payFine => 'دفع الغرامة';

  @override
  String get withdrawFromMfukoJamii => 'السحب من الصندوق الاجتماعي';

  @override
  String get giveLoan => 'صرف القرض';

  @override
  String get markCompleted => 'مكتمل';

  @override
  String get markPending => 'قيد الانتظار';

  @override
  String get menuBulkSaving => 'الادخار الجماعي';

  @override
  String get menuExpense => 'إدخال تفاصيل المصروف';

  @override
  String get menuLogout => 'تسجيل الخروج';

  @override
  String get snackbarLoggedOut => 'تم تسجيل الخروج';

  @override
  String get attendance => 'الحضور';

  @override
  String get attendanceSummary => 'ملخص الحضور';

  @override
  String get totalMembers => 'إجمالي الأعضاء:';

  @override
  String get present => 'حاضر';

  @override
  String get onTime => 'في الوقت المحدد';

  @override
  String get lates => 'متأخر';

  @override
  String get sentRepresentative => 'أرسل ممثلاً';

  @override
  String get absent => 'غائب';

  @override
  String get withPermission => 'بإذن';

  @override
  String get withoutPermission => 'بدون إذن';

  @override
  String get reasonForAbsence => 'سبب الغياب';

  @override
  String get amountToPaid => 'المبلغ الذي يجب على العضو دفعه:';

  @override
  String get whatWasCollected => 'ما تم تحصيله:';

  @override
  String get hasPaid => 'دفع';

  @override
  String get hasNotPaid => 'لم يدفع';

  @override
  String get compulsorySavingsTitle => 'معلومات الادخار الإلزامي';

  @override
  String get compulsorySavingsSubtitle => 'مساهمات الأعضاء';

  @override
  String get loadingMessage => 'جارٍ تحميل المعلومات...';

  @override
  String get doneButton => 'انتهيت';

  @override
  String get noCompulsorySavings =>
      'لا توجد مبالغ ادخار إلزامي مستحقة على العضو';

  @override
  String get phone => 'الهاتف';

  @override
  String get dueMeeting => 'مستحق للاجتماع';

  @override
  String owedAmount(Object amount) {
    return 'الادخار الإلزامي المستحق:  $amount';
  }

  @override
  String get pay => 'دفع';

  @override
  String get alreadyPaid => 'تم الدفع مسبقاً';

  @override
  String get socialFundTitle => 'معلومات الصندوق الاجتماعي';

  @override
  String socialFundDueAmount(Object amount) {
    return 'المبلغ المستحق للصندوق الاجتماعي:  $amount';
  }

  @override
  String get contributionSummary => 'ملخص المساهمة';

  @override
  String memberName(Object name) {
    return 'العضو: $name';
  }

  @override
  String get paid => 'مدفوع';

  @override
  String get unpaid => 'غير مدفوع';

  @override
  String get noSocialFundDue => 'لا توجد مبالغ صندوق اجتماعي مستحقة على العضو';

  @override
  String get totalLoan => 'إجمالي القرض';

  @override
  String get noUnpaidMemberJamii =>
      'لا يوجد عضو لديه مساهمات صندوق اجتماعي متبقية';

  @override
  String get unpaidContributionsTitle => 'المساهمات غير المدفوعة';

  @override
  String get unpaidContributionsSubtitle => 'مساهمات الصندوق الاجتماعي';

  @override
  String get loanDebtorsTitle => 'مدينو القروض';

  @override
  String get loanSummaryTitle => 'ملخص القرض';

  @override
  String get loanIssuedAmount => 'إجمالي القروض المصروفة:';

  @override
  String get loanRepaidAmount => 'إجمالي القروض المسددة:';

  @override
  String get loanRemainingAmount => 'رصيد القرض المتبقي:';

  @override
  String get noUnpaidLoans => 'لا يوجد أعضاء لديهم قروض غير مسددة.';

  @override
  String get loanDebtors => 'مدينو القروض';

  @override
  String get memberLabel => 'العضو:';

  @override
  String get unpaidLoanAmount => 'مبلغ القرض غير المسدد:';

  @override
  String get loanDetailsTitle => 'تفاصيل القرض';

  @override
  String get makePayment => 'إجراء الدفع';

  @override
  String remainingAmount(Object amount) {
    return 'المبلغ المتبقي:  $amount';
  }

  @override
  String get choosePaymentType => 'اختر نوع الدفع:';

  @override
  String get payAll => 'دفع الكل';

  @override
  String get reduceLoan => 'تخفيض القرض';

  @override
  String get enterPaymentAmount => 'أدخل مبلغ الدفع';

  @override
  String get payLoan => 'دفع القرض';

  @override
  String get member => 'العضو:';

  @override
  String get loanTaken => 'مبلغ القرض المأخوذ:';

  @override
  String get loanToPay => 'المبلغ الواجب سداده:';

  @override
  String get loanRemaining => 'مبلغ القرض المتبقي:';

  @override
  String get paymentHistory => 'سجل المدفوعات:';

  @override
  String get noPaymentsMade => 'لم تُجرَ أي مدفوعات بعد.';

  @override
  String youPaid(Object amount) {
    return 'دفعت:  $amount';
  }

  @override
  String date(Object date) {
    return 'التاريخ: $date';
  }

  @override
  String get fainiPageTitle => 'إصدار غرامة';

  @override
  String get pageSubtitle => 'اختر الغرامة';

  @override
  String get undefinedFine => 'غرامة غير محددة';

  @override
  String priceLabel(Object price) {
    return 'السعر: $price شلن';
  }

  @override
  String get saveFine => 'حفظ الغرامة';

  @override
  String get payFineTitle => 'دفع الغرامة';

  @override
  String remainingFineAmount(Object amount) {
    return 'المبلغ المتبقي:  $amount';
  }

  @override
  String get payAllFines => 'دفع جميع الغرامات';

  @override
  String get payCustomAmount => 'دفع مبلغ مخصص';

  @override
  String get confirmFinePayment => 'دفع الغرامة';

  @override
  String get fineTitle => 'غرامات العضو';

  @override
  String get fineSubtitle => 'دفع الغرامة';

  @override
  String totalFines(Object amount) {
    return 'إجمالي الغرامات المستحقة:  $amount';
  }

  @override
  String paidFines(Object amount) {
    return 'الغرامات المدفوعة:  $amount';
  }

  @override
  String remainingFines(Object amount) {
    return 'المبلغ المتبقي:  $amount';
  }

  @override
  String get pigaFainiTitle => 'إصدار غرامة';

  @override
  String get pigaFainiSubtitle => 'اختر العضو';

  @override
  String get searchHint => 'البحث بالاسم أو رقم العضو';

  @override
  String get fainiSummarySubtitle => 'ملخص الغرامة';

  @override
  String get unknownName => 'غير محدد الاسم';

  @override
  String get unknownPhone => 'رقم الهاتف غير معروف';

  @override
  String get backToFines => 'العودة إلى الغرامات';

  @override
  String get lipaFainiTitle => 'دفع الغرامة';

  @override
  String get totalFinesDue => 'إجمالي الغرامات المستحقة';

  @override
  String get totalFinesPaid => 'إجمالي الغرامات المدفوعة';

  @override
  String get noFineMembers => 'لا يوجد أعضاء لديهم غرامات.';

  @override
  String get unpaidFinesTitle => 'الغرامات غير المدفوعة';

  @override
  String memberTotalFines(Object amount) {
    return 'إجمالي الغرامات:  $amount';
  }

  @override
  String get navigationError => 'حدث خطأ أثناء التنقل. يرجى المحاولة مرة أخرى.';

  @override
  String get memberFinesTitle => 'غرامات العضو';

  @override
  String memberNameLabel(Object name) {
    return 'العضو: $name';
  }

  @override
  String memberNumberLabel(Object number) {
    return 'رقم العضو: $number';
  }

  @override
  String totalFinesLabel(Object amount) {
    return 'إجمالي الغرامات المستحقة:  $amount';
  }

  @override
  String totalPaidLabel(Object amount) {
    return 'الغرامات المدفوعة:  $amount';
  }

  @override
  String totalUnpaidLabel(Object amount) {
    return 'الرصيد المتبقي:  $amount';
  }

  @override
  String memberPhone(Object phone) {
    return 'الهاتف: $phone';
  }

  @override
  String fineTypes(Object fineName) {
    return 'نوع الغرامة: $fineName';
  }

  @override
  String fineAmount(Object amount) {
    return 'مبلغ الغرامة: $amount';
  }

  @override
  String meetingNumber(Object meeting, Object meetings) {
    return 'الاجتماع: $meeting';
  }

  @override
  String get toa_mfuko_jamii => 'سحب الصندوق الاجتماعي';

  @override
  String get sababu_ya_kutoa_mfuko => 'سبب سحب الصندوق الاجتماعي';

  @override
  String get hakuna_sababu => 'لم تُملأ أي أسباب بعد.';

  @override
  String kiasi_cha_juu(Object amount) {
    return 'الحد الأقصى للسحب:  $amount';
  }

  @override
  String get jina => 'الاسم:';

  @override
  String get jina_lisiloeleweka => 'اسم غير معروف';

  @override
  String get namba_haijapatikana => 'الرقم غير موجود';

  @override
  String get chagua_sababu => 'اختر سبب سحب الصندوق الاجتماعي';

  @override
  String get tatizo_katika_kupakia => 'حدث خطأ، يرجى المحاولة مرة أخرى.';

  @override
  String get chagua_kiwango_kutoa => 'اختر مبلغ السحب';

  @override
  String get namba_ya_mwanachama => 'رقم العضو:';

  @override
  String get sababu_ya_kutoa => 'سبب سحب الصندوق الاجتماعي:';

  @override
  String get kiwango_cha_juu => 'الحد الأقصى للسحب:';

  @override
  String get salio_la_sasa => 'الرصيد الحالي:';

  @override
  String get salio_la_kikao_kilichopita =>
      'رصيد الصندوق الاجتماعي للاجتماع السابق:';

  @override
  String get toa_kiasi_chote => 'سحب المبلغ بالكامل';

  @override
  String get toa_kiasi_kingine => 'سحب مبلغ آخر';

  @override
  String get ingiza_kiasi => 'أدخل المبلغ';

  @override
  String get thibitisha_utoaji_pesa => 'تأكيد سحب الصندوق';

  @override
  String get kiasi_cha_kutoa => 'مبلغ السحب:';

  @override
  String get salio_jipya => 'الرصيد الجديد:';

  @override
  String get toa_mkopo => 'صرف قرض';

  @override
  String get tahadhari => 'تحذير!';

  @override
  String get hawezi_kukopa =>
      'لا يمكن للعضو أخذ قرض آخر حتى ينهي القرض الحالي.';

  @override
  String get sababu_ya_kutoa_mkopo => 'سبب أخذ القرض';

  @override
  String weka_sababu(Object name) {
    return 'أدخل سبب حصول العضو $name على هذا القرض:';
  }

  @override
  String get kilimo => 'الزراعة';

  @override
  String get maboresho_nyumba => 'تحسين المنزل';

  @override
  String get elimu => 'التعليم';

  @override
  String get biashara => 'الأعمال التجارية';

  @override
  String get sababu_nyingine => 'سبب آخر';

  @override
  String get weka_sababu_nyingine => 'أدخل السبب الآخر';

  @override
  String get thibitisha_sababu => 'تأكيد السبب';

  @override
  String get tafadhali_weka_sababu_nyingine => 'يرجى إدخال سبب آخر.';

  @override
  String get jumla_ya_akiba => 'إجمالي المدخرات:';

  @override
  String get kiwango_cha_juu_mkopo => 'الحد الأقصى لمبلغ القرض:';

  @override
  String get fedha_zilizopo_mkopo => 'الأموال المتاحة للقرض:';

  @override
  String chukua_mkopo_wote(Object amount) {
    return 'أخذ القرض بالكامل  $amount';
  }

  @override
  String get kiasi_kingine => 'مبلغ آخر';

  @override
  String get kiasi => 'المبلغ';

  @override
  String get weka_kiasi => 'أدخل المبلغ';

  @override
  String get thibitisha_kiasi => 'تأكيد المبلغ';

  @override
  String get tafadhali_chagua_chaguo => 'يرجى اختيار خيار القرض.';

  @override
  String get kiasi_cha_mkopo_wa_mwanachama => 'مبلغ قرض العضو';

  @override
  String get tafadhali_ingiza_kiasi_sahihi => 'يرجى إدخال مبلغ صحيح.';

  @override
  String get hakuna_kiasi_cha_kutosha => 'الأموال غير كافية لصرف هذا القرض.';

  @override
  String get kiasi_hakiruhusiwi => 'المبلغ المختار غير مسموح به.';

  @override
  String get kiasi_na_riba_vimehifadhiwa => 'تم حفظ مبلغ القرض والفائدة.';

  @override
  String get hitilafu_imetokea => 'حدث خطأ. يرجى المحاولة مرة أخرى.';

  @override
  String get muda_wa_marejesho => 'مدة السداد';

  @override
  String kiasi_cha_mkopo_wake_ni(Object amount) {
    return 'مبلغ قرضه هو:\n $amount';
  }

  @override
  String get mkopo_wa_miezi_mingapi => 'مدة القرض بالأشهر؟';

  @override
  String get mwezi_1 => 'شهر واحد';

  @override
  String get miezi_2 => 'شهران';

  @override
  String get miezi_3 => '3 أشهر';

  @override
  String get miezi_6 => '6 أشهر';

  @override
  String get nyingine => 'أخرى';

  @override
  String get ingiza_miezi => 'أدخل عدد الأشهر';

  @override
  String get thibitisha_muda => 'تأكيد المدة';

  @override
  String get tafadhali_chagua_muda => 'يرجى اختيار فترة السداد.';

  @override
  String get tafadhali_ingiza_muda_sahihi => 'يرجى إدخال مدة صحيحة.';

  @override
  String muda_wa_marejesho_umehifadhiwa(Object months) {
    return 'تم حفظ مدة السداد: $months أشهر';
  }

  @override
  String get wadhamini => 'الضامنون';

  @override
  String jinas(Object name) {
    return 'الاسم: $name';
  }

  @override
  String chagua_wadhamini(Object count) {
    return 'اختر $count ضامنين:';
  }

  @override
  String get haidhibiti_idadi => 'يرجى اختيار جميع الضامنين المطلوبين.';

  @override
  String get haijulikani => 'غير معروف';

  @override
  String get muhtasari_wa_mkopo => 'ملخص القرض';

  @override
  String get thibitisha_mkopo => 'تأكيد القرض';

  @override
  String get maelezo_ya_mkopo => 'تفاصيل القرض';

  @override
  String get kiasi_cha_mkopo => 'مبلغ القرض';

  @override
  String get riba_ya_mkopo => 'فائدة القرض';

  @override
  String get maelezo_ya_riba => 'تفاصيل\nالفائدة';

  @override
  String get salio_la_mkopo => 'رصيد القرض';

  @override
  String get tarehe_ya_mwisho => 'تاريخ الاستحقاق';

  @override
  String miezi(Object miezi) {
    return 'أشهر $miezi';
  }

  @override
  String get oneTimeInterest => 'تُدفع الفائدة مرة واحدة فقط';

  @override
  String guarantorExample(int count, String amount) {
    return 'على سبيل المثال، إذا لم تتمكن بيلي من سداد دينها البالغ 150,000 عند التوزيع، فسيُخصم من مدخرات كل من $count أعضاء الذين ضمنوا قرضها مبلغ $amount.';
  }

  @override
  String get communityFundTitle => 'الصندوق الاجتماعي';

  @override
  String get unpaidContribution => 'مساهمة غير مدفوعة';

  @override
  String get expense => 'المصروف';

  @override
  String get chooseUsageType => 'اختر نوع الاستخدام';

  @override
  String usageType(Object type) {
    return '$type';
  }

  @override
  String get matumziStationery => 'مستلزمات مكتبية';

  @override
  String get matumziRefreshment => 'مرطبات';

  @override
  String get matumziLoanPayment => 'سداد قرض';

  @override
  String get matumziCallTime => 'رصيد الاتصالات';

  @override
  String get matumziTechnology => 'تكنولوجيا';

  @override
  String get matumiziMerchandise => 'بضاعة تجارية';

  @override
  String get matumziTransport => 'النقل';

  @override
  String get matumiziBackCharges => 'رسوم بنكية';

  @override
  String get matumziOther => 'أخرى';

  @override
  String get specificUsage => 'الاستخدام المحدد';

  @override
  String get enterSpecificUsage => 'أدخل الاستخدام المحدد';

  @override
  String get pleaseEnterSpecificUsage => 'يرجى إدخال الاستخدام المحدد.';

  @override
  String get pleaseEnterAmount => 'يرجى إدخال المبلغ.';

  @override
  String get next => 'التالي';

  @override
  String get expenseSummary => 'ملخص المصروفات';

  @override
  String get totalAmountSpent => 'إجمالي المبلغ المنفق';

  @override
  String get totalExpenses => 'إجمالي المصروفات:';

  @override
  String get noExpensesRecorded => 'لا توجد مصروفات مسجلة.';

  @override
  String expenseLabel(Object label) {
    return 'المصروف: $label';
  }

  @override
  String get unknown => 'غير معروف';

  @override
  String expenseType(Object type) {
    return 'النوع: $type';
  }

  @override
  String amountLabel(Object amount) {
    return 'المبلغ:  $amount';
  }

  @override
  String fundLabel(Object fund) {
    return 'الصندوق: $fund';
  }

  @override
  String get done => 'تم';

  @override
  String get confirmExpense => 'تأكيد المصروف';

  @override
  String get expenseFund => 'صندوق المصروف';

  @override
  String get expenseTypeLabel => 'نوع المصروف';

  @override
  String get chooseFund => 'اختر الصندوق';

  @override
  String get chooseFundToContribute => 'اختر الصندوق للمساهمة';

  @override
  String get mainGroupFund => 'الصندوق الرئيسي للمجموعة';

  @override
  String get socialFund => 'الصندوق الاجتماعي';

  @override
  String get pleaseChooseFund => 'يرجى اختيار صندوق.';

  @override
  String get bulkSaving => 'الادخار الجماعي';

  @override
  String get chooseContributionType => 'اختر نوع المساهمة';

  @override
  String get donationContribution => 'مساهمة تبرعية';

  @override
  String get businessProfit => 'أرباح الأعمال';

  @override
  String get loanDisbursement => 'صرف القرض';

  @override
  String enterAmountFor(Object type) {
    return 'أدخل المبلغ لـ $type:';
  }

  @override
  String get totalContributionsForCycle => 'إجمالي المساهمات لهذه الدورة';

  @override
  String get contributionsList => 'قائمة المساهمات';

  @override
  String get noContributionsCompleted => 'لم تكتمل أي مساهمات.';

  @override
  String get noFund => 'لا يوجد صندوق';

  @override
  String contributionType(Object type) {
    return 'النوع: $type';
  }

  @override
  String get confirmContribution => 'تأكيد المساهمة';

  @override
  String get fundBalance => 'رصيد الصندوق';

  @override
  String get currentContribution => 'المساهمة الحالية';

  @override
  String get newFundBalance => 'الرصيد الجديد للصندوق';

  @override
  String meetingSummaryTitle(Object meetingNumber) {
    return 'ملخص الاجتماع $meetingNumber';
  }

  @override
  String get sharePurchaseSection => 'شراء الحصص';

  @override
  String get totalSharesDeposited => 'إجمالي الحصص المودعة';

  @override
  String get totalShareValue => 'إجمالي قيمة الحصص';

  @override
  String get amountDeposited => 'المبلغ المودع';

  @override
  String get amountWithdrawn => 'المبلغ المسحوب';

  @override
  String get loansSection => 'القروض';

  @override
  String get loansIssued => 'القروض المصروفة';

  @override
  String get loanAmountRepaid => 'مبلغ القرض المسدد';

  @override
  String get loanAmountOutstanding => 'مبلغ القرض المتبقي';

  @override
  String get finesSection => 'الغرامات';

  @override
  String get totalBulkSaving => 'إجمالي الادخار الجماعي';

  @override
  String get expensesSection => 'المصروفات';

  @override
  String get loadingAttendanceSummary => 'جارٍ تحميل ملخص الحضور...';

  @override
  String get presentMembers => 'الأعضاء الحاضرون';

  @override
  String get earlyMembers => 'مبكرون';

  @override
  String get lateMembers => 'متأخرون';

  @override
  String get representative => 'ممثل';

  @override
  String get absentMembers => 'الأعضاء الغائبون';

  @override
  String get closeMeeting => 'إغلاق الاجتماع';

  @override
  String get sendSmsTitle => 'إرسال رسالة قصيرة';

  @override
  String get sendSmsSubtitle => 'إرسال رسائل قصيرة إلى الأعضاء';

  @override
  String get chooseSmsSendType => 'اختر كيفية إرسال الرسالة القصيرة';

  @override
  String get sendToAll => 'إرسال إلى الجميع';

  @override
  String get chooseMembers => 'اختر الأعضاء';

  @override
  String get selected => 'محدد';

  @override
  String get sendSms => 'إرسال رسالة قصيرة';

  @override
  String sendSmsWithCount(Object count) {
    return 'إرسال رسالة قصيرة ($count)';
  }

  @override
  String get selectMembersToSendSms =>
      'يرجى اختيار أعضاء لإرسال الرسالة القصيرة إليهم';

  @override
  String get noMembersToSendSms => 'لا يوجد أعضاء لإرسال الرسالة القصيرة إليهم';

  @override
  String smsGreeting(Object name) {
    return 'عزيزي/عزيزتي $name،';
  }

  @override
  String get smsSummaryHeader => 'ملخص الاجتماع:';

  @override
  String smsTotalShares(Object shares, Object value) {
    return 'إجمالي الحصص: $shares ( $value)';
  }

  @override
  String smsSocialFund(Object amount) {
    return 'الصندوق الاجتماعي:  $amount';
  }

  @override
  String smsCurrentLoan(Object amount) {
    return 'القرض الحالي:  $amount';
  }

  @override
  String smsFine(Object amount) {
    return 'الغرامة:  $amount';
  }

  @override
  String get failedToCloseMeeting => 'فشل إغلاق الاجتماع';

  @override
  String get meetingNotFound => 'الاجتماع غير موجود';

  @override
  String failedToCloseMeetingWithError(Object error) {
    return 'فشل إغلاق الاجتماع: $error';
  }

  @override
  String get agentPreparedAndOnTime =>
      'هل استعدّ الوكيل جيداً وحضر في الوقت المحدد؟';

  @override
  String get agentExplainedChomoka =>
      'هل شرح الوكيل كيفية استخدام نظام تشوموكا؟';

  @override
  String get pleaseAnswerThisQuestion => 'يرجى الإجابة على هذا السؤال.';

  @override
  String get agentExplainedCosts => 'هل شرح الوكيل التكاليف بوضوح وشفافية؟';

  @override
  String get agentRating => 'كيف تقيّم وكيل تشوموكا؟';

  @override
  String get agentRatingLevel1 => '1. ضعيف';

  @override
  String get agentRatingLevel2 => '2. مقبول';

  @override
  String get agentRatingLevel3 => '3. جيد';

  @override
  String get agentRatingLevel4 => '4. جيد جداً';

  @override
  String get agentRatingLevel5 => '5. ممتاز';

  @override
  String get pleaseChooseRating => 'يرجى اختيار تقييم.';

  @override
  String get unansweredQuestion =>
      'هل لديك سؤال لم يجب عنه الوكيل أو لم تكن راضياً عن إجابته؟';

  @override
  String get question => 'سؤال';

  @override
  String get pleaseWriteQuestion => 'يرجى كتابة سؤالك.';

  @override
  String get suggestionForChomoka => 'ما التغييرات التي تقترحها لنظام تشوموكا؟';

  @override
  String get suggestion => 'اقتراح';

  @override
  String get pleaseWriteSuggestion => 'يرجى كتابة اقتراحك.';

  @override
  String get noMeeting => 'لا يوجد اجتماع';

  @override
  String get noMeetingDesc =>
      'لم يُعقد أي اجتماع في هذه الدورة، يرجى عقد اجتماع للمتابعة مع التوزيع.';

  @override
  String get meetingInProgress => 'الاجتماع جارٍ';

  @override
  String get meetingInProgressDesc =>
      'يرجى إنهاء الاجتماع للمتابعة مع التوزيع.';

  @override
  String get shareout => 'التوزيع';

  @override
  String get chooseShareoutType => 'اختر نوع التوزيع';

  @override
  String get groupShareout => 'توزيع المجموعة';

  @override
  String get groupShareoutDesc =>
      'لقد أكملنا دورتنا ونريد إجراء توزيع. نريد مراجعة حالة مشاركة مجموعتنا.';

  @override
  String get memberShareout => 'توزيع العضو';

  @override
  String get memberShareoutDesc =>
      'نريد إزالة عضو بشكل كامل من مجموعتنا ولن يتمكن العضو من حضور المزيد من الاجتماعات. نريد مراجعة حالة مشاركة العضو.';

  @override
  String get returnToHome => 'العودة إلى الرئيسية';

  @override
  String get summary => 'الملخص';

  @override
  String get chooseMember => 'اختر العضو';

  @override
  String phoneNumberLabel(Object phone) {
    return 'الهاتف: $phone';
  }

  @override
  String get totalMandatorySavings => 'إجمالي الادخار الإلزامي';

  @override
  String get totalVoluntarySavings => 'إجمالي الادخار الاختياري';

  @override
  String get unpaidFineAmount => 'Unpaid \nfine amount';

  @override
  String get memberOwesAmount => 'العضو مدين\nبمبلغ';

  @override
  String get totalShareoutAmount => 'إجمالي مبلغ التوزيع';

  @override
  String get confirmShareout => 'تأكيد التوزيع';

  @override
  String get mandatorySavingsToBeWithdrawn => 'الادخار الإلزامي المراد سحبه';

  @override
  String get voluntarySavingsToBeWithdrawn => 'الادخار الاختياري المراد سحبه';

  @override
  String get memberMustPayAmount => 'يجب على العضو\nدفع مبلغ';

  @override
  String get cashPayment => 'الدفع النقدي';

  @override
  String get noPaymentToMember => 'لن يحصل العضو\nعلى أي دفعة';

  @override
  String get totalSharesCount => 'إجمالي عدد الحصص';

  @override
  String get totalSharesValue => 'إجمالي قيمة الحصص';

  @override
  String get enterKeysToContinue => 'أدخل المفاتيح للمتابعة';

  @override
  String get smsSummaryTitle => 'إرسال الملخص عبر رسالة قصيرة';

  @override
  String get smsYes => 'نعم';

  @override
  String get smsNo => 'لا';

  @override
  String get groupShareTitle => 'توزيع المجموعة';

  @override
  String get noMembersInGroup => 'لا يوجد أعضاء في هذه المجموعة.';

  @override
  String get selectMember => 'اختر العضو';

  @override
  String get totalFine => 'إجمالي الغرامات المحصّلة';

  @override
  String get totalSocialFund => 'إجمالي الصندوق الاجتماعي';

  @override
  String totalShareAmount(Object percentage, Object shares) {
    return 'الحصص: $shares ($percentage%)';
  }

  @override
  String get unpaidLoanMsg =>
      'توجد مدفوعات قروض غير مسددة. يرجى سداد جميع القروض قبل المتابعة.';

  @override
  String get unpaidFineMsg =>
      'توجد غرامات غير مدفوعة. يرجى دفع جميع الغرامات قبل المتابعة.';

  @override
  String get unpaidSocialFundMsg =>
      'توجد مدفوعات صندوق اجتماعي غير مسددة. يرجى سداد جميع المدفوعات قبل المتابعة.';

  @override
  String get unpaidCompulsorySavingsMsg =>
      'توجد مدخرات إلزامية غير مدفوعة. يرجى سداد جميع المدفوعات قبل المتابعة.';

  @override
  String get warning => 'تحذير';

  @override
  String get profit => 'الربح';

  @override
  String get totalExtraCollected => 'إجمالي المبالغ الإضافية المحصّلة';

  @override
  String totalUnpaidAmount(Object amount) {
    return 'إجمالي المبلغ غير المسدد:  $amount';
  }

  @override
  String get totalWithdrawnFromSocialFund =>
      'إجمالي المسحوب من الصندوق الاجتماعي';

  @override
  String get totalFunds => 'إجمالي الصناديق';

  @override
  String get expenses => 'المصروفات';

  @override
  String get otherGroupExpenses => 'مصروفات المجموعة الأخرى';

  @override
  String get amountRemaining => 'المبلغ المتبقي';

  @override
  String get socialFundCarriedForward =>
      'الصندوق الاجتماعي المرحّل إلى الدورة القادمة';

  @override
  String get totalShareFunds => 'إجمالي أموال الحصص';

  @override
  String get amountNextCycleSubtitle => 'المبلغ المرحّل إلى الدورة القادمة';

  @override
  String get sendToNextCycle => 'إرسال إلى الدورة القادمة';

  @override
  String get enterAmountNextCycle =>
      'أدخل المبلغ الذي تريد ترحيله إلى الدورة القادمة لكل صندوق';

  @override
  String availableAmount(Object amount) {
    return 'المتاح  $amount';
  }

  @override
  String amountMustBeLessThanOrEqual(Object amount) {
    return 'يجب أن يكون المبلغ أقل من أو يساوي $amount';
  }

  @override
  String get memberShareDistributionTitle => 'توزيع حصص الأعضاء';

  @override
  String shareValueAmount(Object amount) {
    return 'قيمة الحصة:  $amount';
  }

  @override
  String totalDistributionAmount(Object amount) {
    return 'إجمالي التوزيع:  $amount';
  }

  @override
  String get groupShareDistributionTitle => 'توزيع حصص المجموعة';

  @override
  String get noProfitEmoji => '😢';

  @override
  String get profitEmoji => '😊';

  @override
  String get noProfitMessage => 'لم تحقق مجموعتك أي ربح';

  @override
  String profitMessage(Object amount) {
    return 'تهانينا! حققت مجموعتك ربحاً بمقدار $amount';
  }

  @override
  String get totalDistributionFunds => 'إجمالي أموال التوزيع';

  @override
  String amountTzs(Object amount) {
    return ' $amount';
  }

  @override
  String get nextCycleSocialFund =>
      'مبلغ الصندوق الاجتماعي المرحّل إلى الدورة القادمة';

  @override
  String get nextCycleMemberSavings =>
      'إجمالي مدخرات الأعضاء المرحّلة إلى الدورة القادمة';

  @override
  String get finishCycle => 'إنهاء الدورة';

  @override
  String get memberShareSummaryTitle => 'ملخص حصة العضو';

  @override
  String get memberShareSummarySubtitle => 'ملخص توزيع الحصص';

  @override
  String get giveToNextCycle => 'إرسال إلى الدورة القادمة';

  @override
  String get shareInfoSection => 'معلومات الحصص';

  @override
  String get numberOfShares => 'عدد الحصص:';

  @override
  String get sharePercentage => 'نسبة الحصص:';

  @override
  String get profitInfoSection => 'معلومات الربح';

  @override
  String get profitShare => 'حصة الربح (بحسب الحصص):';

  @override
  String get socialFundShare => 'حصة الصندوق الاجتماعي:';

  @override
  String get distributionSummarySection => 'ملخص التوزيع';

  @override
  String get summaryShareValue => 'قيمة الحصة:';

  @override
  String get summaryProfit => 'الربح:';

  @override
  String get summarySocialFund => 'الصندوق الاجتماعي:';

  @override
  String get summaryTotalDistribution => 'إجمالي التوزيع:';

  @override
  String get paymentInfoSection => 'معلومات الدفع';

  @override
  String get amountToNextCycle => 'المبلغ إلى الدورة القادمة:';

  @override
  String get paymentAmount => 'مبلغ الدفع:';

  @override
  String get inputAmountForNextCycle => 'أدخل المبلغ للدورة القادمة';

  @override
  String get confirmButton => 'تأكيد';

  @override
  String get amountMustBeLessThanOrEqualTotal =>
      'يجب أن يكون المبلغ أقل من أو يساوي إجمالي التوزيع.';

  @override
  String get successfullyPaid => 'تم الدفع بنجاح';

  @override
  String get groupActivitiesTitle => 'أنشطة المجموعة';

  @override
  String get groupBusiness => 'أعمال المجموعة';

  @override
  String get otherActivities => 'أنشطة أخرى';

  @override
  String get training => 'التدريب';

  @override
  String get backToHome => 'العودة إلى الرئيسية';

  @override
  String get addTrainingTitle => 'إضافة تدريب';

  @override
  String get editTrainingTitle => 'تعديل التدريب';

  @override
  String get trainingType => 'نوع التدريب';

  @override
  String get enterTrainingType => 'أدخل نوع التدريب';

  @override
  String get organization => 'المنظمة';

  @override
  String get enterOrganization => 'أدخل اسم المنظمة';

  @override
  String get chooseDate => 'اختر التاريخ';

  @override
  String get membersCount => 'عدد الأعضاء';

  @override
  String get enterMembersCount => 'أدخل عدد الأعضاء';

  @override
  String get trainer => 'المدرّب';

  @override
  String get enterTrainer => 'أدخل اسم المدرّب';

  @override
  String get saveTraining => 'حفظ التدريب';

  @override
  String get saveChanges => 'حفظ التغييرات';

  @override
  String get trainingSaved => 'تم حفظ التدريب بنجاح';

  @override
  String get trainingUpdated => 'تم تحديث التدريب بنجاح';

  @override
  String get pleaseFillAllFields => 'يرجى ملء جميع الحقول';

  @override
  String get pleaseEnterTrainingType => 'يرجى إدخال نوع التدريب';

  @override
  String get pleaseEnterOrganization => 'يرجى إدخال اسم المنظمة';

  @override
  String get pleaseEnterMembersCount => 'يرجى إدخال عدد الأعضاء';

  @override
  String get pleaseEnterTrainer => 'يرجى إدخال اسم المدرّب';

  @override
  String get trainingListTitle => 'قائمة التدريبات';

  @override
  String totalTrainings(Object count) {
    return 'إجمالي التدريبات: $count';
  }

  @override
  String get noTrainingsSaved => 'لا توجد تدريبات محفوظة';

  @override
  String get addNewTraining => 'إضافة تدريب';

  @override
  String get deleteTrainingTitle => 'حذف التدريب';

  @override
  String get deleteTrainingConfirm => 'هل أنت متأكد من حذف هذا التدريب؟';

  @override
  String get trainingDeleted => 'تم حذف التدريب بنجاح';

  @override
  String get addOtherActivityTitle => 'الأنشطة الأخرى';

  @override
  String get editOtherActivityTitle => 'تعديل النشاط';

  @override
  String get activityDate => 'التاريخ';

  @override
  String get chooseActivityDate => 'اختر التاريخ';

  @override
  String get activityName => 'النشاط المنجز';

  @override
  String get enterActivityName => 'أدخل النشاط المنجز';

  @override
  String get beneficiariesCount => 'عدد المستفيدين';

  @override
  String get enterBeneficiariesCount => 'أدخل عدد المستفيدين';

  @override
  String get enterLocation => 'أدخل موقع النشاط';

  @override
  String get saveActivity => 'حفظ النشاط';

  @override
  String get saveActivityChanges => 'حفظ التغييرات';

  @override
  String get activitySaved => 'تم حفظ النشاط بنجاح';

  @override
  String get activityUpdated => 'تم تحديث النشاط بنجاح';

  @override
  String get pleaseFillAllActivityFields => 'يرجى ملء جميع الحقول';

  @override
  String get pleaseEnterActivityName => 'يرجى إدخال النشاط المنجز';

  @override
  String get pleaseEnterBeneficiariesCount => 'يرجى إدخال عدد المستفيدين';

  @override
  String get pleaseEnterLocation => 'يرجى إدخال الموقع';

  @override
  String get activityListTitle => 'قائمة الأنشطة الأخرى';

  @override
  String totalActivities(Object count) {
    return 'إجمالي الأنشطة: $count';
  }

  @override
  String get noActivitiesSaved => 'لا توجد أنشطة محفوظة';

  @override
  String get addNewActivity => 'إضافة نشاط';

  @override
  String get editActivity => 'تعديل';

  @override
  String get deleteActivity => 'حذف';

  @override
  String get deleteActivityTitle => 'حذف النشاط';

  @override
  String get deleteActivityConfirm => 'هل أنت متأكد من حذف هذا النشاط؟';

  @override
  String get activityDeleted => 'تم حذف النشاط بنجاح';

  @override
  String get orderListTitle => 'طلبات المدخلات';

  @override
  String get orderListSubtitle => 'قائمة الطلبات';

  @override
  String get orderListTotalRequests => 'إجمالي الطلبات';

  @override
  String get orderListPending => 'قيد الانتظار';

  @override
  String get orderListApproved => 'معتمد';

  @override
  String get orderListRejected => 'مرفوض';

  @override
  String orderListRequests(Object count) {
    return 'الطلبات $count';
  }

  @override
  String get orderListRefresh => 'تحديث';

  @override
  String get orderListNoRequests => 'لا توجد طلبات محفوظة';

  @override
  String get orderListAddNewPrompt => 'اضغط الزر لإضافة طلب جديد';

  @override
  String get orderListDone => 'تم';

  @override
  String get orderListUnknownInput => 'مدخل';

  @override
  String get orderListUnknownCompany => 'شركة غير معروفة';

  @override
  String get orderListStatusApproved => 'معتمد';

  @override
  String get orderListStatusRejected => 'مرفوض';

  @override
  String get orderListStatusPending => 'قيد الانتظار';

  @override
  String orderListAmount(Object amount) {
    return 'المبلغ: $amount';
  }

  @override
  String get orderListUnknownAmount => 'غير معروف';

  @override
  String get orderListUnknownDate => 'تاريخ غير معروف';

  @override
  String get orderListPrice => 'السعر';

  @override
  String get orderListUnknownPrice => 'غير معروف';

  @override
  String get orderListFinish => 'تم';

  @override
  String get orderListShowAgain => 'عرض مجدداً';

  @override
  String get requestSummaryTitle => 'تفاصيل طلب المدخل';

  @override
  String get requestSummaryListTitle => 'قائمة طلبات المدخلات';

  @override
  String requestSummaryTotal(Object count) {
    return 'إجمالي الطلبات: $count';
  }

  @override
  String get requestSummaryStatus => 'حالة الطلب';

  @override
  String get requestSummaryStatusApproved => 'معتمد';

  @override
  String get requestSummaryStatusRejected => 'مرفوض';

  @override
  String get requestSummaryStatusPending => 'قيد الانتظار';

  @override
  String get requestSummaryStatusMessageApproved =>
      'تم اعتماد طلب المدخل الخاص بك. يمكنك المتابعة في عملية الشراء.';

  @override
  String get requestSummaryStatusMessageRejected =>
      'عذراً، تم رفض طلب المدخل الخاص بك. يرجى التواصل مع المسؤول لمزيد من التفاصيل.';

  @override
  String get requestSummaryStatusMessagePending =>
      'تم استلام طلب المدخل الخاص بك وهو قيد الاعتماد. سيتم إشعارك فور اعتماده.';

  @override
  String get requestSummaryUserInfo => 'معلومات المستخدم';

  @override
  String get requestSummaryUserName => 'اسم المستخدم';

  @override
  String get requestSummaryMemberNumber => 'رقم العضو';

  @override
  String get requestSummaryPhone => 'رقم الهاتف';

  @override
  String get requestSummaryInputType => 'نوع المدخل';

  @override
  String get requestSummaryAmount => 'المبلغ';

  @override
  String get requestSummaryRequestDate => 'تاريخ الطلب';

  @override
  String get requestSummaryCompany => 'الشركة';

  @override
  String get requestSummaryPrice => 'السعر';

  @override
  String get requestSummaryCost => 'التكلفة';

  @override
  String get requestSummaryUnknown => 'غير معروف';

  @override
  String get requestSummaryBack => 'العودة';

  @override
  String get requestSummaryEdit => 'تعديل';

  @override
  String get requestSummaryAddRequest => 'إضافة طلب';

  @override
  String get requestSummaryNoRequests => 'لا توجد طلبات محفوظة';

  @override
  String get requestSummaryAddNewPrompt => 'اضغط الزر لإضافة طلب جديد';

  @override
  String get requestInputTitle => 'طلب مدخل';

  @override
  String get requestInputEditTitle => 'تعديل طلب المدخل';

  @override
  String get requestInputType => 'نوع المدخل';

  @override
  String get requestInputTypeHint => 'أدخل نوع المدخل';

  @override
  String get requestInputTypeError => 'يرجى إدخال نوع المدخل';

  @override
  String get requestInputCompany => 'الشركة';

  @override
  String get requestInputCompanyHint => 'أدخل اسم الشركة';

  @override
  String get requestInputCompanyError => 'يرجى إدخال اسم الشركة';

  @override
  String get requestInputAmount => 'المبلغ';

  @override
  String get requestInputAmountHint => 'أدخل المبلغ';

  @override
  String get requestInputAmountError => 'يرجى إدخال المبلغ';

  @override
  String get requestInputPrice => 'السعر';

  @override
  String get requestInputPriceHint => 'أدخل السعر';

  @override
  String get requestInputPriceError => 'يرجى إدخال السعر';

  @override
  String get requestInputDate => 'التاريخ';

  @override
  String get requestInputDateHint => 'اختر التاريخ';

  @override
  String get requestInputStatus => 'حالة الطلب';

  @override
  String get requestInputStatusHint => 'اختر حالة الطلب';

  @override
  String get requestInputSubmit => 'إرسال الطلب';

  @override
  String get requestInputSaveChanges => 'حفظ التغييرات';

  @override
  String get requestInputSuccess => 'تم إرسال طلبك بنجاح';

  @override
  String get requestInputUpdateSuccess => 'تم تحديث الطلب بنجاح';

  @override
  String requestInputError(Object error) {
    return 'خطأ: $error';
  }

  @override
  String get requestInputFillAll => 'يرجى ملء جميع الحقول';

  @override
  String get businessDashboardTitle => 'لوحة تحكم الأعمال';

  @override
  String get businessDashboardDefaultTitle => 'لوحة تحكم الأعمال';

  @override
  String get businessDashboardLocationUnknown => 'لا يوجد موقع';

  @override
  String get businessDashboardProductType => 'نوع المنتج';

  @override
  String get businessDashboardProductTypeUnknown => 'لا يوجد منتج';

  @override
  String get businessDashboardStartDate => 'تاريخ البدء';

  @override
  String get businessDashboardDateUnknown => 'لا يوجد تاريخ';

  @override
  String get businessDashboardStats => 'إحصائيات الأعمال';

  @override
  String get businessDashboardPurchases => 'المشتريات';

  @override
  String get businessDashboardSales => 'المبيعات';

  @override
  String get businessDashboardExpenses => 'المصروفات';

  @override
  String get businessDashboardProfit => 'الربح';

  @override
  String get businessDashboardActions => 'الإجراءات';

  @override
  String get businessDashboardProfitShare => 'توزيع الأرباح';

  @override
  String get businessDashboardActive => 'نشط';

  @override
  String get businessDashboardInactive => 'غير نشط';

  @override
  String get businessDashboardPending => 'قيد الانتظار';

  @override
  String get businessDashboardStatus => 'الحالة';

  @override
  String businessDashboardError(Object error) {
    return 'خطأ: $error';
  }

  @override
  String get businessListTitle => 'قائمة الأعمال';

  @override
  String businessListCount(Object count) {
    return 'الأعمال $count';
  }

  @override
  String get businessListRefresh => 'تحديث';

  @override
  String get businessListNoBusinesses => 'لا توجد أعمال مسجلة';

  @override
  String get businessListAddPrompt => 'اضغط زر + لإضافة عمل تجاري';

  @override
  String get businessListViewMore => 'عرض المزيد';

  @override
  String get businessListLocationUnknown => 'لا يوجد موقع';

  @override
  String get businessListProductTypeUnknown => 'لا يوجد منتج';

  @override
  String get businessListStatusActive => 'نشط';

  @override
  String get businessListStatusInactive => 'غير نشط';

  @override
  String get businessListStatusPending => 'قيد الانتظار';

  @override
  String get businessListDateUnknown => 'لا يوجد تاريخ';

  @override
  String get businessInformationTitle => 'معلومات العمل التجاري';

  @override
  String get businessInformationName => 'اسم العمل التجاري';

  @override
  String get businessInformationNameHint => 'أدخل اسم العمل التجاري';

  @override
  String get businessInformationNameAbove => 'اسم العمل التجاري:';

  @override
  String get businessInformationNameError => 'يرجى إدخال اسم العمل التجاري';

  @override
  String get businessInformationLocation => 'موقع العمل التجاري';

  @override
  String get businessInformationLocationHint => 'أدخل موقع العمل التجاري';

  @override
  String get businessInformationLocationAbove => 'موقع العمل التجاري:';

  @override
  String get businessInformationLocationError =>
      'يرجى إدخال موقع العمل التجاري';

  @override
  String get businessInformationStartDate => 'تاريخ بدء العمل التجاري';

  @override
  String get businessInformationStartDateHint => 'اختر التاريخ';

  @override
  String get businessInformationStartDateAbove => 'تاريخ البدء:';

  @override
  String get businessInformationProductTypeAbove => 'نوع المنتج:';

  @override
  String get businessInformationProductType => 'نوع المنتج';

  @override
  String get businessInformationProductTypeError => 'يرجى اختيار نوع المنتج';

  @override
  String get businessInformationOtherProductType => 'حدد نوع المنتج';

  @override
  String get businessInformationOtherProductTypeHint => 'أدخل نوع المنتج';

  @override
  String get businessInformationOtherProductTypeAbove => 'حدد نوع المنتج:';

  @override
  String get businessInformationOtherProductTypeError =>
      'يرجى إدخال نوع المنتج';

  @override
  String get businessInformationSave => 'حفظ المعلومات';

  @override
  String get businessInformationSaved => 'تم حفظ معلومات العمل التجاري بنجاح';

  @override
  String get businessSummaryTitle => 'ملخص العمل التجاري';

  @override
  String get businessSummaryNoInfo => 'لا توجد معلومات عن العمل التجاري';

  @override
  String get businessSummaryRegisterPrompt =>
      'يرجى تسجيل عمل تجاري أولاً لرؤية الملخص';

  @override
  String get businessSummaryRegister => 'تسجيل عمل تجاري';

  @override
  String get businessSummaryDone => 'تم';

  @override
  String get businessSummaryInfo => 'معلومات العمل التجاري';

  @override
  String get businessSummaryName => 'اسم العمل التجاري:';

  @override
  String get businessSummaryLocation => 'موقع العمل التجاري:';

  @override
  String get businessSummaryStartDate => 'تاريخ البدء:';

  @override
  String get businessSummaryProductType => 'نوع المنتج:';

  @override
  String get businessSummaryOtherProductType => 'نوع المنتج الآخر:';

  @override
  String get businessSummaryEdit => 'تعديل المعلومات';

  @override
  String get expensesListTitle => 'قائمة المصروفات';

  @override
  String get expensesListNoExpenses => 'لا توجد مصروفات مسجلة';

  @override
  String get expensesListAddPrompt => 'اضغط زر + لإضافة مصروف';

  @override
  String get expensesListAddExpense => 'إضافة مصروف';

  @override
  String expensesListAmount(Object amount) {
    return 'شلن $amount';
  }

  @override
  String expensesListReason(Object reason) {
    return 'السبب: $reason';
  }

  @override
  String expensesListPayer(Object payer) {
    return 'الدافع: $payer';
  }

  @override
  String get expensesListUnknown => 'غير معروف';

  @override
  String get expensesListNoDate => 'لا يوجد تاريخ';

  @override
  String get purchaseListTitle => 'قائمة المشتريات';

  @override
  String get purchaseListNoPurchases => 'لا توجد مشتريات مسجلة';

  @override
  String get purchaseListAddPrompt => 'اضغط زر + لإضافة مشترى';

  @override
  String get purchaseListAddPurchase => 'إضافة مشترى';

  @override
  String purchaseListAmount(Object amount) {
    return 'شلن $amount';
  }

  @override
  String purchaseListBuyer(Object buyer) {
    return 'المشتري: $buyer';
  }

  @override
  String get purchaseListUnknown => 'غير معروف';

  @override
  String get purchaseListNoDate => 'لا يوجد تاريخ';

  @override
  String get saleListTitle => 'قائمة المبيعات';

  @override
  String get saleListNoSales => 'لا توجد مبيعات مسجلة';

  @override
  String get saleListAddPrompt => 'اضغط زر + لإضافة عملية بيع';

  @override
  String get saleListAddSale => 'إضافة عملية بيع';

  @override
  String saleListAmount(Object amount) {
    return 'شلن $amount';
  }

  @override
  String saleListCustomer(Object customer) {
    return 'العميل: $customer';
  }

  @override
  String saleListSeller(Object seller) {
    return 'البائع: $seller';
  }

  @override
  String get saleListUnknown => 'غير معروف';

  @override
  String get saleListNoDate => 'لا يوجد تاريخ';

  @override
  String get expensesTitle => 'تسجيل مصروف';

  @override
  String get expensesBusinessName => 'العمل التجاري';

  @override
  String get expensesBusinessLocationUnknown => 'لا يوجد موقع';

  @override
  String get expensesInfo => 'معلومات المصروف';

  @override
  String get expensesDate => 'التاريخ';

  @override
  String get expensesDateHint => 'يي/شش/سسسس';

  @override
  String get expensesDateError => 'يرجى اختيار تاريخ';

  @override
  String get expensesDateAbove => 'تاريخ المصروف';

  @override
  String get expensesReason => 'سبب المصروف';

  @override
  String get expensesReasonHint => 'أدخل سبب المصروف';

  @override
  String get expensesReasonError => 'يرجى إدخال سبب المصروف';

  @override
  String get expensesReasonAbove => 'سبب المصروف';

  @override
  String get expensesAmount => 'مبلغ المصروف';

  @override
  String get expensesAmountHint => 'أدخل المبلغ بالشلن';

  @override
  String get expensesAmountError => 'يرجى إدخال المبلغ';

  @override
  String get expensesAmountInvalidError => 'يرجى إدخال رقم صحيح';

  @override
  String get expensesAmountAbove => 'المبلغ (شلن)';

  @override
  String get expensesPayer => 'اسم الدافع';

  @override
  String get expensesPayerHint => 'أدخل اسم الدافع';

  @override
  String get expensesPayerError => 'يرجى إدخال اسم الدافع';

  @override
  String get expensesPayerAbove => 'الدافع';

  @override
  String get expensesDescription => 'وصف المصروف';

  @override
  String get expensesDescriptionHint => 'أدخل تفاصيل إضافية للمصروف';

  @override
  String get expensesDescriptionAbove => 'الوصف';

  @override
  String get expensesSave => 'حفظ المعلومات';

  @override
  String get purchasesTitle => 'تسجيل مشترى';

  @override
  String get purchasesBusinessName => 'العمل التجاري';

  @override
  String get purchasesBusinessLocationUnknown => 'لا يوجد موقع';

  @override
  String get purchasesInfo => 'معلومات الشراء';

  @override
  String get purchasesDate => 'التاريخ';

  @override
  String get purchasesDateHint => 'يي/شش/سسسس';

  @override
  String get purchasesDateError => 'يرجى اختيار تاريخ';

  @override
  String get purchasesDateAbove => 'تاريخ الشراء';

  @override
  String get purchasesAmount => 'مبلغ الشراء';

  @override
  String get purchasesAmountHint => 'أدخل المبلغ بالشلن';

  @override
  String get purchasesAmountError => 'يرجى إدخال المبلغ';

  @override
  String get purchasesAmountInvalidError => 'يرجى إدخال رقم صحيح';

  @override
  String get purchasesAmountAbove => 'تكلفة الشراء';

  @override
  String get purchasesBuyer => 'اسم المشتري';

  @override
  String get purchasesBuyerHint => 'أدخل اسم المشتري';

  @override
  String get purchasesBuyerError => 'يرجى إدخال اسم المشتري';

  @override
  String get purchasesBuyerAbove => 'المشتري';

  @override
  String get purchasesDescription => 'وصف الشراء';

  @override
  String get purchasesDescriptionHint => 'أدخل تفاصيل إضافية للشراء';

  @override
  String get purchasesDescriptionAbove => 'الوصف';

  @override
  String get purchasesSave => 'حفظ المعلومات';

  @override
  String get salesTitle => 'تسجيل عملية بيع';

  @override
  String get salesBusinessName => 'العمل التجاري';

  @override
  String get salesBusinessLocationUnknown => 'لا يوجد موقع';

  @override
  String get salesInfo => 'معلومات المبيعات';

  @override
  String get salesDate => 'التاريخ';

  @override
  String get salesDateHint => 'يي/شش/سسسس';

  @override
  String get salesDateError => 'يرجى اختيار تاريخ';

  @override
  String get salesDateAbove => 'تاريخ البيع';

  @override
  String get salesCustomer => 'اسم العميل';

  @override
  String get salesCustomerHint => 'أدخل اسم العميل';

  @override
  String get salesCustomerError => 'يرجى إدخال اسم العميل';

  @override
  String get salesCustomerAbove => 'العميل';

  @override
  String get salesRevenue => 'مبلغ الإيراد';

  @override
  String get salesRevenueHint => 'أدخل المبلغ بالشلن';

  @override
  String get salesRevenueError => 'يرجى إدخال المبلغ';

  @override
  String get salesRevenueInvalidError => 'يرجى إدخال رقم صحيح';

  @override
  String get salesRevenueAbove => 'الإيراد';

  @override
  String get salesSeller => 'اسم البائع';

  @override
  String get salesSellerHint => 'أدخل اسم البائع';

  @override
  String get salesSellerError => 'يرجى إدخال اسم البائع';

  @override
  String get salesSellerAbove => 'البائع';

  @override
  String get salesDescription => 'وصف عملية البيع';

  @override
  String get salesDescriptionHint => 'أدخل تفاصيل إضافية لعملية البيع';

  @override
  String get salesDescriptionAbove => 'الوصف';

  @override
  String get salesSave => 'حفظ المعلومات';

  @override
  String get badiliSarafu => 'تغيير العملة';

  @override
  String get chaguaSarafuYaProgramu => 'اختر عملة التطبيق';

  @override
  String get male => 'ذكر';

  @override
  String get female => 'أنثى';
}
