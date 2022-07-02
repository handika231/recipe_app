import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_app/app/modules/home/controllers/home_controller.dart';

import '../controllers/add_recipe_controller.dart';

class AddRecipeView extends GetView<AddRecipeController> {
  AddRecipeView({Key? key}) : super(key: key);
  final HomeController homeC = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(
              Icons.check,
              size: 30,
              color: Colors.green,
            ),
            onPressed: () async {
              if (controller.formKey.currentState!.validate() &&
                  controller.fileImage.value.path.isNotEmpty) {
                controller.addRecipe();
                await homeC.getAllRecipe();
                Get.back();
              } else {
                Get.snackbar(
                  'Error',
                  'Gambar, title, dan description tidak boleh kosong',
                  colorText: Colors.white,
                  duration: const Duration(seconds: 2),
                  backgroundColor: Colors.redAccent[200],
                );
              }
            },
          ),
        ],
        foregroundColor: Colors.black,
        elevation: 2,
        title: const Text(
          'Add Recipe',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Form(
        key: controller.formKey,
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  Obx(
                    () => Center(
                      child: controller.fileImage.value.path.isEmpty
                          ? Image.asset(
                              'assets/addimage.png',
                              width: Get.width,
                              height: Get.height,
                              fit: BoxFit.contain,
                            )
                          : Image.file(
                              controller.fileImage.value,
                              fit: BoxFit.cover,
                              width: Get.width,
                              height: Get.height,
                            ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.defaultDialog(
                        title: 'Select Image',
                        middleText: '',
                        content: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () async {
                                await controller.openGallery();
                                Get.back();
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Icon(Icons.image, size: 50),
                                  Text(
                                    "Gallery",
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.black,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 32.0,
                            ),
                            InkWell(
                              onTap: () async {
                                await controller.openCamera();
                                Get.back();
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: const [
                                  Icon(Icons.camera_alt, size: 50),
                                  Text(
                                    "Camera",
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.black,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Container(
                      height: Get.height,
                      width: Get.width,
                      color: Colors.black.withOpacity(0.5),
                      child: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 7,
              child: Column(
                children: [
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    maxLines: 1,
                    validator: (value) =>
                        value!.isEmpty ? 'Title Recipe is Required' : null,
                    controller: controller.titleController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[200],
                      hintText: "Title",
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14.0,
                      ),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                        //   borderRadius: BorderRadius.all(Radius.circular(12.0)),
                      ),
                    ),
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Flexible(
                    child: TextFormField(
                      controller: controller.descriptionController,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Description",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 14.0,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.text,
                      maxLines: 50,
                      validator: (value) =>
                          value!.isEmpty ? 'Content Recipe is Required' : null,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
