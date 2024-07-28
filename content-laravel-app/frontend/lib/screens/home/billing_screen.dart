import 'package:flutter/material.dart';

class BillingScreen extends StatelessWidget {
  const BillingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Billing Screen',
        style: Theme.of(context).textTheme.headlineSmall,
      ),
    );
  }
}