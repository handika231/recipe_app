import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_app/app/data/db/db_manager.dart';
import 'package:recipe_app/app/modules/home/controllers/home_controller.dart';
import 'package:sqflite/sqflite.dart';

import '../../../data/model/recipe_model.dart';

class DetailRecipeController extends GetxController {
  DatabaseManager database = DatabaseManager.instance;
  HomeController homeController = HomeController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final fileImage = File('').obs;
  final recipeModel = RecipeModel().obs;

  //create function delete
  Future deleteRecipe(int id) async {
    Database db = await database.database;
    await db.delete('recipes', where: 'id = ?', whereArgs: [id]);
    await homeController.getAllRecipe();
  }

  // Fungsi menambahkan image yang mengambil dari Gallery
  Future openGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    fileImage.value = File(image.path);
  }

// Fungsi menambahkan image yang mengambil dari Camera
  Future openCamera() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image == null) return;
    fileImage.value = File(image.path);
  }

  //create function edit
  Future editRecipe(int id) async {
    Database db = await database.database;
    await db.update(
        'recipes',
        {
          'title': titleController.text,
          'content': descriptionController.text,
          'image': fileImage.value.path,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
        where: 'id = ?',
        whereArgs: [id]);

    await homeController.getAllRecipe();
  }

  @override
  void onInit() {
    super.onInit();
    //Melakukan pengecekan jika argumennya tidak null maka data model diisi dengan data yang dikirimkan dari argumen
    if (Get.arguments != null) {
      recipeModel.value = Get.arguments as RecipeModel;
    }
    homeController.getAllRecipe();
  }
}
