import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_gmf/Models/average_diok.dart';

class ApiServiceDiok {
  Future<DioksidaData> fetchDailyDioksidaSummary(String location) async {
    final url =
          'https://iqacs-chick.research-ai.my.id/api/gas/$location'; // replace with your actual URL

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);


        // Assuming data is parsed into TemperatureData object
        return DioksidaData.fromJson(data);
      } else {
        throw Exception('Failed to load dioksida data');
      }
    } catch (e) {
      print('Error fetching dioksida data: $e');
      rethrow;
    }
  }
}
