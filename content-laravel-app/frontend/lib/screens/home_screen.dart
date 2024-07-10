import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:platform/platform.dart';
import 'package:flutter/material.dart';
import 'package:frontend/globals.dart';
import 'package:frontend/screens/treemap_screen.dart';
import 'package:frontend/services/api_services.dart';
import 'package:frontend/services/auth_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user;
  String? uuid;
  int? id;
  bool _dialogShown = false;

  // Picture Files
  File? _image;
  String? _fileName;
  File? _ktpImage;
  String? _ktpFileName;
  final ImagePicker _picker = ImagePicker();
  final LocalPlatform _platform = const LocalPlatform();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;

    if (args != null && args is Map<String, dynamic>) {
      user = args['user'] as User?;
      uuid = args['uuid'] as String?;
      id = args['id'] as int?;

      _checkUserAgreementsAndNavigate(id!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 25, 25, 25),
      appBar: AppBar(
        title: const Text('TalentPool Login'),
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
              'Welcome back ${user?.displayName}',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8.0),
            Text(
              'Hello there',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24.0),
          ],
        ),
      ),
    );
  }

  Future<void> _checkUserAgreementsAndNavigate(int id) async {
    try {
      bool agreementsAccepted = await ApiService().checkUserAgreements(id);

      if (agreementsAccepted) {
        // Directly navigate to TreemapScreen
        if (mounted) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const TreemapScreen(title: 'Your Title')),
            );
          });
        }
      } else {
        // Show dialog if not already shown
        if (!_dialogShown) {
          _dialogShown = true;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _showTermsDialog(uuid);
          });
        }
      }
    } catch (e) {
      print('Error checking user agreements: $e');
    }
  }

  void _showTermsDialog(String? uuid) {
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
                _submitUpdateAgreements(id!, uuid);
                Navigator.of(context).pop();
                _showIdentityDialog(id!);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _submitUpdateAgreements(int id, String? uuid) async {
    try {
      await ApiService().updateAgreementUser(id, uuid!);
    } catch (e) {
      final message = e.toString();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
          ),
        );
      }
    }
  }

  void _showIdentityDialog(int id) {
    final TextEditingController identityCardController = TextEditingController();
    final TextEditingController bankAccountController = TextEditingController();
    final TextEditingController npwpNumberController = TextEditingController();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              backgroundColor: const Color.fromARGB(255, 25, 25, 25),
              title: const Text('Enter your details'),
              content: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text('Upload Your Picture', style: TextStyle(color: Colors.white)),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.add_a_photo, color: Colors.white),
                          onPressed: () async {
                            if(_platform.isAndroid || _platform.isIOS) {
                              final pickedFileAnd = await _picker.pickImage(source: ImageSource.gallery);

                              if (pickedFileAnd != null) {
                                setState(() {
                                  _image = File(pickedFileAnd.path);
                                  _fileName = pickedFileAnd.name;
                                });
                              } else {
                                if (mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('No image selected.'),
                                    ),
                                  );
                                }
                              }
                            } else {
                              FilePickerResult? pickedFileDskt = await FilePicker.platform.pickFiles(type: FileType.image);
                              
                              if (pickedFileDskt != null && pickedFileDskt.files.single.path != null) {
                                setState(() {
                                  _image = File(pickedFileDskt.files.single.path!);
                                  _fileName = pickedFileDskt.files.single.name;
                                });
                              } else {
                                if (mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('No image selected.'),
                                    ),
                                  );
                                }
                              }
                            }
                          },
                        ),
                        if (_fileName != null)
                          Text(_fileName!, style: const TextStyle(color: Colors.white),),
                      ],
                    ),
                    const SizedBox(height: 16.0), 
                    const Text('Upload KTP', style: TextStyle(color: Colors.white)), // Upload KTP
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.add_a_photo, color: Colors.white),
                          onPressed: () async {
                            if(_platform.isAndroid || _platform.isIOS) {
                              final pickedFileAnd = await _picker.pickImage(source: ImageSource.gallery);

                              if (pickedFileAnd != null) {
                                setState(() {
                                  _ktpImage = File(pickedFileAnd.path);
                                  _ktpFileName = pickedFileAnd.name;
                                });
                              } else {
                                if (mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('No image selected.'),
                                    ),
                                  );
                                }
                              }
                            } else {
                              FilePickerResult? pickedFileDskt = await FilePicker.platform.pickFiles(type: FileType.image);
                              
                              if (pickedFileDskt != null && pickedFileDskt.files.single.path != null) {
                                setState(() {
                                  _ktpImage = File(pickedFileDskt.files.single.path!);
                                  _ktpFileName = pickedFileDskt.files.single.name;
                                });
                              } else {
                                if (mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('No image selected.'),
                                    ),
                                  );
                                }
                              }
                            }
                          },
                        ),
                        if (_ktpFileName != null)
                          Text(_ktpFileName!, style: const TextStyle(color: Colors.white),),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    const Text('Bank Account Number'),
                    const SizedBox(height: 8.0),
                    TextField(
                      controller: bankAccountController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: 'Enter your bank account number',
                        hintStyle: TextStyle(color: Colors.white70),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    const Text('Identity Card Number (KTP)'),
                    const SizedBox(height: 8.0),
                    TextField(
                      controller: identityCardController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: 'Enter your identity card number',
                        hintStyle: TextStyle(color: Colors.white70),
                      ),
                    ),
                    const SizedBox(height: 16.0,),
                    const Text('NPWP Number'),
                    const SizedBox(height: 8.0),
                    TextField(
                      controller: npwpNumberController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: 'Enter NPWP Number',
                        hintStyle: TextStyle(color: Colors.white70),
                      ),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Submit'),
                  onPressed: () async {
                    // Handle the submission of the details
                    final identityCardNumber = identityCardController.text;
                    final bankAccountNumber = bankAccountController.text;
                    final npwpNumber = npwpNumberController.text;

                    // Perform your API call or other actions with the data here
                    _submitDetails(id, identityCardNumber, npwpNumber, bankAccountNumber, _image, _ktpImage);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _submitDetails(int id, String identityCardNumber, String bankAccountNumber, String npwpNumber, File? image, File? ktpImage) async {
    try {
      ApiService().updateUserIdentity(id, identityCardNumber, npwpNumber, bankAccountNumber, image, ktpImage);
    } catch (e) {
      final message = e.toString();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(message),
          ),
        );
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