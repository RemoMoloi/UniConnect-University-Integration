// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:uni_connect_2/Authentication/registration_page.dart';
import 'package:uni_connect_2/Screens/Home_Page/home_page.dart';
import 'package:uni_connect_2/Widgets/my_buttons.dart';
import 'package:uni_connect_2/Widgets/snackbar.dart';
import 'package:uni_connect_2/Widgets/text_field.dart';
import 'Services/authentication.dart';
import 'Services/google_auth.dart';
import 'forgot_password.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      isLoading = true;
    });
    String res = await AuthMethod().loginUser(
      email: emailController.text, password: passwordController.text
    );

    if (res == "success"){
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context)=> HomePage(),
        )
      );
    } else {
      setState(() {
        isLoading = false;
      });
      showSnackBar(context, res);
    }
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
              Center(
                child: SizedBox(
                  width: double.infinity,
                  height: height / 2.7,
                  child: Image.asset('assets/images/cut.jpg'),
                ),
              ),
              const Text(
                "Welcome to UniConnect",
                style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                ),),
                SizedBox(height: 18,),
              TextFieldInput(
                Text: 'Enter your email address', 
                textEditingController: emailController, 
                icon: Icons.email,
              ),
              TextFieldInput(
                Text: 'Enter your password', 
                textEditingController: passwordController, 
                icon: Icons.lock,
                isPassword: true,
              ),
              SizedBox(height: 5,),
              GestureDetector(
                onTap: (){
                  Navigator.push(context, 
                  MaterialPageRoute(
                    builder: (context)=> ForgotPasswordPage() 
                    ));
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal:35),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text('Forgot your password ?',style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.blue,
                  ),
                  ),
                  ),
                ),
              ),
              SizedBox(height: 5,),
              MyButtons(onTap: loginUser, text: "Log In"),
              SizedBox(height: 15,),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegistrationPage()),
              );
              },
                child: const Align(child: Text('Not registered yet ? Create an account', style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Colors.blue),),
                ),
              ),
              SizedBox(height: 5,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: const Color.fromARGB(255, 19, 44, 87)),
                  onPressed: () async {
                    await FirebaseServices().signInWithGoogle();
                    Navigator.pushReplacement(context, 
                    MaterialPageRoute(
                      builder: (context) => HomePage()
                      ));
                  },
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        // child:Image.network(
                        //   "https://ouch-cdn2.icons8.com/VGHyfDgzIiyEwg3RIll1nYupfj653vnEPRLr0AeoJ8g/rs:fit:456:456/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9wbmcvODg2/LzRjNzU2YThjLTQx/MjgtNGZlZS04MDNl/LTAwMTM0YzEwOTMy/Ny5wbmc.png",
                        //   height: 35,
                        // ),
                      ),
                     const SizedBox(width: 10),
                      const Text(
                        "Continue with Google",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
     ),
    );
  }
}