import 'package:flutter/material.dart';

import 'event_card.dart';

class EventCardDetail extends StatelessWidget {
  final double imageWidth;
  final double imageHeight;
  final EventCard eventCard;

  const EventCardDetail(
    this.eventCard, {
    super.key,
    this.imageWidth = double.infinity, // Mặc định: chiều rộng full màn hình
    this.imageHeight = 300, // Mặc định: 300 pixel
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text("Event Detail", style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ảnh sự kiện với kích thước có thể tùy chỉnh
            SizedBox(
              width: imageWidth,
              height: imageHeight,
              child: Image.asset(
                eventCard.eventImage,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tiêu đề sự kiện
                  const Text(
                    "Super Sale Event",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),

                  // Nội dung mô tả sự kiện
                  const Text(
                    "Join us for the biggest sale of the year! Enjoy amazing discounts on your favorite games and exclusive deals available for a limited time.",
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),

                  // Tiêu đề phụ
                  const Text(
                    "Event Name",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),

                  // Nội dung tiêu đề phụ
                  Text(
                    eventCard.eventName,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),

                  // Tiêu đề phụ
                  const Text(
                    "Event Highlights",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),

                  // Nội dung tiêu đề phụ
                  const Text(
                    "- Discounts up to 90%\n- Exclusive pre-orders\n- Free in-game rewards",
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),

                  // Tiêu đề phụ
                  const Text(
                    "Event Duration",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),

                  // Nội dung tiêu đề phụ
                  Text(
                    eventCard.eventDuration,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
