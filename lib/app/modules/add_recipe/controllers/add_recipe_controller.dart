import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_app/app/data/db/db_manager.dart';
import 'package:sqflite/sqflite.dart';

class AddRecipeController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var fileImage = File('').obs;

  var titleController = TextEditingController();
  var descriptionController = TextEditingController();

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

  DatabaseManager database = DatabaseManager.instance;
  void addRecipe() async {
    Database db = await database.database;
    await db.insert('recipes', {
      'id': Random().nextInt(1000),
      'title': titleController.text,
      'content': descriptionController.text,
      'image': fileImage.value.path,
    });
  }

  @override
  void onClose() {
    titleController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
}
