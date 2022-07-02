import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_app/app/routes/app_pages.dart';

import '../controllers/detail_recipe_controller.dart';

class DetailRecipeView extends GetView<DetailRecipeController> {
  const DetailRecipeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    controller.titleController.text = controller.recipeModel.value.title!;
    controller.descriptionController.text =
        controller.recipeModel.value.content!;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: [
          //create popupmenu
          PopupMenuButton(
            onSelected: (value) async {
              if (value == 'edit') {
                await controller.editRecipe(controller.recipeModel.value.id!);
                Get.offNamed(Routes.HOME);
              } else if (value == 'delete') {
                controller.deleteRecipe(controller.recipeModel.value.id!);

                Get.offNamed(Routes.HOME);
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem(
                value: 'edit',
                child: Text('Edit'),
              ),
              const PopupMenuItem(
                value: 'delete',
                child: Text('Delete'),
              ),
            ],
            icon: const Icon(Icons.more_vert),
          ),
        ],
        elevation: 2,
        title: const Text('Detail Recipe'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Column(
        children: [
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
            child: Obx(() => Container(
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(
                        controller.fileImage.value.path.isEmpty
                            ? File(
                                controller.recipeModel.value.image!,
                              )
                            : File(controller.fileImage.value.path),
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                )),
          ),
          Expanded(
            child: Column(
              children: [
                TextFormField(
                  onChanged: (val) {
                    controller.recipeModel.value.title = val;
                  },
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
                    onChanged: (val) {
                      controller.recipeModel.value.content = val;
                    },
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
    );
  }
}
