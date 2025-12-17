import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import 'nav_bar.dart';
import 'app_data_text.dart';

class PageViewText extends StatefulWidget {
  const PageViewText({super.key});

  @override
  State<PageViewText> createState() => _PageViewTextState();
}

class _PageViewTextState extends State<PageViewText>
    with TickerProviderStateMixin {

  int _selectedIndex = 0;

  late final AnimationController _bubbleController;
  late final AnimationController _glowController;
  late final Animation<double> _glowAnim;

  @override
  void initState() {
    super.initState();

    /// 🫧 Bubble animation
    _bubbleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat(reverse: true);

    /// ✨ Border glow animation
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _glowAnim =
        CurvedAnimation(parent: _glowController, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _bubbleController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavBar(),

      appBar: AppBar(
        title: const Text(
          'Rowan Atkinson Quotes',
          style: TextStyle(
            color: Color(0xFFE0BFB8),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Color(0xFFE0BFB8)),
        actions: [
          IconButton(
            icon: const Icon(Icons.share, color: Color(0xFFE0BFB8)),
            onPressed: () {
              Share.share(
                quoteListText[_selectedIndex].quoteText,
              );
            },
          ),
        ],
      ),

      body: Stack(
        children: [

          /// 🌈 BACKGROUND
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

          /// 🫧 SUBTLE BUBBLES
          _bubble(220, Alignment.topLeft, Colors.pinkAccent),
          _bubble(180, Alignment.topRight, Colors.cyanAccent),
          _bubble(260, Alignment.bottomLeft, Colors.purpleAccent),
          _bubble(200, Alignment.bottomRight, Colors.blueAccent),

          /// 📜 CONTENT
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              SizedBox(
                height: 300,
                child: PageView.builder(
                  controller: PageController(viewportFraction: 0.8),
                  itemCount: quoteListText.length,
                  onPageChanged: (i) {
                    setState(() => _selectedIndex = i);
                  },
                  itemBuilder: (context, index) {
                    final isActive = index == _selectedIndex;

                    return AnimatedBuilder(
                      animation: _glowAnim,
                      builder: (_, __) {
                        return Transform.scale(
                          scale: isActive ? 1.0 : 0.95,
                          child: _glassCard(
                            quoteListText[index].quoteText,
                            isActive,
                          ),
                        );
                      },
                    );
                  },
                ),
              ),

              const SizedBox(height: 26),

              /// 🐻 PAGE COUNT
              AnimatedBuilder(
                animation: _glowAnim,
                builder: (_, __) {
                  final glowColor = Color.lerp(
                    Colors.pinkAccent,
                    Colors.cyanAccent,
                    _glowAnim.value,
                  )!;

                  return Text(
                    '${_selectedIndex + 1} / ${quoteListText.length}',
                    style: TextStyle(
                      fontSize: 18,
                      color: glowColor,
                      shadows: [
                        Shadow(
                          color: glowColor.withOpacity(0.7),
                          blurRadius: 14,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// 🫧 BUBBLE
  Widget _bubble(double size, Alignment alignment, Color color) {
    return Align(
      alignment: alignment,
      child: AnimatedBuilder(
        animation: _bubbleController,
        builder: (_, __) {
          return Transform.translate(
            offset: Offset(0, -18 * _bubbleController.value),
            child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    color.withOpacity(0.3),
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

  /// 🌟 GLASS CARD — BORDER GLOW ONLY
  Widget _glassCard(String text, bool active) {
    final glowColor = Color.lerp(
      Colors.pinkAccent,
      Colors.cyanAccent,
      _glowAnim.value,
    )!;

    return ClipRRect(
      borderRadius: BorderRadius.circular(32),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 350),
          margin: const EdgeInsets.symmetric(horizontal: 12),
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 22),

          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.07),
            borderRadius: BorderRadius.circular(32),

            /// ✨ BORDER GLOW ONLY
            border: Border.all(
              color: active
                  ? glowColor.withOpacity(0.85)
                  : Colors.white.withOpacity(0.25),
              width: active ? 2.2 : 1.2,
            ),
          ),

          child: Center(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22,
                height: 1.5,
                color: Colors.white,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

