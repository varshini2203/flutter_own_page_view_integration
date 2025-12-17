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
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF05040A),
              Color(0xFF0E0816),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: SafeArea(
          child: Column(
            children: [

              /// 🐻 HEADER
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 18),
                child: Row(
                  children: [

                    /// AVATAR
                    Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: glowGold.withOpacity(0.7),
                          width: 1.4,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: glowGold.withOpacity(0.25),
                            blurRadius: 14,
                          ),
                        ],
                      ),
                      child: const CircleAvatar(
                        radius: 28,
                        backgroundImage: AssetImage('images/beandp.jpg'),
                      ),
                    ),

                    const SizedBox(width: 14),

                    /// TEXT
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Rowan Atkinson Quotes',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: glowGold,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Version 2.0',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Divider(
                color: Colors.white.withOpacity(0.08),
                thickness: 1,
              ),

              /// 📜 MENU
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    _navItem(context, Icons.home, 'Home', const FlashScreen(), replace: true),
                    _navItem(context, Icons.person, 'Personal Profile', const PersonalProfile()),
                    _navItem(context, Icons.business, 'Company Profile', const CompanyProfile()),
                    _navItem(context, Icons.text_fields, 'Quotes', const PageViewText()),
                    _navItem(context, Icons.image, 'Image Quotes', const PageViewImage()),
                  ],
                ),
              ),
            ],
          ),
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
    return _HoverTile(
      icon: icon,
      title: title,
      onTap: () {
        Navigator.pop(context);
        replace
            ? Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => page),
        )
            : Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => page),
        );
      },
    );
  }
}

/// 🌟 ATTRACTIVE HOVER TILE
class _HoverTile extends StatefulWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _HoverTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  State<_HoverTile> createState() => _HoverTileState();
}

class _HoverTileState extends State<_HoverTile> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: InkWell(
        onTap: widget.onTap,
        splashColor: glowGold.withOpacity(0.12),
        highlightColor: Colors.transparent,

        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          decoration: BoxDecoration(
            color: _hover
                ? glowGold.withOpacity(0.08)
                : Colors.transparent,
          ),

          child: Row(
            children: [

              /// LEFT INDICATOR
              AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                width: 4,
                height: 28,
                decoration: BoxDecoration(
                  color: _hover ? glowGold : Colors.transparent,
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: _hover
                      ? [
                    BoxShadow(
                      color: glowGold.withOpacity(0.6),
                      blurRadius: 12,
                    )
                  ]
                      : [],
                ),
              ),

              const SizedBox(width: 14),

              /// ICON
              AnimatedScale(
                scale: _hover ? 1.08 : 1.0,
                duration: const Duration(milliseconds: 220),
                child: Icon(
                  widget.icon,
                  size: 21,
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
              ),

              const SizedBox(width: 16),

              /// TEXT
              Expanded(
                child: Text(
                  widget.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14.8,
                    letterSpacing: 0.6,
                    color: _hover
                        ? glowGold
                        : Colors.white.withOpacity(0.9),
                    fontWeight: FontWeight.w500,
                    shadows: _hover
                        ? [
                      Shadow(
                        color: glowGold.withOpacity(0.7),
                        blurRadius: 10,
                      )
                    ]
                        : [],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

