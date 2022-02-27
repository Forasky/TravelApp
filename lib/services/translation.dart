// ignore: implementation_imports
import 'package:easy_localization/easy_localization.dart';

class LocalizationKeys {
  static String login = 'Login'.tr();

  static String explainText = 'ExplainText'.tr();

  static String ifHaveNotAccount = 'IfHaveNotAccount'.tr();

  static String register = 'Register'.tr();

  static String wrPassword = 'WritePassword'.tr();

  static String forgotPassword = 'ForgotPassword'.tr();

  static String labelRegistration = 'LabelRegistration'.tr();

  static String enterFLname = 'EnterFirstLastName'.tr();

  static String enterNumber = 'EnterNumber'.tr();

  static String repeatPassword = 'RepeatPassword'.tr();

  static String findPeople = 'FindPeople'.tr();

  static String findCars = 'FindCars'.tr();

  static String people = 'People';

  static String cars = 'Cars';

  static String submit = 'Submit'.tr();

  static String whatsWrong = 'WhatsWrong'.tr();

  static String loading = 'Loading'.tr();

  static String add = 'Add'.tr();

  static String payment = 'Payment'.tr();

  static String viewProfile = 'ViewProfile'.tr();

  static String checkCars = 'CheckCars'.tr();

  static String checkPeople = 'CheckPeople'.tr();

  static String nameApplication = 'NameOfApp'.tr();

  static String addRequest = 'AddRequest'.tr();

  static String from = 'From'.tr();

  static String to = 'To'.tr();
  static String chooseDate = 'ChooseDate'.tr();

  static String choosePayment = 'ChoosePayment'.tr();

  static String enterName = 'EnterName'.tr();

  static String close = 'Close'.tr();

  static String settings = 'Settings'.tr();

  static String chooseLang = 'ChooseLanguage'.tr();

  static String currentLang = 'CurrentLanguage'.tr();

  static String iWantFind = 'IWantFind'.tr();

  static String incorrectUser = 'incorrect user'.tr();

  static String incorrectPassword = 'incorrect password'.tr();

  static String accountExist = 'account exist'.tr();

  static String userNoFound = 'no found'.tr();

  static String enterEmail = 'enter Email'.tr();

  static String plsEnterEmail = 'please enter email'.tr();

  static String enterPassword = 'enter password'.tr();

  static String plsEnterPassword = 'please enter password'.tr();

  static String error = 'error'.tr();

  static String feelLike = 'feelsLike'.tr();

  static String humidity = 'humidity'.tr();

  static String speedWind = 'speedw'.tr();

  static String pressure = 'pressure'.tr();

  static String lastUpdated(DateTime dt) => 'last updated'.tr(
        args: [
          DateFormat.jm().format(dt),
        ],
      );

  static String wait = 'wait'.tr();

  static String yourLocation = 'ur location'.tr();

  static String weatherMap = 'weather map'.tr();

  static String getWeather = 'get weather'.tr();

  static String locationFromMap = 'location map'.tr();

  static String weather = 'weather'.tr();

  static String map = 'map'.tr();

  static String enterCity = 'enter city'.tr();

  static String noDataFound = 'no data found'.tr();

  static String search = 'search'.tr();
}
