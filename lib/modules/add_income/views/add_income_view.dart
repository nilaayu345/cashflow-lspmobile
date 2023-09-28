import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:cash_book_mobile/utils/app_color.dart';
import 'package:cash_book_mobile/widgets/custom_input.dart';

import '../controllers/add_income_controller.dart';

// ignore: must_be_immutable
class AddIncomeView extends GetView<AddIncomeController> {
  late double mWidth;
  late double mHeight;
  @override
  Widget build(BuildContext context) {
    mWidth = MediaQuery.of(context).size.width;
    mHeight = MediaQuery.of(context).size.height / 1.2;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColor.primaryColor,
          title: const Text('Tambah Pemasukan'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            height: mHeight,
            margin: const EdgeInsets.all(20),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomInput(
                      controller: controller.dateC,
                      label: "Tanggal",
                      hint: "Pilih tanggal",
                      suffixIcon: const Icon(
                        Icons.date_range,
                        color: Colors.grey,
                      ),
                      isDate: true,
                    ),
                    CustomInput(
                      controller: controller.nominalC,
                      label: "Nominal",
                      hint: "Masukkan nominal",
                      suffixIcon: const Icon(
                        Icons.money,
                        color: Colors.grey,
                      ),
                      isNumber: true,
                      isNominal: true,
                    ),
                    CustomInput(
                      controller: controller.descriptionC,
                      label: "Keterangan",
                      hint: "Masukkan keterangan",
                    ),
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (controller.isLoading.isFalse) {
                        await controller.resetForm();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      elevation: 0,
                      primary: AppColor.warning,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Reset',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Obx(
                  () => Container(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (controller.isLoading.isFalse) {
                          await controller.addIncome();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        elevation: 0,
                        primary: AppColor.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        (controller.isLoading.isFalse)
                            ? 'Simpan'
                            : 'Loading...',
                        style: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () async {
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      elevation: 0,
                      primary: AppColor.dark,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Kembali',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
