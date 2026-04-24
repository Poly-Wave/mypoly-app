import 'package:flutter/material.dart';
import 'package:mypoly/widget/index.dart';
import 'package:mypoly/style/index.dart';

class AgendaTopicCard extends StatelessWidget {
  final (String title, MPImage image) item;

  const AgendaTopicCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 148,
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        gradient: LinearGradient(
          colors: [Color(0xFF2E5C66), Color(0xFF769999)],
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(1),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFA5FFEF).withValues(alpha: 0.25),
              Color(0xFF256D86).withValues(alpha: 0.6),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(9),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.$1,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                height: 1.4,
                color: ColorStyles.primary10,
              ),
            ),
            SizedBox(height: 6),
            Spacer(),
            Align(alignment: Alignment.bottomRight, child: item.$2),
          ],
        ),
      ),
    );
  }
}
