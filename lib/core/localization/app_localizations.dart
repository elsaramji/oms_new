import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations) ??
        AppLocalizations(const Locale('en'));
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static const List<Locale> supportedLocales = [
    Locale('ar'),
    Locale('en'),
  ];

  bool get isRtl => locale.languageCode == 'ar';

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'appTitle': 'One Medical System - Clinic Portal',
      'login': 'Login',
      'username': 'Username',
      'password': 'Password',
      'doctorAssistant': 'Doctor Assistant',
      'treatingDoctor': 'Treating Doctor',
      'patientIntake': 'Patient Intake',
      'liveQueue': 'Live Consultation Queue',
      'consultation': 'Clinical Consultation',
      'vitals': 'Vital Signs',
      'unverifiedAiDraft':
          'Unverified AI Draft - Requires Doctor Review & Approval',
      'approveAndCommit': 'Approve & Commit',
      'ePrescription': 'E-Prescription',
      'allergies': 'Allergies',
      'chronicConditions': 'Chronic Conditions',
      'searchPatient': 'Search Patient (Phone / National ID)',
      'registerPatient': 'Register New Patient',
      'forwardToQueue': 'Forward to Queue',
      'bmi': 'BMI',
    },
    'ar': {
      'appTitle': 'نظام ون ميديكال - بوابة العيادة',
      'login': 'تسجيل الدخول',
      'username': 'اسم المستخدم',
      'password': 'كلمة المرور',
      'doctorAssistant': 'مساعد الطبيب',
      'treatingDoctor': 'الطبيب المعالج',
      'patientIntake': 'استقبال المرضى',
      'liveQueue': 'طابور الانتظار المباشر',
      'consultation': 'الكشف الطبي',
      'vitals': 'العلامات الحيوية',
      'unverifiedAiDraft':
          'مسودة ذكاء اصطناعي غير معتمدة - تتطلب مراجعة واعتماد الطبيب',
      'approveAndCommit': 'اعتماد وحفظ الكشف',
      'ePrescription': 'الروشتة الإلكترونية',
      'allergies': 'الحساسية والتحذيرات',
      'chronicConditions': 'الأمراض المزمنة',
      'searchPatient': 'بحث عن مريض (الهاتف / الرقم القومي)',
      'registerPatient': 'تسجيل مريض جديد',
      'forwardToQueue': 'تحويل إلى طابور الطبيب',
      'bmi': 'مؤشر كتلة الجسم',
    },
  };

  String translate(String key) {
    return _localizedValues[locale.languageCode]?[key] ??
        _localizedValues['en']?[key] ??
        key;
  }

  String get appTitle => translate('appTitle');
  String get login => translate('login');
  String get username => translate('username');
  String get password => translate('password');
  String get doctorAssistant => translate('doctorAssistant');
  String get treatingDoctor => translate('treatingDoctor');
  String get patientIntake => translate('patientIntake');
  String get liveQueue => translate('liveQueue');
  String get consultation => translate('consultation');
  String get vitals => translate('vitals');
  String get unverifiedAiDraft => translate('unverifiedAiDraft');
  String get approveAndCommit => translate('approveAndCommit');
  String get ePrescription => translate('ePrescription');
  String get allergies => translate('allergies');
  String get chronicConditions => translate('chronicConditions');
  String get searchPatient => translate('searchPatient');
  String get registerPatient => translate('registerPatient');
  String get forwardToQueue => translate('forwardToQueue');
  String get bmi => translate('bmi');
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['ar', 'en'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
