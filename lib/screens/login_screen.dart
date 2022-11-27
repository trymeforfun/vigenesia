import 'package:another_flushbar/flushbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'Register.dart';
import 'package:flutter/gestures.dart';
import 'package:vigenesia/constant/const.dart';
import 'package:vigenesia/models/login_model.dart';
import 'package:vigenesia/screens/main_screen.dart';
import 'dart:convert';

import 'package:vigenesia/screens/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String nama;
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();

  Future<LoginModel> postLogin(String email, String password) async {
    var dio = Dio();
    String baseurl = url;
    print("$baseurl/vigenesia/api/login/");
    Map<String, dynamic> data = {"email": email, "password": password};
    try {
      final response = await dio.post("$baseurl/vigenesia/api/login/",
          data: data,
          options: Options(headers: {'Content-type': 'application/json'}));
      print("Respon -> ${response.data} + ${response.statusCode}");
      if (response.statusCode == 200) {
        final loginModel = LoginModel.fromJson(response.data);
        return loginModel;
      }
    } catch (e) {
      print("Failed To Load ${e.toString()}");
    }
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Login Area",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 50,
              ),
              Center(
                child: Form(
                  key: _fbKey,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 1.3,
                    child: Column(
                      children: [
                        FormBuilderTextField(
                          name: "email",
                          controller: emailController,
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(left: 10),
                              border: OutlineInputBorder(),
                              labelText: "Email"),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FormBuilderTextField(
                          obscureText:
                              true, // <-- Buat bikin setiap inputan jadi bintang " * "
                          name: "password",
                          controller: passwordController,
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.only(left: 10),
                              border: OutlineInputBorder(),
                              labelText: "Password"),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text.rich(
                          TextSpan(
                            children: [
                              const TextSpan(
                                text: "Dont Have Account ?",
                                style: TextStyle(color: Colors.black54),
                              ),
                              TextSpan(
                                  text: "Sign Up",
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  const RegisterScreen()));
                                    },
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.blueAccent,
                                  ))
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                              onPressed: () async {
                                await postLogin(emailController.text,
                                        passwordController.text)
                                    .then(
                                  (value) => {
                                    if (value != null)
                                      {
                                        setState(() {
                                          nama = value.data.nama;
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          MainScreen(
                                                            idUser: value
                                                                .data.iduser,
                                                            nama: nama,
                                                          )));
                                        })
                                      }
                                    else if (value == null)
                                      {
                                        Flushbar(
                                          message:
                                              "Check Your Email / Password",
                                          duration: const Duration(seconds: 5),
                                          backgroundColor: Colors.redAccent,
                                          flushbarPosition:
                                              FlushbarPosition.TOP,
                                        ).show(context)
                                      }
                                  },
                                );
                              },
                              child: const Text("Sign In")),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
