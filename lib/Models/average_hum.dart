class HourlyHumidity {
  final int hour;
  final double averageHumidity;

  HourlyHumidity({required this.hour, required this.averageHumidity});

  @override
  String toString() {
    return 'Hour: $hour, Average Humidity: $averageHumidity';
  }

  factory HourlyHumidity.fromJson(Map<String, dynamic> json) {
    print('Parsing HourlyHumidity from JSON: $json');
    double humidity = (json['nilai_humidity'] ?? 0.0).toDouble();
    DateTime createdAt =
        DateTime.parse(json['created_at'] ?? ''); 
    print(
        'Parsed humidity: $humidity, createdAt: $createdAt'); 
    return HourlyHumidity(
      hour: json['created_at'] != null
          ? int.parse(json['created_at'].substring(11, 13))
          : 0, // Mendapatkan jam dari timestamp
      averageHumidity: (json['nilai_humidity'] ?? 0.0)
          .toDouble(), // Pastikan data kelembaban sesuai
    );
  }
}

// Model class untuk menyimpan data kelembaban keseluruhan
class HumidityData {
  final List<HourlyHumidity> humidity;

  HumidityData({required this.humidity});

  factory HumidityData.fromJson(Map<String, dynamic> json) {
    print('Parsing HumidityData from JSON: $json'); // Debugging input JSON

    List<dynamic> humidityList = json['humidity'] ?? [];
    print(
        'Parsed humidity list: $humidityList'); // Debugging apakah list 'humidity' ada

    List<HourlyHumidity> humidity = humidityList
        .map((humidityItem) => HourlyHumidity.fromJson(humidityItem))
        .toList();
    print(
        'Mapped HourlyHumidity objects: $humidity'); // Debugging hasil mapping

    return HumidityData(humidity: humidity);
  }
}
