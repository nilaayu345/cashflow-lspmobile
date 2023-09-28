import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:cash_book_mobile/modules/home/views/widgets/line_chart_widget.dart';
import 'package:cash_book_mobile/modules/home/views/widgets/menu_widget.dart';
import 'package:cash_book_mobile/routes/app_pages.dart';
import 'package:cash_book_mobile/utils/app_color.dart';
import 'package:cash_book_mobile/utils/currency_format.dart';

import '../controllers/home_controller.dart';

// ignore: must_be_immutable
class HomeView extends GetView<HomeController> {
  late double mWidth;
  late double mHeight;
  @override
  Widget build(BuildContext context) {
    mWidth = MediaQuery.of(context).size.width;
    mHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      height: mHeight,
      margin: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              Container(
                  height: 170, // Tinggi Container

                  child: Obx(
                    () {
                      int totalIncome = 0;
                      int totalExpense = 0;

                      // Loop melalui data pemasukan dan pengeluaran dalam controller
                      for (final cashflow in controller.cashflows) {
                        if (cashflow.status == "income") {
                          totalIncome += cashflow.nominal;
                        } else if (cashflow.status == "expense") {
                          totalExpense += cashflow.nominal;
                        }
                      }

                      return Column(
                        children: [
                          Container(
                            width: mWidth,
                            padding: const EdgeInsets.all(20),
                            child: Center(
                              child: Text(
                                'Rangkuman Bulan Ini',
                                style: TextStyle(
                                  color: AppColor.primaryColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: mWidth,
                            padding: const EdgeInsets.all(20),
                            margin: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppColor.dark,
                              borderRadius: BorderRadius.circular(
                                  12.0), // Atur radius sudut
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey
                                      .withOpacity(0.5), // Warna shadow
                                  spreadRadius: -5, // Penyebaran shadow
                                  blurRadius: 7, // Blur radius shadow
                                  offset: const Offset(
                                      0, 3), // Offset dari shadow (X, Y)
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  'Pengeluaran ${FormattedNominal(totalExpense)}',
                                  style: TextStyle(
                                    color: AppColor.contentColorPink,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "Pemasukan ${FormattedNominal(totalIncome)}",
                                  style: TextStyle(
                                    color: AppColor.contentColorGreen,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      );
                    },
                  )),
            ],
          ),
          const SizedBox(
            height: 40,
          ),
          Container(
            padding: const EdgeInsets.all(20),
            height: 200,
            decoration: BoxDecoration(
              color: AppColor.primaryColor,
              borderRadius: BorderRadius.circular(12.0), // Atur radius sudut
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5), // Warna shadow
                  spreadRadius: -5, // Penyebaran shadow
                  blurRadius: 7, // Blur radius shadow
                  offset: const Offset(0, 3), // Offset dari shadow (X, Y)
                ),
              ],
            ),
            child: const LineChartWidget(
              isShowingMainData: true,
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2, // Jumlah kolom dalam satu baris
              children: [
                InkWell(
                  onTap: () => {Get.toNamed(Routes.ADD_INCOME)},
                  child: const MenuItem(
                    title: 'Tambah Pemasukan',
                    image: AssetImage(
                        'assets/images/icon_income.png'), // Ganti dengan path gambar yang sesuai
                  ),
                ),
                InkWell(
                  onTap: () => {Get.toNamed(Routes.ADD_EXPENSE)},
                  child: const MenuItem(
                    title: 'Tambah Pengeluaran',
                    image: AssetImage(
                        'assets/images/icon_expense.png'), // Ganti dengan path gambar yang sesuai
                  ),
                ),
                InkWell(
                  onTap: () => {Get.toNamed(Routes.DETAIL_CASH_FLOW)},
                  child: const MenuItem(
                    title: 'Detail Cash Flow',
                    image: AssetImage(
                        'assets/images/icon_cash_flow.png'), // Ganti dengan path gambar yang sesuai
                  ),
                ),
                InkWell(
                  onTap: () => {Get.toNamed(Routes.SETTING)},
                  child: const MenuItem(
                    title: 'Pengaturan',
                    image: AssetImage(
                        'assets/images/icon_setting.png'), // Ganti dengan path gambar yang sesuai
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
