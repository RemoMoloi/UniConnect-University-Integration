// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:uni_connect_2/Screens/Faculties/febit_page.dart';
import 'package:uni_connect_2/Screens/Faculties/health_page.dart';
import 'package:uni_connect_2/Screens/Faculties/humanities_page.dart';
import 'package:uni_connect_2/Screens/Faculties/management_sciences_page.dart';
import 'package:uni_connect_2/Screens/Faculties/short_courses_page.dart';
import 'package:uni_connect_2/Screens/Faculties/teaching_page.dart';
import 'package:uni_connect_2/Screens/Event_Feature/event_page.dart';
import 'package:uni_connect_2/Screens/Profile_Feature/profile_page.dart';
import '../Guide/map_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  // List of pages for navigation
  List<Widget> _pages = [
    HomeGrid(),           // Faculties grid
    GuidePage(),         // Campus map page
    EventsPage(),        // Social events page
    const ProfilePage(), // Profile page
  ];

  // Function to handle tab selection
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "UniConnect",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 19, 44, 87),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Faculties',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Campus Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'Events',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: const Color.fromARGB(255, 19, 44, 87),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}

class HomeGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            FacultyRow(
              title: 'HUMANITIES',
              icon: Icons.book,
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const HumanitiesPage()));
              },
              gradientColors: [Color(0xFFFDC830), Color(0xFFF37335)], // vibrant orange gradient
            ),
            const SizedBox(height: 20),
            FacultyRow(
              title: 'HEALTH AND ENVIRONMENTAL SCIENCES',
              icon: Icons.science,
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const HealthPage()));
              },
              gradientColors: [Color(0xFF004d00), Color(0xFF009933)], // darker green gradient
            ),
            const SizedBox(height: 20),
            FacultyRow(
              title: 'MANAGEMENT SCIENCES',
              icon: Icons.business,
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const ManagementPage()));
              },
              gradientColors: [Color(0xFFeb3349), Color(0xFFf45c43)], // bold red gradient
            ),
            const SizedBox(height: 20),
            FacultyRow(
              title: 'Faculty of Engineering, Built Environment and Information Technology',
              icon: Icons.computer,
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const FEBIT_PAGE()));
              },
              gradientColors: [Color(0xFF00c6ff), Color(0xFF0072ff)], // cool blue gradient
            ),
            const SizedBox(height: 20),
            FacultyRow(
              title: 'TEACHING AND LEARNING',
              icon: Icons.school,
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const TeachingPage()));
              },
              gradientColors: [Color(0xFF654ea3), Color(0xFFeaafc8)], // soft purple gradient
            ),
            const SizedBox(height: 20),
            FacultyRow(
              title: 'SHORT COURSES',
              icon: Icons.medical_services,
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const ShortCoursePage()));
              },
              gradientColors: [Color(0xFF4b4b4b), Color(0xFF000000)], // sleek grey-black gradient
            ),
          ],
        ),
      ),
    );
  }
}

class FacultyRow extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function()? onTap;
  final List<Color> gradientColors;

  const FacultyRow({
    required this.title,
    required this.icon,
    required this.onTap,
    required this.gradientColors,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ListTile(
          leading: Icon(
            icon,
            color: Colors.white,
            size: 40,
          ),
          title: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: const Text(
            'Explore',
            style: TextStyle(
              color: Colors.white70,
            ),
          ),
        ),
      ),
    );
  }
}
