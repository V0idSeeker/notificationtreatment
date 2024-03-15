import 'package:flutter/material.dart';

class fireList extends StatelessWidget {
  const fireList({super.key});

  @override
  Widget build(BuildContext context) {

    return Container(
      // list from database
      child: ListView(

        children: [
          ListTile(
            title: Text("Fire"),
            leading: Text("Date"),
            trailing: Text("Location"),
            hoverColor: Colors.green,
          ),
          Divider(),
          ListTile(
              title: Text("Fire"),
              leading: Text("Date"),
              trailing: Text("Location"),
            hoverColor: Colors.green,
          ),
          Divider(),
          ListTile(
              title: Text("Fire"),
              leading: Text("Date"),
              trailing: Text("Location"),
            hoverColor: Colors.green,
          ),
          Divider(),
          ListTile(
              title: Text("Fire"),
              leading: Text("Date"),
              trailing: Text("Location"),
            hoverColor: Colors.green,
          ),
          Divider(),
          ListTile(
              title: Text("Fire"),
              leading: Text("Date"),
              trailing: Text("Location"),
            hoverColor: Colors.green,
          ),
          Divider(),

        ],
      ),
    ) ;
  }
}
