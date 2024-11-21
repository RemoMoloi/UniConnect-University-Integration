import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'even_creation.dart'; // Ensure this path is correct

class EventsPage extends StatefulWidget {
  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  @override
  void initState() {
    super.initState();
    _deletePastEvents(); // Check for and delete past events when the page loads
  }

  Future<void> _deletePastEvents() async {
    DateTime now = DateTime.now(); // Get the current date

    // Query events that are in the past
    QuerySnapshot pastEvents = await FirebaseFirestore.instance
        .collection('events')
        .where('date', isLessThan: now)
        .get();

    // Delete each past event
    for (var event in pastEvents.docs) {
      await FirebaseFirestore.instance.collection('events').doc(event.id).delete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('events')
                    .orderBy('date')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  var events = snapshot.data!.docs;

                  if (events.isEmpty) {
                    return const Center(child: Text("No Upcoming Events", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)));
                  }

                  return ListView.builder(
                    itemCount: events.length,
                    itemBuilder: (context, index) {
                      var event = events[index];
                      Map<String, dynamic>? eventData = event.data() as Map<String, dynamic>?;

                      if (eventData == null || !eventData.containsKey('start_time')) {
                        return const Center(child: Text("No Event Data Available"));
                      }

                      return EventCard(
                        title: eventData['title'] ?? 'No title',
                        description: eventData['description'] ?? 'No description',
                        startTime: eventData['start_time'],
                        endTime: eventData['end_time'],
                        date: eventData['date'],
                        location: eventData['location'] ?? 'No location',
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EventCreationPage()),
          );
        },
        backgroundColor: const Color.fromARGB(255, 19, 44, 87),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  final String title;
  final String description;
  final Timestamp startTime;
  final Timestamp endTime;
  final Timestamp date;
  final String location;

  const EventCard({
    Key? key,
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.date,
    required this.location,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 19, 44, 87),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 12),
            _buildInfoRow(Icons.location_on, location, Colors.red),
            _buildInfoRow(Icons.calendar_today, 'Date: ${DateFormat.yMMMMd().format(date.toDate())}', Colors.blue),
            _buildInfoRow(Icons.access_time, 'Start: ${DateFormat.jm().format(startTime.toDate())}', Colors.green),
            _buildInfoRow(Icons.access_time, 'End: ${DateFormat.jm().format(endTime.toDate())}', Colors.orange),
          ],
        ),
      ),
    );
  }

  Row _buildInfoRow(IconData icon, String text, Color iconColor) {
    return Row(
      children: [
        Icon(icon, color: iconColor),
        const SizedBox(width: 8),
        Expanded(child: Text(text, style: const TextStyle(fontSize: 16))),
      ],
    );
  }
}
