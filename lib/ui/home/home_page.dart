import 'package:flutter/material.dart';

import 'event_card.dart';
import 'sale_counter.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Game Reviewer",
            style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        children: [
          SaleCounter(),
          SizedBox(height: 6),
          EventCard("assets/images/super_sale.png", "February 2025 Super Sale",
              "24 February — 3 March"),
          EventCard("assets/images/super_sale_2.png", "March 2025 Summer Sale",
              "24 March — 3 April"),
          EventCard("assets/images/super_sale_3.png",
              "April 2025 Stunning Sale", "24 April — 3 May")
        ],
      ),
    );
  }
}
