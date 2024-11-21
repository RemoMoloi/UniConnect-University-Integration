import 'package:flutter/material.dart';

import '../../Widgets/my_buttons.dart';
import '../Tutors_Feature/all_tutors.dart';

class ShortCoursePage extends StatelessWidget {
  const ShortCoursePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Short Courses"),
        backgroundColor: const Color.fromARGB(255, 19, 44, 87),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('assets/images/azure.png'),
            ),
            const SizedBox(height: 15,),
            const Text("Short Courses", style: TextStyle(
              fontSize: 30, 
              fontWeight: FontWeight.bold),
              ),
              const Padding(
                padding: EdgeInsets.all(15.0),
                child: Text("The Central University of Technology (CUT) offers a variety of short courses aimed at enhancing skills across multiple disciplines. These courses cater to both individuals and organizations seeking to improve competencies in areas like business management, IT, and health sciences. Designed for flexibility, they accommodate professionals looking to upskill or change careers, fostering continuous learning and personal development. More details about specific courses, schedules, and registration can be found on their website. For more information, visit CUT Short Courses.",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                ),
              ),
              MyButtons(
                  onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> AllTutorsPage())); }, 
                  text: "View Tutors", 
                ),
          ],
        ),
      ),
    );
  }
}