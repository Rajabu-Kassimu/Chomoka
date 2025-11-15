// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get selectCountry => 'Sélectionnez le pays';

  @override
  String get pleaseSelectCountry => 'Veuillez sélectionner votre pays';

  @override
  String get pleaseSelectCountryError =>
      'Veuillez sélectionner un pays avant de continuer.';

  @override
  String get locationInformation => 'Informations de localisation';

  @override
  String get selectLanguage => 'Sélectionnez la langue';

  @override
  String get pleaseSelectLanguage => 'Veuillez sélectionner une langue';

  @override
  String get selectRegion => 'Sélectionnez la région';

  @override
  String get pleaseSelectRegion => 'Veuillez sélectionner une région';

  @override
  String get loan_based_on_shares =>
      'Indiquez combien de fois (x) un membre peut emprunter selon ses parts';

  @override
  String get loan_based_on_savings =>
      'Indiquez combien de fois (x) un membre peut emprunter selon son épargne';

  @override
  String get selectDistrict => 'Sélectionnez le district';

  @override
  String get pleaseSelectDistrict => 'Veuillez sélectionner un district';

  @override
  String get selectWard => 'Sélectionnez le quartier';

  @override
  String get pleaseSelectWard => 'Veuillez sélectionner un quartier';

  @override
  String get enterStreetOrVillage => 'Entrez la rue ou le village';

  @override
  String get pleaseEnterStreetOrVillage =>
      'Veuillez entrer le nom de la rue ou du village';

  @override
  String get dataSavedSuccessfully => 'Données enregistrées avec succès';

  @override
  String errorSavingData(String error) {
    return 'Erreur lors de l\'enregistrement des données : $error';
  }

  @override
  String get permissions => 'Autorisations';

  @override
  String get permissionsDescription =>
      'Chomoka nécessite plusieurs autorisations pour fonctionner correctement et efficacement.';

  @override
  String get permissionsRequest =>
      'Veuillez accepter toutes les demandes d\'autorisation pour continuer à utiliser Chomoka facilement.';

  @override
  String get smsPermission => 'SMS';

  @override
  String get smsDescription =>
      'Chomoka utilise les SMS comme sauvegarde pour stocker des informations en cas d\'absence d\'internet.';

  @override
  String get locationPermission => 'Votre localisation';

  @override
  String get locationDescription =>
      'Pour améliorer l\'efficacité du système, CHOMOKA utilisera vos informations de localisation.';

  @override
  String get mediaPermission => 'Photos et documents';

  @override
  String get mediaDescription =>
      'Vous pouvez enregistrer des photos, des informations et des documents pour vérification.';

  @override
  String get termsAndConditions => 'Termes et conditions';

  @override
  String get aboutChomoka => 'À propos de Chomoka';

  @override
  String get aboutChomokaContent =>
      'Pour utiliser Chomoka, vous devez accepter les termes et conditions ainsi que la politique de confidentialité.';

  @override
  String get dataManagement => 'Gestion des données';

  @override
  String get dataManagementContent =>
      'En utilisant Chomoka, vous acceptez la collecte et le stockage de vos données. Le système peut utiliser vos informations de localisation et envoyer des messages depuis votre téléphone.';

  @override
  String get namedData => 'Données nommées';

  @override
  String get namedDataContent =>
      'Les informations du groupe et des membres seront conservées à des fins d\'enregistrement. Nous ne partagerons pas ces informations sans l\'autorisation du groupe.';

  @override
  String get generalData => 'Données générales';

  @override
  String get generalDataContent =>
      'Nous utiliserons des données générales sans mentionner les noms des membres ou des groupes pour mieux comprendre les évolutions.';

  @override
  String get acceptTerms => 'J\'accepte les termes et conditions';

  @override
  String get confirm => 'Confirmer';

  @override
  String get setupChomoka => 'Configurer Chomoka';

  @override
  String get groupInfo => 'Informations sur le groupe';

  @override
  String get memberInfo => 'Informations sur le membre';

  @override
  String get constitutionInfo => 'Informations sur la constitution';

  @override
  String get fundInfo => 'Informations sur le fonds';

  @override
  String get passwordSetup => 'Configuration du mot de passe';

  @override
  String get passwordSetupComplete =>
      'Configuration du mot de passe terminée !';

  @override
  String get finished => 'Terminé';

  @override
  String get groupInformation => 'Entrez les informations du groupe';

  @override
  String get editGroupInformation => 'Modifier les informations du groupe';

  @override
  String get groupName => 'Nom du groupe';

  @override
  String get enterGroupName => 'Entrez le nom du groupe';

  @override
  String get groupNameRequired => 'Le nom du groupe est requis !';

  @override
  String get yearEstablished => 'Année de création';

  @override
  String get enterYearEstablished => 'Entrez l\'année de création';

  @override
  String get yearEstablishedRequired => 'L\'année de création est requise !';

  @override
  String get enterValidYear => 'Veuillez entrer une année valide !';

  @override
  String enterYearRange(Object currentYear) {
    return 'Veuillez entrer une année entre 1999 et $currentYear !';
  }

  @override
  String get currentRound => 'À quel cycle en est le groupe';

  @override
  String get enterCurrentRound => 'Entrez le cycle actuel du groupe';

  @override
  String get currentRoundRequired => 'Le cycle du groupe est requis !';

  @override
  String get enterValidRound =>
      'Veuillez entrer un numéro valide pour le cycle !';

  @override
  String get update => 'Mettre à jour';

  @override
  String errorUpdatingData(Object error) {
    return 'Erreur lors de la mise à jour des données : $error';
  }

  @override
  String get groupSummary => 'Résumé du groupe';

  @override
  String get sessionSummary => 'Résumé des sessions';

  @override
  String get meetingFrequency => 'À quelle fréquence vous réunissez-vous ?';

  @override
  String get pleaseSelectFrequency =>
      'Veuillez sélectionner la fréquence des réunions !';

  @override
  String get sessionCount => 'Nombre de sessions dans un cycle :';

  @override
  String get enterSessionCount => 'Entrez le nombre de sessions';

  @override
  String get sessionCountRequired => 'Veuillez entrer le nombre de sessions';

  @override
  String get enterValidSessionCount =>
      'Veuillez entrer un nombre valide de sessions';

  @override
  String get pleaseNote => 'Veuillez noter :';

  @override
  String allocationDescription(String allocationDescription) {
    return 'L\'allocation se fait tous les $allocationDescription';
  }

  @override
  String errorOccurred(Object error) {
    return 'Une erreur est survenue : $error';
  }

  @override
  String get groupRegistration => 'Enregistrement du groupe';

  @override
  String get fines => 'Amendes';

  @override
  String get lateness => 'Arrivée tardive';

  @override
  String get absentWithoutPermission => 'Absence sans autorisation';

  @override
  String get sendingRepresentative => 'Envoi d\'un représentant';

  @override
  String get speakingWithoutPermission => 'Parler sans permission';

  @override
  String get phoneUsageDuringMeeting =>
      'Utilisation du téléphone pendant la réunion';

  @override
  String get leadershipMisconduct => 'Mauvais comportement des dirigeants';

  @override
  String get forgettingRules => 'Oubli des règles';

  @override
  String get addNewFine => 'Ajouter une nouvelle amende';

  @override
  String get finesWithoutAmountWontShow =>
      'Les amendes sans montant ne s\'afficheront pas pendant les réunions';

  @override
  String get fineType => 'Type d\'amende';

  @override
  String get addFineType => 'Ajouter un type d\'amende';

  @override
  String get amount => 'Montant';

  @override
  String get percentage => 'Pourcentage';

  @override
  String get memberShareTitle => 'Parts des membres';

  @override
  String get shareCount => 'Nombre de parts';

  @override
  String get saveButton => 'Enregistrer';

  @override
  String get unnamed => 'Sans nom';

  @override
  String get noPhone => 'Pas de numéro';

  @override
  String errorLoadingData(Object error) {
    return 'Erreur lors du chargement des données. Veuillez réessayer.';
  }

  @override
  String failedToUpdateStatus(Object error) {
    return 'Échec de la mise à jour du statut : $error';
  }

  @override
  String get fixedAmount => 'Montant fixe';

  @override
  String get enterPenaltyPercentage => 'Entrez le pourcentage de pénalité';

  @override
  String get percentageRequired => 'Le pourcentage est requis';

  @override
  String get enterValidPercentage => 'Veuillez entrer un pourcentage valide';

  @override
  String get enterFixedAmount => 'Entrez le montant fixe';

  @override
  String get fixedAmountRequired => 'Le montant fixe est requis';

  @override
  String get enterValidAmount => 'Veuillez entrer un montant valide !';

  @override
  String get explainPenaltyUsage =>
      'Expliquez comment les pénalités sont utilisées pour les prêts lorsqu\'un membre ne respecte pas les paiements requis à temps.';

  @override
  String get loanDelayPenalty => 'Pénalité de retard de prêt';

  @override
  String get noPercentagePenalty =>
      'Aucune pénalité en pourcentage ne sera facturée pour les retards de prêt.';

  @override
  String percentagePenaltyExample(String percentage, String amount) {
    return 'Par exemple, si un membre retarde le remboursement de son prêt, il paiera $percentage% de plus chaque mois sur le montant restant. S\'il emprunte 10 000, il devra payer des frais de retard de $amount par mois.';
  }

  @override
  String get noFixedAmountPenalty =>
      'Aucune pénalité à montant fixe ne sera facturée pour les retards de prêt.';

  @override
  String fixedAmountPenaltyExample(String amount) {
    return 'Par exemple, si un membre retarde le remboursement de son prêt, il paiera $amount comme pénalité fixe de retard.';
  }

  @override
  String get addAmount => 'Ajouter un montant';

  @override
  String get cancel => 'Annuler';

  @override
  String get save => 'Enregistrer';

  @override
  String get continue_ => 'Continuer';

  @override
  String get editRegistration => 'Modifier l\'enregistrement';

  @override
  String get registrationStatus => 'Statut de l\'enregistrement';

  @override
  String get selectRegistrationStatus =>
      'Sélectionnez le statut d\'enregistrement';

  @override
  String get pleaseSelectRegistrationStatus =>
      'Veuillez sélectionner le statut d\'enregistrement';

  @override
  String get appVersionName => 'Version Chapati 1.0.0';

  @override
  String get appVersionNumber => 'Version 0001';

  @override
  String get open => 'Ouvrir';

  @override
  String get demo => 'Démo';

  @override
  String get exercise => 'Exercice';

  @override
  String get registrationNumber => 'Numéro d\'enregistrement';

  @override
  String get enterRegistrationNumber => 'Entrez le numéro d\'enregistrement';

  @override
  String get pleaseEnterRegistrationNumber =>
      'Veuillez entrer le numéro d\'enregistrement';

  @override
  String get correct => 'Correct';

  @override
  String get groupInstitution => 'Institution du groupe';

  @override
  String get editInstitution => 'Modifier l\'institution du groupe';

  @override
  String get selectOrganization => 'Sélectionnez l\'organisation';

  @override
  String get pleaseSelectOrganization =>
      'Veuillez sélectionner une organisation';

  @override
  String get enterOrganizationName => 'Entrez le nom de l\'organisation';

  @override
  String get organizationNameRequired =>
      'Le nom de l\'organisation est requis !';

  @override
  String get selectProject => 'Sélectionnez le projet';

  @override
  String get pleaseSelectProject => 'Veuillez sélectionner un projet';

  @override
  String get enterProjectName => 'Entrez le nom du projet';

  @override
  String get projectNameRequired => 'Le nom du projet est requis !';

  @override
  String get enterTeacherId => 'Entrez l\'identifiant de l\'enseignant';

  @override
  String get teacherIdRequired =>
      'L\'identifiant de l\'enseignant est requis !';

  @override
  String get continueText => 'Continuer';

  @override
  String get selectKeyToReset => 'Sélectionnez la clé à réinitialiser';

  @override
  String get keyHolderSecretQuestion =>
      'Le membre titulaire de la clé sélectionnée devra répondre à une question secrète lors de la configuration de la clé';

  @override
  String get resetKey1 => 'Réinitialiser la clé 1';

  @override
  String get resetKey2 => 'Réinitialiser la clé 2';

  @override
  String get resetKey3 => 'Réinitialiser la clé 3';

  @override
  String get selectQuestion => 'Sélectionnez une question';

  @override
  String get answerToQuestion => 'Réponse à la question';

  @override
  String get enterAnswer => 'Entrez la réponse à la question';

  @override
  String get incorrectQuestionOrAnswer =>
      'La question ou la réponse est incorrecte';

  @override
  String get pleaseSelectQuestionAndAnswer =>
      'Veuillez sélectionner une question et y répondre';

  @override
  String get passwordsDoNotMatchTryAgain =>
      'Les mots de passe ne correspondent pas, veuillez réessayer';

  @override
  String get confirmPasswordTitle => 'Confirmer le mot de passe pour';

  @override
  String get groupOverview => 'Vue d\'ensemble du groupe';

  @override
  String get fundOverview => 'Vue d\'ensemble du fonds';

  @override
  String get meetingSummary => 'Résumé de la réunion';

  @override
  String get allocation => 'Allocation';

  @override
  String get registration => 'Enregistrement du groupe';

  @override
  String get registrationType => 'Type d\'enregistrement';

  @override
  String get institutionalInfo => 'Informations institutionnelles';

  @override
  String get institutionName => 'Nom de l\'institution';

  @override
  String get projectName => 'Nom du projet';

  @override
  String get teacherId => 'Identifiant de l\'enseignant';

  @override
  String get location => 'Emplacement';

  @override
  String get loanGuarantors => 'Garants du prêt';

  @override
  String get doesLoanNeedGuarantor => 'Le prêt nécessite-t-il un garant ?';

  @override
  String get numberOfGuarantors => 'Nombre de garants';

  @override
  String get enterNumberOfGuarantors => 'Entrez le nombre de garants';

  @override
  String get numberOfGuarantorsRequired => 'Le nombre de garants est requis';

  @override
  String get securityQuestion1 =>
      'En quelle année est né votre premier enfant ?';

  @override
  String get securityQuestion2 =>
      'Quel est le prénom de votre premier enfant ?';

  @override
  String get securityQuestion3 => 'Quelle est votre année de naissance ?';

  @override
  String get errorSelectQuestion =>
      'Veuillez sélectionner une question de sécurité.';

  @override
  String get errorEnterAnswer => 'Veuillez remplir la réponse à la question.';

  @override
  String get errorSaving =>
      'Un problème est survenu lors de l\'enregistrement. Veuillez réessayer.';

  @override
  String resetQuestionPageTitle(int passwordNumber) {
    return 'Question de sécurité pour la clé $passwordNumber';
  }

  @override
  String get selectQuestionLabel => 'Sélectionnez une question';

  @override
  String get selectQuestionHint => 'Sélectionnez une question';

  @override
  String get answerLabel => 'Réponse';

  @override
  String get answerHint => 'Entrez la réponse';

  @override
  String get pleaseEnterValidNumber => 'Veuillez entrer un nombre valide';

  @override
  String get describeNumberOfGuarantors =>
      'Décrivez le nombre de garants requis pour demander un prêt';

  @override
  String get country => 'Pays';

  @override
  String get region => 'Région';

  @override
  String get district => 'District';

  @override
  String get ward => 'Quartier';

  @override
  String get streetOrVillage => 'Rue ou village';

  @override
  String get sendSummary => 'ENVOYER LE RÉSUMÉ';

  @override
  String get completed => 'Terminé';

  @override
  String members(Object count) {
    return 'Membres : $count';
  }

  @override
  String get noMembers => 'Aucun membre disponible.';

  @override
  String errorFetchingMembers(Object error) {
    return 'Erreur lors de la récupération des membres : $error';
  }

  @override
  String get memberSummary => 'Résumé des membres';

  @override
  String get memberIdentity => 'Identité du membre';

  @override
  String get fullName => 'Nom complet :';

  @override
  String get memberNumber => 'Numéro du membre';

  @override
  String get gender => 'Genre :';

  @override
  String get dob => 'Date de naissance :';

  @override
  String get phoneNumber => 'Numéro de téléphone :';

  @override
  String get job => 'Profession :';

  @override
  String get idType => 'Type de pièce d\'identité :';

  @override
  String get idNumber => 'Numéro de pièce d\'identité :';

  @override
  String get noPhoneNumber => 'Le membre n\'a pas de numéro de téléphone';

  @override
  String summarySent(Object name) {
    return 'Résumé envoyé avec succès à $name';
  }

  @override
  String failedToSendSms(Object name) {
    return 'Échec de l\'envoi à $name';
  }

  @override
  String get totalSavings => 'Épargne totale';

  @override
  String get totalDebt => 'Dette totale';

  @override
  String get totalShares => 'Parts totales';

  @override
  String get communityFundBalance => 'Solde du fonds communautaire';

  @override
  String get currentLoans => 'Prêts en cours';

  @override
  String get totalFinesCollected => 'Total des amendes collectées';

  @override
  String get confirmDeleteUser =>
      'Êtes-vous sûr de vouloir supprimer cet utilisateur ?';

  @override
  String get delete => 'Supprimer';

  @override
  String get enterMemberNumber => 'Entrez le numéro de membre';

  @override
  String get memberNumberRequired => 'Veuillez entrer le numéro de membre';

  @override
  String get memberNumberDigitsOnly =>
      'Le numéro de membre ne doit contenir que des chiffres';

  @override
  String get enterFullName => 'Entrez le nom complet';

  @override
  String get fullNameRequired => 'Veuillez entrer le nom complet du membre';

  @override
  String get fullNameMinLength => 'Le nom doit comporter au moins 3 caractères';

  @override
  String get selectYear => 'Sélectionnez l\'année';

  @override
  String get selectMonth => 'Sélectionnez le mois';

  @override
  String get selectDay => 'Sélectionnez le jour';

  @override
  String get dobRequired =>
      'Veuillez sélectionner la date complète de naissance';

  @override
  String get uniqueMemberNumber => 'Le numéro de membre doit être unique';

  @override
  String get noActiveCycle => 'Erreur : aucun cycle actif trouvé !';

  @override
  String get appTagline => 'Nous vous aidons à renforcer le développement';

  @override
  String get example => 'Exemple';

  @override
  String get mzungukoPendingNoNew =>
      'Le cycle actuel est déjà « en attente ». Aucun nouveau cycle n\'a été démarré.';

  @override
  String get newMzungukoCreated => 'Nouveau cycle démarré avec succès !';

  @override
  String errorSavingMzunguko(String error) {
    return 'Erreur lors de l\'enregistrement ou de la mise à jour du cycle : $error';
  }

  @override
  String get weekly => 'Hebdomadaire';

  @override
  String get biWeekly => 'Toutes les deux semaines';

  @override
  String get monthly => 'Mensuel';

  @override
  String years(int count) {
    return '$count ans';
  }

  @override
  String months(int count) {
    return 'mois';
  }

  @override
  String weeks(int count) {
    return '$count semaines';
  }

  @override
  String get registered => 'Enregistré';

  @override
  String get notRegistered => 'Non enregistré';

  @override
  String get other => 'Autre';

  @override
  String get memberPhoneNumber => 'Numéro de téléphone du membre';

  @override
  String get enterMemberPhoneNumber =>
      'Entrez le numéro de téléphone du membre';

  @override
  String get selectJob => 'Sélectionnez le métier';

  @override
  String get enterJobName => 'Entrez le nom du métier';

  @override
  String get pleaseSelectJob => 'Veuillez sélectionner un métier';

  @override
  String get pleaseEnterJobName => 'Veuillez entrer le nom du métier';

  @override
  String get selectIdType => 'Sélectionnez le type de pièce';

  @override
  String get enterIdNumber => 'Entrez le numéro de la pièce';

  @override
  String get pleaseSelectIdType => 'Veuillez sélectionner le type de pièce';

  @override
  String get pleaseEnterIdNumber => 'Veuillez entrer le numéro de la pièce';

  @override
  String get idPhoto => 'Photo de la pièce d\'identité';

  @override
  String get removePhoto => 'Supprimer la photo';

  @override
  String get takePhoto => 'Prendre une photo';

  @override
  String get chooseFromGallery => 'Choisir dans la galerie';

  @override
  String get farmer => 'Agriculteur';

  @override
  String get teacher => 'Enseignant';

  @override
  String get doctor => 'Médecin';

  @override
  String get entrepreneur => 'Entrepreneur';

  @override
  String get engineer => 'Ingénieur';

  @override
  String get lawyer => 'Avocat';

  @override
  String get none => 'Aucun';

  @override
  String get voterCard => 'Carte d\'électeur';

  @override
  String get nationalId => 'Carte d\'identité nationale';

  @override
  String get zanzibarResidentCard => 'Carte de résident de Zanzibar';

  @override
  String get driversLicense => 'Permis de conduire';

  @override
  String get localGovernmentLetter => 'Lettre du gouvernement local';

  @override
  String get errorSavingPhoto =>
      'Échec de l\'enregistrement de la photo du membre';

  @override
  String get errorRemovingPhoto => 'Échec de la suppression de la photo';

  @override
  String get errorLoadingPhoto => 'Échec du chargement de la photo du membre';

  @override
  String get memberInformation => 'Informations sur le membre';

  @override
  String get memberIdentification => 'Identification du membre';

  @override
  String get dateOfBirth => 'Date de naissance';

  @override
  String get occupation => 'Profession';

  @override
  String get mandatorySavings => 'Épargne obligatoire';

  @override
  String get voluntarySavings => 'Épargne volontaire';

  @override
  String get communityFund => 'Fonds communautaire';

  @override
  String get currentLoan => 'Prêt en cours';

  @override
  String get finish => 'Terminer';

  @override
  String get enterKey1 => 'Entrez la clé 1';

  @override
  String get enterKey2 => 'Entrez la clé 2';

  @override
  String get enterKey3 => 'Entrez la clé 3';

  @override
  String get enterAllKeys => 'Veuillez remplir les trois clés.';

  @override
  String get invalidKeys =>
      'Les clés secrètes sont incorrectes. Veuillez réessayer.';

  @override
  String get systemError =>
      'Un problème est survenu. Veuillez réessayer plus tard.';

  @override
  String get resetSecurityKeys => 'RÉINITIALISER LES CLÉS DE SÉCURITÉ';

  @override
  String get openButton => 'OUVRIR';

  @override
  String get pleaseEnterNewPassword =>
      'Veuillez entrer un nouveau mot de passe';

  @override
  String get passwordMustBeDigitsOnly =>
      'Le mot de passe doit contenir uniquement des chiffres';

  @override
  String get passwordMustBeLessThan4Digits =>
      'Le mot de passe doit contenir moins de 4 chiffres';

  @override
  String get pleaseConfirmNewPassword =>
      'Veuillez confirmer le nouveau mot de passe';

  @override
  String get passwordsDoNotMatch => 'Les mots de passe ne correspondent pas';

  @override
  String get errorOccurredTryAgain =>
      'Une erreur est survenue. Veuillez réessayer.';

  @override
  String editPasswordFor(String key) {
    return 'Modifier le mot de passe pour $key';
  }

  @override
  String get newPassword => 'Nouveau mot de passe';

  @override
  String get confirmNewPassword => 'Confirmez le nouveau mot de passe';

  @override
  String get enterNewPassword => 'Entrez le nouveau mot de passe';

  @override
  String get getHelp => 'Obtenir de l\'aide';

  @override
  String get welcomeChomokaPlus => 'Bienvenue sur Chomoka Plus';

  @override
  String groupOf(Object groupName) {
    return 'Groupe de : $groupName';
  }

  @override
  String get dashboardHelpText =>
      'Nous vous aidons à conserver efficacement les enregistrements de votre groupe.';

  @override
  String get groupServices => 'Services du groupe';

  @override
  String get startMeeting => 'Démarrer la réunion';

  @override
  String get continueExistingMeeting => 'Continuer une réunion existante';

  @override
  String get openNewMeeting => 'Ouvrir une nouvelle réunion de groupe';

  @override
  String get group => 'GROUPE';

  @override
  String get constitution => 'Constitution';

  @override
  String get shareCalculation => 'Calcul des parts';

  @override
  String get systemFeedback => 'Retour du système';

  @override
  String get groupActivities => 'Activités du groupe';

  @override
  String get moreServices => 'Plus de services';

  @override
  String get history => 'Historique';

  @override
  String get viewGroupHistory => 'Voir l\'historique des activités du groupe';

  @override
  String get backupRestore => 'Sauvegarde et restauration';

  @override
  String get backupRestoreDesc =>
      'Sauvegardez et restaurez les enregistrements du groupe';

  @override
  String get chomokaPlusVersion => 'Chomoka Plus v2.0';

  @override
  String get finishShare => 'Terminer le partage';

  @override
  String get finishShareDesc =>
      'Le dernier cycle est terminé. Veuillez finaliser le partage.';

  @override
  String get ok => 'OK';

  @override
  String get meetingOptionsWelcome => 'Bienvenue à une autre réunion';

  @override
  String get midCycleInfo => 'Informations à mi-cycle';

  @override
  String get openMeetingButton => 'OUVRIR LA RÉUNION';

  @override
  String get startNewCycleQuestion => 'Commencez-vous un nouveau cycle ?';

  @override
  String get pressYesToStartFirstMeeting =>
      'APPUYEZ SUR OUI POUR EFFECTUER LA PREMIÈRE RÉUNION';

  @override
  String get pressNoForPastMeetings =>
      'APPUYEZ SUR NON POUR ENREGISTRER LES RÉUNIONS PASSÉES';

  @override
  String get getHelpTitle => 'Obtenir de l\'aide';

  @override
  String get needHelpContact => 'Besoin d\'aide ? Contactez-nous via :';

  @override
  String get call => 'Appel';

  @override
  String get whatsapp => 'WhatsApp';

  @override
  String get email => 'Email';

  @override
  String get faq => 'FAQ';

  @override
  String get close => 'Fermer';

  @override
  String get failedToOpenPhone => 'Échec de l\'ouverture du téléphone.';

  @override
  String get failedToOpenWhatsApp =>
      'WhatsApp n\'est pas disponible sur votre téléphone.';

  @override
  String get failedToOpenWhatsAppGeneric =>
      'Échec de l\'ouverture de WhatsApp.';

  @override
  String get failedToOpenEmail => 'Échec de l\'ouverture de l\'email.';

  @override
  String get constitutionAppTitle => 'Informations sur la constitution';

  @override
  String get constitutionGroupType => 'Type de groupe';

  @override
  String get kayaCmg => 'Kaya CMG';

  @override
  String get kayaCmgHint =>
      'Nous utilisons l\'épargne obligatoire et volontaire pour prêter';

  @override
  String get vsla => 'VSLA';

  @override
  String get vslaHint =>
      'Nous utilisons des parts pour épargner et avons 5 dirigeants';

  @override
  String get shareSubtitle => 'Parts';

  @override
  String get sharePrompt => 'Quelle est la valeur d\'une part en shillings ?';

  @override
  String get shareValueLabel => 'Valeur d\'une part';

  @override
  String get shareValueHint => 'Entrez la valeur d\'une part';

  @override
  String get shareValueRequired => 'La valeur de la part est requise';

  @override
  String get invalidShareValue => 'Veuillez entrer un montant valide';

  @override
  String get groupLeadersSubtitle => 'Dirigeants du groupe';

  @override
  String get editButton => 'Modifier';

  @override
  String get selectAllLeadersError =>
      'Veuillez sélectionner tous les dirigeants';

  @override
  String positionLabel(Object position) {
    return '$position';
  }

  @override
  String selectPositionHint(Object position) {
    return 'Sélectionnez $position';
  }

  @override
  String positionRequired(Object position) {
    return 'Veuillez sélectionner $position';
  }

  @override
  String get jumlaYaHisa => 'Total des parts';

  @override
  String get mfukoWaJamiiSalio => 'Solde du fonds communautaire';

  @override
  String get salioLililolalaSandukuni => 'Solde de la caisse';

  @override
  String get failedToLoadSummaryData =>
      'Échec du chargement des données de synthèse. Veuillez réessayer.';

  @override
  String get jumlaYa => 'Total de';

  @override
  String get wekaJumlaYa => 'Entrez le total de';

  @override
  String get tafadhaliJazaJumlaYa => 'Veuillez remplir le total de';

  @override
  String get tafadhaliIngizaNambariHalali =>
      'Veuillez entrer un nombre valide.';

  @override
  String get jumlaLazimaIweIsiyoHasi => 'Le total doit être un nombre positif.';

  @override
  String get loadingData => 'Chargement des données…';

  @override
  String get taarifaKatikatiYaMzunguko => 'Informations à mi-cycle';

  @override
  String get jumlaZaKikundi => 'Totaux du groupe';

  @override
  String get chairperson => 'Président';

  @override
  String get secretary => 'Secrétaire';

  @override
  String get treasurer => 'Trésorier';

  @override
  String get counter1 => 'Comptable numéro 1';

  @override
  String get counter2 => 'Comptable numéro 2';

  @override
  String get finesTitle => 'Informations sur la constitution';

  @override
  String get finesSubtitle => 'Amendes';

  @override
  String get finesEmptyAmountNote =>
      'Les amendes sans montant n\'apparaîtront pas pendant la réunion';

  @override
  String get enterFineType => 'Entrez le type d\'amende';

  @override
  String get enterAmount => 'Entrez le montant';

  @override
  String get phoneUseInMeeting => 'Utilisation du téléphone pendant la réunion';

  @override
  String get amountPlaceholder => 'montant';

  @override
  String get loanAmountTitle => 'Informations sur la constitution';

  @override
  String get loanAmountSubtitle => 'Montant que peut emprunter un membre';

  @override
  String get loanAmountVSLAPrompt =>
      'Combien de fois un membre peut-il emprunter en fonction de ses parts actuelles ?';

  @override
  String get loanAmountCMGPrompt =>
      'Combien de fois un membre peut-il emprunter selon ses économies actuelles ?';

  @override
  String get loanAmountVSLAHint => 'Défini selon leurs parts actuelles';

  @override
  String get loanAmountCMGHint => 'Défini selon leurs économies actuelles';

  @override
  String get loanAmountRequired =>
      'Veuillez entrer une valeur valide (numérique) !';

  @override
  String get loanAmountInvalidNumber => 'Veuillez entrer un nombre valide !';

  @override
  String get loanAmountMustBePositive =>
      'La valeur doit être supérieure à zéro !';

  @override
  String loanAmountExample(String amount, String type, String multiplier) {
    return 'Par exemple, un membre peut emprunter $amount s\'il possède $type d\'une valeur de 10 000, soit $multiplier fois leur $type.';
  }

  @override
  String get interestDescription =>
      'Décrivez comment les frais de service s\'appliquent à vos prêts';

  @override
  String get yes => 'Oui';

  @override
  String get no => 'Non';

  @override
  String get selectFund => 'Sélectionnez un fonds';

  @override
  String get fundWithoutName => 'Fonds sans nom';

  @override
  String get addAnotherFund => 'Ajouter un autre fonds';

  @override
  String get communityFundInfo => 'Informations sur le fonds communautaire';

  @override
  String get fundName => 'Nom du fonds';

  @override
  String get enterFundName => 'Entrez le nom du fonds';

  @override
  String get fundNameRequired => 'Le nom du fonds est requis !';

  @override
  String get contributionAmount => 'Montant de la contribution';

  @override
  String get enterContributionAmount => 'Entrez le montant de la contribution';

  @override
  String get contributionAmountRequired =>
      'Le montant de la contribution est requis !';

  @override
  String get edit => 'Modifier';

  @override
  String get withdrawalReasons => 'Motifs de retrait';

  @override
  String get noReasonsRecorded => 'Aucun motif enregistré';

  @override
  String get equalAmount => 'Montant égal';

  @override
  String get anyAmount => 'N\'importe quel montant';

  @override
  String get notWithdrawableMidCycle => 'Non retirable en milieu de cycle';

  @override
  String get withdrawByMemberName => 'Retirer par nom de membre';

  @override
  String get withdrawAsGroup => 'Retirer en tant que groupe';

  @override
  String get select => 'Sélectionner';

  @override
  String get education => 'Éducation';

  @override
  String get agriculture => 'Agriculture';

  @override
  String get communityProject => 'Projet communautaire';

  @override
  String get cocoa => 'Cacao';

  @override
  String get otherGoals => 'Autres objectifs';

  @override
  String get pleaseSelectContributionProcedure =>
      'Veuillez sélectionner la procédure de contribution';

  @override
  String get pleaseSelectWithdrawalProcedure =>
      'Veuillez sélectionner la procédure de retrait';

  @override
  String get dataUpdatedSuccessfully => 'Données mises à jour avec succès !';

  @override
  String get errorSavingDataGeneric =>
      'Erreur lors de l\'enregistrement des données. Veuillez réessayer.';

  @override
  String get fundInformation => 'Fund Information';

  @override
  String get fundProcedures => 'Procédures de fonds';

  @override
  String get pleaseEnterFundName => 'Veuillez entrer le nom du fonds';

  @override
  String get fundGoals => 'Objectifs du fonds';

  @override
  String get pleaseSelectFundGoal =>
      'Veuillez sélectionner un objectif du fonds';

  @override
  String get enterOtherGoals => 'Entrez d\'autres objectifs';

  @override
  String get pleaseEnterOtherGoals => 'Veuillez entrer d\'autres objectifs';

  @override
  String get contributionProcedure => 'Procédure de contribution';

  @override
  String get pleaseEnterContributionAmount =>
      'Veuillez entrer le montant de la contribution';

  @override
  String get loanable => 'Prêtable';

  @override
  String get withdrawalProcedures => 'Procédures de retrait';

  @override
  String get fundProcedure => 'Procédure du fonds';

  @override
  String get withdrawalProcedure => 'Procédure de retrait';

  @override
  String get notWithdrawableDuringCycle => 'Non retirable pendant le cycle';

  @override
  String get selectOption => 'Select';

  @override
  String get fundSummarySubtitle => 'Résumé du fonds';

  @override
  String get withdrawalType => 'Type de contribution';

  @override
  String get deleteFundTitle => 'Supprimer le fonds ?';

  @override
  String get thisFund => 'Ce fonds';

  @override
  String get deleteFundWarning => 'Cette action est irréversible.';

  @override
  String setPasswordTitle(Object step) {
    return 'Définir le mot de passe pour $step';
  }

  @override
  String get allPasswordsSetTitle => 'Tous les mots de passe sont définis';

  @override
  String get backupCompleted => 'Sauvegarde terminée avec succès !';

  @override
  String get uhifadhiKumbukumbu => 'Sauvegarde des données';

  @override
  String get tumaTaarifa => 'Envoyer les informations';

  @override
  String get chaguaMahaliNaHifadhi => 'Choisir l\'emplacement et enregistrer';

  @override
  String get hifadhiNakala => 'Enregistrer une copie';

  @override
  String get hifadhiNakalaRafiki => 'Envoyer une sauvegarde à un ami';

  @override
  String get hifadhiNakalaRafikiDescription =>
      'Envoyez une copie des données Chomoka à votre ami pour plus de sécurité.';

  @override
  String get uhifadhiKumbukumbuDescription =>
      'Sauvegardez vos données Chomoka dans un fichier ZIP. Vous pouvez restaurer ces données à tout moment.';

  @override
  String get error => 'Erreur';

  @override
  String errorSharingBackup(Object error) {
    return 'Erreur lors du partage de la sauvegarde : $error';
  }

  @override
  String get uwekaji_taarifa_katikati_mzunguko =>
      'Saisie des informations à mi-cycle';

  @override
  String get loading_group_data => 'Chargement des données du groupe…';

  @override
  String get kikundi_mzunguko => 'Dans quel cycle est le groupe ?';

  @override
  String get taarifa_zimehifadhiwa => 'Données enregistrées avec succès !';

  @override
  String imeshindwa_kuhifadhi(Object error) {
    return 'Échec de l\'enregistrement des données : $error';
  }

  @override
  String get thibitisha_ingizo => 'La validation des entrées a échoué.';

  @override
  String get namba_kikao => 'Numéro de session';

  @override
  String get ingiza_namba_kikao => 'Entrez le numéro de session';

  @override
  String get namba_kikao_inahitajika => 'Le numéro de session est requis';

  @override
  String get namba_kikao_halali =>
      'Veuillez entrer un numéro de session valide';

  @override
  String get endelea => 'Continuer';

  @override
  String get taarifa_kikao_kilichopita =>
      'Informations de la session précédente';

  @override
  String get hisa_wanachama => 'Parts des membres';

  @override
  String get muhtasari_kikao => 'Résumé de la session';

  @override
  String get jumla_kikundi => 'Total du groupe';

  @override
  String get akiba_wanachama => 'Économies des membres';

  @override
  String get akiba_binafsi => 'Épargne personnelle';

  @override
  String get wadaiwa_mikopo => 'Débiteurs de prêt';

  @override
  String get mchango_haujalipwa => 'Contributions non payées';

  @override
  String get jumla_hisa => 'Total des parts';

  @override
  String get jumla_akiba => 'Épargne totale';

  @override
  String get jumla_mikopo => 'Prêts totaux';

  @override
  String get jumla_riba => 'Intérêts totaux';

  @override
  String get jumla_adhabu => 'Total des amendes';

  @override
  String get jumla_mfuko_jamii => 'Fonds communautaire total';

  @override
  String get chaguaNjiaUhifadhi => 'Sélectionnez la méthode de sauvegarde';

  @override
  String get taarifaZimehifadhiwa => 'Informations enregistrées avec succès !';

  @override
  String get sawa => 'OK';

  @override
  String uhifadhiProgress(Object progress) {
    return 'Progression de la sauvegarde : $progress%';
  }

  @override
  String get midCycleMeetingInfo =>
      'Informations sur la réunion en milieu de cycle';

  @override
  String get groupTotals => 'Totaux du groupe';

  @override
  String get groupTotalsSummary => 'Résumé des totaux du groupe';

  @override
  String get enterTotalShares => 'Entrez le total des parts';

  @override
  String get pleaseEnterTotalShares => 'Veuillez entrer le total des parts';

  @override
  String get shareValue => 'Valeur de la part';

  @override
  String get enterShareValue => 'Entrez la valeur de la part';

  @override
  String get pleaseEnterShareValue => 'Veuillez entrer la valeur de la part';

  @override
  String get enterTotalSavings => 'Entrez l\'épargne totale';

  @override
  String get pleaseEnterTotalSavings => 'Veuillez entrer l\'épargne totale';

  @override
  String get enterCommunityFundBalance =>
      'Entrez le solde du fonds communautaire';

  @override
  String get pleaseEnterCommunityFundBalance =>
      'Veuillez entrer le solde du fonds communautaire';

  @override
  String get pleaseEnterValidPositiveNumber =>
      'La valeur doit être un nombre positif';

  @override
  String get memberShares => 'Parts des membres';

  @override
  String get unpaidContributions => 'Contributions non payées';

  @override
  String get memberContributions => 'Contributions des membres';

  @override
  String get fineOwed => 'Amendes dues';

  @override
  String get enterFineOwed => 'Entrez les amendes dues';

  @override
  String get pleaseEnterFineOwed => 'Veuillez entrer les amendes dues';

  @override
  String get communityFundOwed => 'Fonds communautaire dû';

  @override
  String get enterCommunityFundOwed =>
      'Entrez le montant dû du fonds communautaire';

  @override
  String get pleaseEnterCommunityFundOwed =>
      'Veuillez entrer le montant dû du fonds communautaire';

  @override
  String get loanInformation => 'Informations sur le prêt';

  @override
  String get memberLoanInfo => 'Infos sur le prêt du membre';

  @override
  String get selectReason => 'Sélectionnez un motif';

  @override
  String get reasonForLoan => 'Motif du prêt';

  @override
  String get pleaseSelectReason => 'Veuillez sélectionner un motif';

  @override
  String get houseRenovation => 'Rénovation de la maison';

  @override
  String get business => 'Entreprise';

  @override
  String get enterOtherReason => 'Entrez un autre motif';

  @override
  String get otherReason => 'Autre motif';

  @override
  String get pleaseEnterOtherReason => 'Veuillez entrer un autre motif';

  @override
  String get loanAmount => 'Montant du prêt';

  @override
  String get enterLoanAmount => 'Entrez le montant du prêt';

  @override
  String get pleaseEnterLoanAmount => 'Veuillez entrer le montant du prêt';

  @override
  String get pleaseEnterValidAmount => 'Veuillez entrer un montant valide';

  @override
  String get amountPaid => 'Montant payé :';

  @override
  String get enterAmountPaid => 'Entrez le montant payé';

  @override
  String get pleaseEnterAmountPaid => 'Veuillez entrer le montant payé';

  @override
  String get outstandingBalance => 'Solde impayé';

  @override
  String get calculatedAutomatically => 'Calculé automatiquement';

  @override
  String get pleaseEnterOutstandingAmount => 'Veuillez entrer le solde impayé';

  @override
  String get loanMeeting => 'Réunion de prêt';

  @override
  String get enterLoanMeeting => 'Entrez le numéro de réunion de prêt';

  @override
  String get pleaseEnterLoanMeeting =>
      'Veuillez entrer le numéro de réunion de prêt';

  @override
  String get loanDuration => 'Durée du prêt (mois)';

  @override
  String get enterLoanDuration => 'Entrez la durée en mois';

  @override
  String get pleaseEnterLoanDuration => 'Veuillez entrer la durée du prêt';

  @override
  String get loading => 'Chargement…';

  @override
  String get noMembersFound => 'Aucun membre trouvé.';

  @override
  String get searchByNameOrPhone => 'Rechercher par nom ou téléphone';

  @override
  String get memberList => 'Liste des membres';

  @override
  String get validate => 'Valider';

  @override
  String get dataValidationFailed => 'La validation des données a échoué.';

  @override
  String get shareInformation => 'Informations sur les parts';

  @override
  String get saveShares => 'Enregistrer les parts';

  @override
  String get shares => 'Parts';

  @override
  String get enterShares => 'Entrez le nombre de parts';

  @override
  String get loanSummary => 'Résumé du prêt';

  @override
  String get memberLoanSummary => 'Résumé du prêt du membre';

  @override
  String get loanDetails => 'DÉTAILS DU PRÊT';

  @override
  String get vslaMemberShares => 'Parts des membres';

  @override
  String get vslaShareInformation => 'Informations sur les parts';

  @override
  String get vslaShareValue => 'Valeur de la part';

  @override
  String get vslaTotalShares => 'Parts totales';

  @override
  String get vslaShareValuePerShare => 'Valeur par part';

  @override
  String get vslaEnterShareCount => 'Entrez le nombre de parts';

  @override
  String get vslaShareCountRequired => 'Le nombre de parts est requis';

  @override
  String get vslaEnterValidShareCount =>
      'Veuillez entrer un nombre de parts valide';

  @override
  String get vslaSaveShares => 'Enregistrer les parts';

  @override
  String get vslaSharesSavedSuccessfully => 'Parts enregistrées avec succès !';

  @override
  String vslaTotalSharesMustMatch(String total, String current) {
    return 'Le total des parts doit être $total. Actuellement $current. Veuillez ajuster.';
  }

  @override
  String get vslaGroupTotals => 'Totaux du groupe';

  @override
  String get vslaGroupTotalsSummary => 'Résumé des totaux du groupe';

  @override
  String get vslaCommunityFundBalance => 'Solde du fonds communautaire';

  @override
  String get vslaBoxBalance => 'Solde de la caisse';

  @override
  String get vslaCurrentLoanBalance => 'Solde des prêts en cours';

  @override
  String get vslaMembers => 'Membres';

  @override
  String get vslaUnpaidContributions => 'Contributions non payées';

  @override
  String get vslaTotalFinesOwed => 'Total des amendes dues';

  @override
  String get vslaEnterTotalShares => 'Entrez le total des parts';

  @override
  String get vslaEnterCommunityFundBalance =>
      'Entrez le solde du fonds communautaire';

  @override
  String get vslaEnterBoxBalance => 'Entrez le solde de la caisse';

  @override
  String get vslaPleaseEnterTotalShares => 'Veuillez entrer le total des parts';

  @override
  String get vslaPleaseEnterCommunityFundBalance =>
      'Veuillez entrer le solde du fonds';

  @override
  String get vslaPleaseEnterBoxBalance =>
      'Veuillez entrer le solde de la caisse';

  @override
  String get vslaPleaseEnterValidPositiveNumber =>
      'La valeur doit être un nombre positif';

  @override
  String get vslaMidCycleInformation => 'Informations à mi-cycle';

  @override
  String get vslaMemberShareTitle => 'Parts des membres';

  @override
  String get vslaMemberShareSubtitle => 'Entrez les parts du membre';

  @override
  String get vslaMemberNumber => 'Numéro du membre';

  @override
  String get vslaShareCount => 'Share Count';

  @override
  String get vslaNoMembersFound => 'Aucun membre trouvé';

  @override
  String get vslaErrorLoadingData =>
      'Erreur lors du chargement des données. Veuillez réessayer.';

  @override
  String vslaErrorSavingData(String error) {
    return 'Erreur lors de l\'enregistrement des données : $error';
  }

  @override
  String get uwekajiTaarifaKatikaMzunguko =>
      'Saisie des données en milieu de cycle';

  @override
  String get jumlaYaKikundi => 'Total du groupe';

  @override
  String get hisaZaWanachama => 'Parts des membres';

  @override
  String get taarifaZaKikundi => 'Informations du groupe';

  @override
  String get jumlaYaTaarifaZaKikundi => 'Total des informations du groupe';

  @override
  String get inapakiaTaarifa => 'Chargement des informations…';

  @override
  String get hakunaTaarifaZilizopo =>
      'Aucune donnée disponible pour le moment.';

  @override
  String get taarifaZaHisa => 'Informations sur les parts';

  @override
  String get thamaniYaHisaMoja => 'Valeur par part';

  @override
  String get wekaMfukoWaJamiiSalio => 'Définir le solde du fonds communautaire';

  @override
  String get tafadhaliJazaMfukoWaJamiiSalio =>
      'Veuillez remplir le solde du fonds communautaire.';

  @override
  String get wekaSalioLililolalaSandukuni => 'Définir le solde de la caisse';

  @override
  String get tafadhaliJazaSalioLililolalaSandukuni =>
      'Veuillez remplir le solde de la caisse.';

  @override
  String get salioLazimaIweIsiyoHasi => 'Le solde doit être non négatif.';

  @override
  String get jumlaYaThamaniYaHisa => 'Valeur totale des parts';

  @override
  String get tafadhaliJazaJumlaYaHisa => 'Veuillez remplir le total des parts.';

  @override
  String get salioLililolalaSandukuniError =>
      'Le solde de la caisse doit être supérieur au total des parts et du fonds communautaire.';

  @override
  String get jumlaYaHisaZote => 'Nombre total de parts';

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
    return 'Par exemple, si un membre emprunte 10 000 il paiera $rate% du montant restant du prêt chaque mois. S’il rembourse son prêt plus tôt, il évitera de payer des intérêts.';
  }

  @override
  String loanInterestExampleEqual(Object amount, Object rate) {
    return 'Par exemple, si un membre emprunte 10 000 il paiera $amount% du montant réel du prêt. Il paiera $rate chaque mois.';
  }

  @override
  String loanInterestExampleOnce(Object amount, Object rate) {
    return 'Par exemple, si un membre emprunte 10 000 il remboursera avec un intérêt de $amount% du montant réel du prêt. Il paiera $rate comme intérêt lors du remboursement du prêt.';
  }

  @override
  String get constitutionTitle => 'Constitution';

  @override
  String get membershipRules => 'Membership Rules';

  @override
  String get method => 'Method:';

  @override
  String get savings => 'Épargne';

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
  String get noFines => 'Aucune amende enregistrée pour ce membre.';

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
  String get historia => 'Historique';

  @override
  String historiaYa(String name) {
    return 'Historique de $name';
  }

  @override
  String get hakuna_vikao => 'Aucune réunion terminée dans ce cycle !';

  @override
  String get tafutaJinaSimu => 'Rechercher par nom ou numéro de téléphone';

  @override
  String get hakunaWanachama => 'Aucun membre trouvé.';

  @override
  String get muhtasariKikao => 'Résumé de la réunion';

  @override
  String get funga => 'Fermer';

  @override
  String get tumaMuhtasari => 'Envoyer le résumé';

  @override
  String get mwanachamaSiSimu => 'Le membre n\'a pas de numéro de téléphone';

  @override
  String muhtasariUmetumwa(String name) {
    return 'Résumé envoyé à $name avec succès';
  }

  @override
  String get imeshindwaTumaSMS =>
      'Échec de l\'envoi du SMS, veuillez réessayer';

  @override
  String get kikao => 'Réunion';

  @override
  String kikao_ya(String name) {
    return 'Réunion de $name';
  }

  @override
  String get mipangilio => 'Paramètres';

  @override
  String get badiliLugha => 'Changer la langue';

  @override
  String get chaguaLughaYaProgramu => 'Choisir la langue de l\'application';

  @override
  String get kiswahili => 'Swahili';

  @override
  String get english => 'Anglais';

  @override
  String get french => 'Français';

  @override
  String get rekebishaFunguo => 'Ajuster les clés';

  @override
  String get badilishaNenoLaSiri => 'Changer le mot de passe';

  @override
  String get kifo => 'Décès';

  @override
  String get futazoteZaMzungukoHuuKishaAnzaMzungukoMpya =>
      'Supprimer toutes les données de ce cycle et démarrer un nouveau';

  @override
  String get rekebishaMzunguko => 'Modifier le cycle';

  @override
  String get thibitisha => 'Confirmer';

  @override
  String get jeUnaHitajiKufutaTaarifaZoteNaKuanzaMzungukoMpya =>
      'Voulez-vous supprimer toutes les données et démarrer un nouveau cycle ?';

  @override
  String get ndio => 'Oui';

  @override
  String imeshindwaKuHifadhi(String error) {
    return 'Échec de l\'enregistrement : $error';
  }

  @override
  String get hapana => 'Non';

  @override
  String get kuhusuChomoka => 'À propos de Chomoka';

  @override
  String get toleoLaChapa100 => 'Version 1.0.0';

  @override
  String get toleo4684 => 'Version 4684';

  @override
  String get mkataba => 'Contrat';

  @override
  String get vigezoNaMasharti => 'Termes et conditions';

  @override
  String get somaVigezoNaMashartiYaChomoka =>
      'Lire les termes et conditions de Chomoka';

  @override
  String get msaadaWaKitaalamu => 'Support technique';

  @override
  String get chomokaItajaribuKutumaBaadhiYaIliKikundiKipateMsaadaZaidiWaKitalaamu =>
      'Chomoka tentera d\'envoyer certaines données pour fournir davantage de support technique au groupe';

  @override
  String get vslaPreviousMeetingSummary => 'Résumé de la réunion';

  @override
  String get nimemaliza => 'Soumettre';

  @override
  String get idleBalanceInBox => 'Solde inactif dans la caisse';

  @override
  String get currentLoanBalance => 'Solde du prêt en cours';

  @override
  String get remainingCommunityContribution =>
      'Contribution restante au fonds communautaire';

  @override
  String get totalOutstandingFines => 'Total des amendes en cours';

  @override
  String get kikundi => 'Groupe';

  @override
  String get nunuaHisa => 'Acheter des parts';

  @override
  String get sasaUtaanzaMchakatoWaKununuaHisaKwaKilaMwanachama =>
      'Commencez le processus d\'achat de parts pour chaque membre';

  @override
  String get anzaSasa => 'COMMENCER MAINTENANT';

  @override
  String get rudiNymba => 'RETOUR';

  @override
  String get hisa => 'Parts';

  @override
  String get hesabuYaHisa => 'Compte de parts';

  @override
  String get jumlaYaAkiba => 'Total des parts';

  @override
  String get hisaAlizonunuaLeo => 'Parts à acheter';

  @override
  String get chaguaIdadiYaHisaZaKununua =>
      'Sélectionnez le nombre de parts à acheter';

  @override
  String get chaguaZote => 'Tout sélectionner';

  @override
  String get ruka => 'Passer';

  @override
  String get hisaZilizochaguliwa => 'Parts sélectionnées';

  @override
  String get badilishaHisa => 'Modifier les parts';

  @override
  String get ongezaHisa => 'Ajouter des parts';

  @override
  String get ongezaHisaZaidiKwaMwanachama =>
      'Ajouter plus de parts pour chaque membre';

  @override
  String get punguzaHisa => 'Retirer des parts';

  @override
  String get punguzaIdadiYaHisaZaMwanachama =>
      'Retirer des parts pour chaque membre';

  @override
  String get futaZote => 'Supprimer tout';

  @override
  String get futaHisaZoteZaLeo => 'Supprimer toutes les parts de ce cycle';

  @override
  String get ongeza => 'Ajouter';

  @override
  String get punguza => 'Retirer';

  @override
  String get futa => 'Supprimer';

  @override
  String get ingizaIdadiYaHisaUnezotakaKununua =>
      'Entrez le nombre de parts que vous souhaitez ajouter';

  @override
  String get ingizaIdadiYaHisaUnezotakaKupunguza =>
      'Entrez le nombre de parts que vous souhaitez retirer';

  @override
  String get ghairi => 'Annuler';

  @override
  String get idadiYaHisa => 'Nombre de parts';

  @override
  String get tafadhaliIngizaNambaSahihi => 'Veuillez entrer un nombre valide';

  @override
  String get muhtasariWaHisa => 'Résumé des parts';

  @override
  String get jumlaYaFedha => 'Montant total';

  @override
  String contributeToFund(String fundName) {
    return 'Contribuer à $fundName';
  }

  @override
  String get amountToContribute => 'Montant à contribuer';

  @override
  String get totalCollected => 'Total collecté';

  @override
  String shareNote(Object amount) {
    return 'Note : un membre peut acheter une part d\'une valeur de $amount par réunion';
  }

  @override
  String get help => 'Aide';

  @override
  String get welcome => 'Bienvenue';

  @override
  String get helpDescription =>
      'Nous vous aidons à conserver efficacement les registres de votre groupe';

  @override
  String get continueMeeting => 'Continuer la réunion';

  @override
  String get wanachama => 'Membres';

  @override
  String get fund => 'Distribution de groupe';

  @override
  String get feedback => 'Retour';

  @override
  String get groupsActivities => 'Activités de groupe';

  @override
  String get historyDescription => 'View the history of group activities';

  @override
  String get backupAndRestore => 'Sauvegarde et restauration';

  @override
  String get backupDescription => 'Backup and restore group records';

  @override
  String get serviceMore => 'Plus de services';

  @override
  String get historyHints => 'View the history of group activities';

  @override
  String get sendData => 'Sauvegarde et restauration';

  @override
  String get sendDataHint =>
      'Sauvegardez et restaurez les enregistrements de groupe';

  @override
  String get whatsappNotInstalled =>
      'WhatsApp n\'est pas installé sur votre téléphone';

  @override
  String get whatsappFailed => 'Échec de l\'ouverture de WhatsApp';

  @override
  String get helpEmailSubject => 'Aide – Application Chomoka Plus';

  @override
  String get welcomeNextMeeting => 'Bienvenue à la prochaine réunion';

  @override
  String get midCycleReport => 'Rapport de mi-cycle';

  @override
  String get tapToOpenMeeting => 'Touchez pour ouvrir la réunion';

  @override
  String get tapYesToStartFirstMeeting =>
      'TOUCHEZ OUI POUR DÉMARRER LA PREMIÈRE RÉUNION';

  @override
  String get openMeeting => 'OUVRIR LA RÉUNION';

  @override
  String get tapNoToEnterPastMeetings =>
      'TOUCHEZ NON POUR ENTRER LES RÉUNIONS PASSÉES';

  @override
  String meetingTitle(Object meetingNumber) {
    return 'Réunion n° $meetingNumber';
  }

  @override
  String get groupAttendance => 'Présence du groupe';

  @override
  String get contributeMfukoJamii => 'Contribuer au fonds social';

  @override
  String get buyShares => 'Acheter des parts';

  @override
  String contributeOtherFund(Object mfukoName) {
    return 'Contribuer à $mfukoName';
  }

  @override
  String get repayLoan => 'Rembourser le prêt';

  @override
  String get payFine => 'Payer l\'amende';

  @override
  String get withdrawFromMfukoJamii => 'Retirer du fonds social';

  @override
  String get giveLoan => 'Accorder le prêt';

  @override
  String get markCompleted => 'completed';

  @override
  String get markPending => 'pending';

  @override
  String get menuBulkSaving => 'Épargne en masse';

  @override
  String get menuExpense => 'Saisir les dépenses';

  @override
  String get menuLogout => 'Déconnexion';

  @override
  String get snackbarLoggedOut => 'Déconnecté';

  @override
  String get attendance => 'Présence';

  @override
  String get attendanceSummary => 'Résumé de présence';

  @override
  String get totalMembers => 'Nombre total de membres';

  @override
  String get present => 'Présent';

  @override
  String get onTime => 'À l\'heure';

  @override
  String get lates => 'En retard';

  @override
  String get sentRepresentative => 'Représentant envoyé';

  @override
  String get absent => 'Absent';

  @override
  String get withPermission => 'Avec permission';

  @override
  String get withoutPermission => 'Sans permission';

  @override
  String get reasonForAbsence => 'Raison de l\'absence';

  @override
  String get amountToPaid => 'Montant que le membre doit payer :';

  @override
  String get whatWasCollected => 'Montant collecté :';

  @override
  String get hasPaid => 'A payé';

  @override
  String get hasNotPaid => 'N\'a pas payé';

  @override
  String get compulsorySavingsTitle =>
      'Informations sur l\'épargne obligatoire';

  @override
  String get compulsorySavingsSubtitle => 'Contributions des membres';

  @override
  String get loadingMessage => 'Loading information...';

  @override
  String get doneButton => 'Terminé';

  @override
  String get noCompulsorySavings =>
      'Aucune épargne obligatoire due par le membre';

  @override
  String get phone => 'Téléphone';

  @override
  String get dueMeeting => 'Réunion due';

  @override
  String owedAmount(Object amount) {
    return 'Épargne obligatoire due : $amount';
  }

  @override
  String get pay => 'Payer';

  @override
  String get alreadyPaid => 'Déjà payé';

  @override
  String get socialFundTitle => 'Informations sur le fonds social';

  @override
  String socialFundDueAmount(Object amount) {
    return 'Montant dû pour le fonds social : $amount';
  }

  @override
  String get contributionSummary => 'Résumé des contributions';

  @override
  String memberName(Object name) {
    return 'Membre : $name';
  }

  @override
  String get paid => 'Payé';

  @override
  String get unpaid => 'Impayé';

  @override
  String get noSocialFundDue =>
      'Aucun montant du fonds social dû par le membre';

  @override
  String get totalLoan => 'Prêt total';

  @override
  String get noUnpaidMemberJamii =>
      'Aucun membre n\'a de contribution sociale impayée';

  @override
  String get unpaidContributionsTitle => 'Unpaid Contributions';

  @override
  String get unpaidContributionsSubtitle => 'Social Fund Contributions';

  @override
  String get loanDebtorsTitle => 'Débiteurs de prêt';

  @override
  String get loanSummaryTitle => 'Résumé du prêt';

  @override
  String get loanIssuedAmount => 'Montant total des prêts accordés :';

  @override
  String get loanRepaidAmount => 'Montant total remboursé :';

  @override
  String get loanRemainingAmount => 'Solde restant du prêt :';

  @override
  String get noUnpaidLoans => 'Aucun membre avec des prêts impayés.';

  @override
  String get loanDebtors => 'Débiteurs';

  @override
  String get memberLabel => 'Membre :';

  @override
  String get unpaidLoanAmount => 'Montant prêt impayé';

  @override
  String get loanDetailsTitle => 'Détails du prêt';

  @override
  String get makePayment => 'Effectuer un paiement';

  @override
  String remainingAmount(Object amount) {
    return 'Montant restant : $amount';
  }

  @override
  String get choosePaymentType => 'Choisir le type de paiement :';

  @override
  String get payAll => 'Payer tout';

  @override
  String get reduceLoan => 'Réduire le prêt';

  @override
  String get enterPaymentAmount => 'Entrez le montant du paiement';

  @override
  String get payLoan => 'Payer le prêt';

  @override
  String get member => 'MEMBRE';

  @override
  String get loanTaken => 'Montant emprunté :';

  @override
  String get loanToPay => 'Montant à rembourser :';

  @override
  String get loanRemaining => 'Montant restant du prêt :';

  @override
  String get paymentHistory => 'Historique des paiements :';

  @override
  String get noPaymentsMade => 'Aucun paiement effectué.';

  @override
  String youPaid(Object amount) {
    return 'Vous avez payé : $amount';
  }

  @override
  String date(Object date) {
    return 'Date : $date';
  }

  @override
  String get fainiPageTitle => 'Émettre une amende';

  @override
  String get pageSubtitle => 'Sélectionner une amende';

  @override
  String get undefinedFine => 'Amende non définie';

  @override
  String priceLabel(Object price) {
    return 'Prix : $price Tsh';
  }

  @override
  String get saveFine => 'Enregistrer l\'amende';

  @override
  String get payFineTitle => 'Payer l\'amende';

  @override
  String remainingFineAmount(Object amount) {
    return 'Montant restant : $amount';
  }

  @override
  String get payAllFines => 'Payer toutes les amendes';

  @override
  String get payCustomAmount => 'Payer un montant personnalisé';

  @override
  String get confirmFinePayment => 'Payer l\'amende';

  @override
  String get fineTitle => 'Amendes du membre';

  @override
  String get fineSubtitle => 'Payer l\'amende';

  @override
  String totalFines(Object amount) {
    return 'Total des amendes dues : $amount';
  }

  @override
  String paidFines(Object amount) {
    return 'Amendes payées : $amount';
  }

  @override
  String remainingFines(Object amount) {
    return 'Montant restant : $amount';
  }

  @override
  String get pigaFainiTitle => 'Imposer une amende';

  @override
  String get pigaFainiSubtitle => 'Sélectionner un membre';

  @override
  String get searchHint => 'Rechercher par nom ou numéro de membre';

  @override
  String get fainiSummarySubtitle => 'Résumé des amendes';

  @override
  String get unknownName => 'Inconnu';

  @override
  String get unknownPhone => 'Téléphone inconnu';

  @override
  String get backToFines => 'Retour aux amendes';

  @override
  String get lipaFainiTitle => 'Payer l\'amende';

  @override
  String get totalFinesDue => 'Total des amendes dues';

  @override
  String get totalFinesPaid => 'Total des amendes payées';

  @override
  String get noFineMembers => 'Aucun membre avec des amendes.';

  @override
  String get unpaidFinesTitle => 'Amendes impayées';

  @override
  String memberTotalFines(Object amount) {
    return 'Total des amendes : $amount';
  }

  @override
  String get navigationError =>
      'Une erreur s\'est produite lors de la navigation. Veuillez réessayer.';

  @override
  String get memberFinesTitle => 'Amendes du membre';

  @override
  String memberNameLabel(Object name) {
    return 'Membre : $name';
  }

  @override
  String memberNumberLabel(Object number) {
    return 'Numéro de membre : $number';
  }

  @override
  String totalFinesLabel(Object amount) {
    return 'Total des amendes dues : $amount';
  }

  @override
  String totalPaidLabel(Object amount) {
    return 'Amendes payées : $amount';
  }

  @override
  String totalUnpaidLabel(Object amount) {
    return 'Solde restant : $amount';
  }

  @override
  String memberPhone(Object phone) {
    return 'Téléphone : $phone';
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
    return 'Réunion : $meeting';
  }

  @override
  String get toa_mfuko_jamii => 'Retirer du fonds social';

  @override
  String get sababu_ya_kutoa_mfuko => 'Raison du retrait du fonds social';

  @override
  String get hakuna_sababu => 'Aucune raison n\'a été saisie.';

  @override
  String kiasi_cha_juu(Object amount) {
    return 'Montant maximal de retrait : $amount';
  }

  @override
  String get jina => 'Nom :';

  @override
  String get jina_lisiloeleweka => 'Nom inconnu';

  @override
  String get namba_haijapatikana => 'Numéro non trouvé';

  @override
  String get chagua_sababu => 'Sélectionner la raison du retrait';

  @override
  String get tatizo_katika_kupakia =>
      'Une erreur est survenue, veuillez réessayer.';

  @override
  String get chagua_kiwango_kutoa => 'Sélectionner le montant à retirer';

  @override
  String get namba_ya_mwanachama => 'Numéro du membre :';

  @override
  String get sababu_ya_kutoa => 'Raison du retrait :';

  @override
  String get kiwango_cha_juu => 'Montant maximal de retrait :';

  @override
  String get salio_la_sasa => 'Solde actuel :';

  @override
  String get salio_la_kikao_kilichopita =>
      'Solde du fonds social à la réunion précédente :';

  @override
  String get toa_kiasi_chote => 'Retirer le montant complet';

  @override
  String get toa_kiasi_kingine => 'Retirer un autre montant';

  @override
  String get ingiza_kiasi => 'Entrez le montant';

  @override
  String get thibitisha_utoaji_pesa => 'Confirmer le retrait du fonds';

  @override
  String get kiasi_cha_kutoa => 'Montant du retrait :';

  @override
  String get salio_jipya => 'Nouveau solde :';

  @override
  String get toa_mkopo => 'Accorder un prêt';

  @override
  String get tahadhari => 'Attention !';

  @override
  String get hawezi_kukopa =>
      'Un membre ne peut pas emprunter de nouveau avant d\'avoir terminé le prêt en cours.';

  @override
  String get sababu_ya_kutoa_mkopo => 'Raison de la prise du prêt';

  @override
  String weka_sababu(Object name) {
    return 'Entrez la raison pour laquelle $name prend ce prêt :';
  }

  @override
  String get kilimo => 'Agriculture';

  @override
  String get maboresho_nyumba => 'Amélioration de la maison';

  @override
  String get elimu => 'Éducation';

  @override
  String get biashara => 'Entreprise';

  @override
  String get sababu_nyingine => 'Autre raison';

  @override
  String get weka_sababu_nyingine => 'Entrez une autre raison';

  @override
  String get thibitisha_sababu => 'Confirmer la raison';

  @override
  String get tafadhali_weka_sababu_nyingine =>
      'Veuillez saisir une autre raison.';

  @override
  String get jumla_ya_akiba => 'Épargne totale :';

  @override
  String get kiwango_cha_juu_mkopo => 'Montant maximal du prêt :';

  @override
  String get fedha_zilizopo_mkopo => 'Fonds disponibles pour le prêt :';

  @override
  String chukua_mkopo_wote(Object amount) {
    return 'Prendre le prêt complet $amount';
  }

  @override
  String get kiasi_kingine => 'Autre montant';

  @override
  String get kiasi => 'Montant';

  @override
  String get weka_kiasi => 'Entrez le montant';

  @override
  String get thibitisha_kiasi => 'Confirmer le montant';

  @override
  String get tafadhali_chagua_chaguo => 'Veuillez choisir une option de prêt.';

  @override
  String get kiasi_cha_mkopo_wa_mwanachama => 'Montant du prêt du membre';

  @override
  String get tafadhali_ingiza_kiasi_sahihi =>
      'Veuillez entrer un montant valide.';

  @override
  String get hakuna_kiasi_cha_kutosha =>
      'Fonds insuffisants pour accorder ce prêt.';

  @override
  String get kiasi_hakiruhusiwi =>
      'Le montant sélectionné n\'est pas autorisé.';

  @override
  String get kiasi_na_riba_vimehifadhiwa =>
      'Montant du prêt et intérêts enregistrés.';

  @override
  String get hitilafu_imetokea =>
      'Une erreur est survenue. Veuillez réessayer.';

  @override
  String get muda_wa_marejesho => 'Durée de remboursement';

  @override
  String kiasi_cha_mkopo_wake_ni(Object amount) {
    return 'Son montant de prêt est :\n$amount';
  }

  @override
  String get mkopo_wa_miezi_mingapi => 'Durée du prêt en mois ?';

  @override
  String get mwezi_1 => '1 mois';

  @override
  String get miezi_2 => '2 mois';

  @override
  String get miezi_3 => '3 mois';

  @override
  String get miezi_6 => '6 mois';

  @override
  String get nyingine => 'Autre';

  @override
  String get ingiza_miezi => 'Entrez le nombre de mois';

  @override
  String get thibitisha_muda => 'Confirmer la durée';

  @override
  String get tafadhali_chagua_muda =>
      'Veuillez choisir une durée de remboursement.';

  @override
  String get tafadhali_ingiza_muda_sahihi =>
      'Veuillez entrer une durée valide.';

  @override
  String muda_wa_marejesho_umehifadhiwa(Object months) {
    return 'Durée de remboursement enregistrée : $months mois';
  }

  @override
  String get wadhamini => 'Garants';

  @override
  String jinas(Object name) {
    return 'Nom : $name';
  }

  @override
  String chagua_wadhamini(Object count) {
    return 'Sélectionner $count garants :';
  }

  @override
  String get haidhibiti_idadi =>
      'Veuillez sélectionner tous les garants requis.';

  @override
  String get haijulikani => 'Inconnu';

  @override
  String get muhtasari_wa_mkopo => 'Résumé du prêt';

  @override
  String get thibitisha_mkopo => 'Confirmer le prêt';

  @override
  String get maelezo_ya_mkopo => 'Détails du prêt';

  @override
  String get kiasi_cha_mkopo => 'Montant du prêt';

  @override
  String get riba_ya_mkopo => 'Intérêt du prêt';

  @override
  String get maelezo_ya_riba => 'Détails\nsur les intérêts';

  @override
  String get salio_la_mkopo => 'Solde du prêt';

  @override
  String get tarehe_ya_mwisho => 'Date d\'échéance';

  @override
  String miezi(Object miezi) {
    return 'Mois $miezi';
  }

  @override
  String get oneTimeInterest => 'Les intérêts sont payés une seule fois';

  @override
  String guarantorExample(int count, String amount) {
    return 'Par exemple, si Pili ne peut pas rembourser la dette de 150 000 à l\'échéance, l\'épargne des $count garants sera réduite chacun de $amount.';
  }

  @override
  String get communityFundTitle => 'Fonds communautaire';

  @override
  String get unpaidContribution => 'Contribution impayée';

  @override
  String get expense => 'Dépense';

  @override
  String get chooseUsageType => 'Choisir le type d\'utilisation';

  @override
  String usageType(Object type) {
    return '$type';
  }

  @override
  String get matumziStationery => 'Papeterie';

  @override
  String get matumziRefreshment => 'Rafraîchissements';

  @override
  String get matumziLoanPayment => 'Paiement du Prêt';

  @override
  String get matumziCallTime => 'Temps d\'appel (Vocha)';

  @override
  String get matumziTechnology => 'Technologie';

  @override
  String get matumiziMerchandise => 'Marchandises Commerciales';

  @override
  String get matumziTransport => 'Transport';

  @override
  String get matumiziBackCharges => 'Frais Bancaires';

  @override
  String get matumziOther => 'Autres';

  @override
  String get specificUsage => 'Utilisation spécifique';

  @override
  String get enterSpecificUsage => 'Entrez l\'utilisation spécifique';

  @override
  String get pleaseEnterSpecificUsage =>
      'Veuillez entrer l\'utilisation spécifique.';

  @override
  String get pleaseEnterAmount => 'Please enter an amount';

  @override
  String get next => 'Next';

  @override
  String get expenseSummary => 'Expense Summary';

  @override
  String get totalAmountSpent => 'Montant total dépensé';

  @override
  String get totalExpenses => 'Total des dépenses';

  @override
  String get noExpensesRecorded => 'Aucune dépense enregistrée.';

  @override
  String expenseLabel(Object label) {
    return 'Dépense : $label';
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
    return 'Fonds : $fund';
  }

  @override
  String get done => 'Terminé';

  @override
  String get confirmExpense => 'Confirm Expense';

  @override
  String get expenseFund => 'Expense Fund';

  @override
  String get expenseTypeLabel => 'Type :';

  @override
  String get chooseFund => 'Choisir un fonds';

  @override
  String get chooseFundToContribute => 'Choisir un fonds à contribuer';

  @override
  String get mainGroupFund => 'Fonds principal';

  @override
  String get socialFund => 'Fonds social';

  @override
  String get pleaseChooseFund => 'Please choose a fund.';

  @override
  String get bulkSaving => 'Épargne collective';

  @override
  String get chooseContributionType => 'Choisir le type de contribution';

  @override
  String get donationContribution => 'Contribution de don';

  @override
  String get businessProfit => 'Profit commercial';

  @override
  String get loanDisbursement => 'Décaissement du prêt';

  @override
  String enterAmountFor(Object type) {
    return 'Entrez le montant pour $type :';
  }

  @override
  String get totalContributionsForCycle =>
      'Total des contributions pour ce cycle';

  @override
  String get contributionsList => 'Contributions List';

  @override
  String get noContributionsCompleted => 'No contributions completed.';

  @override
  String get noFund => 'No Fund';

  @override
  String contributionType(Object type) {
    return 'Type : $type';
  }

  @override
  String get confirmContribution => 'Confirmer la contribution';

  @override
  String get fundBalance => 'Solde du fonds';

  @override
  String get currentContribution => 'Contribution actuelle';

  @override
  String get newFundBalance => 'Nouveau solde du fonds';

  @override
  String meetingSummaryTitle(Object meetingNumber) {
    return 'Résumé de la réunion $meetingNumber';
  }

  @override
  String get sharePurchaseSection => 'Achat de parts';

  @override
  String get totalSharesDeposited => 'Total des parts déposées';

  @override
  String get totalShareValue => 'Valeur totale des parts';

  @override
  String get amountDeposited => 'Montant déposé';

  @override
  String get amountWithdrawn => 'Montant retiré';

  @override
  String get loansSection => 'Prêts';

  @override
  String get loansIssued => 'Prêts accordés';

  @override
  String get loanAmountRepaid => 'Montant du prêt remboursé';

  @override
  String get loanAmountOutstanding => 'Montant du prêt restant';

  @override
  String get finesSection => 'Amendes';

  @override
  String get totalBulkSaving => 'Total de l\'épargne collective';

  @override
  String get expensesSection => 'Dépenses';

  @override
  String get loadingAttendanceSummary => 'Chargement du résumé de présence...';

  @override
  String get presentMembers => 'Membres présents';

  @override
  String get earlyMembers => 'Arrivés tôt';

  @override
  String get lateMembers => 'En retard';

  @override
  String get representative => 'Représentant';

  @override
  String get absentMembers => 'Membres absents';

  @override
  String get closeMeeting => 'Clôturer la réunion';

  @override
  String get sendSmsTitle => 'Envoyer SMS';

  @override
  String get sendSmsSubtitle => 'Envoyer un SMS aux membres';

  @override
  String get chooseSmsSendType => 'Choisissez le mode d\'envoi';

  @override
  String get sendToAll => 'Envoyer à tous';

  @override
  String get chooseMembers => 'Choisir les membres';

  @override
  String get selected => 'Sélectionné';

  @override
  String get sendSms => 'Envoyer SMS';

  @override
  String sendSmsWithCount(Object count) {
    return 'Envoyer SMS ($count)';
  }

  @override
  String get selectMembersToSendSms => 'Veuillez sélectionner des membres';

  @override
  String get noMembersToSendSms => 'Aucun membre sélectionnable';

  @override
  String smsGreeting(Object name) {
    return 'Cher/Chère $name,';
  }

  @override
  String get smsSummaryHeader => 'Résumé de la réunion :';

  @override
  String smsTotalShares(Object shares, Object value) {
    return 'Total des parts : $shares ($value)';
  }

  @override
  String smsSocialFund(Object amount) {
    return 'Fonds social : $amount';
  }

  @override
  String smsCurrentLoan(Object amount) {
    return 'Prêt en cours : $amount';
  }

  @override
  String smsFine(Object amount) {
    return 'Amende : $amount';
  }

  @override
  String get failedToCloseMeeting => 'Échec de la clôture';

  @override
  String get meetingNotFound => 'Réunion introuvable';

  @override
  String failedToCloseMeetingWithError(Object error) {
    return 'Échec de la clôture : $error';
  }

  @override
  String get agentPreparedAndOnTime =>
      'L\'agent s\'est-il bien préparé et est-il arrivé à l\'heure ?';

  @override
  String get agentExplainedChomoka =>
      'L\'agent a‑t‑il expliqué comment utiliser Chomoka ?';

  @override
  String get pleaseAnswerThisQuestion => 'Veuillez répondre.';

  @override
  String get agentExplainedCosts =>
      'L\'agent a‑t‑il clairement expliqué les coûts ?';

  @override
  String get agentRating => 'Comment évalueriez‑vous l\'agent Chomoka ?';

  @override
  String get agentRatingLevel1 => '1. Pauvre';

  @override
  String get agentRatingLevel2 => '2. Moyen';

  @override
  String get agentRatingLevel3 => '3. Bien';

  @override
  String get agentRatingLevel4 => '4. Très bien';

  @override
  String get agentRatingLevel5 => '5. Excellent';

  @override
  String get pleaseChooseRating => 'Veuillez choisir une note.';

  @override
  String get unansweredQuestion =>
      'Avez‑vous une question restée sans réponse ?';

  @override
  String get question => 'Question';

  @override
  String get pleaseWriteQuestion => 'Veuillez écrire votre question.';

  @override
  String get suggestionForChomoka => 'Suggestions pour Chomoka ?';

  @override
  String get suggestion => 'Suggestion';

  @override
  String get pleaseWriteSuggestion => 'Veuillez écrire votre suggestion.';

  @override
  String get noMeeting => 'Aucune réunion';

  @override
  String get noMeetingDesc => 'Aucune réunion n\'a encore eu lieu ce cycle.';

  @override
  String get meetingInProgress => 'Réunion en cours';

  @override
  String get meetingInProgressDesc =>
      'Veuillez terminer la réunion pour continuer.';

  @override
  String get shareout => 'Répartition';

  @override
  String get chooseShareoutType => 'Choisissez le type de répartition';

  @override
  String get groupShareout => 'Répartition du groupe';

  @override
  String get groupShareoutDesc =>
      'Notre cycle est terminé, nous voulons revoir la participation.';

  @override
  String get memberShareout => 'Répartition individuelle';

  @override
  String get memberShareoutDesc =>
      'Nous voulons exclure un membre et revoir sa participation.';

  @override
  String get returnToHome => 'Retour à l\'accueil';

  @override
  String get summary => 'Résumé';

  @override
  String get chooseMember => 'Choisir un membre';

  @override
  String phoneNumberLabel(Object phone) {
    return 'Téléphone : $phone';
  }

  @override
  String get totalMandatorySavings => 'Épargne obligatoire totale';

  @override
  String get totalVoluntarySavings => 'Épargne volontaire totale';

  @override
  String get unpaidFineAmount => 'Montant amende impayé';

  @override
  String get memberOwesAmount => 'Le membre doit';

  @override
  String get totalShareoutAmount => 'Montant total de la répartition';

  @override
  String get confirmShareout => 'Confirmer la répartition';

  @override
  String get mandatorySavingsToBeWithdrawn => 'Épargne obligatoire à retirer';

  @override
  String get voluntarySavingsToBeWithdrawn => 'Épargne volontaire à retirer';

  @override
  String get memberMustPayAmount => 'Le membre doit payer';

  @override
  String get cashPayment => 'Paiement en espèces';

  @override
  String get noPaymentToMember => 'Aucun paiement pour le membre';

  @override
  String get totalSharesCount => 'Nombre total de parts';

  @override
  String get totalSharesValue => 'Valeur totale des parts';

  @override
  String get enterKeysToContinue => 'Entrez les clés pour continuer';

  @override
  String get smsSummaryTitle => 'Envoyer le résumé par SMS';

  @override
  String get smsYes => 'Oui';

  @override
  String get smsNo => 'Non';

  @override
  String get groupShareTitle => 'Répartition de groupe';

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
    return 'Parts : $shares ($percentage%)';
  }

  @override
  String get unpaidLoanMsg => 'Prêts impayés présents. Veuillez régulariser.';

  @override
  String get unpaidFineMsg =>
      'Amendes impayées présentes. Veuillez régulariser.';

  @override
  String get unpaidSocialFundMsg =>
      'Contributions sociales impayées présentes. Veuillez régulariser.';

  @override
  String get unpaidCompulsorySavingsMsg =>
      'Épargnes obligatoires impayées présentes. Veuillez régulariser.';

  @override
  String get warning => 'Avertissement';

  @override
  String get profit => 'Profit';

  @override
  String get totalExtraCollected => 'Total supplémentaire collecté';

  @override
  String totalUnpaidAmount(Object amount) {
    return 'Montant impayé total : $amount';
  }

  @override
  String get totalWithdrawnFromSocialFund => 'Total retiré du fonds social';

  @override
  String get totalFunds => 'Total des fonds';

  @override
  String get expenses => 'Expenses';

  @override
  String get otherGroupExpenses => 'Autres dépenses du groupe';

  @override
  String get amountRemaining => 'Montant restant';

  @override
  String get socialFundCarriedForward =>
      'Fonds social reporté au prochain cycle';

  @override
  String get totalShareFunds => 'Total des fonds des parts';

  @override
  String get amountNextCycleSubtitle => 'Montant reporté au prochain cycle';

  @override
  String get sendToNextCycle => 'Transférer au prochain cycle';

  @override
  String get enterAmountNextCycle => 'Entrez le montant à transférer';

  @override
  String availableAmount(Object amount) {
    return 'Disponible : $amount';
  }

  @override
  String amountMustBeLessThanOrEqual(Object amount) {
    return 'Le montant doit être ≤ $amount';
  }

  @override
  String get memberShareDistributionTitle => 'Répartition individuelle';

  @override
  String shareValueAmount(Object amount) {
    return 'Valeur par part : $amount';
  }

  @override
  String totalDistributionAmount(Object amount) {
    return 'Distribution totale : $amount';
  }

  @override
  String get groupShareDistributionTitle => 'Distribution de groupe';

  @override
  String get noProfitEmoji => '😢';

  @override
  String get profitEmoji => '😊';

  @override
  String get noProfitMessage => 'Votre groupe n\'a pas réalisé de profit';

  @override
  String profitMessage(Object amount) {
    return 'Félicitations ! Votre groupe a fait $amount de profit';
  }

  @override
  String get totalDistributionFunds => 'Fonds totaux de distribution';

  @override
  String amountTzs(Object amount) {
    return ' $amount';
  }

  @override
  String get nextCycleSocialFund => 'Fonds social reporté';

  @override
  String get nextCycleMemberSavings => 'Épargne des membres reportée';

  @override
  String get finishCycle => 'Terminer le cycle';

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
  String get requestInputTitle => 'Saisie de commande';

  @override
  String get requestInputEditTitle => 'Modifier la demande de saisie';

  @override
  String get requestInputType => 'Type de saisie';

  @override
  String get requestInputTypeHint => 'Entrez le type de saisie';

  @override
  String get requestInputTypeError => 'Veuillez entrer le type de saisie';

  @override
  String get requestInputCompany => 'Entreprise';

  @override
  String get requestInputCompanyHint => 'Entrez le nom de l\'entreprise';

  @override
  String get requestInputCompanyError =>
      'Veuillez entrer le nom de l\'entreprise';

  @override
  String get requestInputAmount => 'Montant';

  @override
  String get requestInputAmountHint => 'Entrez le montant';

  @override
  String get requestInputAmountError => 'Veuillez entrer le montant';

  @override
  String get requestInputPrice => 'Prix';

  @override
  String get requestInputPriceHint => 'Entrez le prix';

  @override
  String get requestInputPriceError => 'Veuillez entrer le prix';

  @override
  String get requestInputDate => 'Date';

  @override
  String get requestInputDateHint => 'Sélectionnez la date';

  @override
  String get requestInputStatus => 'Statut de la demande';

  @override
  String get requestInputStatusHint => 'Sélectionnez le statut';

  @override
  String get requestInputSubmit => 'Envoyer la demande';

  @override
  String get requestInputSaveChanges => 'Enregistrer les modifications';

  @override
  String get requestInputSuccess => 'Votre demande a été soumise avec succès';

  @override
  String get requestInputUpdateSuccess => 'Demande mise à jour avec succès';

  @override
  String requestInputError(Object error) {
    return 'Erreur : $error';
  }

  @override
  String get requestInputFillAll => 'Veuillez remplir tous les champs';

  @override
  String get businessDashboardTitle => 'Tableau de bord';

  @override
  String get businessDashboardDefaultTitle => 'Tableau de bord';

  @override
  String get businessDashboardLocationUnknown => 'Aucun emplacement';

  @override
  String get businessDashboardProductType => 'Type de produit';

  @override
  String get businessDashboardProductTypeUnknown => 'Aucun produit';

  @override
  String get businessDashboardStartDate => 'Date de début';

  @override
  String get businessDashboardDateUnknown => 'Aucune date';

  @override
  String get businessDashboardStats => 'Statistiques';

  @override
  String get businessDashboardPurchases => 'Achats';

  @override
  String get businessDashboardSales => 'Ventes';

  @override
  String get businessDashboardExpenses => 'Dépenses';

  @override
  String get businessDashboardProfit => 'Profit';

  @override
  String get businessDashboardActions => 'Actions';

  @override
  String get businessDashboardProfitShare => 'Distribution du profit';

  @override
  String get businessDashboardActive => 'Actif';

  @override
  String get businessDashboardInactive => 'Inactif';

  @override
  String get businessDashboardPending => 'En attente';

  @override
  String get businessDashboardStatus => 'Statut';

  @override
  String businessDashboardError(Object error) {
    return 'Erreur : $error';
  }

  @override
  String get businessListTitle => 'Liste des entreprises';

  @override
  String businessListCount(Object count) {
    return 'Entreprises $count';
  }

  @override
  String get businessListRefresh => 'Actualiser';

  @override
  String get businessListNoBusinesses => 'Aucune entreprise enregistrée';

  @override
  String get businessListAddPrompt => 'Appuyez sur + pour ajouter';

  @override
  String get businessListViewMore => 'Voir plus';

  @override
  String get businessListLocationUnknown => 'Aucun emplacement';

  @override
  String get businessListProductTypeUnknown => 'Aucun produit';

  @override
  String get businessListStatusActive => 'Actif';

  @override
  String get businessListStatusInactive => 'Inactif';

  @override
  String get businessListStatusPending => 'En attente';

  @override
  String get businessListDateUnknown => 'Aucune date';

  @override
  String get businessInformationTitle => 'Informations sur l\'entreprise';

  @override
  String get businessInformationName => 'Nom de l\'entreprise';

  @override
  String get businessInformationNameHint => 'Entrez le nom';

  @override
  String get businessInformationNameAbove => 'Nom :';

  @override
  String get businessInformationNameError => 'Veuillez entrer le nom';

  @override
  String get businessInformationLocation => 'Emplacement';

  @override
  String get businessInformationLocationHint => 'Entrez l\'emplacement';

  @override
  String get businessInformationLocationAbove => 'Emplacement :';

  @override
  String get businessInformationLocationError =>
      'Veuillez entrer l\'emplacement';

  @override
  String get businessInformationStartDate => 'Date de début';

  @override
  String get businessInformationStartDateHint => 'Sélectionnez la date';

  @override
  String get businessInformationStartDateAbove => 'Date de début :';

  @override
  String get businessInformationProductTypeAbove => 'Type de produit :';

  @override
  String get businessInformationProductType => 'Type de produit';

  @override
  String get businessInformationProductTypeError =>
      'Veuillez sélectionner un type';

  @override
  String get businessInformationOtherProductType => 'Spécifiez le type';

  @override
  String get businessInformationOtherProductTypeHint => 'Entrez le type';

  @override
  String get businessInformationOtherProductTypeAbove => 'Spécifiez :';

  @override
  String get businessInformationOtherProductTypeError =>
      'Veuillez entrer le type';

  @override
  String get businessInformationSave => 'Enregistrer';

  @override
  String get businessInformationSaved => 'Informations enregistrées';

  @override
  String get businessSummaryTitle => 'Résumé';

  @override
  String get businessSummaryNoInfo => 'Aucune info disponible';

  @override
  String get businessSummaryRegisterPrompt =>
      'Inscrivez une entreprise pour afficher le résumé';

  @override
  String get businessSummaryRegister => 'Enregistrer';

  @override
  String get businessSummaryDone => 'Terminé';

  @override
  String get businessSummaryInfo => 'Informations sur l\'entreprise';

  @override
  String get businessSummaryName => 'Nom :';

  @override
  String get businessSummaryLocation => 'Emplacement :';

  @override
  String get businessSummaryStartDate => 'Date de début :';

  @override
  String get businessSummaryProductType => 'Type de produit :';

  @override
  String get businessSummaryOtherProductType => 'Autre type :';

  @override
  String get businessSummaryEdit => 'Modifier';

  @override
  String get expensesListTitle => 'Liste des dépenses';

  @override
  String get expensesListNoExpenses => 'Aucune dépense enregistrée';

  @override
  String get expensesListAddPrompt => 'Appuyez sur + pour ajouter';

  @override
  String get expensesListAddExpense => 'Ajouter une dépense';

  @override
  String expensesListAmount(Object amount) {
    return '$amount TSh';
  }

  @override
  String expensesListReason(Object reason) {
    return 'Motif : $reason';
  }

  @override
  String expensesListPayer(Object payer) {
    return 'Payeur : $payer';
  }

  @override
  String get expensesListUnknown => 'Inconnu';

  @override
  String get expensesListNoDate => 'Aucune date';

  @override
  String get purchaseListTitle => 'Liste des achats';

  @override
  String get purchaseListNoPurchases => 'Aucun achat enregistré';

  @override
  String get purchaseListAddPrompt => 'Appuyez sur + pour ajouter';

  @override
  String get purchaseListAddPurchase => 'Ajouter un achat';

  @override
  String purchaseListAmount(Object amount) {
    return '$amount TSh';
  }

  @override
  String purchaseListBuyer(Object buyer) {
    return 'Acheteur : $buyer';
  }

  @override
  String get purchaseListUnknown => 'Inconnu';

  @override
  String get purchaseListNoDate => 'Aucune date';

  @override
  String get saleListTitle => 'Liste des ventes';

  @override
  String get saleListNoSales => 'Aucune vente enregistrée';

  @override
  String get saleListAddPrompt => 'Appuyez sur + pour ajouter';

  @override
  String get saleListAddSale => 'Ajouter une vente';

  @override
  String saleListAmount(Object amount) {
    return '$amount TSh';
  }

  @override
  String saleListCustomer(Object customer) {
    return 'Client : $customer';
  }

  @override
  String saleListSeller(Object seller) {
    return 'Vendeur : $seller';
  }

  @override
  String get saleListUnknown => 'Inconnu';

  @override
  String get saleListNoDate => 'Aucune date';

  @override
  String get expensesTitle => 'Enregistrer une dépense';

  @override
  String get expensesBusinessName => 'Entreprise';

  @override
  String get expensesBusinessLocationUnknown => 'Aucun emplacement';

  @override
  String get expensesInfo => 'Informations sur la dépense';

  @override
  String get expensesDate => 'Date';

  @override
  String get expensesDateHint => 'jj/mm/aaaa';

  @override
  String get expensesDateError => 'Veuillez sélectionner une date';

  @override
  String get expensesDateAbove => 'Date de la dépense';

  @override
  String get expensesReason => 'Motif de la dépense';

  @override
  String get expensesReasonHint => 'Entrez le motif';

  @override
  String get expensesReasonError => 'Veuillez entrer le motif';

  @override
  String get expensesReasonAbove => 'Motif de la dépense';

  @override
  String get expensesAmount => 'Montant';

  @override
  String get expensesAmountHint => 'Entrez le montant (TSh)';

  @override
  String get expensesAmountError => 'Veuillez entrer le montant';

  @override
  String get expensesAmountInvalidError => 'Veuillez entrer un nombre valable';

  @override
  String get expensesAmountAbove => 'Montant (TSh)';

  @override
  String get expensesPayer => 'Nom du payeur';

  @override
  String get expensesPayerHint => 'Entrez le nom du payeur';

  @override
  String get expensesPayerError => 'Veuillez entrer le nom du payeur';

  @override
  String get expensesPayerAbove => 'Payeur';

  @override
  String get expensesDescription => 'Description';

  @override
  String get expensesDescriptionHint => 'Entrez plus de détails';

  @override
  String get expensesDescriptionAbove => 'Description';

  @override
  String get expensesSave => 'Enregistrer';

  @override
  String get purchasesTitle => 'Enregistrer un achat';

  @override
  String get purchasesBusinessName => 'Entreprise';

  @override
  String get purchasesBusinessLocationUnknown => 'Aucun emplacement';

  @override
  String get purchasesInfo => 'Informations sur l\'achat';

  @override
  String get purchasesDate => 'Date';

  @override
  String get purchasesDateHint => 'jj/mm/aaaa';

  @override
  String get purchasesDateError => 'Veuillez sélectionner une date';

  @override
  String get purchasesDateAbove => 'Date de l\'achat';

  @override
  String get purchasesAmount => 'Montant';

  @override
  String get purchasesAmountHint => 'Entrez le montant (TSh)';

  @override
  String get purchasesAmountError => 'Veuillez entrer le montant';

  @override
  String get purchasesAmountInvalidError => 'Veuillez entrer un nombre valable';

  @override
  String get purchasesAmountAbove => 'Coût (TSh)';

  @override
  String get purchasesBuyer => 'Nom de l\'acheteur';

  @override
  String get purchasesBuyerHint => 'Entrez le nom';

  @override
  String get purchasesBuyerError => 'Veuillez entrer le nom';

  @override
  String get purchasesBuyerAbove => 'Acheteur';

  @override
  String get purchasesDescription => 'Description';

  @override
  String get purchasesDescriptionHint => 'Entrez plus de détails';

  @override
  String get purchasesDescriptionAbove => 'Description';

  @override
  String get purchasesSave => 'Enregistrer';

  @override
  String get salesTitle => 'Enregistrer une vente';

  @override
  String get salesBusinessName => 'Entreprise';

  @override
  String get salesBusinessLocationUnknown => 'Aucun emplacement';

  @override
  String get salesInfo => 'Informations sur la vente';

  @override
  String get salesDate => 'Date';

  @override
  String get salesDateHint => 'jj/mm/aaaa';

  @override
  String get salesDateError => 'Veuillez sélectionner une date';

  @override
  String get salesDateAbove => 'Date de la vente';

  @override
  String get salesCustomer => 'Nom du client';

  @override
  String get salesCustomerHint => 'Entrez le nom du client';

  @override
  String get salesCustomerError => 'Veuillez entrer le nom du client';

  @override
  String get salesCustomerAbove => 'Client';

  @override
  String get salesRevenue => 'Montant de la vente';

  @override
  String get salesRevenueHint => 'Entrez le montant (TSh)';

  @override
  String get salesRevenueError => 'Veuillez entrer le montant';

  @override
  String get salesRevenueInvalidError => 'Veuillez entrer un nombre valable';

  @override
  String get salesRevenueAbove => 'Chiffre d\'affaires';

  @override
  String get salesSeller => 'Nom du vendeur';

  @override
  String get salesSellerHint => 'Entrez le nom du vendeur';

  @override
  String get salesSellerError => 'Veuillez entrer le nom';

  @override
  String get salesSellerAbove => 'Vendeur';

  @override
  String get salesDescription => 'Description';

  @override
  String get salesDescriptionHint => 'Entrez plus de détails';

  @override
  String get salesDescriptionAbove => 'Description';

  @override
  String get salesSave => 'Enregistrer';

  @override
  String get badiliSarafu => 'Changer la devise';

  @override
  String get chaguaSarafuYaProgramu => 'Sélectionnez la devise';

  @override
  String get male => 'Homme';

  @override
  String get female => 'Femme';
}
