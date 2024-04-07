import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notificationtreatment/controlers/LogInControler.dart';


import 'Home.dart';

class LogIn extends StatelessWidget {
  const LogIn({super.key});

  @override
  Widget build(BuildContext context) {
    final formkey = GlobalKey<FormState>();
    return GetBuilder<LogInControler>(
        init:LogInControler() ,
        builder: (controller){
      return Scaffold(

        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage("https://images.pexels.com/photos/338936/pexels-photo-338936.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
              fit: BoxFit.cover,
            ), ),
          child: Center(
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
                          if (value!.isEmpty || value != controller.username)
                            return "Invalid Username";
                          else
                            return null;
                        },
                      ),
                      TextFormField(
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(labelText: "Password :"),
                        validator: (value) {
                          if (value!.isEmpty || value != controller.password)
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
                              MaterialPageRoute(builder: (context) => Home(userData: controller.userdata,) ),
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
        ),
      );
    });
  }
}
