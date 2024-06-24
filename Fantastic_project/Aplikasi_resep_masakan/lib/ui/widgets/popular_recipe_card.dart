import 'package:flutter/material.dart';

class PopularRecipeCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: [
          Image.asset('assets/recipe.jpg'), // Replace with your recipe image
          const ListTile(
            title: Text('Resep daging sapi yang lezat'),
            subtitle: Row(
              children: [
                Icon(Icons.access_time, size: 16),
                SizedBox(width: 4),
                Text('10 min'),
              ],
            ),
            trailing: Icon(Icons.favorite_border),
          ),
        ],
      ),
    );
  }
}
