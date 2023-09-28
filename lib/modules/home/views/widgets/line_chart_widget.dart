import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cash_book_mobile/modules/home/controllers/home_controller.dart';
import 'package:cash_book_mobile/utils/app_color.dart';

class LineChartWidget extends GetView<HomeController> {
  const LineChartWidget({required this.isShowingMainData});

  final bool isShowingMainData;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (controller.expenseSpots.isNotEmpty ||
            controller.incomeSpots.isNotEmpty) {
          return LineChart(
            sampleData1,
            duration: const Duration(milliseconds: 250),
          );
        } else {
          // Tampilkan indikator loading atau pesan lain jika data belum siap
          return Center(
            child: Text(
              'Data Masih Kosong, belum bisa tracking',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          );
        }
      },
    );
  }

  LineChartData get sampleData1 => LineChartData(
        lineTouchData: lineTouchData1,
        gridData: gridData,
        titlesData: titlesData1,
        borderData: borderData,
        lineBarsData: lineBarsData1,
      );

  LineTouchData get lineTouchData1 => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
        ),
      );

  FlTitlesData get titlesData1 => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );

  List<LineChartBarData> get lineBarsData1 => [
        lineChartBarData1_1,
        lineChartBarData1_2,
      ];

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
      color: Colors.white,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'Rp 0';
        break;
      case 500000:
        text = 'Rp 500.000';
        break;
      case 1000000:
        text = 'Rp 1.000.000';
        break;
      case 1500000:
        text = 'Rp 1.500.000';
        break;
      case 2000000:
        text = 'Rp 2.000.000';
        break;
      default:
        return Container();
    }

    return Text(
      text,
      style: style,
      textAlign: TextAlign.center,
    );
  }

  SideTitles leftTitles() => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: true,
        interval: 500000,
        reservedSize: 100,
      );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
      color: Colors.white,
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: Text(
        value.toInt().toString(),
        style: style,
      ),
    );
  }

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 32,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );

  FlGridData get gridData => const FlGridData(show: true);

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: Border(
          bottom: BorderSide(
              color: AppColor.primaryColor.withOpacity(0.2), width: 4),
          left: const BorderSide(color: Colors.transparent),
          right: const BorderSide(color: Colors.transparent),
          top: const BorderSide(color: Colors.transparent),
        ),
      );

  LineChartBarData get lineChartBarData1_1 => LineChartBarData(
        isCurved: true,
        color: AppColor.contentColorPink,
        barWidth: 8,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(show: false),
        spots: controller.expenseSpots,
      );

  LineChartBarData get lineChartBarData1_2 => LineChartBarData(
        isCurved: true,
        color: AppColor.contentColorGreen,
        barWidth: 8,
        isStrokeCapRound: true,
        dotData: const FlDotData(show: false),
        belowBarData: BarAreaData(
          show: false,
          color: AppColor.contentColorPink.withOpacity(0),
        ),
        spots: controller.incomeSpots,
      );
}
