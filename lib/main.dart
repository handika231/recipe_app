import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Recipe App",
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}

///class Main adalah entry point dari aplikasi., sehingga berfungsi untuk menjalankan aplikasi.
///class MyApp adalah class yang dijadikan sebagai dasar dari aplikasi
///title digunakan sebagai nama aplikasi saat aplikasi sedang di pause
///initialRoute digunakan untuk menentukan route yang akan dijalankan saat aplikasi dijalankan.
///getPages digunakan untuk menentukan route yang akan dijalankan saat aplikasi dijalankan. dan berguna untuk menampung keseluruhan routes