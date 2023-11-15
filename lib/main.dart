import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:lite_jobs/controller/applied_jobs_provider.dart';
import 'package:lite_jobs/controller/provider/auth_provider.dart';
import 'package:lite_jobs/controller/provider/edit_your_profile_provider.dart';
import 'package:lite_jobs/controller/provider/finish_your_profile_provider.dart';
import 'package:lite_jobs/controller/provider/home_screen_provider.dart';
import 'package:lite_jobs/controller/provider/job_description_page_provider.dart';
import 'package:lite_jobs/controller/provider/post_job_provider.dart';
import 'package:lite_jobs/controller/provider/searc_screen_provider.dart';
import 'package:lite_jobs/controller/provider/select_person_from_applied_list.dart';
import 'package:lite_jobs/controller/provider/selected_user_status_provider.dart';
import 'package:lite_jobs/controller/provider/sign_in_screen_provider.dart';
import 'package:lite_jobs/controller/provider/sign_up_screen_provider.dart';
import 'package:lite_jobs/screens/auth/initialPage/initial_page.dart';
import 'package:lite_jobs/screens/splashScreen/splash_screen.dart';
import 'package:provider/provider.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyBnA02Mr4oAdKJ-KZpw6zfKF-n-1XdZZks",
        appId: "1:210768281009:web:b6fbe90560d44f1d3dd190",
        messagingSenderId: "210768281009",
        projectId: "litejobs-9f389",
        storageBucket: "litejobs-9f389.appspot.com",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(const LiteJobs());
}

class LiteJobs extends StatelessWidget {
  const LiteJobs({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => AuthProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => SignUpScreenProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => SigninProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => PostJobScreenProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => JobDescriptionProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => SelectedUserStatusProvider(),
          ),
          // ChangeNotifierProvider(
          //   create: (context) => AppliedJobsProvider(),
          // ),
          ChangeNotifierProvider(
            create: (context) => SelectPersonFromListProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => FinishYourProfileProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => EditProfilePageProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => SearchScreenProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => HomeScreenProvider(),
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Colors.blue,
          ),
          home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasData) {
                return const SplashScreen();
              } else {
                return const InitialPage();
              }
            },
          ),
        ));
  }
}
