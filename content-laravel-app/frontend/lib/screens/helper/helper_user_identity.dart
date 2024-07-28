import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:platform/platform.dart';
import 'package:frontend/services/api_services.dart';

// Picture Files
File? _image, _ktpImage;
String? _fileName, _ktpFileName;
final ImagePicker _picker = ImagePicker();
const LocalPlatform _platform = LocalPlatform();

void showIdentityDialog(BuildContext context, int id) {
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
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('No image selected.'),
                                ),
                              );
                            }
                          } else {
                            FilePickerResult? pickedFileDskt = await FilePicker.platform.pickFiles(type: FileType.image);
                            
                            if (pickedFileDskt != null && pickedFileDskt.files.single.path != null) {
                              setState(() {
                                _image = File(pickedFileDskt.files.single.path!);
                                _fileName = pickedFileDskt.files.single.name;
                              });
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('No image selected.'),
                                ),
                              );
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
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('No image selected.'),
                                ),
                              );
                            }
                          } else {
                            FilePickerResult? pickedFileDskt = await FilePicker.platform.pickFiles(type: FileType.image);
                            
                            if (pickedFileDskt != null && pickedFileDskt.files.single.path != null) {
                              setState(() {
                                _ktpImage = File(pickedFileDskt.files.single.path!);
                                _ktpFileName = pickedFileDskt.files.single.name;
                              });
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('No image selected.'),
                                ),
                              );
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
                  _submitDetails(context, id, identityCardNumber, npwpNumber, bankAccountNumber, _image, _ktpImage);
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

void _submitDetails(BuildContext context, id, String identityCardNumber, String bankAccountNumber, String npwpNumber, File? image, File? ktpImage) async {
  try {
    ApiService().updateUserIdentity(id, identityCardNumber, npwpNumber, bankAccountNumber, image, ktpImage);
  } catch (e) {
    final message = e.toString();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
