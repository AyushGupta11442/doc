import 'package:doctor/ClinicProfile/CentersList.dart';
import 'package:doctor/appointment/UpcomingAppointments.dart';
import 'package:doctor/appointmentBooking/details_appointment.dart';
import 'package:doctor/auth/loginpage.dart';
import 'package:doctor/routes/routesName.dart';
import 'package:doctor/view/HealthArticles/views/Article.dart';
import 'package:doctor/view/HealthArticles/views/ArticleOfCategory.dart';
import 'package:doctor/view/HealthArticles/views/AuthorsAllArticles.dart';
import 'package:doctor/view/HealthArticles/views/BookmarkedArticles.dart';
import 'package:doctor/view/HealthArticles/views/FilterArticle.dart';
import 'package:doctor/view/HealthArticles/views/Homepage.dart';
import 'package:doctor/view/Settings/view/ForgotPassword.dart';
import 'package:doctor/view/Settings/view/Settings.dart';
import 'package:doctor/view/clinicReview/view/AllReviews.dart';
import 'package:doctor/view/clinicReview/view/ClinicReview.dart';
import 'package:doctor/view/clinicReview/view/Submitted.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../Home/view/Homepage.dart';
import '../core/globalkey/globalkey.dart';
import '../error_screen.dart';
import '../main.dart';
import '../view/splashscreen.dart';

class Routes {
// ! routes
  static final GoRouter router = GoRouter(
    // refreshListenable:  ,
    redirect: (((BuildContext context, GoRouterState state) {
      final loggedIn = loginInfo.isLogin;
      final isLogging = state.location == '/login';
      if (!loggedIn && !isLogging) return '/login';
      if (loggedIn && isLogging) return '/home';
      return null;
    })),
    refreshListenable: loginInfo,
    initialLocation: '/splash',
    navigatorKey: navigatorKeyGo,
    routes: [
      // ! list of routes
      // ShellRoute(),
      GoRoute(
        name: RouteNames.loginScreen,
        path: '/login',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: LoginPage(),
        ),
      ),
      GoRoute(
        name: RouteNames.homeScreen,
        path: '/home',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const HomePage(),
        ),
      ),
      GoRoute(
        name: RouteNames.splashScreen,
        path: '/splash',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: SplashScreen(),
        ),
      ),
      GoRoute(
        name: RouteNames.cliniclist,
        path: '/allClinics',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const CentersList(),
        ),
      ),
      GoRoute(
        name: RouteNames.clinicReview,
        path: '/clinicReview',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const ClinicReview(),
        ),
      ),
      GoRoute(
        name: RouteNames.reviewsubmitted,
        path: '/reviewsubmitted',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const SubmitScreen(),
        ),
      ),
      GoRoute(
        name: RouteNames.allReviews,
        path: '/allReviews',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const AllReviews(),
        ),
      ),
      GoRoute(
        name: RouteNames.articleHomePage,
        path: '/articleHomePage',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const ArticleHomePage(),
        ),
      ),
      GoRoute(
        name: RouteNames.articleList,
        path: '/articleList',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const ArticleList(),
        ),
      ),
      GoRoute(
        name: RouteNames.bookmarkedArticles,
        path: '/bookmarkedArticles',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const BookmarkedArticles(),
        ),
      ),
      GoRoute(
        name: RouteNames.authorsArticles,
        path: '/authorsArticles',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const AuthorsArticles(),
        ),
      ),
      GoRoute(
        name: RouteNames.articleView,
        path: '/articleView',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const Article(),
        ),
      ),
      GoRoute(
        name: RouteNames.filterArticle,
        path: '/filterArticle',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const FilterArticle(),
        ),
      ),
      GoRoute(
        name: RouteNames.settings,
        path: '/settings',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const MySettings(),
        ),
      ),
      GoRoute(
        name: RouteNames.forgotpassword,
        path: '/forgotpassword',
        pageBuilder: (context, state) =>
            MaterialPage(key: state.pageKey, child: const ForgotPassword()),
      ),
      GoRoute(
        name: RouteNames.upcomingAppointment,
        path: '/upcomingAppointment',
        pageBuilder: (context, state) =>
            MaterialPage(key: state.pageKey, child: const UpcomingAppointments()),
      ),
      GoRoute(
        name: RouteNames.appointmentDetails,
        path: '/appointmentDetails',
        pageBuilder: (context, state) =>
            MaterialPage(key: state.pageKey, child: const Appointment_Confirmation(appointment: null,)),
      ),
      // GoRoute(
      //   name: RouteNames.otpMail,
      //   path: '/otpMail',
      //   pageBuilder: (context, state) =>
      //       MaterialPage(key: state.pageKey, child:  OtpEmail(email: '',)),
      // ),
    ],
    errorPageBuilder: (context, state) => CustomTransitionPage(
      key: state.pageKey,
      child: ErrorScreen(
        state.error!,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          RotationTransition(
        turns: animation,
        child: ErrorScreen(
          state.error!,
        ),
      ),
    ),
    // redirect to the login page if the user is not logged in
  );
}
