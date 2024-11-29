import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mobile_gmf/Models/average_temp.dart';

// Temperature Graph widget
class TemperatureGraph extends StatelessWidget {
  final List<HourlyTemperature> averageTemperatureData;

  TemperatureGraph({required this.averageTemperatureData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text('Hourly Average Temperature',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              SizedBox(
                height: 200,
                child: BarChart(
                  BarChartData(
                    gridData: FlGridData(show: false),
                    borderData: FlBorderData(show: false),
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: true),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: true),
                      ),
                    ),
                    barGroups: averageTemperatureData.map((data) {
                      return BarChartGroupData(
                        x: data.hour,
                        barRods: [
                          BarChartRodData(
                            toY: data.averageTemperature,
                            color: data.averageTemperature > 30
                                ? Colors.red
                                : Colors.blue,
                            width: 16,
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
