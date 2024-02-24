import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nayapakistan/common/color_extension.dart';
import 'package:nayapakistan/common_widget/round_button.dart';
import 'package:nayapakistan/common_widget/round_textfield.dart';
import 'package:nayapakistan/view/main_tab/main_tab_view.dart';

class UpdateView extends StatefulWidget {
  const UpdateView({Key? key}) : super(key: key);

  @override
  State<UpdateView> createState() => _UpdateViewState();
}

class _UpdateViewState extends State<UpdateView> {
  final TextEditingController txtDate = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController fullName = TextEditingController();
  final TextEditingController ageNumber = TextEditingController();
  final TextEditingController contactNo = TextEditingController();
  String? selectedGender;

  Future<void> updateUserProfileData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No user logged in')),
      );
      return;
    }

    Map<String, dynamic> updatedData = {};

    if (selectedGender != null && selectedGender!.isNotEmpty) {
      updatedData['gender'] = selectedGender;
    }
    if (fullName.text.isNotEmpty) {
      updatedData['Full Name'] = fullName.text;
    }
    if (ageNumber.text.isNotEmpty) {
      updatedData['Age'] = ageNumber.text;
    }
    if (contactNo.text.isNotEmpty) {
      updatedData['Contact Number'] = contactNo.text;
    }
    if (txtDate.text.isNotEmpty) {
      updatedData['DOB'] = txtDate.text;
    }
    if (weightController.text.isNotEmpty) {
      updatedData['Weight'] = weightController.text;
    }
    if (heightController.text.isNotEmpty) {
      updatedData['Height'] = heightController.text;
    }

    if (updatedData.isNotEmpty) {
      try {
        await FirebaseFirestore.instance
            .collection('userProfile')
            .doc(user.uid)
            .update(updatedData);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully')),
        );

        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const MainTabView()));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error updating profile: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No changes detected')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: TColor.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Image.asset(
                  "assets/images/complete_profile.png",
                  width: media.width,
                  fit: BoxFit.fitWidth,
                ),
                SizedBox(height: media.width * 0.05),
                Text(
                  "Update Your Profile",
                  style: TextStyle(
                      color: TColor.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  "Make changes to your profile.",
                  style: TextStyle(color: TColor.gray, fontSize: 12),
                ),
                SizedBox(height: media.width * 0.05),
                _buildGenderDropdown(),
                _buildTextField(fullName, "Full Name", TextInputType.text,
                    "assets/images/p_personal.png"),
                _buildTextField(ageNumber, "Age", TextInputType.number,
                    "assets/images/date.png"),
                _buildTextField(txtDate, "Date of Birth",
                    TextInputType.datetime, "assets/images/date.png"),
                _buildTextField(contactNo, "Contact Number",
                    TextInputType.phone, "assets/images/p_contact.png"),
                _buildWeightHeightRow(),
                SizedBox(height: media.width * 0.07),
                RoundButton(
                    title: "Update Profile", onPressed: updateUserProfileData),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGenderDropdown() {
    return Container(
      decoration: BoxDecoration(
          color: TColor.lightGray, borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          Container(
            alignment: Alignment.center,
            width: 50,
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Image.asset("assets/images/gender.png",
                width: 20, height: 20, fit: BoxFit.contain, color: TColor.gray),
          ),
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedGender,
                items: ["Male", "Female"]
                    .map((name) => DropdownMenuItem(
                        value: name,
                        child: Text(name,
                            style:
                                TextStyle(color: TColor.gray, fontSize: 14))))
                    .toList(),
                onChanged: (value) => setState(() => selectedGender = value),
                isExpanded: true,
                hint: Text(selectedGender ?? "Choose Gender",
                    style: TextStyle(color: TColor.gray, fontSize: 12)),
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      TextInputType keyboardType, String iconPath) {
    var media = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(top: media.width * 0.04),
      child: RoundTextField(
          controller: controller,
          label: label,
          keyboardType: keyboardType,
          icon: iconPath),
    );
  }

  Widget _buildWeightHeightRow() {
    return Row(
      children: [
        Expanded(
            child: _buildTextField(weightController, "Weight",
                TextInputType.number, "assets/images/weight.png")),
        const SizedBox(width: 8),
        _buildMetricContainer("KG"),
        const SizedBox(width: 8),
        Expanded(
            child: _buildTextField(heightController, "Height",
                TextInputType.number, "assets/images/hight.png")),
        const SizedBox(width: 8),
        _buildMetricContainer("CM"),
      ],
    );
  }

  Widget _buildMetricContainer(String metric) {
    return Container(
      width: 50,
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: TColor.secondaryG),
          borderRadius: BorderRadius.circular(15)),
      child: Text(metric, style: TextStyle(color: TColor.white, fontSize: 12)),
    );
  }
}
