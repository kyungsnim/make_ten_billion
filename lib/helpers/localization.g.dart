import 'package:get/get.dart';

class Localization extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en': {
'auth.signInButton': 'Sign In',
'auth.signUpButton': 'Sign Up',
'auth.resetPasswordButton': 'Send Password Reset',
'auth.emailFormField': 'Email',
'auth.passwordFormField': 'Password',
'auth.nameFormField': 'Name',
'auth.signInErrorTitle': 'Sign In Error',
'auth.signInError': 'Login failed: email or password incorrect.',
'auth.resetPasswordLabelButton': 'Forgot password?',
'auth.signUpLabelButton': 'Create an Account',
'auth.signUpErrorTitle': 'Sign Up Failed.',
'auth.signUpError': 'There was a problem signing up.  Please try again later.',
'auth.signInLabelButton': 'Have an Account? Sign In.',
'auth.resetPasswordNoticeTitle': 'Password Reset Email Sent',
'auth.resetPasswordNotice': 'Check your email and follow the instructions to reset your password.',
'auth.resetPasswordFailed': 'Password Reset Email Failed',
'auth.signInonResetPasswordLabelButton': 'Sign In',
'auth.updateUser': 'Update Profile',
'auth.updateUserSuccessNoticeTitle': 'User Updated',
'auth.updateUserSuccessNotice': 'User information successfully updated.',
'auth.updateUserEmailInUse': 'That email address already has an account.',
'auth.updateUserFailNotice': 'Failed to update user',
'auth.enterPassword': 'Enter your password',
'auth.cancel': 'Cancel',
'auth.submit': 'Submit',
'auth.changePasswordLabelButton': 'Change Password',
'auth.resetPasswordTitle': 'Reset Password',
'auth.updateProfileTitle': 'Update Profile',
'auth.wrongPasswordNoticeTitle': 'Login Failed',
'auth.wrongPasswordNotice': 'The password does not match our records.',
'auth.unknownError': 'Unknown Error',
'settings.title': 'Settings',
'settings.language': 'Language',
'settings.theme': 'Theme',
'settings.signOut': 'Sign Out',
'settings.dark': 'Dark',
'settings.light': 'Light',
'settings.system': 'System',
'settings.updateProfile': 'Update Profile',
'home.title': 'Home',
'home.nameLabel': 'Name',
'home.uidLabel': 'UID',
'home.emailLabel': 'Email',
'home.adminUserLabel': 'Admin User',
'app.title': 'Flutter Starter Project',
'validator.email': 'Please enter a valid email address.',
'validator.password': 'Password must be at least 6 characters.',
'validator.name': 'Please enter a name.',
'validator.number': 'Please enter a number.',
'validator.notEmpty': 'This is a required field.',
'validator.amount': 'Please enter a number i.e. 250 - no dollar symbol and no cents',
},
'fr': {
'auth.signInButton': 'S\'identifier',
'auth.signUpButton': 'S\'inscrire',
'auth.resetPasswordButton': 'Envoyer Password Reset',
'auth.emailFormField': 'E-mail',
'auth.passwordFormField': 'Mot de passe',
'auth.nameFormField': 'Nom',
'auth.signInErrorTitle': 'Erreur de connexion',
'auth.signInError': 'Échec de la connexion: e-mail ou mot de passe incorrect.',
'auth.resetPasswordLabelButton': 'Mot de passe oublié?',
'auth.signUpLabelButton': 'Créer un compte',
'auth.signUpErrorTitle': 'Échec de l\'inscription.',
'auth.signUpError': 'Il y avait un problème de signer. Veuillez réessayer plus tard.',
'auth.signInLabelButton': 'Avoir un compte? S\'identifier.',
'auth.resetPasswordNoticeTitle': 'Réinitialiser le mot de passe e-mail envoyé',
'auth.resetPasswordNotice': 'Vérifiez votre e-mail et suivez les instructions pour réinitialiser votre mot de passe.',
'auth.resetPasswordFailed': 'Réinitialiser le mot de passe Email Échec',
'auth.signInonResetPasswordLabelButton': 'S\'identifier',
'auth.updateUser': 'Mettre à jour le profil',
'auth.updateUserSuccessNoticeTitle': 'Mise à jour l\'utilisateur',
'auth.updateUserSuccessNotice': 'Informations sur l\'utilisateur mis à jour avec succès.',
'auth.updateUserEmailInUse': 'Cette adresse e-mail a déjà un compte.',
'auth.updateUserFailNotice': 'Impossible de mettre à jour l\'utilisateur',
'auth.enterPassword': 'Tapez votre mot de passe',
'auth.cancel': 'Annuler',
'auth.submit': 'Soumettre',
'auth.changePasswordLabelButton': 'Changer le mot de passe',
'auth.resetPasswordTitle': 'réinitialiser le mot de passe',
'auth.updateProfileTitle': 'Mettre à jour le profil',
'auth.wrongPasswordNoticeTitle': 'Échec de la connexion',
'auth.wrongPasswordNotice': 'Le mot de passe ne correspond pas à nos dossiers.',
'auth.unknownError': 'Erreur inconnue',
'settings.title': 'Paramètres',
'settings.language': 'Langue',
'settings.theme': 'Thème',
'settings.signOut': 'Se déconnecter',
'settings.dark': 'Sombre',
'settings.light': 'Lumière',
'settings.system': 'Système',
'settings.updateProfile': 'Mettre à jour le profil',
'home.title': 'Domicile',
'home.nameLabel': 'Nom',
'home.uidLabel': 'UID',
'home.emailLabel': 'E-mail',
'home.adminUserLabel': 'utilisateur admin',
'app.title': 'Flutter projet de démarrage',
'validator.email': 'S\'il vous plaît, mettez une adresse email valide.',
'validator.password': 'Le mot de passe doit être au moins de 6 caractères.',
'validator.name': 'S\'il vous plaît entrer un nom.',
'validator.number': 'S\'il vous plaît entrer un numéro.',
'validator.notEmpty': 'Ceci est un champ obligatoire.',
'validator.amount': 'S\'il vous plaît entrer un numéro à savoir 250 - aucun symbole du dollar et pas cents',
},
'es': {
'auth.signInButton': 'Iniciar sesión',
'auth.signUpButton': 'Inscribirse',
'auth.resetPasswordButton': 'Enviar restablecimiento de contraseña',
'auth.emailFormField': 'Correo electrónico',
'auth.passwordFormField': 'Contraseña',
'auth.nameFormField': 'Nombre',
'auth.signInErrorTitle': 'Error al iniciar sesión',
'auth.signInError': 'La conexión falló: correo electrónico o contraseña incorrecta.',
'auth.resetPasswordLabelButton': '¿Se te olvidó tu contraseña?',
'auth.signUpLabelButton': 'Crea una cuenta',
'auth.signUpErrorTitle': 'Registro fallido.',
'auth.signUpError': 'Hubo un problema al inscribirse. Por favor, inténtelo de nuevo más tarde.',
'auth.signInLabelButton': '¿Tener una cuenta? Iniciar sesión.',
'auth.resetPasswordNoticeTitle': 'Restablecer contraseña de correo electrónico enviados',
'auth.resetPasswordNotice': 'Consultar su correo electrónico y siga las instrucciones para restablecer su contraseña.',
'auth.resetPasswordFailed': 'Restablecer contraseña de correo electrónico incorrecto',
'auth.signInonResetPasswordLabelButton': 'Iniciar sesión',
'auth.updateUser': 'Actualización del perfil',
'auth.updateUserSuccessNoticeTitle': 'Actualización de usuario',
'auth.updateUserSuccessNotice': 'La información de usuario actualizada correctamente.',
'auth.updateUserEmailInUse': 'Esa dirección de correo electrónico ya tiene una cuenta.',
'auth.updateUserFailNotice': 'Error al usuario la actualización',
'auth.enterPassword': 'Ingresa tu contraseña',
'auth.cancel': 'Cancelar',
'auth.submit': 'Enviar',
'auth.changePasswordLabelButton': 'Cambiar la contraseña',
'auth.resetPasswordTitle': 'Restablecer la contraseña',
'auth.updateProfileTitle': 'Actualización del perfil',
'auth.wrongPasswordNoticeTitle': 'Error de inicio de sesion',
'auth.wrongPasswordNotice': 'La contraseña no coincide con nuestros registros.',
'auth.unknownError': 'Error desconocido',
'settings.title': 'Ajustes',
'settings.language': 'Idioma',
'settings.theme': 'Tema',
'settings.signOut': 'Desconectar',
'settings.dark': 'Oscuro',
'settings.light': 'Luz',
'settings.system': 'Sistema',
'settings.updateProfile': 'Actualización del perfil',
'home.title': 'Casa',
'home.nameLabel': 'Nombre',
'home.uidLabel': 'UID',
'home.emailLabel': 'Correo electrónico',
'home.adminUserLabel': 'admin User',
'app.title': 'Proyecto de arranque aleteo',
'validator.email': 'Por favor, introduce una dirección de correo electrónico válida.',
'validator.password': 'La contraseña debe tener al menos 6 caracteres.',
'validator.name': 'Por favor, introduzca un nombre.',
'validator.number': 'Por favor, introduzca un número.',
'validator.notEmpty': 'Este es un campo obligatorio.',
'validator.amount': 'Por favor, introduzca un número, es decir 250 - ningún símbolo del dólar y sin centavos',
},
'de': {
'auth.signInButton': 'Einloggen',
'auth.signUpButton': 'Anmeldung',
'auth.resetPasswordButton': 'Senden Passwort zurücksetzen',
'auth.emailFormField': 'Email',
'auth.passwordFormField': 'Passwort',
'auth.nameFormField': 'Name',
'auth.signInErrorTitle': 'Anmelden Fehler',
'auth.signInError': 'Fehler bei der Anmeldung: E-Mail oder Passwort falsch.',
'auth.resetPasswordLabelButton': 'Passwort vergessen?',
'auth.signUpLabelButton': 'Ein Konto erstellen',
'auth.signUpErrorTitle': 'Anmeldung gescheitert.',
'auth.signUpError': 'Es gab ein Problem anmeldest. Bitte versuchen Sie es später noch einmal.',
'auth.signInLabelButton': 'Ein Konto haben? Einloggen.',
'auth.resetPasswordNoticeTitle': 'Passwort zurücksetzen E-Mail gesendet',
'auth.resetPasswordNotice': 'Überprüfen Sie Ihre E-Mail und folgen Sie den Anweisungen, um Ihr Passwort zurücksetzen können.',
'auth.resetPasswordFailed': 'Passwort zurücksetzen E-Mail fehlgeschlagen',
'auth.signInonResetPasswordLabelButton': 'Einloggen',
'auth.updateUser': 'Profil aktualisieren',
'auth.updateUserSuccessNoticeTitle': 'Benutzer Aktualisiert',
'auth.updateUserSuccessNotice': 'Benutzerinformationen erfolgreich aktualisiert.',
'auth.updateUserEmailInUse': 'Die E-Mail-Adresse hat bereits ein Konto.',
'auth.updateUserFailNotice': 'Fehler beim Update Benutzer',
'auth.enterPassword': 'Geben Sie Ihr Passwort',
'auth.cancel': 'Stornieren',
'auth.submit': 'einreichen',
'auth.changePasswordLabelButton': 'Kennwort ändern',
'auth.resetPasswordTitle': 'Passwort zurücksetzen',
'auth.updateProfileTitle': 'Profil aktualisieren',
'auth.wrongPasswordNoticeTitle': 'Fehler bei der Anmeldung',
'auth.wrongPasswordNotice': 'Das Passwort nicht unsere entsprechenden Datensätze gefunden.',
'auth.unknownError': 'Unbekannter Fehler',
'settings.title': 'die Einstellungen',
'settings.language': 'Sprache',
'settings.theme': 'Thema',
'settings.signOut': 'Austragen',
'settings.dark': 'Dunkel',
'settings.light': 'Licht',
'settings.system': 'System',
'settings.updateProfile': 'Profil aktualisieren',
'home.title': 'Zuhause',
'home.nameLabel': 'Name',
'home.uidLabel': 'UID',
'home.emailLabel': 'Email',
'home.adminUserLabel': 'Admin Benutzer',
'app.title': 'Flutter Starter-Projekt',
'validator.email': 'Bitte geben Sie eine gültige E-Mail-Adresse ein.',
'validator.password': 'Passwort muss mindestens 6 Zeichen lang sein.',
'validator.name': 'Bitte geben Sie einen Namen.',
'validator.number': 'Bitte gebe eine Nummer ein.',
'validator.notEmpty': 'Dies ist ein Pflichtfeld.',
'validator.amount': 'Bitte geben Sie eine Zahl das heißt 250 - kein Dollar-Symbol und keinen Cent',
},
'hi': {
'auth.signInButton': 'दाखिल करना',
'auth.signUpButton': 'साइन अप करें',
'auth.resetPasswordButton': 'भेजें पासवर्ड रीसेट',
'auth.emailFormField': 'ईमेल',
'auth.passwordFormField': 'कुंजिका',
'auth.nameFormField': 'नाम',
'auth.signInErrorTitle': 'साइन इन त्रुटि',
'auth.signInError': 'लॉगइन असफल: ईमेल या पासवर्ड गलत है।',
'auth.resetPasswordLabelButton': 'पासवर्ड भूल गए?',
'auth.signUpLabelButton': 'खाता बनाएं',
'auth.signUpErrorTitle': 'साइन अप करने में विफल रहा।',
'auth.signUpError': 'साइन अप करने में समस्या हुई थी। बाद में पुन: प्रयास करें।',
'auth.signInLabelButton': 'एक खाता है? दाखिल करना।',
'auth.resetPasswordNoticeTitle': 'पासवर्ड रीसेट ईमेल भेजा',
'auth.resetPasswordNotice': 'अपने ईमेल की जाँच करें और निर्देशों का अपना पासवर्ड रीसेट करने का पालन करें।',
'auth.resetPasswordFailed': 'पासवर्ड रीसेट ईमेल में विफल',
'auth.signInonResetPasswordLabelButton': 'दाखिल करना',
'auth.updateUser': 'प्रोफ़ाइल अपडेट करें',
'auth.updateUserSuccessNoticeTitle': 'उपयोगकर्ता अपडेट किया गया',
'auth.updateUserSuccessNotice': 'उपयोगकर्ता जानकारी सफलतापूर्वक अपडेट।',
'auth.updateUserEmailInUse': 'यही कारण है कि ईमेल पता पहले से ही खाता है।',
'auth.updateUserFailNotice': 'उपयोगकर्ता अद्यतन करने में विफल',
'auth.enterPassword': 'अपना पासवर्ड डालें',
'auth.cancel': 'रद्द करना',
'auth.submit': 'प्रस्तुत',
'auth.changePasswordLabelButton': 'पासवर्ड बदलें',
'auth.resetPasswordTitle': 'पासवर्ड रीसेट',
'auth.updateProfileTitle': 'प्रोफ़ाइल अपडेट करें',
'auth.wrongPasswordNoticeTitle': 'लॉगिन विफल',
'auth.wrongPasswordNotice': 'पासवर्ड हमारे रिकॉर्ड से मेल नहीं खाता।',
'auth.unknownError': 'अज्ञात त्रुटि',
'settings.title': 'समायोजन',
'settings.language': 'भाषा: हिन्दी',
'settings.theme': 'विषय',
'settings.signOut': 'प्रस्थान करें',
'settings.dark': 'अंधेरा',
'settings.light': 'रोशनी',
'settings.system': 'प्रणाली',
'settings.updateProfile': 'प्रोफ़ाइल अपडेट करें',
'home.title': 'घर',
'home.nameLabel': 'नाम',
'home.uidLabel': 'यूआईडी',
'home.emailLabel': 'ईमेल',
'home.adminUserLabel': 'व्यवस्थापक उपयोगकर्ता',
'app.title': 'स्पंदन स्टार्टर परियोजना',
'validator.email': 'कृपया एक वैध ई - मेल एड्रेस डालें।',
'validator.password': 'पासवर्ड कम से कम 6 अंकों का होना चाहिए।',
'validator.name': 'एक नाम दर्ज करें।',
'validator.number': 'एक संख्या दर्ज करें।',
'validator.notEmpty': 'यह एक आवश्यक फील्ड है।',
'validator.amount': 'कोई डॉलर प्रतीक और कोई सेंट - एक नंबर अर्थात 250 दर्ज करें',
},
'pt': {
'auth.signInButton': 'Entrar',
'auth.signUpButton': 'Inscrever-se',
'auth.resetPasswordButton': 'Enviar Password Reset',
'auth.emailFormField': 'E-mail',
'auth.passwordFormField': 'Senha',
'auth.nameFormField': 'Nome',
'auth.signInErrorTitle': 'Entrar erro',
'auth.signInError': 'Falha de logon: e-mail ou senha incorreta.',
'auth.resetPasswordLabelButton': 'Esqueceu a senha?',
'auth.signUpLabelButton': 'Crie a sua conta aqui',
'auth.signUpErrorTitle': 'Registre-se Falhou.',
'auth.signUpError': 'Houve um problema se inscrever. Por favor, tente novamente mais tarde.',
'auth.signInLabelButton': 'Ter uma conta? Entrar.',
'auth.resetPasswordNoticeTitle': 'Senha enviada uma reinicialização',
'auth.resetPasswordNotice': 'Verifique se o seu e-mail e siga as instruções para redefinir sua senha.',
'auth.resetPasswordFailed': 'Password Reset-mail Falha',
'auth.signInonResetPasswordLabelButton': 'Entrar',
'auth.updateUser': 'Atualizar perfil',
'auth.updateUserSuccessNoticeTitle': 'do usuário atualizada',
'auth.updateUserSuccessNotice': 'informações do usuário atualizado com sucesso.',
'auth.updateUserEmailInUse': 'Este endereço de email já tem uma conta.',
'auth.updateUserFailNotice': 'Falha ao usuário de atualização',
'auth.enterPassword': 'Coloque sua senha',
'auth.cancel': 'Cancelar',
'auth.submit': 'Enviar',
'auth.changePasswordLabelButton': 'Alterar a senha',
'auth.resetPasswordTitle': 'Password Reset',
'auth.updateProfileTitle': 'Atualizar perfil',
'auth.wrongPasswordNoticeTitle': 'Falha no login',
'auth.wrongPasswordNotice': 'A senha não coincide com nossos registros.',
'auth.unknownError': 'Erro desconhecido',
'settings.title': 'Definições',
'settings.language': 'Língua',
'settings.theme': 'Tema',
'settings.signOut': 'Sair',
'settings.dark': 'Escuro',
'settings.light': 'Luz',
'settings.system': 'Sistema',
'settings.updateProfile': 'Atualizar perfil',
'home.title': 'Casa',
'home.nameLabel': 'Nome',
'home.uidLabel': 'UID',
'home.emailLabel': 'E-mail',
'home.adminUserLabel': 'admin User',
'app.title': 'Projeto de arranque Flutter',
'validator.email': 'Por favor insira um endereço de e-mail válido.',
'validator.password': 'A senha deve ter pelo menos 6 caracteres.',
'validator.name': 'Por favor, indique um nome.',
'validator.number': 'Por favor, coloque um numero.',
'validator.notEmpty': 'Este é um campo obrigatório.',
'validator.amount': 'Por favor insira um número ou seja 250 - nenhum símbolo dólar e há centavos',
},
'zh': {
'auth.signInButton': '登入',
'auth.signUpButton': '报名',
'auth.resetPasswordButton': '发送密码重置',
'auth.emailFormField': '电子邮件',
'auth.passwordFormField': '密码',
'auth.nameFormField': '名称',
'auth.signInErrorTitle': '登录错误',
'auth.signInError': '登录失败：电子邮件或密码不正确。',
'auth.resetPasswordLabelButton': '忘记密码？',
'auth.signUpLabelButton': '创建一个帐户',
'auth.signUpErrorTitle': '注册失败。',
'auth.signUpError': '有注册的问题。请稍后再试。',
'auth.signInLabelButton': '有一个账户？登入。',
'auth.resetPasswordNoticeTitle': '密码重置邮件已发送',
'auth.resetPasswordNotice': '检查你的电子邮件，并按照重置密码的说明。',
'auth.resetPasswordFailed': '密码重置电子邮件失败',
'auth.signInonResetPasswordLabelButton': '登入',
'auth.updateUser': '更新个人信息',
'auth.updateUserSuccessNoticeTitle': '用户更新',
'auth.updateUserSuccessNotice': '用户信息更新成功。',
'auth.updateUserEmailInUse': '该电子邮件地址已经有一个帐户。',
'auth.updateUserFailNotice': '无法更新用户',
'auth.enterPassword': '输入您的密码',
'auth.cancel': '取消',
'auth.submit': '提交',
'auth.changePasswordLabelButton': '更改密码',
'auth.resetPasswordTitle': '重设密码',
'auth.updateProfileTitle': '更新个人信息',
'auth.wrongPasswordNoticeTitle': '登录失败',
'auth.wrongPasswordNotice': '该密码不符合我们的记录。',
'auth.unknownError': '未知错误',
'settings.title': '设置',
'settings.language': '语',
'settings.theme': '主题',
'settings.signOut': '登出',
'settings.dark': '黑暗的',
'settings.light': '光',
'settings.system': '系统',
'settings.updateProfile': '更新个人信息',
'home.title': '家',
'home.nameLabel': '名称',
'home.uidLabel': 'UID',
'home.emailLabel': '电子邮件',
'home.adminUserLabel': '管理员用户',
'app.title': '扑启动项目',
'validator.email': '请输入有效的电子邮件地址。',
'validator.password': '密码必须至少6个字符。',
'validator.name': '请输入姓名。',
'validator.number': '请输入一个数字。',
'validator.notEmpty': '这是一个必填字段。',
'validator.amount': '请输入一个数，即250  - 没有美元符号和无分',
},
'ja': {
'auth.signInButton': 'サインイン',
'auth.signUpButton': 'サインアップ',
'auth.resetPasswordButton': '送信パスワードリセット',
'auth.emailFormField': 'Eメール',
'auth.passwordFormField': 'パスワード',
'auth.nameFormField': '名前',
'auth.signInErrorTitle': 'エラーサインイン',
'auth.signInError': 'ログインに失敗しました：電子メールまたはパスワードが正しくありません。',
'auth.resetPasswordLabelButton': 'パスワードをお忘れですか？',
'auth.signUpLabelButton': 'アカウントを作成する',
'auth.signUpErrorTitle': 'サインアップは失敗しました。',
'auth.signUpError': 'サインアップする問題が発生しました。後ほど再度お試しください。',
'auth.signInLabelButton': 'アカウントを持っています？サインイン。',
'auth.resetPasswordNoticeTitle': 'パスワードリセットのメール送信され',
'auth.resetPasswordNotice': 'あなたの電子メールをチェックして、あなたのパスワードをリセットするための指示に従ってください。',
'auth.resetPasswordFailed': 'パスワードリセットのメールが失敗しました。',
'auth.signInonResetPasswordLabelButton': 'サインイン',
'auth.updateUser': 'プロフィールを更新',
'auth.updateUserSuccessNoticeTitle': 'ユーザーの更新',
'auth.updateUserSuccessNotice': 'ユーザー情報が正常に更新します。',
'auth.updateUserEmailInUse': 'そのメールアドレスは、既にアカウントを持っています。',
'auth.updateUserFailNotice': '更新ユーザーに失敗しました。',
'auth.enterPassword': 'パスワードを入力してください',
'auth.cancel': 'キャンセル',
'auth.submit': '参加する',
'auth.changePasswordLabelButton': 'パスワードを変更する',
'auth.resetPasswordTitle': 'パスワードを再設定する',
'auth.updateProfileTitle': 'プロフィールを更新',
'auth.wrongPasswordNoticeTitle': 'ログインに失敗しました',
'auth.wrongPasswordNotice': 'パスワードは我々の記録と一致しません。',
'auth.unknownError': '不明なエラー',
'settings.title': '設定',
'settings.language': '言語',
'settings.theme': 'テーマ',
'settings.signOut': 'サインアウト',
'settings.dark': '闇',
'settings.light': '光',
'settings.system': 'システム',
'settings.updateProfile': 'プロフィールを更新',
'home.title': '家',
'home.nameLabel': '名前',
'home.uidLabel': 'UID',
'home.emailLabel': 'Eメール',
'home.adminUserLabel': '管理者ユーザー',
'app.title': 'フラッタースタータープロジェクト',
'validator.email': '有効なメールアドレスを入力してください。',
'validator.password': 'パスワードは少なくとも6文字でなければなりません。',
'validator.name': '名前を入力してください。',
'validator.number': '番号を入力してください。',
'validator.notEmpty': 'これは必要項目です。',
'validator.amount': 'ノードル記号なしセント - すなわち、250番号を入力してください。',
},
'ru': {
'auth.signInButton': 'Войти',
'auth.signUpButton': 'Зарегистрироваться',
'auth.resetPasswordButton': 'Отправить Сброс пароля',
'auth.emailFormField': 'Электронное письмо',
'auth.passwordFormField': 'Пароль',
'auth.nameFormField': 'Имя',
'auth.signInErrorTitle': 'Ошибка входа',
'auth.signInError': 'Войти не удалось: адрес электронной почты или пароль неверен.',
'auth.resetPasswordLabelButton': 'забыл пароль?',
'auth.signUpLabelButton': 'Завести аккаунт',
'auth.signUpErrorTitle': 'Регистрация прошла неудачно.',
'auth.signUpError': 'Была проблема подписания. Пожалуйста, повторите попытку позже.',
'auth.signInLabelButton': 'Иметь аккаунт? Войти.',
'auth.resetPasswordNoticeTitle': 'Сброс пароля Email Sent',
'auth.resetPasswordNotice': 'Проверьте электронную почту и следуйте инструкциям, чтобы сбросить пароль.',
'auth.resetPasswordFailed': 'Сброс пароля Email Failed',
'auth.signInonResetPasswordLabelButton': 'Войти',
'auth.updateUser': 'Обновить профиль',
'auth.updateUserSuccessNoticeTitle': 'Пользователь Обновлено',
'auth.updateUserSuccessNotice': 'Информация о пользователе успешно обновлена.',
'auth.updateUserEmailInUse': 'Этот адрес электронной почты уже есть учетная запись.',
'auth.updateUserFailNotice': 'Не удался пользователь обновления',
'auth.enterPassword': 'Введите свой пароль',
'auth.cancel': 'Отмена',
'auth.submit': 'Представлять на рассмотрение',
'auth.changePasswordLabelButton': 'Измени пароль',
'auth.resetPasswordTitle': 'Сброс пароля',
'auth.updateProfileTitle': 'Обновить профиль',
'auth.wrongPasswordNoticeTitle': 'Ошибка входа',
'auth.wrongPasswordNotice': 'Пароль не соответствует нашим данным.',
'auth.unknownError': 'Неизвестная ошибка',
'settings.title': 'Настройки',
'settings.language': 'Язык',
'settings.theme': 'Тема',
'settings.signOut': 'Выход',
'settings.dark': 'Темный',
'settings.light': 'Свет',
'settings.system': 'Система',
'settings.updateProfile': 'Обновить профиль',
'home.title': 'Дом',
'home.nameLabel': 'Имя',
'home.uidLabel': 'UID',
'home.emailLabel': 'Электронное письмо',
'home.adminUserLabel': 'Пользователь Admin',
'app.title': 'Проект флаттер Starter',
'validator.email': 'Пожалуйста, введите действительный адрес электронной почты.',
'validator.password': 'Пароль должен быть не менее 6 символов.',
'validator.name': 'Пожалуйста, введите имя.',
'validator.number': 'Пожалуйста, введите номер.',
'validator.notEmpty': 'Это поле обязательно для заполнения.',
'validator.amount': 'Пожалуйста, введите номер 250 - т.е. без символа доллара и ни цента',
},
        };
      }
      