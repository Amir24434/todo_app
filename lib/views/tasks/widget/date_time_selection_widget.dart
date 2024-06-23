// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class DateTimeSelectionWidget extends StatelessWidget {
  const DateTimeSelectionWidget({
    super.key,
    required this.textTheme,
    required this.onTap,
    required this.title,
    required this.time,
    this.isTime = false,
  });

  final TextTheme textTheme;
  final VoidCallback onTap;
  final String title;
  final String time;
  final bool isTime;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(20),
        height: 55,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Colors.grey.shade300,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                title,
                style: textTheme.headlineSmall,
              ),
            ),
            Container(
              width: isTime ? 150 : 80,
              height: 35,
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                border: Border.all(
                  color: Colors.grey.shade300,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  time,
                  style: textTheme.titleSmall,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
