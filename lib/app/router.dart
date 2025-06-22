import 'package:get/get.dart';

import '../views/home_view.dart';
import '../views/cart_view.dart';
import '../views/checkout_view.dart';
import '../utils/constants.dart';

class AppRouter {
  static final routes = [
    GetPage(
      name: AppConstants.homeRoute,
      page: () => const HomeView(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppConstants.cartRoute,
      page: () => const CartView(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppConstants.checkoutRoute,
      page: () => const CheckoutView(),
      transition: Transition.rightToLeft,
    ),
  ];
}
