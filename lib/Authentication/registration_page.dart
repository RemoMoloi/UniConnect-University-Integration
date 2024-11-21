import 'package:flutter/material.dart';
import 'package:uni_connect_2/Screens/Home_Page/home_page.dart';
import 'package:uni_connect_2/Widgets/my_buttons.dart';
import 'package:uni_connect_2/Widgets/text_field.dart';

import '../Widgets/snackbar.dart';
import 'Services/authentication.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  //controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  bool isLoading = false;

  void signupUser() async {
    // set is loading to true.
    setState(() {
      isLoading = true;
    });
    // signup user using our authmethod
    String res = await AuthMethod().signupUser(
        email: emailController.text,
        password: passwordController.text,
        name: nameController.text);
    // if string return is success, user has been creaded and navigate to next screen other witse show error.
    if (res == "success") {
      setState(() {
        isLoading = false;
      });
      //navigate to the next screen
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    } else {
      setState(() {
        isLoading = false;
      });
      // show error
      showSnackBar(context, res);
    }
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    surnameController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: SizedBox(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: height / 2.7,
                //Add Image
                child: Image.asset('assets/images/cut.jpg'),
              ),
              const Text(
                "Register for UniConnect",
                style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                ),),
              SizedBox(height: 18,),
              TextFieldInput(
                Text: 'Enter your name', 
                textEditingController: nameController, 
                icon: Icons.person,
              ),
              TextFieldInput(
                Text: 'Enter your surname', 
                textEditingController: surnameController, 
                icon: Icons.family_restroom,
              ),
              TextFieldInput(
                Text: 'Enter your email address', 
                textEditingController: emailController, 
                icon: Icons.email,
              ),
              //SizedBox(height: 5,),
              TextFieldInput(
                Text: 'Enter your password', 
                textEditingController: passwordController, 
                icon: Icons.lock,
                isPassword: true,
              ), 
              MyButtons(onTap: signupUser, text: "Register"),
              SizedBox(height: 30,),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Align(child: Text('Already have an account ? Log in', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 19),),
                ),
              ),
            ],
          ),
        ),
     ),),
    );
  }
}