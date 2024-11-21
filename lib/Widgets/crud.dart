// import 'package:firebase_auth/firebase_auth.dart'; // Ensure Firebase Auth is added

// void _addEvent() async {
//   User? user = FirebaseAuth.instance.currentUser;
//   if (user != null) {
//     String userId = user.uid; // Get the currently logged-in user's UID

//     String title = _titleController.text;
//     String description = _descriptionController.text;
//     String location = _locationController.text;
//     String date = _dateController.text;
//     String startTime = _startTimeController.text;
//     String endTime = _endTimeController.text;

//     if (title.isNotEmpty &&
//         description.isNotEmpty &&
//         location.isNotEmpty &&
//         date.isNotEmpty &&
//         startTime.isNotEmpty &&
//         endTime.isNotEmpty) {
//       FirebaseFirestore.instance.collection('events').add({
//         'title': title,
//         'description': description,
//         'location': location,
//         'date': DateTime.parse(date),
//         'start_time': DateFormat('HH:mm').parse(startTime),
//         'end_time': DateFormat('HH:mm').parse(endTime),
//         'created_by': userId, // Save the user ID of the event creator
//         'created_at': Timestamp.now(),
//       });

//       _titleController.clear();
//       _descriptionController.clear();
//       _locationController.clear();
//       _dateController.clear();
//       _startTimeController.clear();
//       _endTimeController.clear();

//       setState(() {
//         _isFormVisible = false; // Hide the form after adding the event
//       });
//     }
//   }
// }
