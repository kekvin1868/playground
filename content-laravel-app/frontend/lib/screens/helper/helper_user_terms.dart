import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend/services/api_services.dart';
import 'package:frontend/screens/helper/helper_user_identity.dart';

void showTermsDialog(BuildContext context, int id, String? uuid) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: const Color.fromARGB(255, 25, 25, 25),
        title: const Text('Terms of Service and User Agreement'),
        content: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Please read and agree to the Terms of Service and User Agreement before proceeding.',
              ),
              SizedBox(height: 16.0),
              Text(
                '1. Terms of Service:\nLorem ipsum dolor sit amet, consectetur adipiscing elit.',
              ),
              SizedBox(height: 8.0),
              Text(
                '2. User Agreement:\nLorem ipsum dolor sit amet, consectetur adipiscing elit.',
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Decline'),
            onPressed: () {
              exit(0);
            },
          ),
          TextButton(
            child: const Text('Agree'),
            onPressed: () {
              _submitUpdateAgreements(context, id, uuid);
              Navigator.of(context).pop();
              showIdentityDialog(context, id);
            },
          ),
        ],
      );
    },
  );
}

Future<void> _submitUpdateAgreements(BuildContext context, int id, String? uuid) async {
    try {
      await ApiService().updateAgreementUser(id, uuid!);
    } catch (e) {
      final message = e.toString();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
    }
  }