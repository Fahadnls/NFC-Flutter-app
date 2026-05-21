// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';

import '../modules/home/views/home_view.dart';
import '../modules/preferences/views/preferences_view.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/shell/views/main_shell_view.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/trip_history/views/trip_history_view.dart';
import '../modules/trip_planner/views/final_trip_plan_view.dart';
import '../modules/trip_planner/views/stop_suggestions_view.dart';
import '../modules/trip_planner/views/trip_input_view.dart';
import '../modules/trip_planner/views/trip_permission_view.dart';
import '../modules/trip_planner/views/trip_preview_view.dart';
import '../modules/welcome/views/welcome_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = <GetPage<dynamic>>[
    GetPage(name: Routes.SPLASH, page: () => const SplashView()),
    GetPage(name: Routes.WELCOME, page: () => const WelcomeView()),
    GetPage(name: Routes.PERMISSION, page: () => const TripPermissionView()),
    GetPage(name: Routes.PREFERENCES, page: () => const PreferencesView()),
    GetPage(name: Routes.SHELL, page: () => const MainShellView()),
    GetPage(name: Routes.HOME, page: () => const HomeView()),
    GetPage(name: Routes.TRIPS, page: () => const TripHistoryView()),
    GetPage(name: Routes.PROFILE, page: () => const ProfileView()),
    GetPage(name: Routes.TRIP_INPUT, page: () => const TripInputView()),
    GetPage(name: Routes.TRIP_PREVIEW, page: () => const TripPreviewView()),
    GetPage(
      name: Routes.STOP_SUGGESTIONS,
      page: () => const StopSuggestionsView(),
    ),
    GetPage(
      name: Routes.FINAL_TRIP_PLAN,
      page: () => const FinalTripPlanView(),
    ),
  ];
}
