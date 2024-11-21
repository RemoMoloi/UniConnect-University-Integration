import 'package:flutter/material.dart';
import 'package:uni_connect_2/Screens/Tutors_Feature/all_tutors.dart';

import '../../Widgets/my_buttons.dart';

class HumanitiesPage extends StatelessWidget {
  const HumanitiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Humanities"),
        backgroundColor: const Color.fromARGB(255, 19, 44, 87),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/images/humanities.png'),
          ),
          const SizedBox(height: 15,),
          const Text("Faculty of Humanities", style: TextStyle(
            fontSize: 30, 
            fontWeight: FontWeight.bold),
            ),
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text("The Faculty of Humanities at CUT comprises six departments: Communication Sciences, Design and Studio Art, Mathematics, Science and Technology Education, Language and Social Sciences Education, Educational and Professional Studies, and Post Graduate Studies: Education. It offers a range of qualifications from Diplomas to Doctoral degrees, focusing on career-oriented education. Initial teacher qualifications include a four-year Bachelor of Education. The faculty emphasizes research and innovative practices in humanities disciplines. For more information, you can visit the CUT Faculty of Humanities page.",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
            ),
            MyButtons(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> AllTutorsPage())); 
                }, 
                text: "View Tutors",              
              ),
        ],
      ),
    );
  }
}