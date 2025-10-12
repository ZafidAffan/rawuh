import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ReportHistoryPage extends StatefulWidget {
  final int userId;

  ReportHistoryPage({required this.userId});

  @override
  _ReportHistoryPageState createState() => _ReportHistoryPageState();
}

class _ReportHistoryPageState extends State<ReportHistoryPage> {
  List<dynamic> _reports = [];

  final Color primaryColor = const Color(0xFF347433); // Hijau dominan
  final Color accentColor = const Color(0xFFF5F0CD);  // Kuning muda
  final Color warningColor = const Color(0xFF3674B5); // Biru notifikasi

  @override
  void initState() {
    super.initState();
    fetchReports();
  }

  Future<void> fetchReports() async {
    final url = Uri.parse(
        "https://pelaporan-sampah-js.vercel.app/user-report?user_id=${widget.userId}");
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        setState(() {
          _reports = jsonDecode(response.body);
        });
      } else {
        print("Gagal mengambil data: ${response.statusCode}");
      }
    } catch (e) {
      print("Error mengambil data laporan: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Riwayat Laporan'),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
      body: _reports.isEmpty
          ? Center(child: Text("Belum ada laporan"))
          : ListView.builder(
              itemCount: _reports.length,
              itemBuilder: (context, index) {
                final report = _reports[index];
                final imgUrl = report['image_path'];
                final fullImageUrl =
                    'http://172.20.10.2:8000/serve_image.php?file=$imgUrl';

                debugPrint("URL gambar: $fullImageUrl");

                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  color: accentColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: (imgUrl != null && imgUrl.toString().isNotEmpty)
                              ? Image.network(
                                  fullImageUrl,
                                  width: 80,
                                  height: 80,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      width: 80,
                                      height: 80,
                                      color: Colors.grey[300],
                                      child: Icon(Icons.broken_image,
                                          color: Colors.grey[600]),
                                    );
                                  },
                                )
                              : Container(
                                  width: 80,
                                  height: 80,
                                  color: Colors.grey[300],
                                  child: Icon(Icons.image_not_supported,
                                      color: Colors.grey[600]),
                                ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                report['description'] ??
                                    'Deskripsi tidak tersedia',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: primaryColor,
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                "Alamat: ${report['address'] ?? '-'}",
                                style: TextStyle(fontSize: 14),
                              ),
                              Text(
                                "Status: ${report['status'] ?? '-'}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: warningColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "Tanggal: ${report['created_at'] ?? '-'}",
                                style: TextStyle(fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
