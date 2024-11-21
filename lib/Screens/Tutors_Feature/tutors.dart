import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uni_connect_2/Widgets/my_buttons.dart';

class TutorPage extends StatefulWidget {
  @override
  _TutorPageState createState() => _TutorPageState();
}

class _TutorPageState extends State<TutorPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();

  // Controllers for registration form fields
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController studentNumberController = TextEditingController();
  final TextEditingController courseController = TextEditingController();
  final TextEditingController subjectController = TextEditingController();

  String availability = 'Available'; // Default availability
  String facultyOpt = 'Humanities'; // Default faculty
  final List<String> availabilityOptions = ['Available', "N/A"];
  final List<String> facultyOptions = [
    'Humanities',
    'Health and Environmental Sciences',
    'Management Sciences',
    'FEBIT',
    'Teaching and Learning',
    'Short Courses',
  ]; // Dropdown options

  Future<void> _registerTutor() async {
    User? user = _auth.currentUser;
    if (user != null) {
      // Add tutor data to Firestore
      await _firestore.collection('tutors').add({
        'name': firstNameController.text,
        'surname': surnameController.text,
        'email': user.email,
        'studentNumber': studentNumberController.text,
        'faculty': facultyOpt,
        'course': courseController.text,
        'subject': subjectController.text,
        'availability': availability,
      });

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tutor Registered Successfully')),
      );

      // Navigate to AllTutorsPage
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Tutor Registration",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 19, 44, 87),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // First Name TextField
                _buildStyledTextField(
                  label: 'First Name',
                  controller: firstNameController,
                  icon: Icons.person_outline,
                ),
                const SizedBox(height: 10),

                // Surname TextField
                _buildStyledTextField(
                  label: 'Surname',
                  controller: surnameController,
                  icon: Icons.person_outline,
                ),
                const SizedBox(height: 10),

                // Student Number TextField
                _buildStyledTextField(
                  label: 'Student Number',
                  controller: studentNumberController,
                  icon: Icons.school_outlined,
                ),
                const SizedBox(height: 10),

                // Faculty Dropdown
                _buildStyledDropdown(
                  value: facultyOpt,
                  label: 'Faculty',
                  options: facultyOptions,
                  onChanged: (String? newValue) {
                    setState(() {
                      facultyOpt = newValue!;
                    });
                  },
                ),
                const SizedBox(height: 10),

                // Course TextField
                _buildStyledTextField(
                  label: 'Course',
                  controller: courseController,
                  icon: Icons.book_outlined,
                ),
                const SizedBox(height: 10),

                // Subject TextField
                _buildStyledTextField(
                  label: 'Subject',
                  controller: subjectController,
                  icon: Icons.subject_outlined,
                ),
                const SizedBox(height: 10),

                // Availability Dropdown
                _buildStyledDropdown(
                  value: availability,
                  label: 'Availability',
                  options: availabilityOptions,
                  onChanged: (String? newValue) {
                    setState(() {
                      availability = newValue!;
                    });
                  },
                ),
                const SizedBox(height: 20),

                // Register Button with validation
                MyButtons(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      _registerTutor();
                    }
                  },
                  text: "Register as a Tutor",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Custom-styled TextField function
  Widget _buildStyledTextField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    bool isPassword = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          hintText: label,
          hintStyle: const TextStyle(
            color: Colors.black45,
            fontSize: 18,
          ),
          prefixIcon: Icon(icon, color: Colors.black45),
          contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          filled: true,
          fillColor: const Color(0xFFedf0f8), // Background color
          
          // Adding the border
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 1.5), // Visible grey border
            borderRadius: BorderRadius.circular(30), // Rounded corners
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.blue, width: 2), // Blue border when focused
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your $label';
          }
          return null;
        },
      ),
    );
  }

  // Custom-styled DropdownButtonFormField function
  Widget _buildStyledDropdown({
    required String value,
    required String label,
    required List<String> options,
    required ValueChanged<String?> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: const Color(0xFFedf0f8), // Background color
          borderRadius: BorderRadius.circular(30), // Rounded corners
          border: Border.all(color: Colors.grey, width: 1.5), // Border
        ),
        child: DropdownButtonFormField<String>(
          value: value,
          decoration: InputDecoration(
            hintText: label,
            hintStyle: const TextStyle(
              color: Colors.black45,
              fontSize: 18,
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 15),
          ),
          items: options.map((String option) {
            return DropdownMenuItem<String>(
              value: option,
              child: Text(option),
            );
          }).toList(),
          onChanged: onChanged,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select $label';
            }
            return null;
          },
        ),
      ),
    );
  }
}