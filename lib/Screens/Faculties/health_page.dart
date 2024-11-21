import 'package:flutter/material.dart';

import '../../Widgets/my_buttons.dart';
import '../Tutors_Feature/all_tutors.dart';

class HealthPage extends StatelessWidget {
  const HealthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Health & Environmental Sciences"),
        backgroundColor: const Color.fromARGB(255, 19, 44, 87),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('assets/images/health.png'),
            ),
            const SizedBox(height: 15,),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Faculty of Health and Environmental Sciences", style: TextStyle(
                fontSize: 30, 
                fontWeight: FontWeight.bold),
                ),
            ),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Text("The Faculty of Health and Environmental Sciences at CUT includes the Departments of Agriculture, Clinical Sciences, Health Sciences, and Life Sciences. It offers a range of qualifications from National Diplomas to BTech and postgraduate degrees. The faculty emphasizes practical learning, research engagement, and community service, aiming to equip students with the skills needed for careers in health and environmental sectors. Students are encouraged to participate in various research initiatives to address health challenges and promote sustainable practices. For more information, visit the CUT Faculty of Health and Environmental Sciences page.",
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