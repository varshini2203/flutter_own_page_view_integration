import 'package:flutter/material.dart';
import 'package:flutter_own_page_view_integration/app_data_image.dart';


class DisplayImage extends StatelessWidget {
  final AppDataImages appData;

  const DisplayImage({
    super.key,   // Suggested fix
    required this.appData,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        image: DecorationImage(
          image: AssetImage(appData.image),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
