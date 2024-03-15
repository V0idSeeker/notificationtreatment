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
          width: MediaQuery.of(context).size.width / 4,
          height: MediaQuery.of(context).size.height / 4,
          color: Theme.of(context).primaryColorLight,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextFormField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(labelText: "Username :"),
                    validator: (value) {
                      if (value!.isEmpty || value != controler.username)
                        return "Invalid Username";
                      else
                        return null;
                    },
                  ),
                  TextFormField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(labelText: "Password :"),
                    validator: (value) {
                      if (value!.isEmpty || value != controler.password)
                        return "Invalid Password";
                      else
                        return null;
                    },
                  ),
                  ElevatedButton(
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
      ),
    );
  }
}
