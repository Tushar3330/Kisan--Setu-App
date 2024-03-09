import 'package:flutter/material.dart';

class ServicesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Services'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Services for Farmers',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            ServiceItem(
              title: 'Weather Forecast',
              description: 'Get weather forecasts for your region to plan your farming activities.',
            ),
            ServiceItem(
              title: 'Crop Management',
              description: 'Manage your crops, including planting, watering, fertilizing, and harvesting.',
            ),
            ServiceItem(
              title: 'Market Prices',
              description: 'Check market prices for various crops to make informed selling decisions.',
            ),
            ServiceItem(
              title: 'Pest Control',
              description: 'Learn about common pests and how to control them to protect your crops.',
            ),
            // Add more service items as needed
          ],
        ),
      ),
    );
  }
}

class ServiceItem extends StatelessWidget {
  final String title;
  final String description;

  const ServiceItem({
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(title),
        subtitle: Text(description),
        leading: CircleAvatar(
          child: Icon(Icons.webhook_sharp),
        ),
        onTap: () {
          // Handle service item tap
        },
      ),
    );
  }
}
