import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'tutors.dart'; // Import your TutorPage

class AllTutorsPage extends StatefulWidget {
  @override
  _AllTutorsPageState createState() => _AllTutorsPageState();
}

class _AllTutorsPageState extends State<AllTutorsPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String searchQuery = '';
  late Future<List<Map<String, dynamic>>> _tutorsFuture;

  @override
  void initState() {
    super.initState();
    _tutorsFuture = _fetchTutors();
  }

  // This method retrieves the tutors from Firestore
  Future<List<Map<String, dynamic>>> _fetchTutors() async {
    QuerySnapshot snapshot = await _firestore.collection('tutors').get();
    return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }

  Future<void> _refreshTutors() async {
    setState(() {
      _tutorsFuture = _fetchTutors();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'All Tutors',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 19, 44, 87),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Bar
            TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value.toLowerCase();
                });
              },
              decoration: InputDecoration(
                labelText: 'Search by Faculty',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.search, color: const Color.fromARGB(255, 19, 44, 87)),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            const SizedBox(height: 20),

            // Expanded GridView inside RefreshIndicator
            Expanded(
              child: RefreshIndicator(
                onRefresh: _refreshTutors, // Refresh method
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: _tutorsFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text('No tutors available.'));
                    }

                    final tutors = snapshot.data!;
                    // Filter tutors based on the search query
                    final filteredTutors = tutors.where((tutor) {
                      final faculty = tutor['faculty']?.toLowerCase() ?? '';
                      return faculty.contains(searchQuery);
                    }).toList();

                    return GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.9,
                      ),
                      itemCount: filteredTutors.length,
                      itemBuilder: (context, index) {
                        final tutor = filteredTutors[index];
                        return TutorCard(tutor: tutor);
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TutorPage()),
          );
        },
        backgroundColor: const Color.fromARGB(255, 19, 44, 87),
        child: const Icon(Icons.add),
        tooltip: 'Register as Tutor',
      ),
    );
  }
}

class TutorCard extends StatelessWidget {
  final Map<String, dynamic> tutor;

  TutorCard({required this.tutor});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: 'Name: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black),
                  ),
                  TextSpan(
                    text: '${tutor['name'] ?? 'N/A'}',
                    style: const TextStyle(
                      fontWeight: FontWeight.normal, fontSize: 13, color: Colors.black),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: 'Email: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black),
                  ),
                  TextSpan(
                    text: '${tutor['email'] ?? 'N/A'}',
                    style: const TextStyle(
                      fontWeight: FontWeight.normal, fontSize: 13, color: Colors.black),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: 'Faculty: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black),
                  ),
                  TextSpan(
                    text: '${tutor['faculty'] ?? 'N/A'}',
                    style: const TextStyle(
                      fontWeight: FontWeight.normal, fontSize: 13, color: Colors.black),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: 'Course: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black),
                  ),
                  TextSpan(
                    text: '${tutor['course'] ?? 'N/A'}',
                    style: const TextStyle(
                      fontWeight: FontWeight.normal, fontSize: 13, color: Colors.black),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: 'Key Module: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black),
                  ),
                  TextSpan(
                    text: '${tutor['subject'] ?? 'N/A'}',
                    style: const TextStyle(
                      fontWeight: FontWeight.normal, fontSize: 13, color: Colors.black),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: 'Availability: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black),
                  ),
                  TextSpan(
                    text: '${tutor['availability'] ?? 'N/A'}',
                    style: const TextStyle(
                      fontWeight: FontWeight.normal, fontSize: 13, color: Colors.black),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}