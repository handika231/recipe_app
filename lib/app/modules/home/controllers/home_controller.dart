import 'package:get/get.dart';
import 'package:recipe_app/app/data/db/db_manager.dart';
import 'package:recipe_app/app/data/model/recipe_model.dart';
import 'package:sqflite/sqflite.dart';

class HomeController extends GetxController {
  //Membuat List kosong yang nantinya akan diisi data dari database
  RxList allRecipe = <RecipeModel>[].obs;

  //Memanggil class database nya
  DatabaseManager database = DatabaseManager.instance;

  //Membuat fungsi untuk mengambil seluruh data dari database
  Future getAllRecipe() async {
    Database db = await database.database;
    List<Map<String, dynamic>> data = await db.query('recipes');
    //Melakukan pengecekan jika datanya tidak kosong maka variabel list tadi di isi dengan data dari database
    if (data.isNotEmpty) {
      allRecipe(RecipeModel.toJsonList(data));
      allRecipe.refresh(); //Refresh disini berfungsi untuk update UI
    } else {
      allRecipe.clear();
      allRecipe.refresh();
    }
  }

//FUNGSI YANG PERTAMA KALI DIPANGGIL
  @override
  void onInit() {
    getAllRecipe();
    super.onInit();
  }
}
