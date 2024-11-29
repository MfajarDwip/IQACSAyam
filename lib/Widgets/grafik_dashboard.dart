import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class HourlySensorData {
  final String timeRange;
  final double averageValue;

  HourlySensorData({required this.timeRange, required this.averageValue});
}

class SensorGraphPage extends StatefulWidget {
  @override
  _SensorGraphPageState createState() => _SensorGraphPageState();
}

class _SensorGraphPageState extends State<SensorGraphPage> {
  // Simulasi data dari sensor (gunakan data dari API Anda)
  List<HourlySensorData> sensorData = [];

  @override
  void initState() {
    super.initState();
    fetchSensorData(); // Mengambil data dari API atau simulasi
  }

  void fetchSensorData() {
    // Simulasi data (data dari API Anda harus diformat seperti ini)
    List<Map<String, dynamic>> rawData = [
      {"time": "00:00 - 04:00", "average": 3.5},
      {"time": "04:00 - 08:00", "average": 5.0},
      {"time": "08:00 - 12:00", "average": 4.2},
      {"time": "12:00 - 16:00", "average": 6.8},
      {"time": "16:00 - 20:00", "average": 7.1},
      {"time": "20:00 - 00:00", "average": 4.9},
    ];

    setState(() {
      sensorData = rawData
          .map((data) => HourlySensorData(
                timeRange: data["time"],
                averageValue: data["average"],
              ))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Grafik Rata-Rata Sensor'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Rata-rata Sensor per 4 Jam',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Expanded(
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 10,
                  barGroups: sensorData
                      .asMap()
                      .entries
                      .map((entry) {
                        int index = entry.key;
                        HourlySensorData data = entry.value;
                        return BarChartGroupData(
                          x: index,
                          barRods: [
                            BarChartRodData(
                              toY: data.averageValue,
                              color: Colors.blue,
                              width: 16,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ],
                        );
                      })
                      .toList(),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          int index = value.toInt();
                          if (index >= 0 && index < sensorData.length) {
                            return Text(
                              sensorData[index].timeRange,
                              style: TextStyle(fontSize: 10),
                            );
                          }
                          return Container();
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 2,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            '${value.toInt()}',
                            style: TextStyle(fontSize: 10),
                          );
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  gridData: FlGridData(
                    show: true,
                    horizontalInterval: 2,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
