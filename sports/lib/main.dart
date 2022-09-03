import 'package:fantacySports/constance/DataStorage.dart';
import 'package:fantacySports/constance/constance.dart';
import 'package:fantacySports/constance/themes.dart';
import 'package:fantacySports/modules/home/home.dart';
import 'package:fantacySports/modules/login/loginPage.dart';
import 'package:fantacySports/modules/register/registerPage.dart';
import 'package:fantacySports/modules/splash/spalshPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fantacySports/constance/constance.dart' as constance;
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';

import 'Networking/notification.dart';
import 'Testing/Splash.dart';

void main() async {


  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // await flutterLocalNotificationsPlugin
  //     .resolvePlatformSpecificImplementation<
  //     AndroidFlutterLocalNotificationsPlugin>()
  //     ?.createNotificationChannel(channel);
  //
  // await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
  //   alert: true,
  //   badge: true,
  //   sound: true,
  // );
  await FlutterDownloader.initialize(
      debug: true,
      // optional: set to false to disable printing logs to console (default: true)
      ignoreSsl:
          true // option: set to false to disable working with http links (default: false)
      );
  FlutterDownloader.registerCallback(TestClass.callback);

  // FlutterDownloader.registerCallback((id, status, progress) {
  //   print('$id ${status} ${progress}');
  // });
  // FlutterDownloader.registerCallback(callback);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) => runApp(MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => Data()),
        ],
        child: new MyApp(),
      )
          // new MyApp()
          ));
}

// const AndroidNotificationChannel channel = AndroidNotificationChannel(
//   'high_importance_channel', // id
//   'High Importance Notifications', // title
//   // description
//   importance: Importance.high,
// );
// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
// FlutterLocalNotificationsPlugin();
//
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   // If you're going to use other Firebase services in the background, such as Firestore,
//   // make sure you call `initializeApp` before using other Firebase services.
//   await Firebase.initializeApp();
//   print('Handling a background message ${message.messageId}');
// }

class MyApp extends StatefulWidget {
  static setCustomeTheme(BuildContext context, int index) {
    final _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setCustomeTheme(index);
  }

  static setCustomeLanguage(BuildContext context, String languageCode) {
    final _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLanguage(languageCode);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  String notificationTitle = 'No Title';
  String notificationBody = 'No Body';
  String notificationData = 'No Data';

  setCustomeTheme(int index) {
    if (index == 6) {
      setState(() {
        AppTheme.isLightTheme = true;
      });
    } else if (index == 7) {
      setState(() {
        AppTheme.isLightTheme = false;
      });
    } else {
      setState(() {
        constance.colorsIndex = index;
        constance.primaryColorString =
            ConstanceData().colors[constance.colorsIndex];
        constance.secondaryColorString = constance.primaryColorString;
      });
    }
  }

  String locale = "en";

  setLanguage(String languageCode) {
    // setState(() {
    //   locale = languageCode;
    //   constance.locale = languageCode;
    // });
  }

  @override
  void initState() {

    final firebaseMessaging = FCM();
    firebaseMessaging.setNotifications();

    firebaseMessaging.streamCtlr.stream.listen(_changeData);
    firebaseMessaging.bodyCtlr.stream.listen(_changeBody);
    firebaseMessaging.titleCtlr.stream.listen(_changeTitle);
    super.initState();
  }

  _changeData(String msg) => setState(() => notificationData = msg);

  _changeBody(String msg) => setState(() => notificationBody = msg);

  _changeTitle(String msg) => setState(() => notificationTitle = msg);
  String token;

  getToken() async {
    token = await FirebaseMessaging.instance.getToken();
  }

  @override
  Widget build(BuildContext context) {
    constance.locale = locale;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness:
          AppTheme.isLightTheme ? Brightness.dark : Brightness.light,
      statusBarBrightness:
          AppTheme.isLightTheme ? Brightness.light : Brightness.dark,
      systemNavigationBarColor:
          AppTheme.isLightTheme ? Colors.white : Colors.black,
      systemNavigationBarDividerColor: Colors.grey,
      systemNavigationBarIconBrightness:
          AppTheme.isLightTheme ? Brightness.dark : Brightness.light,
    ));
    return MaterialApp(
      title: 'Apna Team',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.getTheme(),
      home: Splash(),
      routes: routes,
    );
  }

  var routes = <String, WidgetBuilder>{
    // Routes.SPLASH: (BuildContext context) => Splash(),
    Routes.LOGIN: (BuildContext context) => LoginScreen(),
    Routes.REGISTER: (BuildContext context) => RegisterPage(),
    Routes.HOME: (BuildContext context) => Home(),
    Routes.HOST: (BuildContext context) => SplashScreen(),
    // Routes.SIGNUP: (BuildContext context) => SignUpScreen(),
  };
}

class Routes {
  // static const String SPLASH = "/";
  static const String LOGIN = "/login";
  static const String REGISTER = "/register";
  static const String HOME = "/home";
  static const String HOST = "/host";

// static const String SIGNUP = "/signup";
}
class TestClass{
  static void callback(String id, DownloadTaskStatus status, int progress) {}
}