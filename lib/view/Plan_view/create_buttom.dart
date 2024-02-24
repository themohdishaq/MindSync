import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

final TextEditingController nameController = TextEditingController();
final TextEditingController snController = TextEditingController();
final TextEditingController detailsController = TextEditingController();

void createBottomSheet(BuildContext context) {
  showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.blue[100],
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
              top: 20,
              right: 20,
              left: 20,
              bottom: MediaQuery.of(context).viewInsets.bottom + 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Center(
                  child: Text(
                "Make  a plan",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )),
              TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: "Name",
                    hintText: "Workout Plan",
                  )),
              TextField(
                controller: snController,
                decoration: const InputDecoration(
                  labelText: "S.NO",
                  hintText: "e.g 2",
                ),
              ),
              TextField(
                controller: detailsController,
                decoration: const InputDecoration(
                  labelText: "Details",
                  hintText: "6AM - 7PM",
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    try {
                      User? user = FirebaseAuth.instance.currentUser;
                      if (user != null) {
                        String id =
                            DateTime.now().microsecondsSinceEpoch.toString();
                        DatabaseReference databaseReference = FirebaseDatabase
                            .instance
                            .ref()
                            .child(user.uid)
                            .push();
                        databaseReference.set({
                          'name': nameController.text,
                          'sn': snController.text,
                          'details': detailsController.text,
                          'id': id
                        });
                      }
                    } catch (e) {
                      print(e);
                    }
                    nameController.clear();
                    snController.clear();
                    detailsController.clear();
                    Navigator.pop(context);
                  },
                  child: Text('add'))
            ],
          ),
        );
      });
}
