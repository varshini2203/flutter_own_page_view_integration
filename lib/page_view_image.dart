import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_own_page_view_integration/app_data_image.dart';
import 'package:flutter_own_page_view_integration/nav_bar.dart';
import 'package:share_plus/share_plus.dart';

class PageViewImage extends StatefulWidget {
  const PageViewImage({Key? key}) : super(key: key);

  @override
  State<PageViewImage> createState() => _PageViewImageState();
}

class _PageViewImageState extends State<PageViewImage> {
  int _currentIndex = 0;
  final PageController _controller = PageController(viewportFraction: 0.82);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavBar(),

      appBar: AppBar(
        title: const Text(
          'Rowan Atkinson Images',
          style: TextStyle(
            color: Color(0xFFE0BFB8),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Color(0xFFE0BFB8)),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: _shareImage,
          ),
        ],
      ),

      // 🌌 POLISHED BACKGROUND
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.topCenter,
                radius: 1.25,
                colors: [
                  Color(0xFF1A0033),
                  Color(0xFF0D001A),
                  Color(0xFF050008),
                ],
              ),
            ),
          ),

          // ✨ Ambient glow accents
          Positioned(
            top: -120,
            left: -80,
            child: _glowBlob(260, Colors.purpleAccent.withOpacity(0.14)),
          ),
          Positioned(
            bottom: -140,
            right: -100,
            child: _glowBlob(280, Colors.cyanAccent.withOpacity(0.12)),
          ),

          // 📸 MAIN CONTENT
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 400,
                child: PageView.builder(
                  controller: _controller,
                  itemCount: imageList.length,
                  onPageChanged: (index) {
                    setState(() => _currentIndex = index);
                  },
                  itemBuilder: (context, index) {
                    return _imageCard(imageList[index].image);
                  },
                ),
              ),

              const SizedBox(height: 28),

              // ⚡ SUBTLE GLOW INDICATOR
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  imageList.length,
                      (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    width: _currentIndex == index ? 22 : 10,
                    height: 8,
                    decoration: BoxDecoration(
                      color: _currentIndex == index
                          ? Colors.cyanAccent
                          : Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: _currentIndex == index
                          ? [
                        BoxShadow(
                          color: Colors.cyanAccent.withOpacity(0.6),
                          blurRadius: 12,
                          spreadRadius: 2,
                        ),
                      ]
                          : [],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 32),
            ],
          ),
        ],
      ),
    );
  }

  // 🔗 SHARE IMAGE
  Future<void> _shareImage() async {
    final path = imageList[_currentIndex].image;
    final bytes = await rootBundle.load(path);
    final Uint8List data = bytes.buffer.asUint8List();

    await Share.shareXFiles(
      [
        XFile.fromData(
          data,
          mimeType: 'image/jpeg',
          name: 'rowan_atkinson.jpg',
        ),
      ],
      text: 'Rowan Atkinson Image Quote',
    );
  }

  // 🧊 IMAGE CARD (FOCUSED & CLEAN)
  Widget _imageCard(String imagePath) {
    return Center(
      child: AnimatedScale(
        scale: 1.0,
        duration: const Duration(seconds: 4),
        curve: Curves.easeInOut,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: Colors.purpleAccent.withOpacity(0.6),
                blurRadius: 34,
                spreadRadius: 4,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(32),
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  // ✨ AMBIENT GLOW
  Widget _glowBlob(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            color,
            Colors.transparent,
          ],
        ),
      ),
    );
  }
}
