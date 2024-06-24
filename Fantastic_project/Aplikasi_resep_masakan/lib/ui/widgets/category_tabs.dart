import 'package:flutter/material.dart';

class CategoryTabs extends StatelessWidget {
  const CategoryTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/image/category_bg.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: const SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            CategoryTab(label: 'Semua'),
            CategoryTab(label: 'Tepung'),
            CategoryTab(label: 'Sayuran'),
            CategoryTab(label: 'Daging'),
            // Add more categories as needed
          ],
        ),
      ),
    );
  }
}

class CategoryTab extends StatelessWidget {
  final String label;

  const CategoryTab({required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Chip(
        label: Text(label),
      ),
    );
  }
}
