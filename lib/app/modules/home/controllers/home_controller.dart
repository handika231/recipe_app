import 'package:get/get.dart';
import 'package:recipe_app/app/data/db/db_manager.dart';
import 'package:recipe_app/app/data/model/recipe_model.dart';
import 'package:sqflite/sqflite.dart';

class HomeController extends GetxController {
  RxList allRecipe = <RecipeModel>[].obs;
  DatabaseManager database = DatabaseManager.instance;
  Future getAllRecipe() async {
    Database db = await database.database;
    List<Map<String, dynamic>> data = await db.query('recipes');
    if (data.isNotEmpty) {
      allRecipe(RecipeModel.toJsonList(data));
      allRecipe.refresh();
    } else {
      allRecipe.clear();
      allRecipe.refresh();
    }
  }

  @override
  void onInit() {
    getAllRecipe();
    super.onInit();
  }
}
