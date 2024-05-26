import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:inventory/controller/inventory_controller.dart';

class Dashboard extends StatelessWidget {
  final ItemController itemController = Get.put(ItemController());

  Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Obx(() {
                return PieChart(
                  PieChartData(
                    sections: [
                      PieChartSectionData(
                        color: Colors.blue,
                        value: itemController.totalQuantity.toDouble(),
                        title: 'Total Quantity',
                        radius: 50,
                      ),
                      PieChartSectionData(
                        color: Colors.green,
                        value: itemController.totalWorth,
                        title: 'Total Worth',
                        radius: 50,
                      ),
                      PieChartSectionData(
                        color: Colors.red,
                        value: itemController.totalSell.toDouble(),
                        title: 'Total Sell',
                        radius: 50,
                      ),
                    ],
                  ),
                );
              }),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Obx(() {
                return BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: itemController.totalQuantity.toDouble(),
                    barTouchData: BarTouchData(enabled: false),
                    titlesData: FlTitlesData(
                      show: true,
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (double value, TitleMeta meta) {
                            const style = TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            );
                            Widget text;
                            switch (value.toInt()) {
                              case 0:
                                text = const Text('Total Quantity', style: style);
                                break;
                              case 1:
                                text = const Text('Total Worth', style: style);
                                break;
                              case 2:
                                text = const Text('Total Sell', style: style);
                                break;
                              default:
                                text = const Text('');
                                break;
                            }
                            return SideTitleWidget(
                              axisSide: meta.axisSide,
                              child: text,
                            );
                          },
                          reservedSize: 35,
                        ),
                      ),
                      leftTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                    ),
                    barGroups: [
                      BarChartGroupData(
                        x: 0,
                        barRods: [
                          BarChartRodData(
                            toY: itemController.totalQuantity.toDouble(),
                            color: Colors.blue,
                          ),
                        ],
                      ),
                      BarChartGroupData(
                        x: 1,
                        barRods: [
                          BarChartRodData(
                            toY: itemController.totalWorth,
                            color: Colors.green,
                          ),
                        ],
                      ),
                      BarChartGroupData(
                        x: 2,
                        barRods: [
                          BarChartRodData(
                            toY: itemController.totalSell.toDouble(),
                            color: Colors.red,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
