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

class _PageViewImageState extends State<PageViewImage>
    with SingleTickerProviderStateMixin {

  int _currentIndex = 0;
  final PageController _controller = PageController(viewportFraction: 0.82);

  late AnimationController _bubbleController;

  @override
  void initState() {
    super.initState();
    _bubbleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _bubbleController.dispose();
    _controller.dispose();
    super.dispose();
  }

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

      body: Stack(
        children: [

          /// 🌈 CUTE CARTOON BACKGROUND
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF2A0845),
                  Color(0xFF4B176E),
                  Color(0xFF7E3F98),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          /// 🫧 FLOATING CUTE BUBBLES
          _cuteBubble(260, Alignment.topLeft, Colors.pinkAccent),
          _cuteBubble(200, Alignment.topRight, Colors.cyanAccent),
          _cuteBubble(280, Alignment.bottomLeft, Colors.purpleAccent),
          _cuteBubble(220, Alignment.bottomRight, Colors.blueAccent),
          _cuteBubble(120, Alignment.centerLeft, Colors.white),
          _cuteBubble(100, Alignment.centerRight, Colors.pinkAccent),

          /// 📸 MAIN CONTENT
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              SizedBox(
                height: 420,
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

              /// 🐻 CUTE INDICATOR
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  imageList.length,
                      (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    width: _currentIndex == index ? 24 : 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: _currentIndex == index
                          ? Colors.pinkAccent
                          : Colors.white38,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: _currentIndex == index
                          ? [
                        BoxShadow(
                          color: Colors.pinkAccent.withOpacity(0.6),
                          blurRadius: 14,
                          spreadRadius: 3,
                        ),
                      ]
                          : [],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ],
      ),
    );
  }

  // 🫧 CUTE FLOATING BUBBLE
  Widget _cuteBubble(double size, Alignment align, Color color) {
    return Align(
      alignment: align,
      child: AnimatedBuilder(
        animation: _bubbleController,
        builder: (_, __) {
          return Transform.translate(
            offset: Offset(0, -15 * _bubbleController.value),
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    color.withOpacity(0.35),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // 🐻 CUTE IMAGE CARD
  Widget _imageCard(String imagePath) {
    return Center(
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.95, end: 1.0),
        duration: const Duration(seconds: 3),
        curve: Curves.easeInOut,
        builder: (context, scale, child) {
          return Transform.scale(
            scale: scale,
            child: child,
          );
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(36),
            boxShadow: [
              BoxShadow(
                color: Colors.pinkAccent.withOpacity(0.6),
                blurRadius: 40,
                spreadRadius: 6,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(36),
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
            ),
          ),
        ),
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
      text: 'Rowan Atkinson Image 💛',
    );
  }
}

