import 'package:flutter/material.dart';

class RekapKehadiranPage extends StatelessWidget {
  const RekapKehadiranPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Rekap Kehadiran',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: Colors.white,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          RekapCard(
            jenis: 'MK Teori',
            nama: 'Komputasi Mobile',
            hari: 'Senin',
            sks: 3,
            kelas: 'A',
            persen: 75,
          ),
          SizedBox(height: 16),
          RekapCard(
            jenis: 'MK Praktikum',
            nama: 'Pengembangan Aplikasi Piranti Bergerak',
            hari: 'Senin',
            sks: 3,
            kelas: 'A',
            persen: 64,
          ),
        ],
      ),
    );
  }
}

class RekapCard extends StatelessWidget {
  final String jenis;
  final String nama;
  final String hari;
  final int sks;
  final String kelas;
  final int persen;

  const RekapCard({
    super.key,
    required this.jenis,
    required this.nama,
    required this.hari,
    required this.sks,
    required this.kelas,
    required this.persen,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: Colors.black12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFE3F2FD),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                jenis,
                style: const TextStyle(
                  color: Color(0xFF2196F3),
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              nama,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: persen / 100,
                minHeight: 8,
                backgroundColor: Colors.grey[200],
                valueColor:
                    const AlwaysStoppedAnimation<Color>(Color(0xFF64B5F6)),
              ),
            ),
            const SizedBox(height: 4),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                '$persen% Done',
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Hari : $hari\nBobot : ${sks} sks\nKelas $kelas',
              style: const TextStyle(
                fontSize: 12,
                height: 1.4,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
