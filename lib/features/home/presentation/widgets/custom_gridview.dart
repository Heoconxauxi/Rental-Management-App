import 'package:flutter/material.dart';

class UtilitiesGrid extends StatefulWidget {
  const UtilitiesGrid({super.key});

  @override
  State<UtilitiesGrid> createState() => _UtilitiesGridState();
}

class _UtilitiesGridState extends State<UtilitiesGrid> {
  final List<Map<String, dynamic>> utilities = [
    //{"icon": Icons.wifi, "label": "Wi-Fi"},
    {"icon": Icons.local_parking, "label": "Chỗ đậu xe"},
    {"icon": Icons.pool, "label": "Hồ bơi"},
    {"icon": Icons.restaurant, "label": "Nhà hàng"},
    //{"icon": Icons.fitness_center, "label": "Gym"},
    //{"icon": Icons.local_laundry_service, "label": "Giặt ủi"},
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: 28),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1, 
      ),
      itemCount: utilities.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.purple.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(utilities[index]["icon"], size: 40, color: Colors.purple),
                SizedBox(height: 8),
                Text(
                  utilities[index]["label"],
                  style: TextStyle(fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
