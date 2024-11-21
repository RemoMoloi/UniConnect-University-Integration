// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uni_connect_2/Widgets/my_buttons.dart';

class FAQPage extends StatefulWidget {
  @override
  _FAQPageState createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {
  final TextEditingController questionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Frequently Asked Questions",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color.fromARGB(255, 19, 44, 87),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // FAQ List
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection('faq').snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var faq = snapshot.data!.docs[index];
                      return _buildFAQItem(
                        question: faq['question'],
                        answer: faq['answer'] ?? 'Awaiting answer...',
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 16),

            // Ask Question Section
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFedf0f8),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.grey, width: 1.5),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: questionController,
                decoration: const InputDecoration(
                  labelText: 'Ask a question',
                  labelStyle: TextStyle(color: Colors.black54, fontSize: 16),
                  border: InputBorder.none,
                  icon: Icon(Icons.question_answer_outlined, color: const Color.fromARGB(255, 19, 44, 87)),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Submit Button
            MyButtons(
              onTap: () {
                if (questionController.text.isNotEmpty) {
                  FirebaseFirestore.instance.collection('faq').add({
                    'question': questionController.text,
                    'answer': null, // Admin will answer later
                  });
                  questionController.clear();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Question submitted')),
                  );
                }
              },
              text: "Submit",
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildFAQItem({required String question, required String answer}) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Question styling
            Text(
              question,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 19, 44, 87),
              ),
            ),
            const SizedBox(height: 8),
            // Answer styling
            Text(
              answer,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
                height: 1.5, // Line height for better readability
              ),
            ),
          ],
        ),
      ),
    );
  }
}