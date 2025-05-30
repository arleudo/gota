import 'package:flutter/material.dart';
import 'package:gota/components/g_login_button.dart';
import 'package:gota/components/g_text_field.dart';
import 'package:gota/screens/home.dart';
import 'package:gota/services/auth_service.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  Color colorPrimary = const Color.fromARGB(255, 81, 180, 86);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final AuthService _authService = AuthService();

  Future<void> login() async {
    final email = emailController.text;
    final password = passwordController.text;

    final success = await _authService.login(email, password);

    if (success != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login bem-sucedido'),
          backgroundColor: colorPrimary,
        ),
      );

      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const Home(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Email ou senha inválidos'),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: colorPrimary,
        title: const Text("G.O.T.A.", style: TextStyle(color: Colors.white)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 40),
                const Image(
                  image: AssetImage("assets/gota.png"),
                  width: 200,
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: [
                      GTextField(labelText: "Email", controller: emailController),
                      const SizedBox(height: 20),
                      GTextField(
                        labelText: "Senha",
                        controller: passwordController,
                        obscureText: true,
                      ),
                      TextButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Funcionalidade ainda não implementada')),
                          );
                        },
                        child: const Text(
                          "Esqueceu sua senha?",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                      const SizedBox(height: 20),
                      GLoginButton(onPressed: login),
                      const SizedBox(height: 40),

                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white,
                                foregroundColor: Colors.black87,
                                elevation: 1,
                                padding: const EdgeInsets.symmetric(vertical: 12), // altura reduzida
                                side: const BorderSide(color: Colors.grey),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              icon: Image.asset('assets/google.png', height: 20),
                              label: const Text("Google", style: TextStyle(fontSize: 14)),
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Login com Google ainda não implementado')),
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue[800],
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              icon: const Icon(Icons.facebook, size: 20),
                              label: const Text("Facebook", style: TextStyle(fontSize: 14)),
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Login com Facebook ainda não implementado')),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
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

