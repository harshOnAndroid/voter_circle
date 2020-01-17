import 'package:json_annotation/json_annotation.dart';

import 'User.dart';

part 'SubComment.g.dart';

@JsonSerializable()
class SubComment {

  int commentId;
  String type;
  User user;
  String comment;
  String commentTime;

  SubComment({
    this.commentId,
    this.type,
    this.user,
    this.comment,
    this.commentTime,
  });

  factory SubComment.fromJson(Map<String, dynamic> json) =>
      _$SubCommentFromJson(json);

  Map<String, dynamic> toJson() => _$SubCommentToJson(this);

}