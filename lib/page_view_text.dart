import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_own_page_view_integration/nav_bar.dart';
import 'package:share_plus/share_plus.dart';
import 'app_data_text.dart';

class PageViewText extends StatefulWidget {
  const PageViewText({super.key});

  @override
  State<PageViewText> createState() => _PageViewTextState();
}

class _PageViewTextState extends State<PageViewText>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  int _hoverIndex = -1;

  late AnimationController _glowController;
  late Animation<double> _glowAnim;

  @override
  void initState() {
    super.initState();
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _glowAnim =
        CurvedAnimation(parent: _glowController, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
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
              Share.share(quoteListText[_selectedIndex].quoteText);
            },
          ),
        ],
      ),

      // 🌌 POLISHED BACKGROUND (MATCHES IMAGE PAGE)
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.topCenter,
                radius: 1.3,
                colors: [
                  Color(0xFF2B0040),
                  Color(0xFF12001F),
                  Color(0xFF050008),
                ],
              ),
            ),
          ),

          // ✨ Ambient glow blobs
          Positioned(
            top: -120,
            left: -90,
            child: _glowBlob(260, Colors.purpleAccent.withOpacity(0.18)),
          ),
          Positioned(
            bottom: -140,
            right: -100,
            child: _glowBlob(300, Colors.amberAccent.withOpacity(0.14)),
          ),

          // 📜 CONTENT
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 280,
                child: PageView.builder(
                  controller: PageController(viewportFraction: 0.78),
                  itemCount: quoteListText.length,
                  onPageChanged: (i) => setState(() => _selectedIndex = i),
                  itemBuilder: (context, index) {
                    final bool isActive = index == _selectedIndex;
                    final bool isHover = index == _hoverIndex;

                    return MouseRegion(
                      onEnter: (_) => setState(() => _hoverIndex = index),
                      onExit: (_) => setState(() => _hoverIndex = -1),
                      child: AnimatedBuilder(
                        animation: _glowAnim,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: isActive ? 1.0 : 0.93,
                            child: _glassCard(
                              quoteListText[index].quoteText,
                              isActive,
                              isHover,
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 26),

              // ⚡ GLOWING INDICATOR
              AnimatedBuilder(
                animation: _glowAnim,
                builder: (_, __) {
                  final glowColor = Color.lerp(
                    const Color(0xFFFFD27D),
                    const Color(0xFFB16CFF),
                    _glowAnim.value,
                  )!;

                  return Text(
                    '${_selectedIndex + 1}/${quoteListText.length}',
                    style: TextStyle(
                      fontSize: 18,
                      color: glowColor,
                      shadows: [
                        BoxShadow(
                          color: glowColor.withOpacity(0.9),
                          blurRadius: 22,
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

  // 🌟 GLASS QUOTE CARD
  Widget _glassCard(String text, bool active, bool hover) {
    final glowColor = Color.lerp(
      const Color(0xFFFFD27D),
      const Color(0xFFB16CFF),
      _glowAnim.value,
    )!;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      margin: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: active || hover
            ? [
          BoxShadow(
            color: glowColor.withOpacity(0.45),
            blurRadius: 40,
            spreadRadius: 8,
          ),
          BoxShadow(
            color: glowColor.withOpacity(0.25),
            blurRadius: 80,
            spreadRadius: 16,
          ),
        ]
            : [],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 22),
            decoration: BoxDecoration(
              color: const Color(0xFF22002D).withOpacity(0.7),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: glowColor.withOpacity(active ? 0.55 : 0.25),
                width: 1.4,
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
      ),
    );
  }

  // ✨ AMBIENT BACKGROUND GLOW
  Widget _glowBlob(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [color, Colors.transparent],
        ),
      ),
    );
  }
}
