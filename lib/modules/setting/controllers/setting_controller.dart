import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:cash_book_mobile/routes/app_pages.dart';
import 'package:cash_book_mobile/utils/app_color.dart';
import 'package:cash_book_mobile/utils/database_helper.dart';
import 'package:cash_book_mobile/utils/hash_password.dart';

class SettingController extends GetxController {
  //TODO: Implement SettingController

  RxBool isLoading = false.obs;
  RxBool obsecureText = true.obs;
  RxBool obsecureTextNew = true.obs;
  TextEditingController passC = TextEditingController();
  TextEditingController passNewC = TextEditingController();
  final DatabaseHelper dbHelper = DatabaseHelper.instance;

  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> changePassword() async {
    String currentPassword = passC.text;
    String newPassword = passNewC.text;
    final db = await dbHelper.database;

    // Ambil kata sandi saat ini dari database berdasarkan user ID
    final List<Map<String, dynamic>> users = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [box.read('user_id')],
    );

    if (users.isNotEmpty) {
      final storedPassword = users[0]['password'] as String;

      // Periksa apakah kata sandi saat ini cocok dengan yang disimpan di database
      if (checkPassword(currentPassword, storedPassword)) {
        // Enkripsi kata sandi baru sebelum disimpan
        final hashedPassword = HashPassword(newPassword);

        // Update the password in the database
        await db.update(
          'users',
          {'password': hashedPassword},
          where: 'id = ?',
          whereArgs: [box.read('user_id')],
        );

        passC.clear(); // Hapus text pada field kata sandi saat ini
        passNewC.clear(); // Hapus text pada field kata sandi baru

        Get.snackbar(
          'Berhasil',
          'Password berhasil diperbarui',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColor.primaryColor,
          colorText: Colors.white,
        );
      }
    } else {
      // Password saat ini tidak cocok
      Get.snackbar(
        'Error',
        'Gagal memperbarui password',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColor.secondary,
        colorText: Colors.white,
      );
    }
  }

  bool checkPassword(String inputPassword, String storedPassword) {
    // Implementasikan metode enkripsi yang sama seperti yang digunakan sebelumnya
    final hashedInputPassword = HashPassword(inputPassword);

    // Bandingkan password yang dimasukkan dengan yang disimpan di database
    return hashedInputPassword == storedPassword;
  }

  Future<void> logout() async {
    box.remove("user_id");
    box.remove("username");
    Get.offNamed(Routes.LOGIN);
  }
}
