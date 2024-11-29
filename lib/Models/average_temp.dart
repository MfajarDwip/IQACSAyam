class HourlyTemperature {
  final int hour;
  final double averageTemperature;

  HourlyTemperature({required this.hour, required this.averageTemperature});

  @override
  String toString() {
    return 'Hour: $hour, Average Temperature: $averageTemperature';
  }

  // Konstruktor untuk mengonversi data JSON ke objek HourlyTemperature
  factory HourlyTemperature.fromJson(Map<String, dynamic> json) {
    print('Parsing Hourlytemperature from JSON: $json');
    double temperature = (json['nilai_temperature'] ?? 0.0).toDouble();
    DateTime createdAt =
        DateTime.parse(json['created_at'] ?? ''); // Debugging input JSON
    print(
        'Parsed temperature: $temperature, createdAt: $createdAt'); // Debugging hasil parse
    return HourlyTemperature(
      hour: json['created_at'] != null
          ? int.parse(json['created_at'].substring(11, 13))
          : 0, // Mendapatkan jam dari timestamp
      averageTemperature: (json['nilai_temperature'] ?? 0.0)
          .toDouble(), // Pastikan data kelembaban sesuai
    );
  }
}

class TemperatureData {
  final List<HourlyTemperature> temperatures;

  TemperatureData({required this.temperatures});

  factory TemperatureData.fromJson(Map<String, dynamic> json) {
    print('Parsing HumidityData from JSON: $json'); // Debugging input JSON

    List<dynamic> temperatureList = json['Temperature'] ?? [];
    print(
        'Parsed temperature list: $temperatureList'); // Debugging apakah list 'humidity' ada
    List<HourlyTemperature> temperature = temperatureList
        .map((temp) => HourlyTemperature.fromJson(temp))
        .toList();
    print(
        'Mapped Hourlytemperature objects: $temperature'); // Debugging hasil mapping
    return TemperatureData(temperatures: temperature);
  }
}
