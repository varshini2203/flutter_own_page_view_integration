import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_own_page_view_integration/nav_bar.dart';

const Color _roseGold = Color(0xFFE0BFB8);

class CompanyProfile extends StatefulWidget {
  const CompanyProfile({super.key});

  @override
  State<CompanyProfile> createState() => _CompanyProfileState();
}

class _CompanyProfileState extends State<CompanyProfile>
    with TickerProviderStateMixin {

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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavBar(),

      appBar: AppBar(
        title: const Text(
          'Company Profile',
          style: TextStyle(
            color: _roseGold,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.black,
        elevation: 12,
        iconTheme: const IconThemeData(color: _roseGold),
      ),

      body: Stack(
        children: [

          /// 🌈 CARTOON GRADIENT BACKGROUND
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF12001F),
                  Color(0xFF2C003E),
                  Color(0xFF4A145F),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          /// 🫧 FLOATING BUBBLES
          _bubble(260, Alignment.topLeft, Colors.pinkAccent),
          _bubble(200, Alignment.topRight, Colors.purpleAccent),
          _bubble(300, Alignment.bottomLeft, Colors.cyanAccent),
          _bubble(220, Alignment.bottomRight, Colors.amberAccent),
          _bubble(120, Alignment.centerLeft, Colors.white),
          _bubble(100, Alignment.centerRight, Colors.pinkAccent),

          /// 🏢 CONTENT
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                /// 🐻 COMPANY HEADER
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(28),
                        boxShadow: [
                          BoxShadow(
                            color: _roseGold.withOpacity(0.5),
                            blurRadius: 35,
                            spreadRadius: 6,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(22),
                        child: SizedBox(
                          width: 90,
                          height: 90,
                          child: Image.asset(
                            'images/companydp.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 18),

                    const Text(
                      'Tidy Life India Pvt Limited',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: _roseGold,
                        shadows: [
                          Shadow(
                            blurRadius: 12,
                            color: Colors.black,
                            offset: Offset(2, 2),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                /// ✨ DIVIDER
                Container(
                  width: 320,
                  height: 1.6,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        _roseGold,
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                /// 📞 INFO CARDS
                _infoCard(
                  icon: Icons.phone_android,
                  text: '+91 9876543210',
                ),

                _infoCard(
                  icon: Icons.email_outlined,
                  text: 'tidylifeindiapvtltd@gmail.com',
                ),

                _infoCard(
                  icon: Icons.location_city,
                  text:
                  'No. A3 Mahalakshmi Flats,\n'
                      'Sivagami Street,\n'
                      'New Perungalathur,\n'
                      'Chennai, Tamil Nadu - 600063',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// 🫧 FLOATING BUBBLE
  Widget _bubble(double size, Alignment align, Color color) {
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

  /// 🌟 GLASS INFO CARD
  Widget _infoCard({required IconData icon, required String text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.07),
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color: _roseGold.withOpacity(0.4),
                width: 1.3,
              ),
              boxShadow: [
                BoxShadow(
                  color: _roseGold.withOpacity(0.35),
                  blurRadius: 25,
                  spreadRadius: 3,
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(icon, color: _roseGold, size: 30),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    text,
                    style: const TextStyle(
                      fontSize: 17,
                      height: 1.4,
                      color: Color(0xFFFFF2F2),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

