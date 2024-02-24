class UserData {
  final String? userId;
  final int? age;
  final double? weight;
  final double? height;

  UserData({this.userId, this.age, this.weight, this.height});

  factory UserData.fromFirestore(Map<String, dynamic> firestoreData) {
    return UserData(
      age: firestoreData['age'],
      weight: firestoreData['weight'],
      height: firestoreData['height'],
    );
  }
}
