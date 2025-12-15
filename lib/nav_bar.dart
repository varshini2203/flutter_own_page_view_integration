import 'package:flutter/material.dart';
import 'company_profile.dart';
import 'flash_screen.dart';
import 'page_view_image.dart';
import 'page_view_text.dart';
import 'personal_profile.dart';

const Color glowGold = Color(0xFFFFD27D);

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: const Color(0xFF06040A),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: const Text(
                'Rowan Atkinson Quotes',
                style: TextStyle(color: glowGold, fontWeight: FontWeight.w600),
              ),
              accountEmail: const Text(
                'Version 2.0',
                style: TextStyle(color: glowGold),
              ),
              currentAccountPicture: ClipOval(
                child: Image.asset(
                  'images/beandp.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              decoration: const BoxDecoration(
                color: Color(0xFF12021A),
              ),
            ),

            _navItem(context, Icons.home, 'Home', const FlashScreen(), replace: true),
            _navItem(context, Icons.person, 'Personal Profile', const PersonalProfile()),
            _navItem(context, Icons.business, 'Company Profile', const CompanyProfile()),
            _navItem(context, Icons.text_fields, 'Quotes', PageViewText()),
            _navItem(context, Icons.image, 'Image Quotes', PageViewImage()),
          ],
        ),
      ),
    );
  }

  Widget _navItem(
      BuildContext context,
      IconData icon,
      String title,
      Widget page, {
        bool replace = false,
      }) {
    return _GlowTile(
      icon: icon,
      title: title,
      onTap: () {
        Navigator.pop(context);
        replace
            ? Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => page))
            : Navigator.push(context, MaterialPageRoute(builder: (_) => page));
      },
    );
  }
}

class _GlowTile extends StatefulWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _GlowTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  State<_GlowTile> createState() => _GlowTileState();
}

class _GlowTileState extends State<_GlowTile> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: InkWell(
        onTap: widget.onTap,
        splashColor: glowGold.withOpacity(0.15),
        highlightColor: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 14),
          child: Row(
            children: [
              // LEFT GLOW BAR
              AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                width: 4,
                height: 34,
                decoration: BoxDecoration(
                  color: _hover ? glowGold : Colors.transparent,
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: _hover
                      ? [
                    BoxShadow(
                      color: glowGold.withOpacity(0.9),
                      blurRadius: 14,
                    )
                  ]
                      : [],
                ),
              ),
              const SizedBox(width: 16),

              // ICON
              Icon(
                widget.icon,
                size: 22,
                color: _hover ? glowGold : Colors.white70,
                shadows: _hover
                    ? [
                  Shadow(
                    color: glowGold.withOpacity(0.8),
                    blurRadius: 12,
                  )
                ]
                    : [],
              ),

              const SizedBox(width: 16),

              // TEXT
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: 15.5,
                  letterSpacing: 1,
                  color: _hover ? glowGold : Colors.white.withOpacity(0.9),
                  fontWeight: FontWeight.w500,
                  shadows: _hover
                      ? [
                    Shadow(
                      color: glowGold.withOpacity(0.8),
                      blurRadius: 12,
                    )
                  ]
                      : [],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
