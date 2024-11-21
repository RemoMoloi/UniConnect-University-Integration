import 'package:flutter/material.dart';
import 'package:uni_connect_2/Widgets/my_buttons.dart';

import '../Tutors_Feature/all_tutors.dart';

class FEBIT_PAGE extends StatelessWidget {
  const FEBIT_PAGE({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FEBIT"),
        backgroundColor: const Color.fromARGB(255, 19, 44, 87),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('assets/images/BHP.jpg'),
            ),
            SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Faculty of Engineering, Built Environment and Information Technology", style: TextStyle(
                fontSize: 30, 
                fontWeight: FontWeight.bold),
                ),
            ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text("The Faculty of Engineering, Built Environment, and Information Technology at CUT offers diverse programs through departments like Civil, Electrical, and Mechanical Engineering, along with Information Technology and Mathematical & Physical Sciences. The faculty emphasizes applied research, industry collaboration, and leadership development, preparing students for careers in engineering, technology, and related fields. It also focuses on sustainable solutions and innovation to address African challenges. More details can be found at CUT Faculty Page.",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
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