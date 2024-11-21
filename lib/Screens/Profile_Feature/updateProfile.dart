import 'dart:io';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../Widgets/text_field.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  File? _image; // Holds the selected image file
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        DocumentSnapshot userDoc = await _firestore.collection('users').doc(user.uid).get();

        if (userDoc.exists) {
          fullNameController.text = userDoc['name'];
          emailController.text = userDoc['email'];
          phoneNumberController.text = userDoc['phone'] ?? '';
        }
      }
    } catch (e) {
      print("Error loading user data: $e");
    }
  }

  Future<void> _updateUserData() async {
    User? user = _auth.currentUser;

    if (user != null) {
      try {
        // Updating the user data in Firestore
        await _firestore.collection('users').doc(user.uid).update({
          'name': fullNameController.text,
          'email': emailController.text,
          'phone': phoneNumberController.text,
        });

        // If the email is updated, update it in FirebaseAuth too
        if (emailController.text != user.email) {
          await user.updateEmail(emailController.text);
        }

        // If the password is provided, update it in FirebaseAuth too
        if (passwordController.text.isNotEmpty) {
          await user.updatePassword(passwordController.text);
        }

        // Upload the selected profile image to Firebase Storage (optional)
        if (_image != null) {
          final ref = _storage.ref().child('profile_images/${user.uid}.jpg');
          await ref.putFile(_image!);
          final imageUrl = await ref.getDownloadURL();

          // Update the image URL in Firestore
          await _firestore.collection('users').doc(user.uid).update({
            'profileImageUrl': imageUrl,
          });
        }

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Profile updated successfully")),
        );

        // Navigate to ProfilePage after successful update
        Navigator.pop(context);
      } catch (e) {
        print("Error updating profile: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Error updating profile")),
        );
      }
    }
  }

  Future<void> _pickImage() async {
    final XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        backgroundColor: const Color.fromARGB(255, 19, 44, 87),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Profile image with edit option
              Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.grey[300],
                    backgroundImage: _image != null
                        ? FileImage(_image!)
                        : const AssetImage('assets/images/register.png') as ImageProvider,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: const BoxDecoration(
                          color: const Color.fromARGB(255, 19, 44, 87),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          LineAwesomeIcons.camera,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              // Form fields for updating profile
              Form(
                child: Column(
                  children: [
                    TextFieldInput(
                      Text: "Full Name",
                      textEditingController: fullNameController,
                      icon: Icons.person_outline,
                    ),
                    const SizedBox(height: 20),
                    TextFieldInput(
                      Text: "E-Mail",
                      textEditingController: emailController,
                      icon: Icons.email_outlined,
                    ),
                    const SizedBox(height: 20),
                    TextFieldInput(
                      Text: "Phone No.",
                      textEditingController: phoneNumberController,
                      icon: Icons.phone_android_outlined,
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _updateUserData,
                        style: ElevatedButton.styleFrom(
                          //primary: const Color.fromARGB(255, 19, 44, 87),
                          shape: const StadiumBorder(),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: const Text(
                          "Update Profile",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}