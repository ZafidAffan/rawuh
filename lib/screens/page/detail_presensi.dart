import 'package:flutter/material.dart';

class DetailPresensiPage extends StatelessWidget {
  const DetailPresensiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Detail Presensi",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header info matkul
            const Text(
              "Komputasi Mobile",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              "Hari : Senin\nBobot : 3 sks\nKelas : A\nJadwal : 09.40 - 12.10 WIB",
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 20),

            // Progress Kehadiran
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Minimal memiliki 75% kehadiran dalam 14x pertemuan",
                    style: TextStyle(fontSize: 13, color: Colors.black87),
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: 0.64,
                      minHeight: 10,
                      backgroundColor: Colors.grey.shade300,
                      color: const Color(0xFF2F7DBA),
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "64%",
                    style: TextStyle(fontSize: 13, color: Colors.black54),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      _StatusBox(title: "Hadir", count: "6"),
                      _StatusBox(title: "Ijin", count: "1"),
                      _StatusBox(title: "Sakit", count: "0"),
                      _StatusBox(title: "Alpa", count: "0"),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Rekap Kehadiran
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Rekap Kehadiran Anda",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // List dummy pertemuan
                  ...List.generate(10, (index) {
                    final pertemuan = index + 1;
                    IconData icon;
                    Color iconColor;

                    if (pertemuan == 5) {
                      icon = Icons.error;
                      iconColor = Colors.redAccent;
                    } else if (pertemuan <= 6) {
                      icon = Icons.check_circle;
                      iconColor = Colors.green;
                    } else {
                      icon = Icons.circle;
                      iconColor = Colors.grey;
                    }

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Pertemuan $pertemuan",
                            style: const TextStyle(fontSize: 14),
                          ),
                          Icon(icon, color: iconColor, size: 20),
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusBox extends StatelessWidget {
  final String title;
  final String count;

  const _StatusBox({required this.title, required this.count});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          count,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: const TextStyle(
            fontSize: 13,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}
