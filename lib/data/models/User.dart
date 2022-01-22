import 'package:timeago/timeago.dart' as timeago;

class User {
  User({this.username, this.email, this.uid, this.profileImage, this.joinDate});
  final String username, email, uid, joinDate;
  dynamic profileImage;

  factory User.fromJson(Map<String, dynamic> json) {
    print(json['profileImage'] ?? 'hhhh');
    return User(
      username: json['username'],
      email: json['email'],
      uid: json['userId'].toString(),
      joinDate: timeago.format(DateTime.parse(json['joinDate'])),
      profileImage: json['profileImage'] ?? null,
    );
  }
}
