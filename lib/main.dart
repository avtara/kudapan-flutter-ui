import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:kudapan/ui/home.dart';
import 'package:kudapan/ui/signin.dart';
import 'package:kudapan/ui/splash_screen.dart';
import 'package:kudapan/config/constant.dart';
import 'package:kudapan/controllers/auth_controllers.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

void main() async {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('assets/google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['assets/google_fonts'], license);
  });

  // this function makes application always run in portrait mode
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApps());
  });
}

class MyApps extends StatelessWidget {
  // This widget is the root of your application.
  final authC = Get.put(AuthController(), permanent: true);
  @override
  Widget build(BuildContext context) {
    // Initialize all bloc provider used on this entire application here
    return StreamBuilder<User?>(
        stream: authC.streamAuthStatus,
        builder: (context, snapshot) {
          print(snapshot);
          if (snapshot.connectionState == ConnectionState.active) {
            return MaterialApp(
              title: APP_NAME,
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                visualDensity: VisualDensity.adaptivePlatformDensity,
                pageTransitionsTheme: PageTransitionsTheme(builders: {
                  TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
                  TargetPlatform.android: ZoomPageTransitionsBuilder(),
                }),
              ),
              home: snapshot.data != null ? HomePage() : Signin(),
            );
          }
          return SplashScreenPage();
        });
  }
}
