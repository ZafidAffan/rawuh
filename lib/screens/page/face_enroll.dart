import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class FaceEnrollPage extends StatefulWidget {
  const FaceEnrollPage({super.key});

  @override
  State<FaceEnrollPage> createState() => _FaceEnrollPageState();
}

class _FaceEnrollPageState extends State<FaceEnrollPage> {
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;
  bool _isFaceDetected = false;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  // 🔹 Inisialisasi kamera depan
  Future<void> _initCamera() async {
    final cameras = await availableCameras();
    final frontCamera = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
    );

    _controller = CameraController(frontCamera, ResolutionPreset.medium);
    _initializeControllerFuture = _controller!.initialize();

    if (mounted) {
      setState(() {});
    }

    // 🔹 Simulasi face recognition success setelah 3 detik
    // (nantinya kamu bisa ganti dengan logic deteksi wajah beneran)
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _isFaceDetected = true;
      });
      _navigateToQRPage();
    });
  }

  void _navigateToQRPage() {
    Navigator.pushReplacementNamed(context, '/qrscan');
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const primaryBlue = Color(0xFF50B5E3);

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Form Kehadiran',
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
              'Pindai Wajah',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            const Text(
              'Arahkan wajah Anda ke kamera depan',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black54, fontSize: 13),
            ),
            const SizedBox(height: 24),

            // 🔹 Tampilan kamera sungguhan
            Container(
              width: double.infinity,
              height: 280,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.black,
              ),
              clipBehavior: Clip.antiAlias,
              child: (_controller != null &&
                      _initializeControllerFuture != null)
                  ? FutureBuilder(
                      future: _initializeControllerFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return CameraPreview(_controller!);
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      },
                    )
                  : const Center(child: CircularProgressIndicator()),
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
                    _isFaceDetected
                        ? Icons.check_circle
                        : Icons.warning_amber_rounded,
                    color: _isFaceDetected
                        ? Colors.green
                        : Colors.grey.shade600,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      _isFaceDetected
                          ? 'Wajah terdeteksi! Mengalihkan ke halaman QR...'
                          : 'Mohon kedipkan mata untuk memastikan keaslian pengguna',
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // ===== Bottom Nav sama seperti sebelumnya =====
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Colors.white,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(LucideIcons.home),
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, '/home'),
              ),
              const SizedBox(width: 8),
              FloatingActionButton(
                onPressed: () {},
                backgroundColor: primaryBlue,
                child: const Icon(LucideIcons.scanFace),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(LucideIcons.user),
                onPressed: () =>
                    Navigator.pushNamed(context, '/profile'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
