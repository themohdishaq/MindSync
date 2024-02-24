import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:nayapakistan/common/color_extension.dart';
import 'package:nayapakistan/view/Plan_view/create_buttom.dart';
import 'package:nayapakistan/view/Plan_view/update_bottom.dart';

class PlanView extends StatefulWidget {
  const PlanView({super.key});

  @override
  State<PlanView> createState() => _PlanViewState();
}

class _PlanViewState extends State<PlanView> {
  DatabaseReference? databaseReference;
  String? infouser;
  final user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    super.initState();
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      infouser = user.uid;
      databaseReference = FirebaseDatabase.instance.ref(infouser);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: TColor.lightGray,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text("Make your plan"),
      ),
      //displaying plangs
      body: Column(
        children: [
          Expanded(
            child: FirebaseAnimatedList(
              query: databaseReference!,
              itemBuilder: (context, snapshot, animation, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                      title: Text(
                        snapshot.child("Name").value.toString(),
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                        ),
                      ),
                      subtitle:
                          Text(snapshot.child("details").value.toString()),
                      leading: CircleAvatar(
                          child: Text(snapshot.child("sn").value.toString())),
                      trailing: PopupMenuButton(
                          icon: const Icon(Icons.more_vert),
                          itemBuilder: (context) => [
                                // for update operation
                                PopupMenuItem(
                                  value: 1,
                                  child: ListTile(
                                    onTap: () {
                                      Navigator.pop(context);
                                      updateBottomSheet(
                                          context,
                                          snapshot
                                              .child("name")
                                              .value
                                              .toString(),
                                          snapshot.key,
                                          snapshot.child("sn").value.toString(),
                                          snapshot
                                              .child("details")
                                              .value
                                              .toString(),
                                          infouser);
                                    },
                                    leading: const Icon(Icons.edit),
                                    title: const Text("Edit"),
                                  ),
                                ),
                                PopupMenuItem(
                                  value: 2,
                                  child: ListTile(
                                    onTap: () {
                                      Navigator.pop(context);
                                      if (snapshot.key != null) {
                                        Future.delayed(Duration.zero, () {
                                          databaseReference!
                                              .child(snapshot.key!)
                                              .remove(); // Use the key from the snapshot.
                                        });
                                      }
                                    },
                                    leading: const Icon(Icons.delete),
                                    title: const Text("Detete"),
                                  ),
                                )
                              ])),
                );
              },
            ),
          )
        ],
      ),

      //creating a planning
      floatingActionButton: FloatingActionButton(
        onPressed: () => createBottomSheet(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
