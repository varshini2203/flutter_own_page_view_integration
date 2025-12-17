import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'page_view_text.dart';

const Color _roseGold = Color(0xFFE0BFB8);
const Color _cutePink = Color(0xFFF8C8DC);
const Color _cutePurple = Color(0xFFD6C6F2);

class FlashScreen extends StatefulWidget {
  const FlashScreen({super.key});

  @override
  State<FlashScreen> createState() => _FlashScreenState();
}

class _FlashScreenState extends State<FlashScreen>
    with TickerProviderStateMixin {

  late AnimationController _logoController;
  late AnimationController _fadeController;

  late Animation<double> _scaleAnim;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _floatAnim;

  @override
  void initState() {
    super.initState();

    /// ⏳ Auto Navigate after 3 seconds
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const PageViewText()),
      );
    });

    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..forward();

    _scaleAnim = Tween<double>(begin: 0.9, end: 1.05).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeInOut),
    );

    _floatAnim = Tween<Offset>(
      begin: const Offset(0, 0),
      end: const Offset(0, -0.04),
    ).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeInOut),
    );

    _fadeAnim = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    );
  }

  @override
  void dispose() {
    _logoController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  /// 🫧 Floating Cute Bubble
  Widget _bubble(double size, Alignment align, Color color) {
    return Align(
      alignment: align,
      child: AnimatedBuilder(
        animation: _logoController,
        builder: (_, __) {
          return Transform.translate(
            offset: Offset(0, -10 * _logoController.value),
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

  /// 🐻 Cute Logo Card
  Widget _logo() {
    return SlideTransition(
      position: _floatAnim,
      child: ScaleTransition(
        scale: _scaleAnim,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.08),
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: _cutePink.withOpacity(0.6),
                blurRadius: 60,
                spreadRadius: 12,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(26),
            child: SizedBox(
              width: 170,
              height: 170,
              child: Image.asset(
                'images/beandp.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// 💬 Cute Quote Card
  Widget _quote() {
    return FadeTransition(
      opacity: _fadeAnim,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(26),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
            child: Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.07),
                borderRadius: BorderRadius.circular(26),
                border: Border.all(
                  color: _roseGold.withOpacity(0.25),
                ),
              ),
              child: Text(
                "🐻 Mr. Bean taught me one thing 💛\n\n"
                    "Enjoy your own company instead of expecting someone else.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  height: 1.6,
                  fontWeight: FontWeight.w600,
                  color: _roseGold.withOpacity(0.95),
                ),
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
      body: Stack(
        children: [

          /// 🌈 Cute Gradient Background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF2B124C),
                  Color(0xFF4A1C6A),
                  Color(0xFF7A3E9D),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          /// 🫧 More Cute Bubbles
          _bubble(280, Alignment.topLeft, _cutePink),
          _bubble(200, Alignment.topRight, _cutePurple),
          _bubble(240, Alignment.bottomLeft, _cutePurple),
          _bubble(180, Alignment.bottomRight, _cutePink),

          /// 💕 Content
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                _logo(),

                const SizedBox(height: 40),

                _quote(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

