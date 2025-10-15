import 'package:flutter/material.dart';
import 'page/detail_presensi.dart'; // 🔹 Import halaman detail presensi

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryBlue = const Color(0xFF2F7DBA);
    final lightBlue = const Color(0xFFE3F2FD);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ===== Header User =====
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Selamat Pagi 😊",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Restu Sofyan!",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "5220411082",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset(
                      "lib/assets/profile.png",
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // ===== Tanggal =====
              const Text(
                "30 September 2025",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 14),

              // ===== Dua Kartu =====
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildCard("Jadwal Anda", "lib/assets/jadwal.png", primaryBlue),
                  _buildCard("Rekap Kehadiran", "lib/assets/kehadiran.png", primaryBlue),
                ],
              ),
              const SizedBox(height: 18),

              // ===== Progress Presensi =====
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: lightBlue,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Baris atas: judul + tombol titik tiga
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Lengkapi"),
                            SizedBox(height: 6),
                            Text(
                              "Presensi Anda!",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        IconButton(
                          icon: const Icon(Icons.more_vert, color: Colors.black54),
                          onPressed: () {
                            // 🔹 Navigasi ke halaman detail presensi
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const DetailPresensiPage(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Progress bar
                    LinearProgressIndicator(
                      value: 0.66,
                      color: primaryBlue,
                      backgroundColor: Colors.white,
                      minHeight: 6,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "66% Done",
                      style: TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // ===== Jadwal Perkuliahan =====
              const Text(
                "Jadwal Perkuliahan",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              _buildScheduleCard(
                title: "Komputasi Mobile",
                subtitle: "MK Teori",
                startTime: "09.40",
                endTime: "12.10",
                color: primaryBlue,
              ),
              const SizedBox(height: 12),
              _buildScheduleCard(
                title: "Pengembangan Aplikasi Piranti Bergerak",
                subtitle: "MK Praktikum",
                startTime: "15.30",
                endTime: "18.00",
                color: const Color(0xFF00ACC1),
              ),
            ],
          ),
        ),
      ),

      // ===== Bottom Navigation =====
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            Icon(Icons.home, size: 28, color: Colors.grey),
            SizedBox(width: 48), // space for FAB
            Icon(Icons.person, size: 28, color: Colors.grey),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryBlue,
        onPressed: () {},
        child: const Icon(Icons.qr_code_scanner, color: Colors.white),
      ),
    );
  }

  // ===== Widget Helper untuk Kartu =====
  Widget _buildCard(String title, String imagePath, Color color) {
    return Expanded(
      child: Container(
        height: 110,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.calendar_today, color: color),
              const Spacer(),
              Text(
                title,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: color.withOpacity(0.8),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ===== Widget Helper untuk Jadwal =====
  Widget _buildScheduleCard({
    required String title,
    required String subtitle,
    required String startTime,
    required String endTime,
    required Color color,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black12),
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 2, offset: Offset(0, 2))
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                subtitle,
                style: TextStyle(color: color, fontSize: 12),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(startTime,
                    style:
                        const TextStyle(fontSize: 14, color: Colors.black54)),
                const Expanded(
                  child: Divider(color: Colors.black26, thickness: 1),
                ),
                Text(endTime,
                    style:
                        const TextStyle(fontSize: 14, color: Colors.black54)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
