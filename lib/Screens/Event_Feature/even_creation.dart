import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uni_connect_2/Widgets/my_buttons.dart';
import 'package:uni_connect_2/Widgets/text_field.dart';

class EventCreationPage extends StatelessWidget {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Event', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        backgroundColor: const Color.fromARGB(255, 19, 44, 87),
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFieldInput(
                Text: "Event Title",
                textEditingController: _titleController,
                icon: Icons.label_important,
              ),
              const SizedBox(height: 15),
              TextFieldInput(
                Text: "Event Description",
                textEditingController: _descriptionController,
                icon: Icons.description,
              ),
              const SizedBox(height: 15),
              TextFieldInput(
                Text: "Event Location",
                textEditingController: _locationController,
                icon: Icons.location_on,
              ),
              const SizedBox(height: 15),
              TextField(
                controller: _dateController,
                decoration: InputDecoration(
                  labelText: 'Event Date (YYYY-MM-DD)',
                  labelStyle: const TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 16,
                  ),
                  prefixIcon: const Icon(Icons.calendar_today, color: Colors.blueGrey),
                  contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey, width: 1.5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.blueGrey, width: 2.0),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: const Color(0xFFedf0f8),
                ),
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null) {
                    _dateController.text = DateFormat('yyyy-MM-dd').format(pickedDate);
                  }
                },
              ),
              const SizedBox(height: 15),
              TextFieldInput(
                Text: "Start Time (HH:MM)",
                textEditingController: _startTimeController,
                icon: Icons.access_time,
              ),
              const SizedBox(height: 15),
              TextFieldInput(
                Text: "End Time (HH:MM)",
                textEditingController: _endTimeController,
                icon: Icons.access_time_outlined,
              ),
              const SizedBox(height: 30),
              MyButtons(
                onTap: () => _addEvent(context),
                 text: "Add Event")
            ],
          ),
        ),
      ),
    );
  }

  void _addEvent(BuildContext context) async {
    String title = _titleController.text;
    String description = _descriptionController.text;
    String location = _locationController.text;
    String date = _dateController.text;
    String startTime = _startTimeController.text;
    String endTime = _endTimeController.text;

    if (title.isNotEmpty &&
        description.isNotEmpty &&
        location.isNotEmpty &&
        date.isNotEmpty &&
        startTime.isNotEmpty &&
        endTime.isNotEmpty) {
      try {
        await FirebaseFirestore.instance.collection('events').add({
          'title': title,
          'description': description,
          'location': location,
          'date': DateTime.parse(date),
          'start_time': DateFormat('HH:mm').parse(startTime),
          'end_time': DateFormat('HH:mm').parse(endTime),
          'created_at': Timestamp.now(),
        });

        // Clear the fields
        _titleController.clear();
        _descriptionController.clear();
        _locationController.clear();
        _dateController.clear();
        _startTimeController.clear();
        _endTimeController.clear();

        // Show a confirmation message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Event added successfully!')),
        );

        // Navigate back to the previous page
        Navigator.pop(context);
      } catch (e) {
        // Show error message if event could not be added
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add event: $e')),
        );
      }
    } else {
      // Show a warning if fields are empty
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields')),
      );
    }
  }
}
