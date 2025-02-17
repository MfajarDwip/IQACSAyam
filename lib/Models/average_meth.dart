// Model class to represent a single temperature record
class HourlyMethane {
  final int hour;
  final double averageMethane;

  HourlyMethane({required this.hour, required this.averageMethane});

  factory HourlyMethane.fromJson(Map<String, dynamic> json) {
    return HourlyMethane(
      hour: json['hour'],
      averageMethane: (json['average_methane'] ?? 0.0).toDouble(),
    );
  }
}

// Model class to represent a list of temperature records
class MethaneData {
  final List<HourlyMethane> methane;

  MethaneData({required this.methane});

  // Factory method to create an instance from JSON
  factory MethaneData.fromJson(Map<String, dynamic> json) {
    List<dynamic> methanaList = json['methane'] ?? [];
    List<HourlyMethane> meth =
        methanaList.map((temp) => HourlyMethane.fromJson(temp)).toList();
    return MethaneData(methane: meth);
  }
}
