import 'package:flutter/material.dart';
import 'package:flutter_application_1/database.dart';
import 'package:sqflite/sqflite.dart';

class PasswordRecovery extends StatefulWidget {
  @override
  State<PasswordRecovery> createState() => PasswordRecoveryState();
}

class PasswordRecoveryState extends State<PasswordRecovery> {
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerPass1 = TextEditingController();
  TextEditingController controllerPass2 = TextEditingController();
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
        automaticallyImplyLeading: false,
        title: Text(
          'Recover password',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 150,
            ),
            Row(
              children: [
                Expanded(child: Container()),
                Container(
                  width: MediaQuery.of(context).size.width - 100,
                  child: TextField(
                    controller: controllerName,
                    decoration: InputDecoration(hintText: 'User Name'),
                  ),
                ),
                Expanded(child: Container()),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Expanded(child: Container()),
                Container(
                  width: MediaQuery.of(context).size.width - 100,
                  child: TextField(
                    controller: controllerPass1,
                    decoration: InputDecoration(hintText: 'New Password'),
                  ),
                ),
                Expanded(child: Container()),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Expanded(child: Container()),
                Container(
                  width: MediaQuery.of(context).size.width - 100,
                  child: TextField(
                    controller: controllerPass2,
                    decoration: InputDecoration(hintText: 'Confirm Password'),
                  ),
                ),
                Expanded(child: Container()),
              ],
            ),
            const SizedBox(
              height: 80,
            ),
            GestureDetector(
              onTap: () async {
                var updatedKey = controllerPass1.text;
                var userName = controllerName.text;
                var confirmPass = controllerPass2.text;
                //DatabaseHelper().updateInfo(updatedKey, 2);

                if (userName.isNotEmpty) {
                  if (updatedKey.isNotEmpty) {
                    bool validate = validatingPassword(updatedKey);
                    if (validate) {
                      if (updatedKey == confirmPass) {
                        List<Map<String, dynamic>> list =
                            await DatabaseHelper().queryFromTable();
                        for (int i = 0; i < list.length; i++) {
                          /* if (list[i]['empty'] == 'empty') {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('No such profile available')));
                          } else*/
                          if (list[i]['name'] == userName) {
                            int userId = list[i]['id'];
                            await DatabaseHelper()
                                .updateInfo(updatedKey, userId);
                                Navigator.popAndPushNamed(context, '/LogIn');
                            break;
                          }else if(list[i]['empty'] == 'empty'){}
                        }
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                              'Password should contain at least one special character & a numeric value')));
                    }
                  }
                } else {}
              },
              child: Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      color: Colors.green),
                  width: MediaQuery.of(context).size.width - 70,
                  height: 40,
                  child: const Center(
                      child: Text(
                    'Update password',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ))),
            ),
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
