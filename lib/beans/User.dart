import 'package:json_annotation/json_annotation.dart';

part 'User.g.dart';

@JsonSerializable()
class User {
  @JsonKey(name:"displayName")
  String name;
  String imgUrl;

  User(
      {
      this.name,
      this.imgUrl,
      });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
