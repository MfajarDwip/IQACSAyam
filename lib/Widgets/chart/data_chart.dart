import 'dart:async'; // Perlu untuk Timer
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class AirQualityChart extends StatefulWidget {
  final List<double> averageTemperatures;
  final List<double> averageHumidity;
  final List<double> averageAmonia;

  AirQualityChart({
    required this.averageTemperatures,
    required this.averageHumidity,
    required this.averageAmonia,
    Key? key,
  }) : super(key: key);

  @override
  AirQualityChartState createState() => AirQualityChartState();
}

class AirQualityChartState extends State<AirQualityChart> {
  late Timer _timer; // Timer untuk memperbarui waktu
  List<String> _hourLabels = []; // Label waktu per jam

  @override
  void initState() {
    super.initState();
    _updateHourLabels(); // Inisialisasi label waktu
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _updateHourLabels(); // Perbarui label setiap detik
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Hentikan timer saat widget dihancurkan
    super.dispose();
  }

  // Fungsi untuk memperbarui label waktu
  void _updateHourLabels() {
    setState(() {
      _hourLabels = _generateHourLabels();
    });
  }

  // Generate label waktu 7 jam terakhir
  List<String> _generateHourLabels() {
    List<String> labels = [];
    DateTime now = DateTime.now();
    for (int i = 7; i >= 0; i--) {
      DateTime hour = now.subtract(Duration(hours: i)); // Hitung waktu mundur
      labels.add("${hour.hour.toString().padLeft(2, '0')}:00"); // Format label
    }
    return labels;
  }

  double _calculateAverage(List<double> data) {
    if (data.isEmpty) return 0.0;
    return data.reduce((a, b) => a + b) / data.length;
  }

  String _roundValue(double value) {
    if (value == value.toInt()) {
      return value.toInt().toString();
    } else {
      return value.toStringAsFixed(1);
    }
  }

  @override
  Widget build(BuildContext context) {
    double avgTemperature = _calculateAverage(widget.averageTemperatures);
    double avgHumidity = _calculateAverage(widget.averageHumidity);
    double avgAmonia = _calculateAverage(widget.averageAmonia);

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Rata-rata 7 Jam Terakhir',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildAverageStat("Suhu", avgTemperature, Colors.red),
                  _buildAverageStat("Kelembapan", avgHumidity, Colors.orange.shade600),
                  _buildAverageStat("Amonia", avgAmonia, Colors.orange.shade300),
                ],
              ),
              SizedBox(height: 20),
              SizedBox(
                height: 150,
                child: BarChart(
                  BarChartData(
                    barGroups: List.generate(
                      widget.averageTemperatures.length,
                      (index) => makeGroupData(
                        index,
                        widget.averageTemperatures[index],
                        widget.averageHumidity[index],
                        widget.averageAmonia[index],
                      ),
                    ),
                    borderData: FlBorderData(show: false),
                    titlesData: FlTitlesData(
                      show: true,
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            int index = value.toInt();
                            if (index >= 0 && index < _hourLabels.length) {
                              return Text(
                                _hourLabels[index],
                                style: TextStyle(fontSize: 10),
                              );
                            } else {
                              return Text('');
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildLegend(Colors.red, "Suhu"),
                  _buildLegend(Colors.orange.shade300, "Kelembapan"),
                  _buildLegend(Colors.orange.shade600, "Amonia"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(
      int x, double temperature, double humidity, double amonia) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: temperature,
          color: Colors.red,
          width: 20,
          borderRadius: BorderRadius.circular(6),
        ),
        BarChartRodData(
          toY: humidity,
          color: Colors.orange.shade600,
          width: 20,
          borderRadius: BorderRadius.circular(6),
        ),
        BarChartRodData(
          toY: amonia,
          color: Colors.orange.shade300,
          width: 20,
          borderRadius: BorderRadius.circular(6),
        ),
      ],
    );
  }

  Widget _buildAverageStat(String label, double value, Color color) {
    return Column(
      children: [
        Text(
          _roundValue(value),
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: color),
        ),
        Text(
          label,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
        ),
      ],
    );
  }

  Widget _buildLegend(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}
