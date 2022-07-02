import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_app/app/routes/app_pages.dart';

import '../controllers/detail_recipe_controller.dart';

class DetailRecipeView extends GetView<DetailRecipeController> {
  const DetailRecipeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          //create popupmenu
          PopupMenuButton(
            onSelected: (value) {
              if (value == 'edit') {
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
        title: const Text('DetailRecipeView'),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            image: DecorationImage(
              image: FileImage(
                File(
                  controller.recipeModel.value.image!,
                ),
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
