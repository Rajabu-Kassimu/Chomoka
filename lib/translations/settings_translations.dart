class SettingsTranslations {
  static Map<String, Map<String, String>> translations = {
    'Kiswahili': {
      'settings': 'Mipangilio',
      'change_language': 'Badili Lugha',
      'select_program_language': 'Chagua lugha ya programu',
      'reset_password': 'Rekebisha funguo',
      'change_password': 'Badilisha neno lako la siri',
      'reset_cycle': 'Rekebisha mzunguko',
      'reset_cycle_desc':
          'Futa taarifa zote za mzunguko huu kisha anza mzunguko mpya',
      'confirm': 'Thibitisha',
      'confirm_reset':
          'Je, unahitaji kufuta taarifa zote na kuanza mzunguko mpya?',
      'yes': 'Ndio',
      'no': 'Hapana',
      'all_data_cleared': 'Taarifa zote zimefutwa',
      'error_clearing_data': 'Hitilafu imetokea wakati wa kufuta taarifa',
      'about_chomoka': 'Kuhusu chomoka',
      'version': 'Toleo la chapa 1.0.0 \nToleo 4684',
      'agreement': 'Mkataba',
      'terms_conditions': 'Vigezo na masharti',
      'terms_conditions_desc': 'Soma vigezo na masharti ya chomoka',
      'technical_support': 'Msaada wa Kitaalamu',
      'technical_support_desc':
          'Chomoka itajaribu kutuma baadhi ya ili kikundi kipate msaada zaidi wa kitalaamu',
    },
    'English': {
      'settings': 'Settings',
      'change_language': 'Change Language',
      'select_program_language': 'Select program language',
      'reset_password': 'Reset Password',
      'change_password': 'Change your password',
      'reset_cycle': 'Reset Cycle',
      'reset_cycle_desc':
          'Delete all information from this cycle and start a new cycle',
      'confirm': 'Confirm',
      'confirm_reset':
          'Do you want to delete all information and start a new cycle?',
      'yes': 'Yes',
      'no': 'No',
      'all_data_cleared': 'All data has been cleared',
      'error_clearing_data': 'An error occurred while clearing data',
      'about_chomoka': 'About Chomoka',
      'version': 'Version 1.0.0 \nBuild 4684',
      'agreement': 'Agreement',
      'terms_conditions': 'Terms and Conditions',
      'terms_conditions_desc': 'Read Chomoka\'s terms and conditions',
      'technical_support': 'Technical Support',
      'technical_support_desc':
          'Chomoka will try to send some to get additional technical support for the group',
    },
    'Français': {
      'settings': 'Paramètres',
      'change_language': 'Changer de langue',
      'select_program_language': 'Sélectionner la langue du programme',
      'reset_password': 'Réinitialiser le mot de passe',
      'change_password': 'Modifier votre mot de passe',
      'reset_cycle': 'Réinitialiser le cycle',
      'reset_cycle_desc':
          'Supprimer toutes les informations de ce cycle et commencer un nouveau cycle',
      'confirm': 'Confirmer',
      'confirm_reset':
          'Voulez-vous supprimer toutes les informations et commencer un nouveau cycle ?',
      'yes': 'Oui',
      'no': 'Non',
      'all_data_cleared': 'Toutes les données ont été effacées',
      'error_clearing_data':
          'Une erreur s\'est produite lors de l\'effacement des données',
      'about_chomoka': 'À propos de Chomoka',
      'version': 'Version 1.0.0 \nBuild 4684',
      'agreement': 'Accord',
      'terms_conditions': 'Conditions générales',
      'terms_conditions_desc': 'Lire les conditions générales de Chomoka',
      'technical_support': 'Support technique',
      'technical_support_desc':
          'Chomoka essaiera d\'envoyer certains pour obtenir un support technique supplémentaire pour le groupe',
    },
  };

  static String getText(String language, String key) {
    return translations[language]?[key] ?? translations['English']![key]!;
  }
}
