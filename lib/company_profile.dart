import 'package:flutter/material.dart';
import 'package:flutter_own_page_view_integration/nav_bar.dart';

class CompanyProfile extends StatelessWidget {
  const CompanyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        title: const Text(
          'Company Profile',
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
              Color(0xFF2C003E), // Deep Purple Black
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),

        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              /// COMPANY HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: Color(0xFFE0BFB8), // Rose Gold
                        width: 3,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFFE0BFB8).withOpacity(0.4),
                          blurRadius: 25,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: SizedBox.fromSize(
                        size: const Size.fromRadius(45),
                        child: Image.asset(
                          'images/companydp.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 15),

                  const Text(
                    'Tidy Life India Pvt Limited',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFE0BFB8), // Rose Gold
                      shadows: [
                        Shadow(
                          blurRadius: 10,
                          color: Colors.black,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              /// ROSE GOLD DIVIDER
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

              /// CONTACT CARDS
              _buildInfoCard(
                icon: Icons.phone_android,
                text: '+91 9876543210',
              ),

              _buildInfoCard(
                icon: Icons.email_outlined,
                text: 'tidy life india pvt ltd @gmail.com',
              ),

              _buildInfoCard(
                icon: Icons.location_city,
                text:
                'No. A3 Mahalakshmi Flats, Sivagami Street,\nNew Perungalathur,\nChennai, Tamil Nadu - 600063',
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 🔥 Custom Rose-Gold Luxury Info Cards
  Card _buildInfoCard({required IconData icon, required String text}) {
    return Card(
      elevation: 20,
      shadowColor: Color(0xFFE0BFB8),
      color: Colors.black.withOpacity(0.6),
      margin: const EdgeInsets.symmetric(vertical: 18, horizontal: 50),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(
          color: Color(0xFFE0BFB8), // Rose-gold border
          width: 1.5,
        ),
      ),

      child: ListTile(
        leading: Icon(
          icon,
          color: Color(0xFFE0BFB8), // Rose Gold Icon
          size: 30,
        ),

        title: Text(
          text,
          style: const TextStyle(
            fontSize: 17,
            color: Color(0xFFFFF2F2), // Very soft white
            fontWeight: FontWeight.w500,
            height: 1.4,
          ),
        ),
      ),
    );
  }
}
