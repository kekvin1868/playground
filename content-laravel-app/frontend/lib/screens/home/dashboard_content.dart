import 'package:flutter/material.dart';

class DashboardContent extends StatelessWidget {
  DashboardContent({super.key});

  final List<Map<String, String>> cardData = [
    {
      'title': 'Projects',
      'content': ''
    },
    {
      'title': 'Todo',
      'content': ''
    },
    {
      'title': 'Billing',
      'content': ''
    },
    {
      'title': 'Late Project Task',
      'content': ''
    },
  ];

  final List<Color> cardColors = [
    const Color.fromARGB(255, 0, 69, 187),
    const Color.fromARGB(255, 187, 94, 0),
    const Color.fromARGB(255, 10, 118, 0),
    const Color.fromARGB(255, 165, 0, 0),
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 1,
      childAspectRatio: 3,
      children: List.generate(cardData.length, (index) {
        return Container(
          margin: const EdgeInsets.all(8.0),
          child: Card(
            color: cardColors[index % cardColors.length],
            child: SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      cardData[index]['title']!,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      cardData[index]['content']!,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}