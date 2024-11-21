import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Central University of Technology"),
        backgroundColor: const Color.fromARGB(255, 19, 44, 87),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/images/cut.png'),
          ),
          SizedBox(height: 15,),
          Text("About CUT", style: TextStyle(
            fontSize: 30, 
            fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text("The Central University of Technology (CUT), with campuses in Bloemfontein and Welkom, is a prominent institution in South Africa. It offers diverse programs through four faculties: Engineering, Built Environment and Information Technology; Health and Environmental Sciences; Humanities; and Management Sciences. These faculties provide a range of qualifications, from diplomas to postgraduate degrees, emphasizing work-integrated learning to prepare students for real-world professional challenges. CUT aims to be a leading African University of Technology by 2030, focusing on innovation and socio-economic impact, addressing the needs of the continent through education and technological solutions",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
            )
        ],
      ),
    );
  }
}