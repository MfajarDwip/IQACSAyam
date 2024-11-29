class HourlyAmonia {
  final int hour;
  final double averageAmonia;

  HourlyAmonia({required this.hour, required this.averageAmonia});

  @override
  String toString() {
    return 'Hour: $hour, Average Amonia: $averageAmonia';
  }

  factory HourlyAmonia.fromJson(Map<String, dynamic> json) {
    print('Parsing HourlyAmonia from JSON: $json');
    double amonia = (json['nilai_amonia'] ?? 0.0).toDouble();
    DateTime createdAt =
        DateTime.parse(json['created_at'] ?? ''); 
    print(
        'Parsed amonia: $amonia, createdAt: $createdAt'); 
    return HourlyAmonia(
      hour: json['created_at'] != null
          ? DateTime.parse(json['created_at']).hour
          : 0,
      averageAmonia:
          json['nilai_amonia'] != null ? json['nilai_amonia'].toDouble() : 0,
    );
  }
}

class AmoniaData {
  List<HourlyAmonia> amonia;

  AmoniaData({required this.amonia});

  factory AmoniaData.fromJson(Map<String, dynamic> json) {
     print('Parsing amoniajson from JSON: $json'); // Debugging input JSON
 
      List<dynamic> amoniaList = json['amonia'] ?? [];
    print(
        'Parsed amonia list: $amoniaList'); // Debugging apakah list 'humidity' ada
    List<HourlyAmonia> amonia = amoniaList
        .map((amoniaItem) => HourlyAmonia.fromJson(amoniaItem))
        .toList();
    print(
        'Mapped HourlyAmonia objects: $amonia'); // Debugging hasil mapping

    return AmoniaData(amonia: amonia);
  }
}
