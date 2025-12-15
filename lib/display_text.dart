import 'package:flutter/material.dart';
import 'app_data_text.dart';

class DisplayText extends StatelessWidget {
  final AppDataText appData;

  const DisplayText({super.key, required this.appData});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.indigoAccent,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(16),
      alignment: Alignment.center,
      child: Text(
        appData.quoteText,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
