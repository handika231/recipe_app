import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_recipe_controller.dart';

class DetailRecipeView extends GetView<DetailRecipeController> {
  const DetailRecipeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DetailRecipeView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'DetailRecipeView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
