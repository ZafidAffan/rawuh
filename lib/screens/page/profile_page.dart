import 'package:flutter/material.dart';
import '../home_page.dart'; // untuk navigasi balik ke home jika dibutuhkan

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryBlue = const Color(0xFF2F7DBA);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // ===== Header Profile =====
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('lib/assets/profile.png'),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Restu Sofyan Ma’arif",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        "restu@codingankuu.com",
                        style: TextStyle(color: Colors.grey),
                      ),
                      const Text(
                        "5220411082",
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.green.shade100,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Text(
                          "Mahasiswa Aktif",
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // ===== Data Akademik =====
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  const Text(
                    "Akademik",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const Divider(),
                  _buildRowData("Jenjang", "Sarjana"),
                  _buildRowData("Program Studi", "Informatika"),
                  _buildRowData("Fakultas", "Sains & Teknologi"),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // ===== Data Diri =====
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  const Text(
                    "Data Diri Lainnya",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const Divider(),
                  _buildRowData("NIK", "12345689030411"),
                  _buildRowData("Tempat Lahir", "Dikasur Yang Empuk"),
                  _buildRowData("Tanggal Lahir", "11 - 12 - 2003"),
                  _buildRowData("Email", "restu@codingankuu.com"),
                  _buildRowData("Telepon", "+666666666666"),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // ===== Tombol Logout =====
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red.shade300),
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: Icon(Icons.logout_rounded, color: Colors.red.shade400),
                title: const Text(
                  "Logout",
                  style: TextStyle(color: Colors.red),
                ),
                trailing: const Icon(Icons.arrow_forward_ios_rounded,
                    size: 16, color: Colors.red),
                onTap: () {},
              ),
            ),
          ],
        ),
      ),

      // ===== Bottom Navigation (sama seperti HomePage) =====
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.home, size: 28, color: Colors.grey),
              onPressed: () {
                // 🔹 Navigasi balik ke HomePage
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
            ),
            const SizedBox(width: 48),
            IconButton(
              icon: const Icon(Icons.person, size: 28, color: Colors.blue),
              onPressed: () {
                // sudah di halaman ini
              },
            ),
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

  // ===== Widget Helper untuk Data =====
  Widget _buildRowData(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: const TextStyle(
                  fontWeight: FontWeight.w500, color: Colors.black54)),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: const TextStyle(color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
