import 'package:get/get.dart';

import '../modules/add_recipe/views/add_recipe_view.dart';
import '../modules/detail_recipe/bindings/detail_recipe_binding.dart';
import '../modules/detail_recipe/views/detail_recipe_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_RECIPE,
      page: () => const DetailRecipeView(),
      binding: DetailRecipeBinding(),
    ),
    GetPage(
      name: _Paths.ADD_RECIPE,
      page: () => AddRecipeView(),
      // binding: AddRecipeBinding(),
    ),
  ];
}

/// Di File ini berguna untuk mengatur lalu lintas routing antar page.
