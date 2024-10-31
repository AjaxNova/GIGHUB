// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lite_jobs/controller/provider/auth_provider.dart';
// import 'package:lite_jobs/controller/applied_jobs_provider.dart';
import 'package:lite_jobs/controller/provider/edit_your_profile_provider.dart';
import 'package:lite_jobs/controller/provider/finish_your_profile_provider.dart';
import 'package:lite_jobs/controller/provider/home_screen_provider.dart';
import 'package:lite_jobs/controller/provider/job_description_page_provider.dart';
import 'package:lite_jobs/controller/provider/post_job_provider.dart';
import 'package:lite_jobs/controller/provider/searc_screen_provider.dart';
import 'package:lite_jobs/controller/provider/select_person_from_applied_list.dart';
import 'package:lite_jobs/controller/provider/selected_user_status_provider.dart';
import 'package:lite_jobs/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:lite_jobs/features/finishYourProfile/presentation/bloc/finish_profile_bloc.dart';
import 'package:lite_jobs/features/splashScreen/presentation/bloc/splash_screen_bloc.dart';
import 'package:lite_jobs/features/splashScreen/presentation/pages/splash_screen.dart';
import 'package:lite_jobs/injection_container.dart';
import 'package:lite_jobs/utils/secret/secrets.dart';
import 'package:lite_jobs/view/screens/auth/initialPage/initial_page.dart';
import 'package:provider/provider.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(options: fOptions);
  } else {
    await Firebase.initializeApp();
  }
  await initializeDependacies();

  runApp(const LiteJobs());
}

class LiteJobs extends StatelessWidget {
  const LiteJobs({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (BuildContext context) => AuthBloc(sl(), sl()),
        ),
        BlocProvider<SplashScreenBloc>(
          create: (BuildContext context) => SplashScreenBloc(sl()),
        ),
        BlocProvider<FinishProfileBloc>(
          create: (BuildContext context) => FinishProfileBloc(sl()),
        ),
      ],
      child: MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => AuthProviderData(),
            ),
            // ChangeNotifierProvider(
            //   create: (context) => SignUpScreenProvider(),
            // ),
            // ChangeNotifierProvider(
            //   create: (context) => SigninProvider(),
            // ),
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
                  // return const InitialPage();
                  return const InitialPage();
                }
              },
            ),
          )),
    );
  }
}
