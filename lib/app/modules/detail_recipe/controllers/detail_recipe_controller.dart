import 'package:get/get.dart';
import 'package:recipe_app/app/data/db/db_manager.dart';
import 'package:recipe_app/app/modules/home/controllers/home_controller.dart';
import 'package:sqflite/sqflite.dart';

import '../../../data/model/recipe_model.dart';

class DetailRecipeController extends GetxController {
  DatabaseManager database = DatabaseManager.instance;
  HomeController homeController = HomeController();
  final recipeModel = RecipeModel().obs;
  //create function delete
  Future deleteRecipe(int id) async {
    Database db = await database.database;
    await db.delete('recipes', where: 'id = ?', whereArgs: [id]);
    await homeController.getAllRecipe();
  }

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      recipeModel.value = Get.arguments as RecipeModel;
    }
    homeController.getAllRecipe();
  }
}
