import 'package:flutter/material.dart';
import 'package:one_byte_foods/nav/homepage.dart';
import 'package:one_byte_foods/nav/navigatorpage.dart';
import 'package:one_byte_foods/services/auth_service.dart';
import 'package:one_byte_foods/user/signup.dart';

class UserLogin extends StatefulWidget {
  const UserLogin({super.key});

  @override
  State<UserLogin> createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Log In"),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/logo.png",
                height: size.height * 0.2,
              ),
              const Text("One Byte Foods",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  )),
              const Text("Where Every Flavor Tells A Story",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 50),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextFormField(
                  controller: email,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      labelText: "Email"),
                ),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextFormField(
                  controller: pass,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      labelText: "Password"),
                  obscureText: true,
                ),
              ),
              const SizedBox(height: 10),
              InkWell(
                child: const Text(
                  "Forgot password?",
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () async {
                  await AuthService.resetPass(email: email.text);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      duration: Duration(milliseconds: 500),
                      content: Text("Reset password ink sent to your email!")));
                },
              ),
              const SizedBox(height: 10),
              SizedBox(
                  width: 200,
                  child: ElevatedButton(
                      onPressed: () async {
                        String status = await AuthService.logInWithEmailAndPass(
                            email: email.text, pass: pass.text);
                        print(status);
                        if (status == "log") {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: Text("Logged In Successfully!"),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        MyWidget()));
                                          },
                                          child: Text("Ok!"))
                                    ],
                                  ));
                        } else if (status == "user-not-found") {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: Text(
                                      "User Not Found!!",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text("Ok!"))
                                    ],
                                  ));
                        } else if (status == "wrong-password") {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: Text(
                                      "Wront Password!!",
                                      style: TextStyle(color: Colors.red),
                                    ),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text("Ok!"))
                                    ],
                                  ));
                        }
                      },
                      child: const Text("Log In"))),
              SizedBox(
                height: size.height * 0.02,
              ),
              Text("or"),
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
              SizedBox(
                height: size.height * 0.02,
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const UserSignUp()));
                  },
                  child: const Text(
                    "Dont have an account? Sign Up",
                    style: TextStyle(color: Colors.blue),
                  ))
            ],
          ),
        ));
  }
}
