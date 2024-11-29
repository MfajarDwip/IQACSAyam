// Model class to represent a single temperature record
class HourlyDioksida {
  final int hour;
  final double averageDioksida;

  HourlyDioksida({required this.hour, required this.averageDioksida});

  factory HourlyDioksida.fromJson(Map<String, dynamic> json) {
    return HourlyDioksida(
      hour: json['hour'],
      averageDioksida: (json['average_dioksida'] ?? 0.0).toDouble(),
    );
  }
}

// Model class to represent a list of temperature records
class DioksidaData {
  final List<HourlyDioksida> dioksida;

  DioksidaData({required this.dioksida});

  // Factory method to create an instance from JSON
  factory DioksidaData.fromJson(Map<String, dynamic> json) {
    List<dynamic> dioksidaList = json['dioksida'] ?? [];
     List<HourlyDioksida> diok =
        dioksidaList.map((temp) => HourlyDioksida.fromJson(temp)).toList();
    return DioksidaData(dioksida: diok);
  }
}
