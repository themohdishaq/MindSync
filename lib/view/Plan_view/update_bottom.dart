import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

final TextEditingController nameController = TextEditingController();
final TextEditingController snController = TextEditingController();
final TextEditingController detailsController = TextEditingController();

void updateBottomSheet(BuildContext context, name, id, sn, details, info) {
  nameController.text = name;
  snController.text = sn;
  detailsController.text = details;

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
                    hintText: "ishaq",
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
                  labelText: "details",
                  hintText: "Pakistan",
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    final databaseReference =
                        FirebaseDatabase.instance.ref(info).child(id);
                    databaseReference.update({
                      'name': nameController.text.toString(),
                      'sn': snController.text.toString(),
                      'details': detailsController.text.toString(),
                    }).then((_) {
                      Navigator.pop(context);
                    }).catchError((error) {
                      // Handle errors here, if any
                      print("Update failed: $error");
                    });
                  },
                  child: const Text('Update'))
            ],
          ),
        );
      });
}
