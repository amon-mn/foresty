import 'package:flutter/material.dart';
import 'package:foresty/autentication/screens/components/my_button.dart';
import 'package:foresty/autentication/screens/components/my_textfild.dart';
import 'package:foresty/autentication/screens/components/square_tile.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  // text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // sign user in method
  void signUserIn() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 50),
      
                // logo
                const Icon(
                  Icons.forest,
                  size: 150,
                  color: Color.fromARGB(255, 0, 90, 3),
                  ),
                  
                  const SizedBox(height: 80),
      
                // welcome
                const Text(
                  'Bem Vindo!',
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 90, 3),
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
      
                const SizedBox(height: 25),
      
                // username textfield
                MyTextField(
                  controller: usernameController,
                  hintText: 'Digite seu nome de usuário',
                  obscureText: false,
                ),
      
                const SizedBox(height: 10),
      
                // password textfield
                MyTextField(
                  controller: passwordController,
                  hintText: 'Digite sua senha',
                  obscureText: true,
                ),
                
                // forgot password?
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 35.0,
                    vertical: 5.0,
                  ),
                  
                  child: TextButton(
                    onPressed: (){}, 
                    child: Text(
                      'Esqueceu a senha?',
                      style: TextStyle(color: Colors.black),  
                    )
                    ),
                  
                  
                  
                  /*Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Esqueceu a senha?',
                        style: TextStyle(color: Colors.black),
                      )
                    ],
                  ), */
                  ),


      
                // sign in button
                MyButton(
                  onTap: signUserIn,
                ),

                const SizedBox(height: 50),
                

                // or continue with
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'Ou continue com',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),
                
                // google / facebook / yahoo sign in buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // google button
                    SquareTite(imagePath: 'lib/assets/google.png'),

                    const SizedBox(width: 15),

                    // facebook button
                    SquareTite(imagePath: 'lib/assets/facebook.png'),

                    const SizedBox(width: 15),

                    // yahoo button
                    SquareTite(imagePath: 'lib/assets/yahoo.png'),
                 
                  ],
                )
                  
                // not a member? register now
              ],
            ),
          ),
        ),
      ),
    );
  }
}