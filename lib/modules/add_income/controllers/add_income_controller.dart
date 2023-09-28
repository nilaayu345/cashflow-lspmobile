import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:cash_book_mobile/modules/home/controllers/home_controller.dart';
import 'package:cash_book_mobile/routes/app_pages.dart';
import 'package:cash_book_mobile/utils/app_color.dart';
import 'package:cash_book_mobile/utils/database_helper.dart';

class AddIncomeController extends GetxController {
  //TODO: Implement AddIncomeController
  RxBool isLoading = false.obs;
  TextEditingController dateC = TextEditingController();
  TextEditingController nominalC = TextEditingController();
  TextEditingController descriptionC = TextEditingController();

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

  Future<void> resetForm() async {
    dateC.text = "01-01-2021";
    nominalC.clear();
    descriptionC.clear();
  }

  Future<void> addIncome() async {
    final date = dateC.text;
    final nominalWithRp = nominalC.text;
    final numericText = nominalWithRp.replaceAll("Rp ", "").replaceAll(".", "");
    final nominal = int.tryParse(numericText);
    final description = descriptionC.text;
    final status = "income"; // Status income

    final cashflow = {
      'user_id': box.read('user_id'),
      'date': date,
      'nominal': nominal,
      'description': description,
      'status': status, // Konversi ke integer
    };

    final id = await dbHelper.insertCashflow(cashflow);

    if (id != null) {
      final HomeController homeController = Get.put(HomeController());
      homeController.reInitialize();
      Get.offNamed(Routes.HOME);
      Get.snackbar(
        'Berhasil',
        'Data pemasukan berhasil disimpan',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColor.primaryColor,
        colorText: Colors.white,
      );
    } else {
      // Handle jika gagal menyimpan data
      Get.snackbar(
        'Error',
        'Gagal menyimpan data pemasukan',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColor.secondary,
        colorText: Colors.white,
      );
    }
  }
}
