import 'package:json_annotation/json_annotation.dart';

import 'SubComment.dart';
import 'User.dart';

part 'Comment.g.dart';

@JsonSerializable()
class Comment{

  int id;
  String type;
  User user;
  String comment;
  List<SubComment> replies;
  String commentTime;

  Comment({
    this.id,
    this.type,
    this.user,
    this.comment,
    this.replies,
    this.commentTime,
});

  factory Comment.fromJson(Map<String, dynamic> json) => _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);

}