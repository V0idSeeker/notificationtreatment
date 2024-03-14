import 'package:flutter/material.dart';
import 'package:notificationtreatment/controlers/LogInControler.dart';
import 'package:provider/provider.dart';

import 'Home.dart';

class LogIn extends StatelessWidget {
  const LogIn({super.key});

  @override
  Widget build(BuildContext context) {
    final formkey = GlobalKey<FormState>();
    final controler = Provider.of<LogInControler>(context);
    return Scaffold(
      body: Center(
        child: Container(
          color: Theme.of(context).primaryColorLight,
          child: Form(
            key: formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextFormField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(hintText: "Username"),
                  validator: (value) {
                    if (value!.isEmpty || value != controler.username)
                      return "Invalid Username";
                    else
                      return null;
                  },
                ),
                TextFormField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(hintText: "Password"),
                  validator: (value) {
                    if (value!.isEmpty || value != controler.password)
                      return "Invalid Password";
                    else
                      return null;
                  },
                ),
                MaterialButton(
                  onPressed: () {
                    if (formkey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Home()),
                      );
                    } else
                      return null;
                  },
                  child: Text("Submit"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
