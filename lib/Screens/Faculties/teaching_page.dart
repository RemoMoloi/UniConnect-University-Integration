import 'package:flutter/material.dart';

import '../../Widgets/my_buttons.dart';
import '../Tutors_Feature/all_tutors.dart';

class TeachingPage extends StatelessWidget {
  const TeachingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Teaching and Learning"),
        backgroundColor: const Color.fromARGB(255, 19, 44, 87),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/images/support.jpg'),
          ),
          const SizedBox(height: 15,),
          const Text("Faculty of Teaching and Learing", style: TextStyle(
            fontSize: 25, 
            fontWeight: FontWeight.bold),
            ),
            const Padding(
              padding: EdgeInsets.all(20.0),
              child: Text("The Faculty of Teaching and Learning at CUT focuses on enhancing educational practices through innovative teaching strategies and pedagogical research. It comprises departments like the Centre for Innovation in Learning and Teaching (CILT) and the Disability Unit, aiming to improve the learning experience for all students. The faculty emphasizes quality education and integrates technology to foster an inclusive academic environment, supporting both faculty and student development. For more details, visit the CUT Faculty of Teaching and Learning.",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
            ),
            MyButtons(
                onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> AllTutorsPage())); }, 
                text: "View Tutors", 
              ),
        ],
      ),
    );
  }
}