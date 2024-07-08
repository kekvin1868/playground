import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/globals.dart';
import 'package:frontend/services/auth_services.dart';
import 'package:frontend/services/email_services.dart';
import 'package:frontend/services/api_services.dart';

class KeyScreen extends StatefulWidget {
  const KeyScreen({super.key});

  @override
  _KeyScreenState createState() => _KeyScreenState();
}

class _KeyScreenState extends State<KeyScreen> {
  final TextEditingController _uuidController = TextEditingController();
  late Map<String, dynamic> args;
  late User? user;
  late String uuid;
  late int id;
  bool _emailSent = false;

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    user = args['user'] as User?;
    uuid = args['uuid'] as String;
    id = args['id'] as int;

    _sendEmailOnce(uuid, user?.email);
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 25, 25, 25),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 25, 25, 25),
        title: const Text(''),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await AuthService().signOut(context);
            }
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/diawan-logo.png',
              height: 150.0,
            ),
            const SizedBox(height: 60.0),
            Text(
              'Welcome ${user?.displayName}',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 28.0),
            FractionallySizedBox(
              widthFactor: 0.70,
              child: Text(
                "Let's activate your account first! We have sent you an email containing your Unique ID for your account. With your Unique ID attached, your account will be activated.",
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 48.0),
            FractionallySizedBox(
              widthFactor: 0.40,
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextField(
                    controller: _uuidController,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter your Unique ID',
                    ),
                    cursorColor: Colors.white,
                    keyboardType: TextInputType.text,
                  ),
                ),
            ),
            const SizedBox(height: 36.0),
            SizedBox(
              width: 250,
              child: ElevatedButton(
                onPressed: () => _verifyUniqueId(user, _uuidController.text, id), 
                child: const Text('Activate'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _sendEmailOnce(String uuid, String? email) async {
    if (!_emailSent) {
      try {
        await EmailService.sendEmail(uuid, email);
        setState(() {
          _emailSent = true;
        });
      } catch (e) {
        print('Error sending email: $e');
      }
    }
  }
  
  void _verifyUniqueId(User? googleUser, String uuid, int userId) async {
    print(userId);
    final bool validation = await ApiService().validateUuid(uuid);

    if (validation) {
      await ApiService().updateUser(userId, uuid);
      if (mounted) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pushReplacementNamed(
            context,
            '/home',
            arguments: {
              'user': googleUser,
              'uuid': uuid,
              'id': userId,
            }
          );
        });
      }
    } else {
      if (mounted) {
        showErrorSnackBar("Invalid Unique ID");
      }
    }
  }

  void showErrorSnackBar(String message) {
    scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color.fromARGB(255, 30, 30, 30),
      ),
    );
  }
}