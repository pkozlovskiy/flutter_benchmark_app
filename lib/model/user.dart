import 'package:json_annotation/json_annotation.dart';

import 'friend.dart';
import 'fruit.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final String id;
  final int index;
  final String guid;
  final bool isActive;
  final String balance;
  final String picture;
  final int age;
  final String eyeColor;
  final String name;
  final String company;
  final String email;
  final String phone;
  final String address;
  final String about;
  final DateTime registered;
  final double latitude;
  final double longitude;
  final List<String> tags;
  final List<int> range;
  final List<Friend> friends;
  final String greeting;
  final Fruit favoriteFruit;

  User(
      this.id,
      this.index,
      this.guid,
      this.isActive,
      this.balance,
      this.picture,
      this.age,
      this.eyeColor,
      this.name,
      this.company,
      this.email,
      this.phone,
      this.address,
      this.about,
      this.registered,
      this.latitude,
      this.longitude,
      this.tags,
      this.range,
      this.friends,
      this.greeting,
      this.favoriteFruit);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
