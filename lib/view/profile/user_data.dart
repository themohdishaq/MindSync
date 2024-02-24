class UsersData {
  final String fullName;
  final String ageNumber;
  final String contactNo;
  final String height;
  final String weight;

  UsersData({
    required this.fullName,
    required this.ageNumber,
    required this.contactNo,
    required this.height,
    required this.weight,
  });

  factory UsersData.fromFirestore(Map<String, dynamic> firestore) {
    return UsersData(
      fullName: firestore['Full Name'] ?? '',
      ageNumber: firestore['Age'] ?? '',
      contactNo: firestore['Contact Number'] ?? '',
      height: firestore['height'] ?? '',
      weight: firestore['weight'] ?? '',
    );
  }
}
