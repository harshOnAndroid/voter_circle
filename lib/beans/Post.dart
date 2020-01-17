import 'package:json_annotation/json_annotation.dart';

import 'Comment.dart';
import 'User.dart';

part 'Post.g.dart';

@JsonSerializable()
class Post{

  int id;
  String postTime;
  String post;
  User user;
  List<Comment> comments;
  String title;

  Post({
    this.id,
    this.title,
    this.postTime,
    this.post,
    this.user,
    this.comments,
});

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);

  @override
  String toString() {

    return _$PostToJson(this).toString();;
  }

}