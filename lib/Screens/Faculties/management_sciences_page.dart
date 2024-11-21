import 'package:flutter/material.dart';

import '../../Widgets/my_buttons.dart';
import '../Tutors_Feature/all_tutors.dart';

class ManagementPage extends StatelessWidget {
  const ManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Management Sciences"),
        backgroundColor: const Color.fromARGB(255, 19, 44, 87),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('assets/images/management.png'),
            ),
            const SizedBox(height: 15,),
            const Text("Faculty of Humanities", style: TextStyle(
              fontSize: 30, 
              fontWeight: FontWeight.bold),
              ),
              const Padding(
                padding: EdgeInsets.all(15.0),
                child: Text("The Faculty of Management Sciences at CUT provides vocational education across various disciplines, including Accounting, Business Management, Hospitality Management, and Public Management. It emphasizes practical training, enabling students to develop the skills necessary for the job market. The faculty boasts a high employment rate among graduates and offers postgraduate opportunities like MTech and DTech degrees. The curriculum is designed to meet industry needs, preparing students for successful careers in their chosen fields. For more details, visit the CUT Faculty of Management Sciences page.",
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