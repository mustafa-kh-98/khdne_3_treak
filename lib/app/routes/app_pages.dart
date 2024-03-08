import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../modules/auth_pages/login_page/bindings/login_page_binding.dart';
import '../modules/auth_pages/login_page/views/login_page_view.dart';
import '../modules/auth_pages/register_page/bindings/register_page_binding.dart';
import '../modules/auth_pages/register_page/views/register_page_view.dart';
import '../modules/onboarding_page/bindings/onboarding_page_binding.dart';
import '../modules/onboarding_page/views/onboarding_page_view.dart';
import '../modules/splash_page/bindings/splash_page_binding.dart';
import '../modules/splash_page/views/splash_page_view.dart';
import '../modules/vehicles_pages/add_vehicle_page/bindings/add_vehicle_page_binding.dart';
import '../modules/vehicles_pages/add_vehicle_page/views/add_vehicle_page_view.dart';
import '../modules/vehicles_pages/my_vehicles_page/bindings/my_vehicles_page_binding.dart';
import '../modules/vehicles_pages/my_vehicles_page/views/my_vehicles_page_view.dart';
import '../modules/vehicles_pages/vehicle_inof_page/bindings/vehicle_inof_page_binding.dart';
import '../modules/vehicles_pages/vehicle_inof_page/views/vehicle_inof_page_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH_PAGE;

  static final routes = [
    GetPage(
      name: _Paths.REGISTER_PAGE,
      page: () => const RegisterPageView(),
      binding: RegisterPageBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN_PAGE,
      page: () => const LoginPageView(),
      binding: LoginPageBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING_PAGE,
      page: () => const OnboardingPageView(),
      binding: OnboardingPageBinding(),
      transition: Transition.fade,
      curve: Curves.easeOut,
      transitionDuration: const Duration(seconds:2 )
    ),
    GetPage(
      name: _Paths.MY_VEHICLES_PAGE,
      page: () => const MyVehiclesPageView(),
      binding: MyVehiclesPageBinding(),
    ),
    GetPage(
      name: _Paths.VEHICLE_INOF_PAGE,
      page: () => const VehicleInofPageView(),
      binding: VehicleInofPageBinding(),
    ),
    GetPage(
      name: _Paths.ADD_VEHICLE_PAGE,
      page: () => const AddVehiclePageView(),
      binding: AddVehiclePageBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH_PAGE,
      page: () => const SplashPageView(),
      binding: SplashPageBinding(),
    ),
  ];
}
