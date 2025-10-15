import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QRScanPage extends StatefulWidget {
  const QRScanPage({super.key});

  @override
  State<QRScanPage> createState() => _QRScanPageState();
}

class _QRScanPageState extends State<QRScanPage> {
  bool _isScanned = false;

  void _onDetect(BarcodeCapture capture) {
    if (_isScanned) return; // cegah duplikasi deteksi
    final List<Barcode> barcodes = capture.barcodes;
    if (barcodes.isNotEmpty) {
      final String? qrData = barcodes.first.rawValue;
      if (qrData != null) {
        setState(() => _isScanned = true);

        // 🔹 Aksi setelah QR berhasil dipindai
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('QR Code terdeteksi: $qrData')),
        );

        // 🔹 Setelah berhasil, arahkan ke halaman berikutnya
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pushReplacementNamed(context, '/success'); // ubah sesuai rute kamu
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const primaryBlue = Color(0xFF50B5E3);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Scan QR Code',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      // ===== BODY =====
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Pindai QR Code',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            const Text(
              'Arahkan kamera ke QR Code untuk melanjutkan proses kehadiran',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black54, fontSize: 13),
            ),
            const SizedBox(height: 24),

            // ===== KAMERA SCANNER =====
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // 🔹 Tampilan kamera real-time
                    MobileScanner(
                      onDetect: _onDetect,
                      fit: BoxFit.cover,
                    ),

                    // 🔹 Overlay garis scan
                    if (!_isScanned)
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: primaryBlue.withOpacity(0.8),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        width: 240,
                        height: 240,
                      ),

                    // 🔹 Overlay icon lucide
                    if (!_isScanned)
                      const Icon(
                        LucideIcons.scanLine,
                        color: Colors.white70,
                        size: 100,
                      ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // 🔹 Pesan status
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  Icon(
                    _isScanned
                        ? Icons.check_circle
                        : Icons.qr_code_scanner_rounded,
                    color: _isScanned ? Colors.green : Colors.grey.shade600,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      _isScanned
                          ? 'QR Code berhasil dipindai!'
                          : 'Arahkan kamera ke QR Code Anda',
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
