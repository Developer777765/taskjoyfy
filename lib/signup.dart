import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/database.dart';

class SignUp extends StatefulWidget {
  @override
  State<SignUp> createState() {
    return SignUpState();
  }
}

class SignUpState extends State<SignUp> {
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  TextEditingController controllerMail = TextEditingController();
  TextEditingController controllerDate = TextEditingController();
  TextEditingController controllerMobNumber = TextEditingController();
  List<String> specialCharacters = [
    '!',
    '@',
    '#',
    '\$',
    '%',
    '^',
    '&',
    '*',
    '(',
    ')',
    '-',
    '_',
    '+',
    '=',
    '{',
    '}',
    '[',
    ']',
    '|',
    '\\',
    ':',
    ';',
    '"',
    '\'',
    '<',
    '>',
    ',',
    '.',
    '?',
    '/',
  ];
  List<String> numbers = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Sign Up',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Row(
              children: [
                SizedBox(
                  width: 7,
                ),
                Column(children: [
                  SizedBox(
                    height: 25,
                  ),
                  Text('UserName     ')
                ]),
                SizedBox(
                  width: 30,
                ),
                Container(
                    width: MediaQuery.of(context).size.width - 150,
                    child: TextField(
                      controller: controllerName,
                    ))
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                SizedBox(
                  width: 7,
                ),
                Column(children: [
                  SizedBox(
                    height: 25,
                  ),
                  Text('Password     ')
                ]),
                SizedBox(
                  width: 30,
                ),
                Container(
                    width: MediaQuery.of(context).size.width - 150,
                    child: TextField(
                      controller: controllerPassword,
                      obscureText: true,
                      decoration: InputDecoration(hintText: ''),
                    ))
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                SizedBox(
                  width: 7,
                ),
                Column(children: [
                  SizedBox(
                    height: 25,
                  ),
                  Text('Mail id          ')
                ]),
                SizedBox(
                  width: 30,
                ),
                Container(
                    width: MediaQuery.of(context).size.width - 150,
                    child: TextField(
                      controller: controllerMail,
                      keyboardType: TextInputType.emailAddress,
                    ))
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                SizedBox(
                  width: 7,
                ),
                Column(children: [
                  SizedBox(
                    height: 25,
                  ),
                  Text('Date of birth')
                ]),
                SizedBox(
                  width: 30,
                ),
                Container(
                    width: MediaQuery.of(context).size.width - 150,
                    child: TextField(
                      controller: controllerDate,
                      decoration: InputDecoration(hintText: 'dd-mm-yyyy'),
                      keyboardType: TextInputType.text,
                    ))
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                SizedBox(
                  width: 7,
                ),
                Column(children: [
                  SizedBox(
                    height: 25,
                  ),
                  Text('Mobile no    ')
                ]),
                SizedBox(
                  width: 30,
                ),
                Container(
                    width: MediaQuery.of(context).size.width - 150,
                    child: TextField(
                      controller: controllerMobNumber,
                      keyboardType: TextInputType.phone,
                    ))
              ],
            ),
            const SizedBox(
              height: 90,
            ),
            GestureDetector(
              child: Container(
                height: 30,
                width: 220,
                child: Center(
                    child: Text(
                  'Sign Up',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(15)),
              ),
              onTap: () async {
                //await DatabaseHelper().insertingIntoTableValues();
                String name = controllerName.text;
                String password = controllerPassword.text;
                String mail = controllerMail.text;
                String mob = controllerMobNumber.text;
                String date = controllerDate.text;
                try {
                  if (name.isNotEmpty) {
                    if (password.isNotEmpty) {
                      bool validating = validatingPassword(password);
                      if (validating) {
                        if (mail.isNotEmpty) {
                          if (mob.isNotEmpty) {
                            if (mob.length == 10) {
                              if (date.isNotEmpty) {
                                //var val = validatingPassword('trouble123');
                                //print('returned is $val');
                                List<Map<String,Object?>> queried = await DatabaseHelper().queryFromTable();
                                for(int i = 0; i <queried.length; i++){
                                  if(queried[i]['name'] == name){
                                    
                                     ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'User name unavailable')));
                                            break;
                                  }else{
                                    await DatabaseHelper().insertingIntoTableValues(
                                      name, password, mail, mob, date);
                                  Navigator.popAndPushNamed(context,'/LogIn');
                                  }
                                }
                                  
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            'Give the necessary details')));
                              }
                            }else{
                               ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Mobile no should be 10 digits')));
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Give the necessary details')));
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Give the necessary details')));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                                'Password should contain at least one special character & a numeric value')));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text('Give the necessary details')));
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Give the necessary details')));
                  }
                } catch (headAche) {
                  print(headAche.toString());
                }
              },
            )
          ],
        ),
      ),
    );
  }

  bool validatingPassword(String pass) {
    //var test = 'trouble#123';
    bool flag1 = false;
    bool flag2 = false;
    for (int i = 0; i < pass.length; i++) {
      for (int j = 0; j < specialCharacters.length; j++) {
        if (pass.substring(i, i + 1) == specialCharacters[j]) {
          flag1 = true;
          break;
        }
      }
    }
    for (int i = 0; i < pass.length; i++) {
      //10
      for (int j = 0; j < numbers.length; j++) {
        //3
        if (pass.substring(i, i + 1) == numbers[j]) {
          flag2 = true;
          break;
        }
      }
    }

    if (flag1 == true && flag2 == true) {
      return flag1;
    }
    return false;
  }
}
