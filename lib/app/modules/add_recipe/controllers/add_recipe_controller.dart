import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

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
}
