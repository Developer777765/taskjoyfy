import 'package:flutter/material.dart';
import 'package:flutter_application_1/database.dart';
import 'package:flutter_application_1/forgotPassword.dart';
import 'package:flutter_application_1/home.dart';
import 'package:flutter_application_1/signup.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LogIn(),
      routes: {
        '/SignUp': (context) {
          return SignUp();
        },
        '/HomePage': (context) {
          return HomePage();
        },
        '/LogIn': (context) {
          return LogIn();
        },
        '/PasswordRecovery': (context) {
          return PasswordRecovery();
        },
      },
    );
  }
}

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() {
    return LogInState();
  }
}

class LogInState extends State<LogIn> {
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerPass = TextEditingController();
  bool navigate = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          'Login',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 130,
            ),
            Row(
              children: [
                Expanded(child: Container()),
                Container(
                  width: MediaQuery.of(context).size.width - 100,
                  child: TextField(
                    controller: controllerName,
                    decoration: InputDecoration(hintText: 'User name'),
                  ),
                ),
                Expanded(child: Container()),
              ],
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Expanded(child: Container()),
                Container(
                  width: MediaQuery.of(context).size.width - 100,
                  child: TextField(
                    controller: controllerPass,
                    decoration: InputDecoration(hintText: 'Password'),
                  ),
                ),
                Expanded(child: Container()),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              child: const Text(
                'Forgot password?',
                style: TextStyle(color: Colors.blue),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/PasswordRecovery');
              },
            ),
            const SizedBox(
              height: 40,
            ),
            GestureDetector(
              child: Container(
                width: 220,
                child: Center(
                    child: Text(
                  'Sign Up',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                )),
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(15)),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/SignUp');
              },
            ),
            const SizedBox(
              height: 40,
            ),
            GestureDetector(
              child: Container(
                width: 220,
                child: Center(
                    child: Text(
                  'Login',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                )),
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(15)),
              ),
              onTap: () async {
                //print('inside function');
                // List<Map<String,Object?>> data = await DatabaseHelper().queryFromTable();
                //print(data);
                String value = 'passwordsss';
                print(value.substring(0, 1));
                var name = controllerName.text;
                var pass = controllerPass.text;
                var authorizedUser;
                if (name.isNotEmpty) {
                  if (pass.isNotEmpty) {
                    List<Map<String, Object?>> data =
                        await DatabaseHelper().queryFromTable();
                    for (int i = 0; i < data.length; i++) {
                      if (data[i]['name'] == name &&
                          data[i]['password'] == pass) {
                        authorizedUser = data[i]['name'];
                        navigate = true;
                        break;
                      }
                    }
                    if (navigate) {
                      // Navigator.popAndPushNamed(context, '/HomePage');
                      
                      Navigator.popAndPushNamed(context, '/HomePage',arguments: authorizedUser);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Wrong credentials')));
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Give the necessary details')));
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Give the necessary details')));
                }
              },
            ),
            SizedBox(
              height: 30,
            ),
            // Row(children: [Image.asset('assets/images/instalogo.jpg',height: 50,width: 50,),SizedBox(width: 15,),Image.asset('assets/images/book.jpg',height: 50,width: 50,)],),
          ],
        ),
      ),
    );
  }
}
