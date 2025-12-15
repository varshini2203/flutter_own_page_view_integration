import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_own_page_view_integration/nav_bar.dart';
import 'package:flutter_own_page_view_integration/page_view_text.dart';

const Color _roseGold = Color(0xFFE0BFB8);

class FlashScreen extends StatefulWidget {
  const FlashScreen({super.key});

  @override
  State<FlashScreen> createState() => _FlashScreenState();
}

class _FlashScreenState extends State<FlashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _textAnim;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _textAnim = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildLogo() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 450),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: _roseGold.withOpacity(0.12),
            blurRadius: 30,
            spreadRadius: 6,
          ),
        ],
        border: Border.all(
          color: _roseGold.withOpacity(0.25),
          width: 1.2,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: SizedBox.fromSize(
          size: const Size.fromRadius(80),
          child: const Image(
            image: AssetImage('images/beandp.jpg'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  // 🔥 BUTTON
  Widget _buildNextButton() {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const PageViewText()),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 14,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.06),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: _roseGold.withOpacity(0.4),
                width: 1.4,
              ),
              boxShadow: [
                BoxShadow(
                  color: _roseGold.withOpacity(0.35),
                  blurRadius: 20,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Text(
              "Enter",
              style: TextStyle(
                color: _roseGold,
                fontSize: 18,
                letterSpacing: 2,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavBar(),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF06040A),
              Color(0xFF12021A),
              Color(0xFF2B1236),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLogo(),
              const SizedBox(height: 30),

              FadeTransition(
                opacity: _textAnim,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.04),
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: _roseGold.withOpacity(0.12),
                            width: 1.2,
                          ),
                        ),
                        child: Text(
                          'Mr. Bean taught me one thing in life, enjoy your own company instead of expecting someone else.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22,
                            letterSpacing: 1.8,
                            color: _roseGold.withOpacity(0.95),
                            fontWeight: FontWeight.bold,
                            shadows: [
                              Shadow(
                                offset: const Offset(1.5, 1.5),
                                blurRadius: 6,
                                color: Colors.black.withOpacity(0.6),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // ✅ BUTTON INSTEAD OF LOADING LINE
              _buildNextButton(),
            ],
          ),
        ),
      ),
    );
  }
}
