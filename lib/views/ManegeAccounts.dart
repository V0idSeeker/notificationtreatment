import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notificationtreatment/controlers/ManegeAccountsController.dart';

class ManegeAccounts extends StatelessWidget {
  const ManegeAccounts({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ManegeAccountsController>(
        init: ManegeAccountsController(),
        builder:(controller){
          final formkey = GlobalKey<FormState>();
          bool isManeger=false;


          return Center(
            child: Container(
              width: MediaQuery.of(context).size.width/3,
              height: MediaQuery.of(context).size.height/2,
              child: Form(
                key: formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Add Account"),
                      TextFormField(
                        decoration: InputDecoration(

                          labelText: "Name:",border: OutlineInputBorder( // Border for the TextFormField
                          borderSide: BorderSide(color: Colors.grey), // Border color
                          borderRadius: BorderRadius.circular(8.0), // Optional: Border radius
                        ),),
                        validator: (value){
                          if(value.toString().length==0) return "This Field Must Be Filled";
                          if(!RegExp(r'^[A-Za-z0-9 \d]+$').hasMatch(value.toString()))
                            return "Invalid Charechters";
                          controller.data["name"]=value.toString();





                        },
                      ),
                      TextFormField(

                        decoration: InputDecoration(

                          labelText: "Username:",border: OutlineInputBorder( // Border for the TextFormField
                          borderSide: BorderSide(color: Colors.grey), // Border color
                          borderRadius: BorderRadius.circular(8.0), // Optional: Border radius
                        ),),
                        validator: (value){
                          if(value.toString().length==0) return "This Field Must Be Filled";
                          if(!RegExp(r'^[A-Za-z0-9 \d]+$').hasMatch(value.toString()))
                            return "Invalid Charechters";
                          controller.data["username"]=value.toString();

                        },
                      ),
                      TextFormField(

                        obscureText: true,


                        decoration: InputDecoration(

                          helperText: "use only numbers , letters and at least 8 characters",
                          labelText: "Password:",border: OutlineInputBorder( // Border for the TextFormField
                          borderSide: BorderSide(color: Colors.grey), // Border color
                          borderRadius: BorderRadius.circular(8.0), // Optional: Border radius
                        ),

                        ),
                        validator: (value){

                          if(value.toString().length==0) return "This Field Must Be Filled";
                          if(!RegExp(r'^[A-Za-z0-9 \d]+$').hasMatch(value.toString()))
                            return "Invalid Charechters";
                          controller.data["password"]=value.toString();

                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,


                        children: [

                          Text("Is Maneger:"),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: GetBuilder<ManegeAccountsController>(
                              id: "Switch",

                              builder: (controller) {
                                return Switch(
                                    value: isManeger,
                                    onChanged: (value){
                                        isManeger=value;

                                      controller.update(["Switch"]);
                                });
                              }
                            ),
                          ),
                        ],
                      ),
                      Text("Location :"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [


                          Container(
                            width: MediaQuery.of(context).size.width/3/2.5,
                            child: TextFormField(

                              decoration: InputDecoration(labelText: "Latitude:",border: OutlineInputBorder( // Border for the TextFormField
                                borderSide: BorderSide(color: Colors.grey), // Border color
                                borderRadius: BorderRadius.circular(8.0), // Optional: Border radius
                              ),),
                              validator: (value){
                                if(value.toString().length==0) return "This Field Must Be Filled";
                                if(!RegExp(r'^[-+]?[0-9]*\.?[0-9]+([eE][-+]?[0-9]+)?$').hasMatch(value.toString()))
                                  return "Invalid Characters";
                                double val=double.parse(value.toString());
                                if( val>180 || val<-180) return "Value  mus tbe between -90 and 90";
                                controller.data["latitude"]=value.toString();



                              },
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width/3/2.5,
                            child: TextFormField(
                              decoration: InputDecoration(labelText: "Longitude:",border: OutlineInputBorder( // Border for the TextFormField
                                borderSide: BorderSide(color: Colors.grey), // Border color
                                borderRadius: BorderRadius.circular(8.0), // Optional: Border radius
                              ),),
                              validator: (value){
                                if(value.toString().length==0) return "This Field Must Be Filled";
                                if(!RegExp(r'^[-+]?[0-9]*\.?[0-9]+([eE][-+]?[0-9]+)?$').hasMatch(value.toString()))
                                  return "Invalid Characters";
                                double val=double.parse(value.toString());
                                if( val>180 || val<-180) return "Value  mus tbe between -180 and 180";
                                controller.data["longitude"]=value.toString();

                              },
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            if (!formkey.currentState!.validate()) return null;
                            String title="";
                            String content="";
                            controller.data["isManager"]=isManeger.toString();
                            String ? error =await controller.addUser();
                            if(error== null) {
                              title="Success !!";
                              content ="user '${controller.data["name"]}' added Successfully !!";

                            }else{
                              title="Failed !!";
                              content =error.toString();

                            }
                            showAdaptiveDialog(context: context, builder: (context)
                            {
                              return AlertDialog(
                                title: Text(title),
                                content: Text(content),
                                actions: [
                                  FloatingActionButton(onPressed:(){
                                    Navigator.pop(context);
                                    if(error== null) Future.delayed(Duration(milliseconds: 200) ,(){
                                      formkey.currentState?.reset();
                                    });
                                  } , child: Text("close"),)
                                ],

                              );

                            });


                          }
                          , child: Text("Add User"))


                    ],
                  ),

              ),
            ),
          );

        });
  }
}
