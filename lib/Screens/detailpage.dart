import 'package:flutter/material.dart';
import 'package:mobile_gmf/Theme.dart';

class StatusKualitasUdaraPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBackgroundColor,
      appBar: AppBar(
        title: Text("Informasi Status"),
        backgroundColor: Color(0xFFEF9C66),
      ),
      
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Informasi kualitas udara pertama
            _buildStatusCard(
              context,
              "0.0 - 0.33",
              "Normal",
              Colors.white,
              "Kualitas udara berada dalam kondisi yang baik. Tingkat polusi udara sangat rendah dan tidak ada zat sangat berbahaya seperti partikel berbahaya yang terdeteksi. Risiko terhadap kesehatan sangat minim, baik untuk mahluk hidup.",
              Colors.green,
            ),
            // Informasi kualitas udara kedua
            _buildStatusCard(
              context,
              "0.34 - 0.66",
              "Cukup",
              Colors.white,
              "Kualitas udara berada pada tingkat sedang. Terdapat peningkatan jumlah partikulat polusi di udara, namun masih dalam batas toleransi untuk lingkungan sekitar. Dianjurkan untuk membatasi aktivitas fisik yang berat di luar ruangan.",
           Colors.orange,
            ),
            // Informasi kualitas udara ketiga
            _buildStatusCard(
              context,
              "0.67 - 1",
              "Bahaya",
              Colors.white,
              "Kualitas udara buruk dan berbahaya. Tingkat polusi udara sangat tinggi, mengandung partikulat dan zat berbahaya yang dapat menyebabkan masalah kesehatan serius. Paparan terhadap kondisi ini dapat menyebabkan efek kesehatan yang serius.",
             Colors.red,
            ),
          ],
        ),
      ),
    );
  }

  // Widget untuk setiap card status kualitas udara
  Widget _buildStatusCard(
      BuildContext context, String range, String status, Color color, String info, Color textColor) {
    return Card(
      color: color.withOpacity(1),
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ExpansionTile(
        title: Text(
          '$range - $status',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: textColor),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              info,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
