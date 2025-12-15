import 'package:flutter/material.dart';
import 'package:flutter_own_page_view_integration/nav_bar.dart';

class PersonalProfile extends StatelessWidget {
  const PersonalProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        title: const Text(
          'Personal Profile',
          style: TextStyle(
            color: Color(0xFFE0BFB8), // Rose Gold
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.black,
        elevation: 10,
        iconTheme: const IconThemeData(color: Color(0xFFE0BFB8)),
      ),

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black,
              Color(0xFF2C003E), // deep purple
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              /// PROFILE IMAGE WITH ROSE-GOLD GLOW BORDER
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Color(0xFFE0BFB8), // Rose Gold
                    width: 3,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFFE0BFB8).withOpacity(0.4),
                      blurRadius: 25,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: const CircleAvatar(
                  radius: 70.0,
                  backgroundImage: AssetImage('images/dp.jpg'),
                ),
              ),

              const SizedBox(height: 20),

              /// NAME
              const Text(
                'Srivarshini S',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFE0BFB8), // Rose Gold
                  shadows: [
                    Shadow(
                      blurRadius: 8,
                      color: Colors.black,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
              ),

              const Text(
                'Flutter Developer',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white70,
                ),
              ),

              const SizedBox(height: 25),

              /// ROSE-GOLD DIVIDER
              Container(
                width: 900,
                height: 1.5,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Color(0xFFE0BFB8),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),

              /// PHONE INFO CARD
              _buildInfoCard(
                icon: Icons.phone_android,
                text: '+91 7338754522',
              ),

              /// EMAIL INFO CARD
              _buildInfoCard(
                icon: Icons.email,
                text: 'srivarshinisenthilkumar3678@gmail.com',
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// REUSABLE LUXURY CARD WIDGET
  Card _buildInfoCard({required IconData icon, required String text}) {
    return Card(
      elevation: 20,
      shadowColor: Color(0xFFE0BFB8),
      color: Colors.black.withOpacity(0.55),
      margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(
          color: Color(0xFFE0BFB8), // Rose gold outline
          width: 1.4,
        ),
      ),

      child: ListTile(
        leading: Icon(
          icon,
          color: Color(0xFFE0BFB8),
          size: 30,
        ),

        title: Text(
          text,
          style: const TextStyle(
            fontSize: 17,
            color: Color(0xFFFFF2F2),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
