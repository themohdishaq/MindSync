import 'dart:io';
import 'dart:typed_data';

import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nayapakistan/common/color_extension.dart';
import 'package:nayapakistan/common_widget/round_button.dart';
import 'package:nayapakistan/common_widget/setting_row.dart';
import 'package:nayapakistan/common_widget/title_subtile_cell.dart';
import 'package:nayapakistan/view/on_boarding/on_boarding_view.dart';
import 'package:nayapakistan/view/profile/update_view.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  Uint8List? _image;
  File? selectedImage;
  UserData? currentUserData;
  bool positive = false;
  final auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    fetchUserData().then((data) {
      setState(() {
        currentUserData = data;
      });
    });
  }

  Future<UserData?> fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        DocumentSnapshot userData = await FirebaseFirestore.instance
            .collection('userProfile')
            .doc(user.uid)
            .get();

        if (userData.exists) {
          Map<String, dynamic> dataMap =
              userData.data() as Map<String, dynamic>;
          return UserData.fromFirestore(dataMap);
        }
      } catch (e) {
        print("Error fetching user data: $e");
      }
    }
    return null;
  }

  List<Map<String, String>> otherArr = [
    {"image": "assets/images/p_contact.png", "name": "Contact Us", "tag": "5"},
    {
      "image": "assets/images/p_privacy.png",
      "name": "Privacy Policy",
      "tag": "6"
    },
    {"image": "assets/images/p_setting.png", "name": "Setting", "tag": "7"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColor.white,
        centerTitle: true,
        elevation: 0,
        leadingWidth: 0,
        title: Text(
          "Profile",
          style: TextStyle(
              color: TColor.black, fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
      backgroundColor: TColor.white,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    child: ClipOval(
                      child: _image != null
                          ? Image.memory(
                              _image!,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              'assets/images/u1.png',
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  if (_image == null)
                    Positioned(
                      bottom: -10,
                      left: 140,
                      child: IconButton(
                        onPressed: () {
                          showImagePickerOption(context);
                        },
                        icon: Icon(Icons.add_a_photo),
                      ),
                    ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          currentUserData?.fullName ?? 'Loading...',
                          style: TextStyle(
                              color: TColor.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          currentUserData?.contactNo ?? 'Loading...',
                          style: TextStyle(color: TColor.gray, fontSize: 12),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 80,
                    height: 35,
                    child: RoundButton(
                      title: "Log out",
                      type: RoundButtonType.bgGradient,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      onPressed: () {
                        auth.signOut().then((value) => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const OnBoardingView())));
                      },
                    ),
                  )
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  Expanded(
                    child: TitleSubtitleCell(
                      title: "${currentUserData?.height ?? '...'} cm",
                      subtitle: "Height",
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: TitleSubtitleCell(
                      title: "${currentUserData?.weight ?? '...'} kg",
                      subtitle: "Weight",
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: TitleSubtitleCell(
                      title: "${currentUserData?.ageNumber ?? '...'}",
                      subtitle: "Age",
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                decoration: BoxDecoration(
                    color: TColor.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(color: Colors.black12, blurRadius: 2)
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Notification",
                      style: TextStyle(
                        color: TColor.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      height: 30,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset("assets/images/p_notification.png",
                              height: 15, width: 15, fit: BoxFit.contain),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: Text(
                              "Pop-up Notification",
                              style: TextStyle(
                                color: TColor.black,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          CustomAnimatedToggleSwitch<bool>(
                            current: positive,
                            values: [false, true],
                            dif: 0.0,
                            indicatorSize: Size.square(30.0),
                            animationDuration:
                                const Duration(milliseconds: 200),
                            animationCurve: Curves.linear,
                            onChanged: (b) => setState(() => positive = b),
                            iconBuilder: (context, local, global) {
                              return const SizedBox();
                            },
                            defaultCursor: SystemMouseCursors.click,
                            onTap: () => setState(() => positive = !positive),
                            iconsTappable: false,
                            wrapperBuilder: (context, global, child) {
                              return Stack(
                                alignment: Alignment.center,
                                children: [
                                  Positioned(
                                    left: 10.0,
                                    right: 10.0,
                                    height: 30.0,
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            colors: TColor.secondaryG),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(50.0)),
                                      ),
                                    ),
                                  ),
                                  child,
                                ],
                              );
                            },
                            foregroundIndicatorBuilder: (context, global) {
                              return SizedBox.fromSize(
                                size: const Size(10, 10),
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: TColor.white,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(50.0)),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.black38,
                                          spreadRadius: 0.05,
                                          blurRadius: 1.1,
                                          offset: Offset(0.0, 0.8))
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                decoration: BoxDecoration(
                    color: TColor.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(color: Colors.black12, blurRadius: 2)
                    ]),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Other",
                      style: TextStyle(
                        color: TColor.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: otherArr.length,
                      itemBuilder: (context, index) {
                        var iObj = otherArr[index];
                        return SettingRow(
                          icon: iObj["image"].toString(),
                          title: iObj["name"].toString(),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const UpdateView()),
                            );
                          },
                        );
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void showImagePickerOption(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.blue[100],
      context: context,
      builder: (builderContext) {
        return SizedBox(
          width: MediaQuery.of(builderContext).size.width,
          height: MediaQuery.of(builderContext).size.height / 4,
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    _pickimageFromGallery(context);
                  },
                  child: const SizedBox(
                    child: Column(
                      children: [
                        Icon(
                          Icons.image,
                          size: 70,
                        ),
                        Text('Gallery'),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    _pickimageFromCamera(context);
                  },
                  child: const SizedBox(
                    child: Column(
                      children: [
                        Icon(
                          Icons.camera,
                          size: 70,
                        ),
                        Text('Camera'),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickimageFromGallery(BuildContext context) async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    setState(() {
      selectedImage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
    });
    Navigator.of(context).pop();
  }

  Future<void> _pickimageFromCamera(BuildContext context) async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnImage == null) return;
    setState(() {
      selectedImage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
    });
    Navigator.of(context).pop();
  }
}

class UserData {
  final String fullName;
  final String ageNumber;
  final String contactNo;
  final String height;
  final String weight;

  UserData({
    required this.fullName,
    required this.ageNumber,
    required this.contactNo,
    required this.height,
    required this.weight,
  });

  factory UserData.fromFirestore(Map<String, dynamic> firestore) {
    return UserData(
      fullName: firestore['Full Name'] ?? '',
      ageNumber: firestore['Age'] ?? '',
      contactNo: firestore['Contact Number'] ?? '',
      height: firestore['height'] ?? '',
      weight: firestore['weight'] ?? '',
    );
  }
}
