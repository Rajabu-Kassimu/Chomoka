// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get selectCountry => 'Selecionar País';

  @override
  String get pleaseSelectCountry => 'Por favor, selecione seu país';

  @override
  String get pleaseSelectCountryError =>
      'Por favor, selecione um país antes de continuar.';

  @override
  String get locationInformation => 'Informações de Localização';

  @override
  String get selectLanguage => 'Selecionar Idioma';

  @override
  String get pleaseSelectLanguage => 'Por favor, selecione o idioma';

  @override
  String get selectRegion => 'Selecionar Região';

  @override
  String get pleaseSelectRegion => 'Por favor, selecione a região';

  @override
  String get loan_based_on_shares =>
      'Especifique quantas vezes (x) um membro pode pedir empréstimo com base nas suas ações';

  @override
  String get loan_based_on_savings =>
      'Especifique quantas vezes (x) um membro pode pedir empréstimo com base nas suas poupanças';

  @override
  String get selectDistrict => 'Selecionar Distrito';

  @override
  String get pleaseSelectDistrict => 'Por favor, selecione o distrito';

  @override
  String get selectWard => 'Selecionar Bairro';

  @override
  String get pleaseSelectWard => 'Por favor, selecione o bairro';

  @override
  String get enterStreetOrVillage => 'Digite Rua ou Vila';

  @override
  String get pleaseEnterStreetOrVillage =>
      'Por favor, digite o nome da rua ou vila';

  @override
  String get dataSavedSuccessfully => 'Dados salvos com sucesso!';

  @override
  String errorSavingData(String error) {
    return 'Erro ao salvar dados: $error';
  }

  @override
  String get permissions => 'Permissões';

  @override
  String get permissionsDescription =>
      'O Chomoka requer várias permissões para funcionar corretamente e eficientemente.';

  @override
  String get permissionsRequest =>
      'Por favor, aceite todas as solicitações de permissão para continuar usando o Chomoka facilmente.';

  @override
  String get smsPermission => 'SMS';

  @override
  String get smsDescription =>
      'O Chomoka usa SMS como backup para armazenar informações quando não há internet.';

  @override
  String get locationPermission => 'Sua Localização';

  @override
  String get locationDescription =>
      'Para melhorar a eficiência do sistema, o CHOMOKA usará suas informações de localização.';

  @override
  String get mediaPermission => 'Fotos e Documentos';

  @override
  String get mediaDescription =>
      'Você pode salvar fotos, informações e documentos relacionados para verificação.';

  @override
  String get termsAndConditions => 'Termos e Condições';

  @override
  String get aboutChomoka => 'Sobre o Chomoka';

  @override
  String get aboutChomokaContent =>
      'Para usar o Chomoka, você deve concordar com os termos e condições e a política de privacidade.';

  @override
  String get dataManagement => 'Gestão de Dados';

  @override
  String get dataManagementContent =>
      'Ao usar o Chomoka, você concorda com a coleta e armazenamento dos seus dados. O sistema pode usar suas informações de localização e enviar mensagens do seu telefone.';

  @override
  String get namedData => 'Dados Nomeados';

  @override
  String get namedDataContent =>
      'Informações do grupo e dos membros serão armazenadas para registro. Não compartilharemos essas informações com ninguém sem permissão do grupo.';

  @override
  String get generalData => 'Dados Gerais';

  @override
  String get generalDataContent =>
      'Usaremos dados gerais sem mencionar nomes de membros ou grupos para entender melhor os desenvolvimentos.';

  @override
  String get acceptTerms => 'Eu aceito os termos e condições';

  @override
  String get confirm => 'Confirmar';

  @override
  String get setupChomoka => 'Configurar Chomoka';

  @override
  String get groupInfo => 'Informações do Grupo';

  @override
  String get memberInfo => 'Informações do Membro';

  @override
  String get constitutionInfo => 'Informações da Constituição';

  @override
  String get fundInfo => 'Informações do Fundo';

  @override
  String get passwordSetup => 'Configuração de Senha';

  @override
  String get passwordSetupComplete => 'Configuração de senha concluída!';

  @override
  String get finished => 'Concluído';

  @override
  String get groupInformation => 'Digite as Informações do Grupo';

  @override
  String get editGroupInformation => 'Editar Informações do Grupo';

  @override
  String get groupName => 'Nome do Grupo';

  @override
  String get enterGroupName => 'Digite o Nome do Grupo';

  @override
  String get groupNameRequired => 'O nome do grupo é obrigatório!';

  @override
  String get yearEstablished => 'Ano de Fundação';

  @override
  String get enterYearEstablished => 'Digite o Ano de Fundação';

  @override
  String get yearEstablishedRequired => 'O ano de fundação é obrigatório!';

  @override
  String get enterValidYear => 'Por favor, digite um ano válido!';

  @override
  String enterYearRange(Object currentYear) {
    return 'Por favor, digite um ano entre 1999 e $currentYear!';
  }

  @override
  String get currentRound => 'Em que rodada o grupo está';

  @override
  String get enterCurrentRound => 'Digite a rodada atual do grupo';

  @override
  String get currentRoundRequired => 'A rodada do grupo é obrigatória!';

  @override
  String get enterValidRound =>
      'Por favor, digite um número válido para a rodada!';

  @override
  String get update => 'Atualizar';

  @override
  String errorUpdatingData(Object error) {
    return 'Erro ao atualizar dados: $error';
  }

  @override
  String get groupSummary => 'Resumo do Grupo';

  @override
  String get sessionSummary => 'Resumo da Sessão';

  @override
  String get meetingFrequency => 'Com que frequência vocês se reúnem?';

  @override
  String get pleaseSelectFrequency =>
      'Por favor, selecione a frequência das reuniões!';

  @override
  String get sessionCount => 'Número de sessões em uma rodada:';

  @override
  String get enterSessionCount => 'Digite o número de sessões';

  @override
  String get sessionCountRequired => 'Por favor, informe o número de sessões';

  @override
  String get enterValidSessionCount =>
      'Por favor, digite um número válido para as sessões';

  @override
  String get pleaseNote => 'Por favor, note:';

  @override
  String allocationDescription(String allocationDescription) {
    return 'Alocação a cada $allocationDescription';
  }

  @override
  String errorOccurred(Object error) {
    return 'Erro: $error';
  }

  @override
  String get groupRegistration => 'Registro do Grupo';

  @override
  String get fines => 'Multas';

  @override
  String get lateness => 'Atraso';

  @override
  String get absentWithoutPermission => 'Ausência sem permissão';

  @override
  String get sendingRepresentative => 'Enviou representante';

  @override
  String get speakingWithoutPermission => 'Falar sem permissão';

  @override
  String get phoneUsageDuringMeeting => 'Uso do telefone durante a reunião';

  @override
  String get leadershipMisconduct => 'Má conduta da liderança';

  @override
  String get forgettingRules => 'Esquecer as regras';

  @override
  String get addNewFine => 'Adicionar Nova Multa';

  @override
  String get finesWithoutAmountWontShow =>
      'Multas sem valor não aparecerão durante as reuniões';

  @override
  String get fineType => 'Tipo de multa';

  @override
  String get addFineType => 'Adicionar Tipo de Multa';

  @override
  String get amount => 'Valor';

  @override
  String get percentage => 'Porcentagem';

  @override
  String get memberShareTitle => 'Distribuição do Membro';

  @override
  String get shareCount => 'Número de Participações';

  @override
  String get saveButton => 'Salvar';

  @override
  String get unnamed => 'Sem nome';

  @override
  String get noPhone => 'Sem telefone';

  @override
  String errorLoadingData(Object error) {
    return 'Erro ao carregar dados: $error';
  }

  @override
  String failedToUpdateStatus(Object error) {
    return 'Falha ao atualizar status: $error';
  }

  @override
  String get fixedAmount => 'Valor Fixo';

  @override
  String get enterPenaltyPercentage => 'Digite a porcentagem da penalidade';

  @override
  String get percentageRequired => 'A porcentagem é obrigatória';

  @override
  String get enterValidPercentage => 'Por favor, digite uma porcentagem válida';

  @override
  String get enterFixedAmount => 'Digite o valor fixo';

  @override
  String get fixedAmountRequired => 'O valor fixo é obrigatório';

  @override
  String get enterValidAmount => 'Por favor, digite um valor válido!';

  @override
  String get explainPenaltyUsage =>
      'Explique como as penalidades são usadas para empréstimos quando um membro não realiza todos os pagamentos no prazo.';

  @override
  String get loanDelayPenalty => 'Penalidade por atraso no empréstimo';

  @override
  String get noPercentagePenalty =>
      'Nenhuma penalidade percentual será cobrada por atrasos no empréstimo.';

  @override
  String percentagePenaltyExample(String percentage, String amount) {
    return 'Por exemplo, se um membro atrasar o pagamento do empréstimo, ele pagará $percentage% adicional por mês sobre o valor restante do empréstimo. Se ele pegar 10.000, deverá pagar uma multa de $amount por mês.';
  }

  @override
  String get noFixedAmountPenalty =>
      'Nenhuma penalidade de valor fixo será cobrada por atrasos no empréstimo.';

  @override
  String fixedAmountPenaltyExample(String amount) {
    return 'Por exemplo, se um membro atrasar o pagamento do empréstimo, ele pagará $amount como penalidade fixa por atraso.';
  }

  @override
  String get addAmount => 'Adicionar Valor';

  @override
  String get cancel => 'Cancelar';

  @override
  String get save => 'Salvar';

  @override
  String get continue_ => 'Continuar';

  @override
  String get editRegistration => 'Editar Registro';

  @override
  String get registrationStatus => 'Status do Registro';

  @override
  String get selectRegistrationStatus => 'Selecionar Status do Registro';

  @override
  String get pleaseSelectRegistrationStatus =>
      'Por favor, selecione o status do registro';

  @override
  String get appVersionName => 'Chapati Versão 1.0.0';

  @override
  String get appVersionNumber => 'Versão 0001';

  @override
  String get open => 'Abrir';

  @override
  String get demo => 'Demonstração';

  @override
  String get exercise => 'Exercício';

  @override
  String get registrationNumber => 'Número de Registro';

  @override
  String get enterRegistrationNumber => 'Digite o número de registro';

  @override
  String get pleaseEnterRegistrationNumber =>
      'Por favor, digite o número de registro';

  @override
  String get correct => 'Correto';

  @override
  String get groupInstitution => 'Instituição do Grupo';

  @override
  String get editInstitution => 'Editar Instituição do Grupo';

  @override
  String get selectOrganization => 'Selecionar Organização';

  @override
  String get pleaseSelectOrganization => 'Por favor, selecione a organização';

  @override
  String get enterOrganizationName => 'Digite o nome da organização';

  @override
  String get organizationNameRequired => 'O nome da organização é obrigatório!';

  @override
  String get selectProject => 'Selecionar Projeto';

  @override
  String get pleaseSelectProject => 'Por favor, selecione o projeto';

  @override
  String get enterProjectName => 'Digite o nome do projeto';

  @override
  String get projectNameRequired => 'O nome do projeto é obrigatório!';

  @override
  String get enterTeacherId => 'Digite o ID do Professor';

  @override
  String get teacherIdRequired => 'O ID do professor é obrigatório!';

  @override
  String get continueText => 'Continuar';

  @override
  String get selectKeyToReset => 'Selecione a chave para redefinir';

  @override
  String get keyHolderSecretQuestion =>
      'O membro titular da chave selecionado será questionado com uma pergunta secreta durante a configuração da chave';

  @override
  String get resetKey1 => 'Redefinir chave 1';

  @override
  String get resetKey2 => 'Redefinir chave 2';

  @override
  String get resetKey3 => 'Redefinir chave 3';

  @override
  String get selectQuestion => 'Selecionar Pergunta';

  @override
  String get answerToQuestion => 'Resposta à pergunta';

  @override
  String get enterAnswer => 'Digite a resposta';

  @override
  String get incorrectQuestionOrAnswer => 'Pergunta ou resposta incorreta';

  @override
  String get pleaseSelectQuestionAndAnswer =>
      'Por favor, selecione a pergunta e a resposta';

  @override
  String get passwordsDoNotMatchTryAgain =>
      'As senhas não coincidem, tente novamente';

  @override
  String get confirmPasswordTitle => 'Confirmar Senha para';

  @override
  String get groupOverview => 'Visão geral do grupo';

  @override
  String get fundOverview => 'Visão geral do fundo';

  @override
  String get meetingSummary => 'Resumo da Reunião';

  @override
  String get allocation => 'Alocação';

  @override
  String get registration => 'Registro do Grupo';

  @override
  String get registrationType => 'Tipo de Registro';

  @override
  String get institutionalInfo => 'Informações Institucionais';

  @override
  String get institutionName => 'Nome da Instituição';

  @override
  String get projectName => 'Nome do Projeto';

  @override
  String get teacherId => 'ID do Professor';

  @override
  String get location => 'Localização';

  @override
  String get loanGuarantors => 'Garantidores do Empréstimo';

  @override
  String get doesLoanNeedGuarantor => 'O empréstimo precisa de garantidor?';

  @override
  String get numberOfGuarantors => 'Número de Garantidores';

  @override
  String get enterNumberOfGuarantors => 'Digite o número de garantidores';

  @override
  String get numberOfGuarantorsRequired =>
      'O número de garantidores é obrigatório';

  @override
  String get securityQuestion1 => 'Em que ano nasceu seu primeiro filho?';

  @override
  String get securityQuestion2 => 'Qual o primeiro nome do seu primeiro filho?';

  @override
  String get securityQuestion3 => 'Em que ano você nasceu?';

  @override
  String get errorSelectQuestion =>
      'Por favor, selecione uma pergunta de segurança.';

  @override
  String get errorEnterAnswer => 'Por favor, responda à pergunta.';

  @override
  String get errorSaving =>
      'Houve um problema ao salvar. Por favor, tente novamente.';

  @override
  String resetQuestionPageTitle(int passwordNumber) {
    return 'Pergunta de segurança para chave $passwordNumber';
  }

  @override
  String get selectQuestionLabel => 'Selecionar Pergunta';

  @override
  String get selectQuestionHint => 'Selecionar Pergunta';

  @override
  String get answerLabel => 'Resposta';

  @override
  String get answerHint => 'Digite a Resposta';

  @override
  String get pleaseEnterValidNumber => 'Por favor, insira um número válido';

  @override
  String get describeNumberOfGuarantors =>
      'Descreva o número de garantidores necessários para solicitar um empréstimo';

  @override
  String get country => 'País';

  @override
  String get region => 'Região';

  @override
  String get district => 'Distrito';

  @override
  String get ward => 'Bairro';

  @override
  String get streetOrVillage => 'Rua ou Vila';

  @override
  String get sendSummary => 'ENVIAR RESUMO';

  @override
  String get completed => 'concluído';

  @override
  String members(Object count) {
    return 'Membros: $count';
  }

  @override
  String get noMembers => 'Nenhum membro disponível.';

  @override
  String errorFetchingMembers(Object error) {
    return 'Erro ao obter membros: $error';
  }

  @override
  String get memberSummary => 'Resumo do Membro';

  @override
  String get memberIdentity => 'Identidade do Membro';

  @override
  String get fullName => 'Nome Completo:';

  @override
  String get memberNumber => 'Número do Membro:';

  @override
  String get gender => 'Gênero:';

  @override
  String get dob => 'Data de Nascimento:';

  @override
  String get phoneNumber => 'Número de Telefone:';

  @override
  String get job => 'Profissão:';

  @override
  String get idType => 'Tipo de ID:';

  @override
  String get idNumber => 'Número do ID:';

  @override
  String get noPhoneNumber => 'Membro não possui número de telefone';

  @override
  String summarySent(Object name) {
    return 'Resumo enviado para $name com sucesso';
  }

  @override
  String failedToSendSms(Object name) {
    return 'Falha ao enviar SMS para $name';
  }

  @override
  String get totalSavings => 'Total de Poupanças';

  @override
  String get totalDebt => 'Dívida Total';

  @override
  String get totalShares => 'Total de Ações';

  @override
  String get communityFundBalance => 'Saldo do Fundo Comunitário';

  @override
  String get currentLoans => 'Empréstimos Atuais';

  @override
  String get totalFinesCollected => 'Total de Multas Coletadas';

  @override
  String get confirmDeleteUser =>
      'Tem certeza que deseja excluir este usuário?';

  @override
  String get delete => 'Excluir';

  @override
  String get enterMemberNumber => 'Digite o Número do Membro';

  @override
  String get memberNumberRequired => 'Por favor, digite o número do membro';

  @override
  String get memberNumberDigitsOnly =>
      'O número do membro deve conter apenas dígitos';

  @override
  String get enterFullName => 'Digite o Nome Completo';

  @override
  String get fullNameRequired => 'Por favor, digite o nome completo do membro';

  @override
  String get fullNameMinLength => 'O nome deve ter ao menos 3 caracteres';

  @override
  String get selectYear => 'Selecionar Ano';

  @override
  String get selectMonth => 'Selecionar Mês';

  @override
  String get selectDay => 'Selecionar Dia';

  @override
  String get dobRequired =>
      'Por favor, selecione a data completa de nascimento';

  @override
  String get uniqueMemberNumber => 'O número do membro deve ser único';

  @override
  String get noActiveCycle => 'Erro: Nenhum ciclo ativo encontrado!';

  @override
  String get appTagline => 'Ajudamos você a fortalecer o desenvolvimento';

  @override
  String get example => 'Exemplo';

  @override
  String get mzungukoPendingNoNew =>
      'O ciclo atual já está \"pendente\". Nenhum novo ciclo foi iniciado.';

  @override
  String get newMzungukoCreated => 'Novo ciclo iniciado com sucesso!';

  @override
  String errorSavingMzunguko(String error) {
    return 'Erro ao salvar ou atualizar informações do ciclo: $error';
  }

  @override
  String get weekly => 'Semanal';

  @override
  String get biWeekly => 'A cada duas semanas';

  @override
  String get monthly => 'Mensal';

  @override
  String years(int count) {
    return '$count Anos';
  }

  @override
  String months(int count) {
    return 'meses';
  }

  @override
  String weeks(int count) {
    return '$count Semanas';
  }

  @override
  String get registered => 'Registrado';

  @override
  String get notRegistered => 'Não Registrado';

  @override
  String get other => 'Outro';

  @override
  String get memberPhoneNumber => 'Número de Telefone do Membro';

  @override
  String get enterMemberPhoneNumber => 'Digite o Número de Telefone do Membro';

  @override
  String get selectJob => 'Selecionar Profissão';

  @override
  String get enterJobName => 'Digite o Nome da Profissão';

  @override
  String get pleaseSelectJob => 'Por favor, selecione a profissão';

  @override
  String get pleaseEnterJobName => 'Por favor, digite o nome da profissão';

  @override
  String get selectIdType => 'Selecionar Tipo de Identificação';

  @override
  String get enterIdNumber => 'Digite o Número da Identificação';

  @override
  String get pleaseSelectIdType =>
      'Por favor, selecione o tipo de identificação';

  @override
  String get pleaseEnterIdNumber =>
      'Por favor, digite o número da identificação';

  @override
  String get idPhoto => 'Foto da Identificação';

  @override
  String get removePhoto => 'Remover Foto';

  @override
  String get takePhoto => 'Tirar Foto';

  @override
  String get chooseFromGallery => 'Escolher da Galeria';

  @override
  String get farmer => 'Agricultor';

  @override
  String get teacher => 'Professor';

  @override
  String get doctor => 'Médico';

  @override
  String get entrepreneur => 'Empreendedor';

  @override
  String get engineer => 'Engenheiro';

  @override
  String get lawyer => 'Advogado';

  @override
  String get none => 'Nenhum';

  @override
  String get voterCard => 'Título de Eleitor';

  @override
  String get nationalId => 'Identidade Nacional';

  @override
  String get zanzibarResidentCard => 'Cartão de Residente de Zanzibar';

  @override
  String get driversLicense => 'Carteira de Motorista';

  @override
  String get localGovernmentLetter => 'Carta do Governo Local';

  @override
  String get errorSavingPhoto => 'Falha ao salvar a foto do membro';

  @override
  String get errorRemovingPhoto => 'Falha ao remover a foto';

  @override
  String get errorLoadingPhoto => 'Falha ao carregar a foto do membro';

  @override
  String get memberInformation => 'Informações do Membro';

  @override
  String get memberIdentification => 'Identificação do Membro';

  @override
  String get dateOfBirth => 'Data de Nascimento';

  @override
  String get occupation => 'Ocupação';

  @override
  String get mandatorySavings => 'Poupança Obrigatória';

  @override
  String get voluntarySavings => 'Poupança Voluntária';

  @override
  String get communityFund => 'Fundo Comunitário';

  @override
  String get currentLoan => 'Empréstimo Atual';

  @override
  String get finish => 'Finalizar';

  @override
  String get enterKey1 => 'Digite a Chave 1';

  @override
  String get enterKey2 => 'Digite a Chave 2';

  @override
  String get enterKey3 => 'Digite a Chave 3';

  @override
  String get enterAllKeys => 'Por favor, preencha as três chaves.';

  @override
  String get invalidKeys =>
      'As chaves secretas estão incorretas. Por favor, tente novamente.';

  @override
  String get systemError => 'Ocorreu um problema. Por favor, tente mais tarde.';

  @override
  String get resetSecurityKeys => 'REDEFINIR CHAVES DE SEGURANÇA';

  @override
  String get openButton => 'ABRIR';

  @override
  String get pleaseEnterNewPassword => 'Por favor, digite a nova senha';

  @override
  String get passwordMustBeDigitsOnly => 'A senha deve conter apenas dígitos';

  @override
  String get passwordMustBeLessThan4Digits =>
      'A senha deve ter menos de 4 dígitos';

  @override
  String get pleaseConfirmNewPassword => 'Por favor, confirme a nova senha';

  @override
  String get passwordsDoNotMatch => 'As senhas não coincidem';

  @override
  String get errorOccurredTryAgain =>
      'Ocorreu um erro. Por favor, tente novamente.';

  @override
  String editPasswordFor(String key) {
    return 'Editar senha para $key';
  }

  @override
  String get newPassword => 'Nova Senha';

  @override
  String get confirmNewPassword => 'Confirmar Nova Senha';

  @override
  String get enterNewPassword => 'Digite a nova senha';

  @override
  String get getHelp => 'Obter Ajuda';

  @override
  String get welcomeChomokaPlus => 'Bem-vindo ao Chomoka Plus';

  @override
  String groupOf(Object groupName) {
    return 'Grupo de: $groupName';
  }

  @override
  String get dashboardHelpText =>
      'Ajudamos você a manter registros do seu grupo de forma eficiente.';

  @override
  String get groupServices => 'Serviços do Grupo';

  @override
  String get startMeeting => 'Iniciar Reunião';

  @override
  String get continueExistingMeeting => 'Continuar reunião existente';

  @override
  String get openNewMeeting => 'Abrir nova reunião do grupo';

  @override
  String get group => 'GRUPO';

  @override
  String get constitution => 'Constituição';

  @override
  String get shareCalculation => 'Cálculo de Cotas';

  @override
  String get systemFeedback => 'Feedback do Sistema';

  @override
  String get groupActivities => 'Atividades do Grupo';

  @override
  String get moreServices => 'Mais Serviços';

  @override
  String get history => 'Histórico';

  @override
  String get viewGroupHistory => 'Ver histórico de atividades do grupo';

  @override
  String get backupRestore => 'Backup e Restauração';

  @override
  String get backupRestoreDesc => 'Backup e restauração dos registros do grupo';

  @override
  String get chomokaPlusVersion => 'Chomoka Plus v2.0';

  @override
  String get finishShare => 'Finalizar Cota';

  @override
  String get finishShareDesc =>
      'O último ciclo está completo. Por favor, finalize a cota.';

  @override
  String get ok => 'OK';

  @override
  String get meetingOptionsWelcome => 'Bem-vindo a Outra Reunião';

  @override
  String get midCycleInfo => 'Esta é a informação de meio de ciclo';

  @override
  String get openMeetingButton => 'ABRIR REUNIÃO';

  @override
  String get startNewCycleQuestion => 'Você está começando um novo ciclo?';

  @override
  String get pressYesToStartFirstMeeting =>
      'PRESSIONE SIM PARA CONDUZIR A PRIMEIRA REUNIÃO';

  @override
  String get pressNoForPastMeetings =>
      'PRESSIONE NÃO PARA REGISTRAR REUNIÕES PASSADAS';

  @override
  String get getHelpTitle => 'Obter Ajuda';

  @override
  String get needHelpContact => 'Precisa de ajuda? Contate-nos via:';

  @override
  String get call => 'Ligar';

  @override
  String get whatsapp => 'WhatsApp';

  @override
  String get email => 'Email';

  @override
  String get faq => 'Perguntas Frequentes';

  @override
  String get close => 'Fechar';

  @override
  String get failedToOpenPhone => 'Falha ao abrir o telefone.';

  @override
  String get failedToOpenWhatsApp =>
      'WhatsApp não está disponível no seu telefone.';

  @override
  String get failedToOpenWhatsAppGeneric => 'Falha ao abrir o WhatsApp.';

  @override
  String get failedToOpenEmail => 'Falha ao abrir o email.';

  @override
  String get constitutionAppTitle => 'Informações da Constituição';

  @override
  String get constitutionGroupType => 'Tipo de Grupo';

  @override
  String get kayaCmg => 'Kaya CMG';

  @override
  String get kayaCmgHint =>
      'Usamos poupança obrigatória e voluntária para empréstimos';

  @override
  String get vsla => 'VSLA';

  @override
  String get vslaHint =>
      'Usamos cotas para economizar dinheiro e temos 5 líderes';

  @override
  String get shareSubtitle => 'Cotas';

  @override
  String get sharePrompt => 'Qual o valor de uma cota em Shillings?';

  @override
  String get shareValueLabel => 'Valor da Cota';

  @override
  String get shareValueHint => 'Digite o valor da cota';

  @override
  String get shareValueRequired => 'Valor da cota é obrigatório';

  @override
  String get invalidShareValue => 'Por favor, digite um valor válido';

  @override
  String get groupLeadersSubtitle => 'Líderes do Grupo';

  @override
  String get editButton => 'Editar';

  @override
  String get selectAllLeadersError => 'Por favor, selecione todos os líderes';

  @override
  String positionLabel(Object position) {
    return '$position';
  }

  @override
  String selectPositionHint(Object position) {
    return 'Selecione $position';
  }

  @override
  String positionRequired(Object position) {
    return 'Por favor, selecione $position';
  }

  @override
  String get jumlaYaHisa => 'Total de Ações';

  @override
  String get mfukoWaJamiiSalio => 'Saldo do Fundo Comunitário';

  @override
  String get salioLililolalaSandukuni => 'Saldo da Caixa';

  @override
  String get failedToLoadSummaryData =>
      'Falha ao carregar dados resumidos. Por favor, tente novamente.';

  @override
  String get jumlaYa => 'Total de';

  @override
  String get wekaJumlaYa => 'Digite o total de';

  @override
  String get tafadhaliJazaJumlaYa => 'Por favor, preencha o total de';

  @override
  String get tafadhaliIngizaNambariHalali =>
      'Por favor, insira um número válido.';

  @override
  String get jumlaLazimaIweIsiyoHasi => 'O total deve ser não negativo.';

  @override
  String get loadingData => 'Carregando dados...';

  @override
  String get taarifaKatikatiYaMzunguko => 'Informações do Meio do Ciclo';

  @override
  String get jumlaZaKikundi => 'Totais do Grupo';

  @override
  String get chairperson => 'Presidente';

  @override
  String get secretary => 'Secretário';

  @override
  String get treasurer => 'Tesoureiro';

  @override
  String get counter1 => 'Contador número 1';

  @override
  String get counter2 => 'Contador número 2';

  @override
  String get finesTitle => 'Informações da Constituição';

  @override
  String get finesSubtitle => 'Multas';

  @override
  String get finesEmptyAmountNote =>
      'Multas sem valor não aparecerão durante a reunião';

  @override
  String get enterFineType => 'Digite o tipo de multa';

  @override
  String get enterAmount => 'Digite o valor';

  @override
  String get phoneUseInMeeting => 'Uso do telefone durante a reunião';

  @override
  String get amountPlaceholder => 'valor';

  @override
  String get loanAmountTitle => 'Informações da Constituição';

  @override
  String get loanAmountSubtitle => 'Quanto um membro pode emprestar';

  @override
  String get loanAmountVSLAPrompt =>
      'Quantas vezes um membro pode emprestar com base nas cotas atuais?';

  @override
  String get loanAmountCMGPrompt =>
      'Quantas vezes um membro pode emprestar com base nas poupanças atuais?';

  @override
  String get loanAmountVSLAHint => 'Definir conforme as cotas atuais';

  @override
  String get loanAmountCMGHint => 'Definir conforme as poupanças atuais';

  @override
  String get loanAmountRequired =>
      'Por favor, digite um valor válido (numérico)!';

  @override
  String get loanAmountInvalidNumber => 'Por favor, digite um número válido!';

  @override
  String get loanAmountMustBePositive => 'O valor deve ser maior que zero!';

  @override
  String loanAmountExample(String amount, String type, String multiplier) {
    return 'Por exemplo, um membro pode emprestar $amount se ele tiver $type no valor de 10.000, que é $multiplier vezes seu $type.';
  }

  @override
  String get interestDescription =>
      'Descreva como as cobranças de serviço se aplicam aos seus empréstimos';

  @override
  String get yes => 'Sim';

  @override
  String get no => 'Não';

  @override
  String get selectFund => 'Selecionar Fundo';

  @override
  String get fundWithoutName => 'Fundo Sem Nome';

  @override
  String get addAnotherFund => 'Adicionar Outro Fundo';

  @override
  String get communityFundInfo => 'Informações do Fundo Comunitário';

  @override
  String get fundName => 'Nome do Fundo';

  @override
  String get enterFundName => 'Digite o Nome do Fundo';

  @override
  String get fundNameRequired => 'Nome do fundo é obrigatório!';

  @override
  String get contributionAmount => 'Valor da Contribuição';

  @override
  String get enterContributionAmount => 'Digite o Valor da Contribuição';

  @override
  String get contributionAmountRequired =>
      'Valor da contribuição é obrigatório!';

  @override
  String get edit => 'Editar';

  @override
  String get withdrawalReasons => 'Motivos para Retirada';

  @override
  String get noReasonsRecorded => 'Nenhum motivo registrado';

  @override
  String get equalAmount => 'Valor igual';

  @override
  String get anyAmount => 'Qualquer valor';

  @override
  String get notWithdrawableMidCycle => 'Não retirável no meio do ciclo';

  @override
  String get withdrawByMemberName => 'Retirar pelo nome do membro';

  @override
  String get withdrawAsGroup => 'Retirar como grupo';

  @override
  String get select => 'Selecionar';

  @override
  String get education => 'Educação';

  @override
  String get agriculture => 'Agricultura';

  @override
  String get communityProject => 'Projeto Comunitário';

  @override
  String get cocoa => 'Cacau';

  @override
  String get otherGoals => 'Outros Objetivos';

  @override
  String get pleaseSelectContributionProcedure =>
      'Por favor, selecione o Procedimento de Contribuição';

  @override
  String get pleaseSelectWithdrawalProcedure =>
      'Por favor, selecione os Procedimentos de Retirada';

  @override
  String get dataUpdatedSuccessfully => 'Dados atualizados com sucesso!';

  @override
  String get errorSavingDataGeneric =>
      'Houve um erro ao salvar os dados. Por favor, tente novamente.';

  @override
  String get fundInformation => 'Informações do Fundo';

  @override
  String get fundProcedures => 'Procedimentos do Fundo';

  @override
  String get pleaseEnterFundName => 'Por favor, digite o nome do Fundo';

  @override
  String get fundGoals => 'Objetivos do Fundo';

  @override
  String get pleaseSelectFundGoal =>
      'Por favor, selecione um Objetivo do Fundo';

  @override
  String get enterOtherGoals => 'Digite Outros Objetivos';

  @override
  String get pleaseEnterOtherGoals => 'Por favor, digite Outros Objetivos';

  @override
  String get contributionProcedure => 'Procedimento de Contribuição';

  @override
  String get pleaseEnterContributionAmount =>
      'Por favor, digite o Valor da Contribuição';

  @override
  String get loanable => 'Passível de Empréstimo';

  @override
  String get withdrawalProcedures => 'Procedimentos de Retirada';

  @override
  String get fundProcedure => 'Procedimento do Fundo';

  @override
  String get withdrawalProcedure => 'Procedimento de Retirada';

  @override
  String get notWithdrawableDuringCycle => 'Não retirável durante o ciclo';

  @override
  String get selectOption => 'Selecionar';

  @override
  String get fundSummarySubtitle => 'Resumo do Fundo';

  @override
  String get withdrawalType => 'Tipo de Contribuição';

  @override
  String get deleteFundTitle => 'Excluir Fundo?';

  @override
  String get thisFund => 'Este fundo';

  @override
  String get deleteFundWarning => 'Esta ação não pode ser desfeita.';

  @override
  String setPasswordTitle(Object step) {
    return 'Definir senha para $step';
  }

  @override
  String get allPasswordsSetTitle => 'Todas as Senhas Definidas';

  @override
  String get backupCompleted => 'Backup concluído com sucesso!';

  @override
  String get uhifadhiKumbukumbu => 'Backup de Dados';

  @override
  String get tumaTaarifa => 'Enviar Informações';

  @override
  String get chaguaMahaliNaHifadhi => 'Escolher Local e Salvar';

  @override
  String get hifadhiNakala => 'Salvar Cópia';

  @override
  String get hifadhiNakalaRafiki => 'Enviar Backup para um Amigo';

  @override
  String get hifadhiNakalaRafikiDescription =>
      'Envie uma cópia dos dados do Chomoka para seu amigo para maior segurança.';

  @override
  String get uhifadhiKumbukumbuDescription =>
      'Faça backup dos seus dados do Chomoka em um arquivo ZIP. Você pode restaurar esses dados a qualquer momento.';

  @override
  String get error => 'Erro';

  @override
  String errorSharingBackup(Object error) {
    return 'Erro ao compartilhar backup: $error';
  }

  @override
  String get uwekaji_taarifa_katikati_mzunguko =>
      'Entrada de Informações no Meio do Ciclo';

  @override
  String get loading_group_data => 'Carregando dados do grupo...';

  @override
  String get kikundi_mzunguko => 'Em qual ciclo o grupo está?';

  @override
  String get taarifa_zimehifadhiwa => 'Dados salvos com sucesso!';

  @override
  String imeshindwa_kuhifadhi(Object error) {
    return 'Falha ao salvar dados: $error';
  }

  @override
  String get thibitisha_ingizo => 'Falha na validação da entrada.';

  @override
  String get namba_kikao => 'Número da Sessão';

  @override
  String get ingiza_namba_kikao => 'Digite o número da sessão';

  @override
  String get namba_kikao_inahitajika => 'Número da sessão é obrigatório';

  @override
  String get namba_kikao_halali =>
      'Por favor, insira um número de sessão válido';

  @override
  String get endelea => 'Continuar';

  @override
  String get taarifa_kikao_kilichopita => 'Informações da Sessão Anterior';

  @override
  String get hisa_wanachama => 'Ações dos Membros';

  @override
  String get muhtasari_kikao => 'Resumo da Sessão';

  @override
  String get jumla_kikundi => 'Total do Grupo';

  @override
  String get akiba_wanachama => 'Poupanças dos Membros';

  @override
  String get akiba_binafsi => 'Poupança Pessoal';

  @override
  String get wadaiwa_mikopo => 'Devedores de Empréstimos';

  @override
  String get mchango_haujalipwa => 'Contribuições Não Pagas';

  @override
  String get jumla_hisa => 'Total de Ações';

  @override
  String get jumla_akiba => 'Total de Poupanças';

  @override
  String get jumla_mikopo => 'Total de Empréstimos';

  @override
  String get jumla_riba => 'Total de Juros';

  @override
  String get jumla_adhabu => 'Total de Multas';

  @override
  String get jumla_mfuko_jamii => 'Total do Fundo Comunitário';

  @override
  String get chaguaNjiaUhifadhi => 'Selecione o Método de Backup';

  @override
  String get taarifaZimehifadhiwa => 'Informação salva com sucesso!';

  @override
  String get sawa => 'OK';

  @override
  String uhifadhiProgress(Object progress) {
    return 'Progresso do Backup: $progress%';
  }

  @override
  String get midCycleMeetingInfo => 'Informações da Reunião de Meio de Ciclo';

  @override
  String get groupTotals => 'Totais do Grupo';

  @override
  String get groupTotalsSummary => 'Resumo dos Totais do Grupo';

  @override
  String get enterTotalShares => 'Digite o total de ações';

  @override
  String get pleaseEnterTotalShares => 'Por favor, digite o total de ações';

  @override
  String get shareValue => 'Valor da Ação:';

  @override
  String get enterShareValue => 'Digite o valor por ação';

  @override
  String get pleaseEnterShareValue => 'Por favor, digite o valor por ação';

  @override
  String get enterTotalSavings => 'Digite o total de poupanças';

  @override
  String get pleaseEnterTotalSavings =>
      'Por favor, digite o total de poupanças';

  @override
  String get enterCommunityFundBalance => 'Digite o saldo do fundo comunitário';

  @override
  String get pleaseEnterCommunityFundBalance =>
      'Por favor, digite o saldo do fundo comunitário';

  @override
  String get pleaseEnterValidPositiveNumber =>
      'O valor deve ser um número positivo';

  @override
  String get memberShares => 'Ações dos Membros';

  @override
  String get unpaidContributions => 'Contribuições Não Pagas';

  @override
  String get memberContributions => 'Contribuições do Membro';

  @override
  String get fineOwed => 'Multas Devidas';

  @override
  String get enterFineOwed => 'Digite as multas devidas';

  @override
  String get pleaseEnterFineOwed => 'Por favor, digite as multas devidas';

  @override
  String get communityFundOwed => 'Fundo Comunitário Devido';

  @override
  String get enterCommunityFundOwed =>
      'Digite o valor devido ao fundo comunitário';

  @override
  String get pleaseEnterCommunityFundOwed =>
      'Por favor, digite o valor devido ao fundo comunitário';

  @override
  String get loanInformation => 'Informações do Empréstimo';

  @override
  String get memberLoanInfo => 'Informações do Empréstimo do Membro';

  @override
  String get selectReason => 'Selecione o Motivo';

  @override
  String get reasonForLoan => 'Motivo do Empréstimo';

  @override
  String get pleaseSelectReason => 'Por favor, selecione um motivo';

  @override
  String get houseRenovation => 'Reforma da Casa';

  @override
  String get business => 'Negócios';

  @override
  String get enterOtherReason => 'Digite outro motivo';

  @override
  String get otherReason => 'Outro Motivo';

  @override
  String get pleaseEnterOtherReason => 'Por favor, digite o outro motivo';

  @override
  String get loanAmount => 'Valor do Empréstimo';

  @override
  String get enterLoanAmount => 'Digite o valor do empréstimo';

  @override
  String get pleaseEnterLoanAmount => 'Por favor, digite o valor do empréstimo';

  @override
  String get pleaseEnterValidAmount => 'Por favor, insira um valor válido';

  @override
  String get amountPaid => 'Valor Pago:';

  @override
  String get enterAmountPaid => 'Digite o valor pago';

  @override
  String get pleaseEnterAmountPaid => 'Por favor, digite o valor pago';

  @override
  String get outstandingBalance => 'Saldo Pendentes';

  @override
  String get calculatedAutomatically => 'Calculado automaticamente';

  @override
  String get pleaseEnterOutstandingAmount =>
      'Por favor, digite o saldo pendente';

  @override
  String get loanMeeting => 'Reunião do Empréstimo';

  @override
  String get enterLoanMeeting => 'Digite o número da reunião do empréstimo';

  @override
  String get pleaseEnterLoanMeeting =>
      'Por favor, digite o número da reunião do empréstimo';

  @override
  String get loanDuration => 'Duração do Empréstimo (Meses)';

  @override
  String get enterLoanDuration => 'Digite a duração em meses';

  @override
  String get pleaseEnterLoanDuration =>
      'Por favor, digite a duração do empréstimo';

  @override
  String get loading => 'Carregando...';

  @override
  String get noMembersFound => 'Nenhum membro encontrado.';

  @override
  String get searchByNameOrPhone => 'Pesquisar por nome ou telefone';

  @override
  String get memberList => 'Lista de Membros';

  @override
  String get validate => 'Validar';

  @override
  String get dataValidationFailed => 'Falha na validação dos dados.';

  @override
  String get shareInformation => 'Informações das Ações';

  @override
  String get saveShares => 'Salvar Ações';

  @override
  String get shares => 'Ações';

  @override
  String get enterShares => 'Digite o número de ações';

  @override
  String get loanSummary => 'Resumo do Empréstimo';

  @override
  String get memberLoanSummary => 'Resumo do Empréstimo do Membro';

  @override
  String get loanDetails => 'DETALHES DO EMPRÉSTIMO';

  @override
  String get vslaMemberShares => 'Ações dos Membros';

  @override
  String get vslaShareInformation => 'Informações das Ações';

  @override
  String get vslaShareValue => 'Valor da Ação';

  @override
  String get vslaTotalShares => 'Total de Ações';

  @override
  String get vslaShareValuePerShare => 'Valor por Ação';

  @override
  String get vslaEnterShareCount => 'Digite o número de ações';

  @override
  String get vslaShareCountRequired => 'Número de ações é obrigatório';

  @override
  String get vslaEnterValidShareCount =>
      'Por favor, insira um número válido de ações';

  @override
  String get vslaSaveShares => 'Salvar Ações';

  @override
  String get vslaSharesSavedSuccessfully =>
      'Ações dos membros salvas com sucesso!';

  @override
  String vslaTotalSharesMustMatch(String total, String current) {
    return 'O total de ações deve ser $total. Atualmente $current. Por favor, ajuste.';
  }

  @override
  String get vslaGroupTotals => 'Totais do Grupo';

  @override
  String get vslaGroupTotalsSummary => 'Resumo dos Totais do Grupo';

  @override
  String get vslaCommunityFundBalance => 'Saldo do Fundo Comunitário';

  @override
  String get vslaBoxBalance => 'Saldo da Caixa';

  @override
  String get vslaCurrentLoanBalance => 'Saldo Atual do Empréstimo';

  @override
  String get vslaMembers => 'Membros';

  @override
  String get vslaUnpaidContributions => 'Contribuições Não Pagas';

  @override
  String get vslaTotalFinesOwed => 'Total de Multas Devidas';

  @override
  String get vslaEnterTotalShares => 'Digite o Total de Ações';

  @override
  String get vslaEnterCommunityFundBalance =>
      'Digite o Saldo do Fundo Comunitário';

  @override
  String get vslaEnterBoxBalance => 'Digite o Saldo da Caixa';

  @override
  String get vslaPleaseEnterTotalShares => 'Por favor, digite o total de ações';

  @override
  String get vslaPleaseEnterCommunityFundBalance =>
      'Por favor, digite o saldo do fundo comunitário';

  @override
  String get vslaPleaseEnterBoxBalance => 'Por favor, digite o saldo da caixa';

  @override
  String get vslaPleaseEnterValidPositiveNumber =>
      'O valor deve ser um número positivo';

  @override
  String get vslaMidCycleInformation => 'Informações do Meio do Ciclo';

  @override
  String get vslaMemberShareTitle => 'Ações dos Membros';

  @override
  String get vslaMemberShareSubtitle =>
      'Digite as informações das ações do membro';

  @override
  String get vslaMemberNumber => 'Número do Membro';

  @override
  String get vslaShareCount => 'Contagem de Ações';

  @override
  String get vslaNoMembersFound => 'Nenhum membro encontrado';

  @override
  String get vslaErrorLoadingData =>
      'Erro ao carregar dados. Por favor, tente novamente.';

  @override
  String vslaErrorSavingData(String error) {
    return 'Erro ao salvar dados: $error';
  }

  @override
  String get uwekajiTaarifaKatikaMzunguko =>
      'Entrada de Dados no Meio do Ciclo';

  @override
  String get jumlaYaKikundi => 'Total do Grupo';

  @override
  String get hisaZaWanachama => 'Ações dos Membros';

  @override
  String get taarifaZaKikundi => 'Informações do Grupo';

  @override
  String get jumlaYaTaarifaZaKikundi => 'Informações Totais do Grupo';

  @override
  String get inapakiaTaarifa => 'Carregando informações...';

  @override
  String get hakunaTaarifaZilizopo => 'Nenhum dado disponível no momento.';

  @override
  String get taarifaZaHisa => 'Informações das Ações';

  @override
  String get thamaniYaHisaMoja => 'Valor por Ação';

  @override
  String get wekaMfukoWaJamiiSalio => 'Definir Saldo do Fundo Comunitário';

  @override
  String get tafadhaliJazaMfukoWaJamiiSalio =>
      'Por favor, preencha o Saldo do Fundo Comunitário.';

  @override
  String get wekaSalioLililolalaSandukuni => 'Definir Saldo da Caixa';

  @override
  String get tafadhaliJazaSalioLililolalaSandukuni =>
      'Por favor, preencha o Saldo da Caixa.';

  @override
  String get salioLazimaIweIsiyoHasi => 'O saldo deve ser não negativo.';

  @override
  String get jumlaYaThamaniYaHisa => 'Valor Total das Ações';

  @override
  String get tafadhaliJazaJumlaYaHisa =>
      'Por favor, preencha o total de ações.';

  @override
  String get salioLililolalaSandukuniError =>
      'O saldo da caixa deve ser maior que o total de ações e fundo comunitário.';

  @override
  String get jumlaYaHisaZote => 'Número Total de Ações';

  @override
  String get mchangoHaujalipwa => 'Contribuição Não Paga';

  @override
  String get wadaiwaMikopo => 'Devedores do Empréstimo do Grupo';

  @override
  String get muhtasari => 'Resumo';

  @override
  String get pending => 'pendente';

  @override
  String get uhifadhiKumbukumbuTitle => 'Backup de Dados';

  @override
  String get utunzajiKumbukumbuSmsTab => 'Backup via SMS';

  @override
  String get kanzidataUhifadhiTab => 'Backup do Banco de Dados';

  @override
  String get tumaTaarifaButton => 'Enviar Dados';

  @override
  String get uhifadhiKumbukumbuCardTitle => 'Backup do Banco de Dados';

  @override
  String get uhifadhiKumbukumbuCardDesc =>
      'Salve uma cópia de backup dos seus dados do Chomoka em um arquivo SQL. Você pode restaurar esses dados a qualquer momento.';

  @override
  String get chaguaMahaliNaHifadhiButton => 'Escolher Local e Salvar';

  @override
  String sqlDumpSaved(String filePath) {
    return 'Dump SQL salvo em: $filePath';
  }

  @override
  String errorWithMessage(String message) {
    return 'Erro: $message';
  }

  @override
  String get hifadhiNakalaRafikiCardTitle => 'Compartilhar Dados com um Amigo';

  @override
  String get hifadhiNakalaRafikiCardDesc =>
      'Envie com segurança uma cópia dos seus dados do Chomoka para seu amigo.';

  @override
  String get hifadhiNakalaButton => 'Compartilhar Dados';

  @override
  String get loanInterest => 'Juros do empréstimo:';

  @override
  String get interestType => 'Tipo de Juros';

  @override
  String get monthlyCalculation => 'Cálculo mensal';

  @override
  String get equalAmountAllMonths => 'Valor igual todos os meses';

  @override
  String get enterInterestRate => 'Digite a taxa de juros';

  @override
  String loanInterestExample(Object rate) {
    return 'Por exemplo, se um membro pedir 10.000 emprestado, ele pagará $rate% do saldo restante do empréstimo todos os meses. Se ele pagar o empréstimo antecipadamente, evitará pagar juros.';
  }

  @override
  String loanInterestExampleEqual(Object amount, Object rate) {
    return 'Por exemplo, se um membro pedir 10.000 emprestado, ele pagará $amount% do valor real do empréstimo. Ele pagará $rate todos os meses.';
  }

  @override
  String loanInterestExampleOnce(Object amount, Object rate) {
    return 'Por exemplo, se um membro pedir 10.000 emprestado, ele devolverá com juros de $amount% do valor real do empréstimo. Ele pagará $rate como juros ao devolver o empréstimo.';
  }

  @override
  String get constitutionTitle => 'Constituição';

  @override
  String get membershipRules => 'Regras de Associação';

  @override
  String get method => 'Método:';

  @override
  String get savings => 'Poupança';

  @override
  String get mandatorySavingsValue => 'Valor das poupanças obrigatórias:';

  @override
  String get groupLeaders => 'Líderes do Grupo';

  @override
  String get cashCounter1 => 'Caixa nº 1:';

  @override
  String get cashCounter2 => 'Caixa nº 2:';

  @override
  String get auditor => 'Auditor:';

  @override
  String get contributions => 'Contribuições';

  @override
  String get communityFundAmount => 'Valor do Fundo Comunitário:';

  @override
  String get otherFunds => 'Outros Fundos';

  @override
  String get noFines => 'Nenhuma multa registrada para este membro.';

  @override
  String get loan => 'Empréstimo';

  @override
  String get loanMultiplier =>
      'Um membro pode pegar emprestado quantas vezes o valor de suas ações:';

  @override
  String get loanInterestType => 'Cálculo dos juros do empréstimo:';

  @override
  String get guarantorCount => 'Número de fiadores';

  @override
  String get penaltyCalculation =>
      'Cálculo da penalidade por atraso no empréstimo:';

  @override
  String get lateLoanPenalty => 'Penalidade por atraso no empréstimo:';

  @override
  String get fundInfoTitle => 'Informações do Fundo';

  @override
  String get illness => 'Doença';

  @override
  String get death => 'Falecimento';

  @override
  String get addNewReason => 'Adicionar Novo Motivo';

  @override
  String get reasonsWithoutAmountWarning =>
      'Motivos sem valor não aparecerão durante a reunião';

  @override
  String get reason => 'Motivo';

  @override
  String get enterReason => 'Digite o motivo';

  @override
  String get reasonsForGiving => 'Motivos para Doação';

  @override
  String get reasonsForGivingInFund =>
      'Motivos para doações no fundo comunitário';

  @override
  String get addNewReasonToReceiveMoney =>
      'Adicionar novo motivo para receber dinheiro';

  @override
  String get loadingGroupData => 'Carregando dados do grupo...';

  @override
  String get kikundiKipoMzunguko => 'Em qual ciclo o grupo está?';

  @override
  String mzunguko(Object mzungukoId) {
    return 'Ciclo $mzungukoId';
  }

  @override
  String get invalidGroupDataReceived => 'Dados inválidos do grupo recebidos';

  @override
  String get historia => 'Histórico';

  @override
  String historiaYa(String name) {
    return 'Histórico de $name';
  }

  @override
  String get hakuna_vikao => 'Nenhuma reunião concluída neste ciclo!';

  @override
  String get tafutaJinaSimu => 'Pesquisar por nome ou telefone';

  @override
  String get hakunaWanachama => 'Nenhum membro encontrado.';

  @override
  String get muhtasariKikao => 'Resumo da Reunião';

  @override
  String get funga => 'Fechar';

  @override
  String get tumaMuhtasari => 'Enviar Resumo';

  @override
  String get mwanachamaSiSimu => 'O membro não tem número de telefone';

  @override
  String muhtasariUmetumwa(String name) {
    return 'Resumo enviado para $name com sucesso';
  }

  @override
  String get imeshindwaTumaSMS => 'Falha ao enviar SMS, tente novamente';

  @override
  String get kikao => 'Reunião';

  @override
  String kikao_ya(String name) {
    return 'Reunião de $name';
  }

  @override
  String get mipangilio => 'Configurações';

  @override
  String get badiliLugha => 'Mudar idioma';

  @override
  String get chaguaLughaYaProgramu => 'Escolher idioma do aplicativo';

  @override
  String get kiswahili => 'Suaíli';

  @override
  String get english => 'Inglês';

  @override
  String get french => 'Francês';

  @override
  String get rekebishaFunguo => 'Ajustar teclas';

  @override
  String get badilishaNenoLaSiri => 'Alterar senha';

  @override
  String get kifo => 'Falecimento';

  @override
  String get futazoteZaMzungukoHuuKishaAnzaMzungukoMpya =>
      'Apagar todos os registros deste ciclo e iniciar um novo';

  @override
  String get rekebishaMzunguko => 'Editar ciclo';

  @override
  String get thibitisha => 'Confirmar';

  @override
  String get jeUnaHitajiKufutaTaarifaZoteNaKuanzaMzungukoMpya =>
      'Você deseja apagar todos os registros e iniciar um novo ciclo?';

  @override
  String get ndio => 'Sim';

  @override
  String imeshindwaKuHifadhi(String error) {
    return 'Falha ao salvar informação: $error';
  }

  @override
  String get hapana => 'Não';

  @override
  String get kuhusuChomoka => 'Sobre o Chomoka';

  @override
  String get toleoLaChapa100 => 'Versão 1.0.0';

  @override
  String get toleo4684 => 'Versão 4684';

  @override
  String get mkataba => 'Contrato';

  @override
  String get vigezoNaMasharti => 'Termos e Condições';

  @override
  String get somaVigezoNaMashartiYaChomoka =>
      'Leia os termos e condições do Chomoka';

  @override
  String get msaadaWaKitaalamu => 'Suporte Técnico';

  @override
  String get chomokaItajaribuKutumaBaadhiYaIliKikundiKipateMsaadaZaidiWaKitalaamu =>
      'Chomoka tentará enviar alguns dados para que o grupo receba mais suporte técnico';

  @override
  String get vslaPreviousMeetingSummary => 'Resumo da Reunião';

  @override
  String get nimemaliza => 'Enviar';

  @override
  String get idleBalanceInBox => 'Saldo Ocioso na Caixa';

  @override
  String get currentLoanBalance => 'Saldo Atual do Empréstimo';

  @override
  String get remainingCommunityContribution =>
      'Contribuição Restante para o Fundo Comunitário';

  @override
  String get totalOutstandingFines => 'Total de Multas Pendentes';

  @override
  String get kikundi => 'Grupo';

  @override
  String get nunuaHisa => 'Comprar Ações';

  @override
  String get sasaUtaanzaMchakatoWaKununuaHisaKwaKilaMwanachama =>
      'Iniciar o processo de compra de ações para cada membro';

  @override
  String get anzaSasa => 'COMEÇAR AGORA';

  @override
  String get rudiNymba => 'VOLTAR';

  @override
  String get hisa => 'Ações';

  @override
  String get hesabuYaHisa => 'Conta de Ações';

  @override
  String get jumlaYaAkiba => 'Total de Ações';

  @override
  String get hisaAlizonunuaLeo => 'Ações para Comprar';

  @override
  String get chaguaIdadiYaHisaZaKununua =>
      'Selecione o número de ações para comprar';

  @override
  String get chaguaZote => 'Selecionar Todos';

  @override
  String get ruka => 'Pular';

  @override
  String get hisaZilizochaguliwa => 'Ações Selecionadas';

  @override
  String get badilishaHisa => 'Editar Ações';

  @override
  String get ongezaHisa => 'Adicionar Ações';

  @override
  String get ongezaHisaZaidiKwaMwanachama =>
      'Adicionar mais ações para cada membro';

  @override
  String get punguzaHisa => 'Remover Ações';

  @override
  String get punguzaIdadiYaHisaZaMwanachama => 'Remover ações para cada membro';

  @override
  String get futaZote => 'Apagar Tudo';

  @override
  String get futaHisaZoteZaLeo => 'Apagar todas as ações deste ciclo';

  @override
  String get ongeza => 'Adicionar';

  @override
  String get punguza => 'Remover';

  @override
  String get futa => 'Apagar';

  @override
  String get ingizaIdadiYaHisaUnezotakaKununua =>
      'Digite o número de ações que deseja adicionar';

  @override
  String get ingizaIdadiYaHisaUnezotakaKupunguza =>
      'Digite o número de ações que deseja remover';

  @override
  String get ghairi => 'Cancelar';

  @override
  String get idadiYaHisa => 'Número de Ações';

  @override
  String get tafadhaliIngizaNambaSahihi => 'Por favor, insira um número válido';

  @override
  String get muhtasariWaHisa => 'Resumo das Ações';

  @override
  String get jumlaYaFedha => 'Valor Total';

  @override
  String contributeToFund(String fundName) {
    return 'Contribuir para $fundName';
  }

  @override
  String get amountToContribute => 'Valor para contribuir';

  @override
  String get totalCollected => 'Total arrecadado';

  @override
  String shareNote(Object amount) {
    return 'Nota: Um membro pode comprar uma ação no valor de $amount por reunião';
  }

  @override
  String get help => 'Ajuda';

  @override
  String get welcome => 'Bem-vindo';

  @override
  String get helpDescription =>
      'Ajudamos você a manter registros do seu grupo eficientemente';

  @override
  String get continueMeeting => 'Continuar Reunião';

  @override
  String get wanachama => 'Membros';

  @override
  String get fund => 'Distribuição do Grupo';

  @override
  String get feedback => 'Feedback';

  @override
  String get groupsActivities => 'Atividades do Grupo';

  @override
  String get historyDescription => 'Veja o histórico das atividades do grupo';

  @override
  String get backupAndRestore => 'Backup e Restauração';

  @override
  String get backupDescription => 'Backup e restauração dos registros do grupo';

  @override
  String get serviceMore => 'Mais Serviços';

  @override
  String get historyHints => 'Veja o histórico das atividades do grupo';

  @override
  String get sendData => 'Backup e Restauração';

  @override
  String get sendDataHint => 'Backup e restauração dos registros do grupo';

  @override
  String get whatsappNotInstalled =>
      'WhatsApp não está instalado no seu telefone';

  @override
  String get whatsappFailed => 'Falha ao abrir o WhatsApp';

  @override
  String get helpEmailSubject => 'Ajuda - App Chomoka Plus';

  @override
  String get welcomeNextMeeting => 'Bem-vindo à Próxima Reunião';

  @override
  String get midCycleReport => 'Relatório de Meio de Ciclo';

  @override
  String get tapToOpenMeeting => 'Toque no botão abaixo para abrir a reunião';

  @override
  String get tapYesToStartFirstMeeting =>
      'TOQUE EM SIM PARA INICIAR A PRIMEIRA REUNIÃO';

  @override
  String get openMeeting => 'ABRIR REUNIÃO';

  @override
  String get tapNoToEnterPastMeetings =>
      'TOQUE EM NÃO PARA INSERIR DADOS DE REUNIÕES PASSADAS';

  @override
  String meetingTitle(Object meetingNumber) {
    return 'Reunião Nº $meetingNumber';
  }

  @override
  String get groupAttendance => 'Verificar Presença';

  @override
  String get contributeMfukoJamii => 'Contribuir para o Fundo Social';

  @override
  String get buyShares => 'Comprar Ações';

  @override
  String contributeOtherFund(Object mfukoName) {
    return 'Contribuir para $mfukoName';
  }

  @override
  String get repayLoan => 'Quitar Empréstimo';

  @override
  String get payFine => 'Pagar Multa';

  @override
  String get withdrawFromMfukoJamii => 'Retirar do Fundo Social';

  @override
  String get giveLoan => 'Conceder Empréstimo';

  @override
  String get markCompleted => 'concluído';

  @override
  String get markPending => 'pendente';

  @override
  String get menuBulkSaving => 'Economia em Massa';

  @override
  String get menuExpense => 'Inserir Detalhes de Despesa';

  @override
  String get menuLogout => 'Sair';

  @override
  String get snackbarLoggedOut => 'Desconectado';

  @override
  String get attendance => 'Presença';

  @override
  String get attendanceSummary => 'Resumo da Presença';

  @override
  String get totalMembers => 'Total de Membros';

  @override
  String get present => 'Presente';

  @override
  String get onTime => 'No Horário';

  @override
  String get lates => 'Atrasados';

  @override
  String get sentRepresentative => 'Enviou Representante';

  @override
  String get absent => 'Ausente';

  @override
  String get withPermission => 'Com Permissão';

  @override
  String get withoutPermission => 'Sem Permissão';

  @override
  String get reasonForAbsence => 'Motivo da Ausência';

  @override
  String get amountToPaid => 'Valor que o membro deve pagar:';

  @override
  String get whatWasCollected => 'Valor arrecadado:';

  @override
  String get hasPaid => 'Pagou';

  @override
  String get hasNotPaid => 'Não Pagou';

  @override
  String get compulsorySavingsTitle => 'Informações de Poupanças Obrigatórias';

  @override
  String get compulsorySavingsSubtitle => 'Contribuições dos Membros';

  @override
  String get loadingMessage => 'Carregando informações...';

  @override
  String get doneButton => 'Concluído';

  @override
  String get noCompulsorySavings =>
      'Nenhuma poupança obrigatória devida pelo membro';

  @override
  String get phone => 'Telefone';

  @override
  String get dueMeeting => 'Devido para reunião';

  @override
  String owedAmount(Object amount) {
    return 'Poupanças obrigatórias devidas: $amount';
  }

  @override
  String get pay => 'Pagar';

  @override
  String get alreadyPaid => 'Já Pago';

  @override
  String get socialFundTitle => 'Informações do Fundo Social';

  @override
  String socialFundDueAmount(Object amount) {
    return 'Valor devido ao Fundo Social: $amount';
  }

  @override
  String get contributionSummary => 'Resumo das Contribuições';

  @override
  String memberName(Object name) {
    return 'Membro: $name';
  }

  @override
  String get paid => 'Pago';

  @override
  String get unpaid => 'Não Pago';

  @override
  String get noSocialFundDue =>
      'Nenhum valor do fundo social devido pelo membro';

  @override
  String get totalLoan => 'Empréstimo Total';

  @override
  String get noUnpaidMemberJamii =>
      'Nenhum membro com contribuições de fundo social em atraso';

  @override
  String get unpaidContributionsTitle => 'Contribuições Não Pagas';

  @override
  String get unpaidContributionsSubtitle => 'Contribuições ao Fundo Social';

  @override
  String get loanDebtorsTitle => 'Devedores de Empréstimos';

  @override
  String get loanSummaryTitle => 'Resumo do Empréstimo';

  @override
  String get loanIssuedAmount => 'Total de Empréstimos Concedidos:';

  @override
  String get loanRepaidAmount => 'Total de Empréstimos Pagos:';

  @override
  String get loanRemainingAmount => 'Saldo Remanescente do Empréstimo:';

  @override
  String get noUnpaidLoans => 'Nenhum membro com empréstimos em atraso.';

  @override
  String get loanDebtors => 'Devedores de Empréstimos';

  @override
  String get memberLabel => 'Membro:';

  @override
  String get unpaidLoanAmount => 'Valor do empréstimo \nnão pago';

  @override
  String get loanDetailsTitle => 'Detalhes do Empréstimo';

  @override
  String get makePayment => 'Realizar Pagamento';

  @override
  String remainingAmount(Object amount) {
    return 'Valor Restante: $amount';
  }

  @override
  String get choosePaymentType => 'Escolher Tipo de Pagamento:';

  @override
  String get payAll => 'Pagar Tudo';

  @override
  String get reduceLoan => 'Reduzir Empréstimo';

  @override
  String get enterPaymentAmount => 'Digite o Valor do Pagamento';

  @override
  String get payLoan => 'Pagar Empréstimo';

  @override
  String get member => 'MEMBRO';

  @override
  String get loanTaken => 'Valor do Empréstimo Obtido:';

  @override
  String get loanToPay => 'Valor a Pagar:';

  @override
  String get loanRemaining => 'Valor Restante do Empréstimo:';

  @override
  String get paymentHistory => 'Histórico de Pagamentos:';

  @override
  String get noPaymentsMade => 'Nenhum pagamento realizado ainda.';

  @override
  String youPaid(Object amount) {
    return 'Você Pagou: $amount';
  }

  @override
  String date(Object date) {
    return 'Data';
  }

  @override
  String get fainiPageTitle => 'Aplicar Multa';

  @override
  String get pageSubtitle => 'Selecionar Multa';

  @override
  String get undefinedFine => 'Multa indefinida';

  @override
  String priceLabel(Object price) {
    return 'Preço: $price Tsh';
  }

  @override
  String get saveFine => 'Salvar Multa';

  @override
  String get payFineTitle => 'Pagar Multa';

  @override
  String remainingFineAmount(Object amount) {
    return 'Valor Restante: $amount';
  }

  @override
  String get payAllFines => 'Pagar Todas as Multas';

  @override
  String get payCustomAmount => 'Pagar Valor Personalizado';

  @override
  String get confirmFinePayment => 'Confirmar Pagamento';

  @override
  String get fineTitle => 'Multas do Membro';

  @override
  String get fineSubtitle => 'Pagar Multa';

  @override
  String totalFines(Object amount) {
    return 'Total de Multas Devidas: $amount';
  }

  @override
  String paidFines(Object amount) {
    return 'Multas Pagas: $amount';
  }

  @override
  String remainingFines(Object amount) {
    return 'Valor Restante: $amount';
  }

  @override
  String get pigaFainiTitle => 'Aplicar Multa';

  @override
  String get pigaFainiSubtitle => 'Selecionar Membro';

  @override
  String get searchHint => 'Pesquisar por nome ou número do membro';

  @override
  String get fainiSummarySubtitle => 'Resumo das Multas';

  @override
  String get unknownName => 'Sem nome';

  @override
  String get unknownPhone => 'Telefone desconhecido';

  @override
  String get backToFines => 'Voltar para Multas';

  @override
  String get lipaFainiTitle => 'Pagar Multa';

  @override
  String get totalFinesDue => 'Total de Multas Devidas';

  @override
  String get totalFinesPaid => 'Total de Multas Pagas';

  @override
  String get noFineMembers => 'Nenhum membro com multas.';

  @override
  String get unpaidFinesTitle => 'Multas Não Pagas';

  @override
  String memberTotalFines(Object amount) {
    return 'Total de Multas: $amount';
  }

  @override
  String get navigationError =>
      'Ocorreu um erro ao navegar. Por favor, tente novamente.';

  @override
  String get memberFinesTitle => 'Multas do Membro';

  @override
  String memberNameLabel(Object name) {
    return 'Membro: $name';
  }

  @override
  String memberNumberLabel(Object number) {
    return 'Número do Membro: $number';
  }

  @override
  String totalFinesLabel(Object amount) {
    return 'Total de Multas Devidas: $amount';
  }

  @override
  String totalPaidLabel(Object amount) {
    return 'Multas Pagas: $amount';
  }

  @override
  String totalUnpaidLabel(Object amount) {
    return 'Saldo Restante: $amount';
  }

  @override
  String memberPhone(Object phone) {
    return 'Telefone: $phone';
  }

  @override
  String fineTypes(Object fineName) {
    return 'Tipo de Multa: $fineName';
  }

  @override
  String fineAmount(Object amount) {
    return 'Valor da Multa: $amount';
  }

  @override
  String meetingNumber(Object meeting, Object meetings) {
    return 'Reunião: $meeting';
  }

  @override
  String get toa_mfuko_jamii => 'Retirar Fundo Social';

  @override
  String get sababu_ya_kutoa_mfuko => 'Motivo para Retirada do Fundo Social';

  @override
  String get hakuna_sababu => 'Nenhum motivo preenchido ainda.';

  @override
  String kiasi_cha_juu(Object amount) {
    return 'Valor Máximo para Retirada: $amount';
  }

  @override
  String get jina => 'Nome:';

  @override
  String get jina_lisiloeleweka => 'Nome Desconhecido';

  @override
  String get namba_haijapatikana => 'Número Não Encontrado';

  @override
  String get chagua_sababu => 'Selecionar Motivo para Retirada do Fundo Social';

  @override
  String get tatizo_katika_kupakia =>
      'Ocorreu um erro, por favor tente novamente.';

  @override
  String get chagua_kiwango_kutoa => 'Selecionar Valor para Retirada';

  @override
  String get namba_ya_mwanachama => 'Número do Membro:';

  @override
  String get sababu_ya_kutoa => 'Motivo para retirar do Fundo Social:';

  @override
  String get kiwango_cha_juu => 'Valor máximo para retirada:';

  @override
  String get salio_la_sasa => 'Saldo Atual:';

  @override
  String get salio_la_kikao_kilichopita =>
      'Saldo do Fundo Social na Reunião Anterior:';

  @override
  String get toa_kiasi_chote => 'Retirar valor total';

  @override
  String get toa_kiasi_kingine => 'Retirar outro valor';

  @override
  String get ingiza_kiasi => 'Digite o valor';

  @override
  String get thibitisha_utoaji_pesa => 'Confirmar retirada do fundo';

  @override
  String get kiasi_cha_kutoa => 'Valor da Retirada:';

  @override
  String get salio_jipya => 'Novo saldo:';

  @override
  String get toa_mkopo => 'Conceder Empréstimo';

  @override
  String get tahadhari => 'Aviso!';

  @override
  String get hawezi_kukopa =>
      'Um membro não pode tomar outro empréstimo até quitar o atual.';

  @override
  String get sababu_ya_kutoa_mkopo => 'Motivo para tomar o empréstimo';

  @override
  String weka_sababu(Object name) {
    return 'Digite o motivo pelo qual o membro $name está tomando este empréstimo:';
  }

  @override
  String get kilimo => 'Agricultura';

  @override
  String get maboresho_nyumba => 'Melhoria da Casa';

  @override
  String get elimu => 'Educação';

  @override
  String get biashara => 'Negócios';

  @override
  String get sababu_nyingine => 'Outro motivo';

  @override
  String get weka_sababu_nyingine => 'Digite outro motivo';

  @override
  String get thibitisha_sababu => 'Confirmar motivo';

  @override
  String get tafadhali_weka_sababu_nyingine =>
      'Por favor, insira outro motivo.';

  @override
  String get jumla_ya_akiba => 'Total de Poupanças:';

  @override
  String get kiwango_cha_juu_mkopo => 'Valor Máximo do Empréstimo:';

  @override
  String get fedha_zilizopo_mkopo => 'Fundos Disponíveis para Empréstimo:';

  @override
  String chukua_mkopo_wote(Object amount) {
    return 'Tomar empréstimo completo $amount';
  }

  @override
  String get kiasi_kingine => 'Outro valor';

  @override
  String get kiasi => 'Valor';

  @override
  String get weka_kiasi => 'Digite o valor';

  @override
  String get thibitisha_kiasi => 'Confirmar valor';

  @override
  String get tafadhali_chagua_chaguo =>
      'Por favor selecione uma opção de empréstimo.';

  @override
  String get kiasi_cha_mkopo_wa_mwanachama => 'Valor do empréstimo do membro';

  @override
  String get tafadhali_ingiza_kiasi_sahihi =>
      'Por favor, insira um valor válido.';

  @override
  String get hakuna_kiasi_cha_kutosha =>
      'Fundos insuficientes para conceder este empréstimo.';

  @override
  String get kiasi_hakiruhusiwi => 'O valor selecionado não é permitido.';

  @override
  String get kiasi_na_riba_vimehifadhiwa =>
      'Valor do empréstimo e juros foram salvos.';

  @override
  String get hitilafu_imetokea =>
      'Ocorreu um erro. Por favor, tente novamente.';

  @override
  String get muda_wa_marejesho => 'Duração do Reembolso';

  @override
  String kiasi_cha_mkopo_wake_ni(Object amount) {
    return 'O valor do empréstimo dele é:\n $amount';
  }

  @override
  String get mkopo_wa_miezi_mingapi => 'Duração do empréstimo em meses?';

  @override
  String get mwezi_1 => '1 Mês';

  @override
  String get miezi_2 => '2 Meses';

  @override
  String get miezi_3 => '3 Meses';

  @override
  String get miezi_6 => '6 Meses';

  @override
  String get nyingine => 'Outro';

  @override
  String get ingiza_miezi => 'Digite os meses';

  @override
  String get thibitisha_muda => 'Confirmar duração';

  @override
  String get tafadhali_chagua_muda =>
      'Por favor, selecione um período de reembolso.';

  @override
  String get tafadhali_ingiza_muda_sahihi =>
      'Por favor, insira uma duração válida.';

  @override
  String muda_wa_marejesho_umehifadhiwa(Object months) {
    return 'Tempo de reembolso salvo: $months meses';
  }

  @override
  String get wadhamini => 'Fiadores';

  @override
  String jinas(Object name) {
    return 'Nome: $name';
  }

  @override
  String chagua_wadhamini(Object count) {
    return 'Selecionar $count fiadores:';
  }

  @override
  String get haidhibiti_idadi =>
      'Por favor, selecione todos os fiadores necessários.';

  @override
  String get haijulikani => 'Desconhecido';

  @override
  String get muhtasari_wa_mkopo => 'Resumo do Empréstimo';

  @override
  String get thibitisha_mkopo => 'Confirmar Empréstimo';

  @override
  String get maelezo_ya_mkopo => 'Detalhes do Empréstimo';

  @override
  String get kiasi_cha_mkopo => 'Valor do Empréstimo';

  @override
  String get riba_ya_mkopo => 'Juros do Empréstimo';

  @override
  String get maelezo_ya_riba => 'Detalhes dos Juros';

  @override
  String get salio_la_mkopo => 'Saldo do Empréstimo';

  @override
  String get tarehe_ya_mwisho => 'Data de Vencimento';

  @override
  String miezi(Object miezi) {
    return 'Meses $miezi';
  }

  @override
  String get oneTimeInterest => 'Juros pagos uma única vez';

  @override
  String guarantorExample(int count, String amount) {
    return 'Por exemplo, se Pili não puder pagar sua dívida de empréstimo de 150.000 na hora da partilha, a poupança dos $count membros que garantiram seu empréstimo será reduzida em $amount para cada um.';
  }

  @override
  String get communityFundTitle => 'Fundo Comunitário';

  @override
  String get unpaidContribution => 'Contribuição não paga';

  @override
  String get expense => 'Despesa';

  @override
  String get chooseUsageType => 'Escolher tipo de uso';

  @override
  String usageType(Object type) {
    return '$type';
  }

  @override
  String get matumziStationery => 'Papelaria';

  @override
  String get matumziRefreshment => 'Refrescos';

  @override
  String get matumziLoanPayment => 'Pagamento de Empréstimo';

  @override
  String get matumziCallTime => 'Tempo de Chamada (Vocha)';

  @override
  String get matumziTechnology => 'Tecnologia';

  @override
  String get matumiziMerchandise => 'Mercadorias Comerciais';

  @override
  String get matumziTransport => 'Transporte';

  @override
  String get matumiziBackCharges => 'Taxas Bancárias';

  @override
  String get matumziOther => 'Outro';

  @override
  String get specificUsage => 'Uso específico';

  @override
  String get enterSpecificUsage => 'Digite o uso específico';

  @override
  String get pleaseEnterSpecificUsage => 'Por favor, insira o uso específico.';

  @override
  String get pleaseEnterAmount => 'Por favor, insira um valor';

  @override
  String get next => 'Próximo';

  @override
  String get expenseSummary => 'Resumo das Despesas';

  @override
  String get totalAmountSpent => 'Total gasto';

  @override
  String get totalExpenses => 'Outras Despesas do Grupo';

  @override
  String get noExpensesRecorded => 'Nenhuma despesa registrada.';

  @override
  String expenseLabel(Object label) {
    return 'Despesa: $label';
  }

  @override
  String get unknown => 'Desconhecido';

  @override
  String expenseType(Object type) {
    return 'Tipo: $type';
  }

  @override
  String amountLabel(Object amount) {
    return 'Valor: $amount';
  }

  @override
  String fundLabel(Object fund) {
    return 'Fundo: $fund';
  }

  @override
  String get done => 'Concluído';

  @override
  String get confirmExpense => 'Confirmar Despesa';

  @override
  String get expenseFund => 'Fundo de Despesa';

  @override
  String get expenseTypeLabel => 'Tipo de Despesa';

  @override
  String get chooseFund => 'Escolher Fundo';

  @override
  String get chooseFundToContribute => 'Escolher fundo para contribuir';

  @override
  String get mainGroupFund => 'Fundo Principal do Grupo';

  @override
  String get socialFund => 'Fundo Social';

  @override
  String get pleaseChooseFund => 'Por favor, escolha um fundo.';

  @override
  String get bulkSaving => 'Poupança Coletiva';

  @override
  String get chooseContributionType => 'Escolher Tipo de Contribuição';

  @override
  String get donationContribution => 'Contribuição de Doação';

  @override
  String get businessProfit => 'Lucro Comercial';

  @override
  String get loanDisbursement => 'Desembolso de Empréstimo';

  @override
  String enterAmountFor(Object type) {
    return 'Digite o valor para $type:';
  }

  @override
  String get totalContributionsForCycle =>
      'Total de contribuições para este ciclo';

  @override
  String get contributionsList => 'Lista de Contribuições';

  @override
  String get noContributionsCompleted => 'Nenhuma contribuição concluída.';

  @override
  String get noFund => 'Sem Fundo';

  @override
  String contributionType(Object type) {
    return 'Tipo: $type';
  }

  @override
  String get confirmContribution => 'Confirmar Contribuição';

  @override
  String get fundBalance => 'Saldo do Fundo';

  @override
  String get currentContribution => 'Contribuição Atual';

  @override
  String get newFundBalance => 'Novo Saldo do Fundo';

  @override
  String meetingSummaryTitle(Object meetingNumber) {
    return 'Resumo da Reunião $meetingNumber';
  }

  @override
  String get sharePurchaseSection => 'Compra de Ações';

  @override
  String get totalSharesDeposited => 'Total de Ações Depositadas';

  @override
  String get totalShareValue => 'Valor Total das Ações';

  @override
  String get amountDeposited => 'Valor Depositado';

  @override
  String get amountWithdrawn => 'Valor Retirado';

  @override
  String get loansSection => 'Empréstimos';

  @override
  String get loansIssued => 'Empréstimos Concedidos';

  @override
  String get loanAmountRepaid => 'Valor do Empréstimo Pago';

  @override
  String get loanAmountOutstanding => 'Valor do Empréstimo Pendente';

  @override
  String get finesSection => 'Multas';

  @override
  String get totalBulkSaving => 'Total da Poupança Coletiva';

  @override
  String get expensesSection => 'Despesas';

  @override
  String get loadingAttendanceSummary => 'Carregando resumo de presença...';

  @override
  String get presentMembers => 'Membros Presentes';

  @override
  String get earlyMembers => 'Chegaram Cedo';

  @override
  String get lateMembers => 'Atrasados';

  @override
  String get representative => 'Representante';

  @override
  String get absentMembers => 'Membros Ausentes';

  @override
  String get closeMeeting => 'Encerrar Reunião';

  @override
  String get sendSmsTitle => 'Enviar SMS';

  @override
  String get sendSmsSubtitle => 'Enviar SMS para Membros';

  @override
  String get chooseSmsSendType => 'Escolha como enviar SMS';

  @override
  String get sendToAll => 'Enviar para Todos';

  @override
  String get chooseMembers => 'Selecionar Membros';

  @override
  String get selected => 'Selecionados';

  @override
  String get sendSms => 'Enviar SMS';

  @override
  String sendSmsWithCount(Object count) {
    return 'Enviar SMS ($count)';
  }

  @override
  String get selectMembersToSendSms =>
      'Por favor selecione membros para enviar SMS';

  @override
  String get noMembersToSendSms => 'Nenhum membro para enviar SMS';

  @override
  String smsGreeting(Object name) {
    return 'Caro $name,';
  }

  @override
  String get smsSummaryHeader => 'Resumo da reunião:';

  @override
  String smsTotalShares(Object shares, Object value) {
    return 'Total de Ações: $shares ( $value)';
  }

  @override
  String smsSocialFund(Object amount) {
    return 'Fundo Social: $amount';
  }

  @override
  String smsCurrentLoan(Object amount) {
    return 'Empréstimo Atual: $amount';
  }

  @override
  String smsFine(Object amount) {
    return 'Multa: $amount';
  }

  @override
  String get failedToCloseMeeting => 'Falha ao encerrar a reunião';

  @override
  String get meetingNotFound => 'Reunião não encontrada';

  @override
  String failedToCloseMeetingWithError(Object error) {
    return 'Falha ao encerrar reunião: $error';
  }

  @override
  String get agentPreparedAndOnTime =>
      'O agente se preparou bem e chegou no horário?';

  @override
  String get agentExplainedChomoka =>
      'O agente explicou como usar o sistema Chomoka?';

  @override
  String get pleaseAnswerThisQuestion => 'Por favor, responda a esta pergunta.';

  @override
  String get agentExplainedCosts =>
      'O agente explicou os custos de forma clara e transparente?';

  @override
  String get agentRating => 'Como você classificaria o agente Chomoka?';

  @override
  String get agentRatingLevel1 => '1. Ruim';

  @override
  String get agentRatingLevel2 => '2. Regular';

  @override
  String get agentRatingLevel3 => '3. Bom';

  @override
  String get agentRatingLevel4 => '4. Muito Bom';

  @override
  String get agentRatingLevel5 => '5. Excelente';

  @override
  String get pleaseChooseRating => 'Por favor, escolha uma classificação.';

  @override
  String get unansweredQuestion =>
      'Você tem alguma pergunta que o agente não respondeu ou com a qual você não ficou satisfeito?';

  @override
  String get question => 'Pergunta';

  @override
  String get pleaseWriteQuestion => 'Por favor, escreva sua pergunta.';

  @override
  String get suggestionForChomoka =>
      'Quais mudanças você sugere para o sistema Chomoka?';

  @override
  String get suggestion => 'Sugestão';

  @override
  String get pleaseWriteSuggestion => 'Por favor, escreva sua sugestão.';

  @override
  String get noMeeting => 'Sem Reunião';

  @override
  String get noMeetingDesc =>
      'Nenhuma reunião foi realizada neste ciclo, por favor, realize uma reunião para continuar com a divisão.';

  @override
  String get meetingInProgress => 'Reunião em Andamento';

  @override
  String get meetingInProgressDesc =>
      'Por favor, finalize a reunião para continuar com a divisão.';

  @override
  String get shareout => 'Divisão';

  @override
  String get chooseShareoutType => 'Escolher Tipo de Divisão';

  @override
  String get groupShareout => 'Divisão em Grupo';

  @override
  String get groupShareoutDesc =>
      'Completamos nosso ciclo e queremos fazer uma divisão. Queremos revisar o status de participação do nosso grupo.';

  @override
  String get memberShareout => 'Distribuição de Membro';

  @override
  String get memberShareoutDesc =>
      'Queremos remover completamente um membro do nosso grupo e o membro não poderá mais participar das reuniões. Queremos revisar o status de participação do membro.';

  @override
  String get returnToHome => 'Voltar para Início';

  @override
  String get summary => 'Resumo';

  @override
  String get chooseMember => 'Escolha o Membro';

  @override
  String phoneNumberLabel(Object phone) {
    return 'Telefone: $phone';
  }

  @override
  String get totalMandatorySavings => 'Total de poupanças obrigatórias';

  @override
  String get totalVoluntarySavings => 'Total de poupanças voluntárias';

  @override
  String get unpaidFineAmount => 'Valor da multa \nnão paga';

  @override
  String get memberOwesAmount => 'O membro deve \num valor de';

  @override
  String get totalShareoutAmount => 'Valor total da distribuição';

  @override
  String get confirmShareout => 'Confirmar Distribuição';

  @override
  String get mandatorySavingsToBeWithdrawn =>
      'Poupanças obrigatórias a serem retiradas';

  @override
  String get voluntarySavingsToBeWithdrawn =>
      'Poupanças voluntárias a serem retiradas';

  @override
  String get memberMustPayAmount => 'O membro deve \npagar um valor';

  @override
  String get cashPayment => 'Pagamento em dinheiro';

  @override
  String get noPaymentToMember => 'O membro não \nreceberá pagamento';

  @override
  String get totalSharesCount => 'Total de ações';

  @override
  String get totalSharesValue => 'Valor total das ações';

  @override
  String get enterKeysToContinue => 'Digite as teclas para continuar';

  @override
  String get smsSummaryTitle => 'Enviar resumo via SMS';

  @override
  String get smsYes => 'Sim';

  @override
  String get smsNo => 'Não';

  @override
  String get groupShareTitle => 'Distribuição do Grupo';

  @override
  String get noMembersInGroup => 'Não há membros neste grupo.';

  @override
  String get selectMember => 'Selecionar membro';

  @override
  String get totalFine => 'Total de Multas Coletadas';

  @override
  String get totalSocialFund => 'Total do Fundo Social';

  @override
  String totalShareAmount(Object percentage, Object shares) {
    return 'Ações: $shares ($percentage%)';
  }

  @override
  String get unpaidLoanMsg =>
      'Existem pagamentos de empréstimos não pagos. Por favor, pague todos os empréstimos antes de continuar.';

  @override
  String get unpaidFineMsg =>
      'Existem multas não pagas. Por favor, pague todas as multas antes de continuar.';

  @override
  String get unpaidSocialFundMsg =>
      'Existem pagamentos do fundo social não pagos. Por favor, pague todos os pagamentos antes de continuar.';

  @override
  String get unpaidCompulsorySavingsMsg =>
      'Existem poupanças obrigatórias não pagas. Por favor, pague todos os pagamentos antes de continuar.';

  @override
  String get warning => 'Aviso';

  @override
  String get profit => 'Lucro';

  @override
  String get totalExtraCollected => 'Total Extra Coletado';

  @override
  String totalUnpaidAmount(Object amount) {
    return 'Valor total não pago:  $amount';
  }

  @override
  String get totalWithdrawnFromSocialFund => 'Total Retirado do Fundo Social';

  @override
  String get totalFunds => 'Total de Fundos';

  @override
  String get expenses => 'Despesas';

  @override
  String get otherGroupExpenses => 'Outras Despesas do Grupo';

  @override
  String get amountRemaining => 'Valor Restante';

  @override
  String get socialFundCarriedForward =>
      'Fundo Social Transferido para o Próximo Ciclo';

  @override
  String get totalShareFunds => 'Total de Fundos de Distribuição';

  @override
  String get amountNextCycleSubtitle =>
      'Valor transferido para o próximo ciclo';

  @override
  String get sendToNextCycle => 'Enviar para o próximo ciclo';

  @override
  String get enterAmountNextCycle =>
      'Digite o valor que deseja transferir para o próximo ciclo para cada fundo';

  @override
  String availableAmount(Object amount) {
    return 'Disponível  $amount';
  }

  @override
  String amountMustBeLessThanOrEqual(Object amount) {
    return 'O valor deve ser menor ou igual a $amount';
  }

  @override
  String get memberShareDistributionTitle => 'Distribuição de Ações do Membro';

  @override
  String shareValueAmount(Object amount) {
    return 'Valor da ação:  $amount';
  }

  @override
  String totalDistributionAmount(Object amount) {
    return 'Distribuição total:  $amount';
  }

  @override
  String get groupShareDistributionTitle => 'Distribuição de Ações do Grupo';

  @override
  String get noProfitEmoji => '😢';

  @override
  String get profitEmoji => '😊';

  @override
  String get noProfitMessage => 'Seu grupo não teve lucro';

  @override
  String profitMessage(Object amount) {
    return 'Parabéns! Seu grupo teve um lucro de $amount';
  }

  @override
  String get totalDistributionFunds => 'Total de fundos para distribuição';

  @override
  String amountTzs(Object amount) {
    return ' $amount';
  }

  @override
  String get nextCycleSocialFund =>
      'Valor do fundo social transferido para o próximo ciclo';

  @override
  String get nextCycleMemberSavings =>
      'Total de poupanças dos membros transferidas para o próximo ciclo';

  @override
  String get finishCycle => 'Finalizar ciclo';

  @override
  String get memberShareSummaryTitle => 'Resumo da Distribuição do Membro';

  @override
  String get memberShareSummarySubtitle => 'Resumo da Distribuição de Ações';

  @override
  String get giveToNextCycle => 'Enviar para o próximo ciclo';

  @override
  String get shareInfoSection => 'Informações das Ações';

  @override
  String get numberOfShares => 'Número de Ações:';

  @override
  String get sharePercentage => 'Porcentagem da Ação:';

  @override
  String get profitInfoSection => 'Informações do Lucro';

  @override
  String get profitShare => 'Participação no Lucro (baseado nas ações):';

  @override
  String get socialFundShare => 'Participação no Fundo Social:';

  @override
  String get distributionSummarySection => 'Resumo da Distribuição';

  @override
  String get summaryShareValue => 'Valor da Ação:';

  @override
  String get summaryProfit => 'Lucro:';

  @override
  String get summarySocialFund => 'Fundo Social:';

  @override
  String get summaryTotalDistribution => 'Distribuição Total:';

  @override
  String get paymentInfoSection => 'Informações do Pagamento';

  @override
  String get amountToNextCycle => 'Valor para o próximo ciclo:';

  @override
  String get paymentAmount => 'Valor do pagamento:';

  @override
  String get inputAmountForNextCycle => 'Digite o valor para o próximo ciclo';

  @override
  String get confirmButton => 'Confirmar';

  @override
  String get amountMustBeLessThanOrEqualTotal =>
      'O valor deve ser menor ou igual à distribuição total.';

  @override
  String get successfullyPaid => 'Pago com sucesso';

  @override
  String get groupActivitiesTitle => 'Atividades do Grupo';

  @override
  String get groupBusiness => 'Negócio do Grupo';

  @override
  String get otherActivities => 'Outras Atividades';

  @override
  String get training => 'Treinamento';

  @override
  String get backToHome => 'Voltar para Início';

  @override
  String get addTrainingTitle => 'Adicionar Treinamento';

  @override
  String get editTrainingTitle => 'Editar Treinamento';

  @override
  String get trainingType => 'Tipo de Treinamento';

  @override
  String get enterTrainingType => 'Digite o tipo de treinamento';

  @override
  String get organization => 'Organização';

  @override
  String get enterOrganization => 'Digite o nome da organização';

  @override
  String get chooseDate => 'Escolher data';

  @override
  String get membersCount => 'Número de Membros';

  @override
  String get enterMembersCount => 'Digite o número de membros';

  @override
  String get trainer => 'Instrutor';

  @override
  String get enterTrainer => 'Digite o nome do instrutor';

  @override
  String get saveTraining => 'Salvar Treinamento';

  @override
  String get saveChanges => 'Salvar Alterações';

  @override
  String get trainingSaved => 'Treinamento salvo com sucesso';

  @override
  String get trainingUpdated => 'Treinamento atualizado com sucesso';

  @override
  String get pleaseFillAllFields => 'Por favor, preencha todos os campos';

  @override
  String get pleaseEnterTrainingType =>
      'Por favor, insira o tipo de treinamento';

  @override
  String get pleaseEnterOrganization =>
      'Por favor, insira o nome da organização';

  @override
  String get pleaseEnterMembersCount => 'Por favor, insira o número de membros';

  @override
  String get pleaseEnterTrainer => 'Por favor, insira o nome do instrutor';

  @override
  String get trainingListTitle => 'Lista de Treinamentos';

  @override
  String totalTrainings(Object count) {
    return 'Total de treinamentos: $count';
  }

  @override
  String get noTrainingsSaved => 'Nenhum treinamento salvo';

  @override
  String get addNewTraining => 'Adicionar Treinamento';

  @override
  String get deleteTrainingTitle => 'Excluir Treinamento';

  @override
  String get deleteTrainingConfirm =>
      'Tem certeza que deseja excluir este treinamento?';

  @override
  String get trainingDeleted => 'Treinamento excluído com sucesso';

  @override
  String get addOtherActivityTitle => 'Outras Atividades';

  @override
  String get editOtherActivityTitle => 'Editar Atividade';

  @override
  String get activityDate => 'Data';

  @override
  String get chooseActivityDate => 'Escolher data';

  @override
  String get activityName => 'Atividade Realizada';

  @override
  String get enterActivityName => 'Digite a atividade realizada';

  @override
  String get beneficiariesCount => 'Número de Beneficiários';

  @override
  String get enterBeneficiariesCount => 'Digite o número de beneficiários';

  @override
  String get enterLocation => 'Digite o local da atividade';

  @override
  String get saveActivity => 'Salvar Atividade';

  @override
  String get saveActivityChanges => 'Salvar Alterações';

  @override
  String get activitySaved => 'Atividade salva com sucesso';

  @override
  String get activityUpdated => 'Atividade atualizada com sucesso';

  @override
  String get pleaseFillAllActivityFields =>
      'Por favor, preencha todos os campos';

  @override
  String get pleaseEnterActivityName =>
      'Por favor, insira a atividade realizada';

  @override
  String get pleaseEnterBeneficiariesCount =>
      'Por favor, insira o número de beneficiários';

  @override
  String get pleaseEnterLocation => 'Por favor, insira a localização';

  @override
  String get activityListTitle => 'Lista de Outras Atividades';

  @override
  String totalActivities(Object count) {
    return 'Total de atividades: $count';
  }

  @override
  String get noActivitiesSaved => 'Nenhuma atividade salva';

  @override
  String get addNewActivity => 'Adicionar Atividade';

  @override
  String get editActivity => 'Editar';

  @override
  String get deleteActivity => 'Excluir';

  @override
  String get deleteActivityTitle => 'Excluir Atividade';

  @override
  String get deleteActivityConfirm =>
      'Tem certeza que deseja excluir esta atividade?';

  @override
  String get activityDeleted => 'Atividade excluída com sucesso';

  @override
  String get orderListTitle => 'Solicitações de Insumo';

  @override
  String get orderListSubtitle => 'Lista de Solicitações';

  @override
  String get orderListTotalRequests => 'Total de Solicitações';

  @override
  String get orderListPending => 'Pendente';

  @override
  String get orderListApproved => 'Aprovado';

  @override
  String get orderListRejected => 'Rejeitado';

  @override
  String orderListRequests(Object count) {
    return 'Solicitações $count';
  }

  @override
  String get orderListRefresh => 'Atualizar';

  @override
  String get orderListNoRequests => 'Nenhuma solicitação registrada';

  @override
  String get orderListAddNewPrompt =>
      'Pressione o botão para adicionar uma nova solicitação';

  @override
  String get orderListDone => 'Concluído';

  @override
  String get orderListUnknownInput => 'Insumo';

  @override
  String get orderListUnknownCompany => 'Empresa desconhecida';

  @override
  String get orderListStatusApproved => 'Aprovado';

  @override
  String get orderListStatusRejected => 'Rejeitado';

  @override
  String get orderListStatusPending => 'Pendente';

  @override
  String orderListAmount(Object amount) {
    return 'Quantidade: $amount';
  }

  @override
  String get orderListUnknownAmount => 'Desconhecido';

  @override
  String get orderListUnknownDate => 'Data desconhecida';

  @override
  String get orderListPrice => 'Preço';

  @override
  String get orderListUnknownPrice => 'Desconhecido';

  @override
  String get orderListFinish => 'Concluído';

  @override
  String get orderListShowAgain => 'Mostrar novamente';

  @override
  String get requestSummaryTitle => 'Detalhes da Solicitação de Insumo';

  @override
  String get requestSummaryListTitle => 'Lista de Solicitações de Insumo';

  @override
  String requestSummaryTotal(Object count) {
    return 'Total de solicitações: $count';
  }

  @override
  String get requestSummaryStatus => 'Status da Solicitação';

  @override
  String get requestSummaryStatusApproved => 'Aprovado';

  @override
  String get requestSummaryStatusRejected => 'Rejeitado';

  @override
  String get requestSummaryStatusPending => 'Pendente';

  @override
  String get requestSummaryStatusMessageApproved =>
      'Sua solicitação de insumo foi aprovada. Você pode prosseguir com o processo de compra.';

  @override
  String get requestSummaryStatusMessageRejected =>
      'Desculpe, sua solicitação de insumo foi rejeitada. Por favor, contate o administrador para mais detalhes.';

  @override
  String get requestSummaryStatusMessagePending =>
      'Sua solicitação de insumo foi recebida e está pendente de aprovação. Você será notificado quando for aprovada.';

  @override
  String get requestSummaryUserInfo => 'Informações do Usuário';

  @override
  String get requestSummaryUserName => 'Nome do Usuário';

  @override
  String get requestSummaryMemberNumber => 'Número do Membro';

  @override
  String get requestSummaryPhone => 'Número de Telefone';

  @override
  String get requestSummaryInputType => 'Tipo de Insumo';

  @override
  String get requestSummaryAmount => 'Quantidade';

  @override
  String get requestSummaryRequestDate => 'Data da Solicitação';

  @override
  String get requestSummaryCompany => 'Empresa';

  @override
  String get requestSummaryPrice => 'Preço';

  @override
  String get requestSummaryCost => 'Custo';

  @override
  String get requestSummaryUnknown => 'Desconhecido';

  @override
  String get requestSummaryBack => 'Voltar';

  @override
  String get requestSummaryEdit => 'Editar';

  @override
  String get requestSummaryAddRequest => 'Adicionar Solicitação';

  @override
  String get requestSummaryNoRequests => 'Nenhuma solicitação registrada';

  @override
  String get requestSummaryAddNewPrompt =>
      'Pressione o botão para adicionar uma nova solicitação';

  @override
  String get requestInputTitle => 'Solicitar Insumo';

  @override
  String get requestInputEditTitle => 'Editar Solicitação de Insumo';

  @override
  String get requestInputType => 'Tipo de Insumo';

  @override
  String get requestInputTypeHint => 'Digite o tipo de insumo';

  @override
  String get requestInputTypeError => 'Por favor, insira o tipo de insumo';

  @override
  String get requestInputCompany => 'Empresa';

  @override
  String get requestInputCompanyHint => 'Digite o nome da empresa';

  @override
  String get requestInputCompanyError => 'Por favor, insira o nome da empresa';

  @override
  String get requestInputAmount => 'Quantidade';

  @override
  String get requestInputAmountHint => 'Digite a quantidade';

  @override
  String get requestInputAmountError => 'Por favor, insira a quantidade';

  @override
  String get requestInputPrice => 'Preço';

  @override
  String get requestInputPriceHint => 'Digite o preço';

  @override
  String get requestInputPriceError => 'Por favor, insira o preço';

  @override
  String get requestInputDate => 'Data';

  @override
  String get requestInputDateHint => 'Selecione a data';

  @override
  String get requestInputStatus => 'Status da Solicitação';

  @override
  String get requestInputStatusHint => 'Selecione o status da solicitação';

  @override
  String get requestInputSubmit => 'Enviar Solicitação';

  @override
  String get requestInputSaveChanges => 'Salvar Alterações';

  @override
  String get requestInputSuccess => 'Sua solicitação foi enviada com sucesso';

  @override
  String get requestInputUpdateSuccess => 'Solicitação atualizada com sucesso';

  @override
  String requestInputError(Object error) {
    return 'Erro: $error';
  }

  @override
  String get requestInputFillAll => 'Por favor, preencha todos os campos';

  @override
  String get businessDashboardTitle => 'Painel de Negócios';

  @override
  String get businessDashboardDefaultTitle => 'Painel de Negócios';

  @override
  String get businessDashboardLocationUnknown => 'Sem localização';

  @override
  String get businessDashboardProductType => 'Tipo de Produto';

  @override
  String get businessDashboardProductTypeUnknown => 'Sem produto';

  @override
  String get businessDashboardStartDate => 'Data de Início';

  @override
  String get businessDashboardDateUnknown => 'Sem data';

  @override
  String get businessDashboardStats => 'Estatísticas do Negócio';

  @override
  String get businessDashboardPurchases => 'Compras';

  @override
  String get businessDashboardSales => 'Vendas';

  @override
  String get businessDashboardExpenses => 'Despesas';

  @override
  String get businessDashboardProfit => 'Lucro';

  @override
  String get businessDashboardActions => 'Ações';

  @override
  String get businessDashboardProfitShare => 'Distribuição de Lucro';

  @override
  String get businessDashboardActive => 'Ativo';

  @override
  String get businessDashboardInactive => 'Inativo';

  @override
  String get businessDashboardPending => 'Pendente';

  @override
  String get businessDashboardStatus => 'Status';

  @override
  String businessDashboardError(Object error) {
    return 'Erro: $error';
  }

  @override
  String get businessListTitle => 'Lista de Negócios';

  @override
  String businessListCount(Object count) {
    return 'Negócios $count';
  }

  @override
  String get businessListRefresh => 'Atualizar';

  @override
  String get businessListNoBusinesses => 'Nenhum negócio registrado';

  @override
  String get businessListAddPrompt =>
      'Toque no botão + para adicionar um negócio';

  @override
  String get businessListViewMore => 'Ver Mais';

  @override
  String get businessListLocationUnknown => 'Sem localização';

  @override
  String get businessListProductTypeUnknown => 'Sem produto';

  @override
  String get businessListStatusActive => 'Ativo';

  @override
  String get businessListStatusInactive => 'Inativo';

  @override
  String get businessListStatusPending => 'Pendente';

  @override
  String get businessListDateUnknown => 'Sem data';

  @override
  String get businessInformationTitle => 'Informações do Negócio';

  @override
  String get businessInformationName => 'Nome do Negócio';

  @override
  String get businessInformationNameHint => 'Digite o nome do negócio';

  @override
  String get businessInformationNameAbove => 'Nome do Negócio:';

  @override
  String get businessInformationNameError =>
      'Por favor, insira o nome do negócio';

  @override
  String get businessInformationLocation => 'Localização do Negócio';

  @override
  String get businessInformationLocationHint =>
      'Digite a localização do negócio';

  @override
  String get businessInformationLocationAbove => 'Localização do Negócio:';

  @override
  String get businessInformationLocationError =>
      'Por favor, insira a localização do negócio';

  @override
  String get businessInformationStartDate => 'Data de Início do Negócio';

  @override
  String get businessInformationStartDateHint => 'Selecione a data';

  @override
  String get businessInformationStartDateAbove => 'Data de Início do Negócio:';

  @override
  String get businessInformationProductTypeAbove => 'Tipo de Produto:';

  @override
  String get businessInformationProductType => 'Tipo de Produto';

  @override
  String get businessInformationProductTypeError =>
      'Por favor, selecione o tipo de produto';

  @override
  String get businessInformationOtherProductType =>
      'Especificar Tipo de Produto';

  @override
  String get businessInformationOtherProductTypeHint =>
      'Digite o tipo de produto';

  @override
  String get businessInformationOtherProductTypeAbove =>
      'Especificar Tipo de Produto:';

  @override
  String get businessInformationOtherProductTypeError =>
      'Por favor, insira o tipo de produto';

  @override
  String get businessInformationSave => 'Salvar Informações';

  @override
  String get businessInformationSaved =>
      'Informações do negócio salvas com sucesso';

  @override
  String get businessSummaryTitle => 'Resumo do Negócio';

  @override
  String get businessSummaryNoInfo => 'Nenhuma informação do negócio';

  @override
  String get businessSummaryRegisterPrompt =>
      'Por favor, registre um negócio primeiro para ver o resumo';

  @override
  String get businessSummaryRegister => 'Registrar Negócio';

  @override
  String get businessSummaryDone => 'Concluído';

  @override
  String get businessSummaryInfo => 'Informações do Negócio';

  @override
  String get businessSummaryName => 'Nome do Negócio:';

  @override
  String get businessSummaryLocation => 'Localização do Negócio:';

  @override
  String get businessSummaryStartDate => 'Data de Início:';

  @override
  String get businessSummaryProductType => 'Tipo de Produto:';

  @override
  String get businessSummaryOtherProductType => 'Outro Tipo de Produto:';

  @override
  String get businessSummaryEdit => 'Editar Informações';

  @override
  String get expensesListTitle => 'Lista de Despesas';

  @override
  String get expensesListNoExpenses => 'Nenhuma despesa registrada';

  @override
  String get expensesListAddPrompt =>
      'Toque no botão + para adicionar uma despesa';

  @override
  String get expensesListAddExpense => 'Adicionar Despesa';

  @override
  String expensesListAmount(Object amount) {
    return 'TSh $amount';
  }

  @override
  String expensesListReason(Object reason) {
    return 'Motivo: $reason';
  }

  @override
  String expensesListPayer(Object payer) {
    return 'Pagador: $payer';
  }

  @override
  String get expensesListUnknown => 'Desconhecido';

  @override
  String get expensesListNoDate => 'Sem data';

  @override
  String get purchaseListTitle => 'Lista de Compras';

  @override
  String get purchaseListNoPurchases => 'Nenhuma compra registrada';

  @override
  String get purchaseListAddPrompt =>
      'Toque no botão + para adicionar uma compra';

  @override
  String get purchaseListAddPurchase => 'Adicionar Compra';

  @override
  String purchaseListAmount(Object amount) {
    return 'TSh $amount';
  }

  @override
  String purchaseListBuyer(Object buyer) {
    return 'Comprador: $buyer';
  }

  @override
  String get purchaseListUnknown => 'Desconhecido';

  @override
  String get purchaseListNoDate => 'Sem data';

  @override
  String get saleListTitle => 'Lista de Vendas';

  @override
  String get saleListNoSales => 'Nenhuma venda registrada';

  @override
  String get saleListAddPrompt => 'Toque no botão + para adicionar uma venda';

  @override
  String get saleListAddSale => 'Adicionar Venda';

  @override
  String saleListAmount(Object amount) {
    return 'TSh $amount';
  }

  @override
  String saleListCustomer(Object customer) {
    return 'Cliente: $customer';
  }

  @override
  String saleListSeller(Object seller) {
    return 'Vendedor: $seller';
  }

  @override
  String get saleListUnknown => 'Desconhecido';

  @override
  String get saleListNoDate => 'Sem data';

  @override
  String get expensesTitle => 'Registrar Despesa';

  @override
  String get expensesBusinessName => 'Negócio';

  @override
  String get expensesBusinessLocationUnknown => 'Sem localização';

  @override
  String get expensesInfo => 'Informações da Despesa';

  @override
  String get expensesDate => 'Data';

  @override
  String get expensesDateHint => 'dd/mm/aaaa';

  @override
  String get expensesDateError => 'Por favor, selecione uma data';

  @override
  String get expensesDateAbove => 'Data da Despesa';

  @override
  String get expensesReason => 'Motivo da Despesa';

  @override
  String get expensesReasonHint => 'Digite o motivo da despesa';

  @override
  String get expensesReasonError => 'Por favor, insira o motivo da despesa';

  @override
  String get expensesReasonAbove => 'Motivo da Despesa';

  @override
  String get expensesAmount => 'Valor da Despesa';

  @override
  String get expensesAmountHint => 'Digite o valor em TSh';

  @override
  String get expensesAmountError => 'Por favor, insira o valor';

  @override
  String get expensesAmountInvalidError => 'Por favor, insira um número válido';

  @override
  String get expensesAmountAbove => 'Valor (TSh)';

  @override
  String get expensesPayer => 'Nome do Pagador';

  @override
  String get expensesPayerHint => 'Digite o nome do pagador';

  @override
  String get expensesPayerError => 'Por favor, insira o nome do pagador';

  @override
  String get expensesPayerAbove => 'Pagador';

  @override
  String get expensesDescription => 'Descrição da Despesa';

  @override
  String get expensesDescriptionHint => 'Digite detalhes adicionais da despesa';

  @override
  String get expensesDescriptionAbove => 'Descrição';

  @override
  String get expensesSave => 'Salvar Informações';

  @override
  String get purchasesTitle => 'Registrar Compra';

  @override
  String get purchasesBusinessName => 'Negócio';

  @override
  String get purchasesBusinessLocationUnknown => 'Sem localização';

  @override
  String get purchasesInfo => 'Informações da Compra';

  @override
  String get purchasesDate => 'Data';

  @override
  String get purchasesDateHint => 'dd/mm/aaaa';

  @override
  String get purchasesDateError => 'Por favor, selecione uma data';

  @override
  String get purchasesDateAbove => 'Data da Compra';

  @override
  String get purchasesAmount => 'Valor da Compra';

  @override
  String get purchasesAmountHint => 'Digite o valor em TSh';

  @override
  String get purchasesAmountError => 'Por favor, insira o valor';

  @override
  String get purchasesAmountInvalidError =>
      'Por favor, insira um número válido';

  @override
  String get purchasesAmountAbove => 'Custo da Compra';

  @override
  String get purchasesBuyer => 'Nome do Comprador';

  @override
  String get purchasesBuyerHint => 'Digite o nome do comprador';

  @override
  String get purchasesBuyerError => 'Por favor, insira o nome do comprador';

  @override
  String get purchasesBuyerAbove => 'Comprador';

  @override
  String get purchasesDescription => 'Descrição da Compra';

  @override
  String get purchasesDescriptionHint => 'Digite detalhes adicionais da compra';

  @override
  String get purchasesDescriptionAbove => 'Descrição';

  @override
  String get purchasesSave => 'Salvar Informações';

  @override
  String get salesTitle => 'Registrar Venda';

  @override
  String get salesBusinessName => 'Negócio';

  @override
  String get salesBusinessLocationUnknown => 'Sem localização';

  @override
  String get salesInfo => 'Informações de Venda';

  @override
  String get salesDate => 'Data';

  @override
  String get salesDateHint => 'dd/mm/aaaa';

  @override
  String get salesDateError => 'Por favor, selecione uma data';

  @override
  String get salesDateAbove => 'Data da Venda';

  @override
  String get salesCustomer => 'Nome do Cliente';

  @override
  String get salesCustomerHint => 'Digite o nome do cliente';

  @override
  String get salesCustomerError => 'Por favor, insira o nome do cliente';

  @override
  String get salesCustomerAbove => 'Cliente';

  @override
  String get salesRevenue => 'Valor da Receita';

  @override
  String get salesRevenueHint => 'Digite o valor em TSh';

  @override
  String get salesRevenueError => 'Por favor, insira o valor';

  @override
  String get salesRevenueInvalidError => 'Por favor, insira um número válido';

  @override
  String get salesRevenueAbove => 'Receita';

  @override
  String get salesSeller => 'Nome do Vendedor';

  @override
  String get salesSellerHint => 'Digite o nome do vendedor';

  @override
  String get salesSellerError => 'Por favor, insira o nome do vendedor';

  @override
  String get salesSellerAbove => 'Vendedor';

  @override
  String get salesDescription => 'Descrição da Venda';

  @override
  String get salesDescriptionHint => 'Digite detalhes adicionais da venda';

  @override
  String get salesDescriptionAbove => 'Descrição';

  @override
  String get salesSave => 'Salvar Informações';

  @override
  String get badiliSarafu => 'Alterar Moeda';

  @override
  String get chaguaSarafuYaProgramu => 'Selecione a moeda do aplicativo';

  @override
  String get male => 'Masculino';

  @override
  String get female => 'Feminino';
}
