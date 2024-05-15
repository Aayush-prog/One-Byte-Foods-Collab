import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:one_byte_foods/nav/navigatorpage.dart';
import 'package:one_byte_foods/services/auth_service.dart';
import 'package:one_byte_foods/user/login.dart';

class UserSignUp extends StatefulWidget {
  const UserSignUp({super.key});

  @override
  State<UserSignUp> createState() => _UserSignUpState();
}

class _UserSignUpState extends State<UserSignUp> {
  TextEditingController username = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPwd = TextEditingController();
  Future<void> authenticateWithEmailAndPass() async {
    AuthService.register(
        email: email.text, pass: password.text, fullname: username.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Sign Up"),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.all(20),
                child: TextField(
                  controller: username,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      hintText: "Username",
                      prefixIcon: Icon(Icons.person)),
                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
                child: TextField(
                  controller: email,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      hintText: "Email",
                      prefixIcon: Icon(Icons.mail)),
                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
                child: TextField(
                  controller: password,
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      hintText: "Password",
                      prefixIcon: Icon(Icons.key)),
                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
                child: TextField(
                  controller: confirmPwd,
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      hintText: "Confirm Password",
                      prefixIcon: Icon(Icons.key)),
                ),
              ),
              Container(
                child: ElevatedButton(
                  child: Text("Sign Up"),
                  onPressed: () {
                    if (password.text == confirmPwd.text) {
                      print('equal');
                      authenticateWithEmailAndPass();
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text("Signed Up successfully"),
                                content:
                                    Text("Thank you signing up!Happy eating"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => UserLogin(),
                                            ));
                                      },
                                      child: Text("OK!"))
                                ],
                              ));
                    } else {
                      print('not equal');
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text("Password do not match!"),
                                content: Text(
                                    "Your password and confirm password donot seem to be aligning with each other!"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("OK!"))
                                ],
                              ));
                    }
                  },
                ),
              ),
              Text("or"),
              Text("Sign Up with"),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    child: Image.asset(
                      "assets/images/google.png",
                      height: 80,
                      width: 80,
                    ),
                    onTap: () async {
                      await AuthService.signInWithGoogle();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MyWidget()));
                    },
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UserLogin()));
                },
                child: const Text("Already have an account? Log In"),
              ),
            ],
          ),
        ));
  }
}
