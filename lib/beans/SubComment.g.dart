// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SubComment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SubComment _$SubCommentFromJson(Map<String, dynamic> json) {
  return SubComment(
    commentId: json['commentId'] as int,
    type: json['type'] as String,
    user: json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
    comment: json['comment'] as String,
    commentTime: json['commentTime'] as String,
  );
}

Map<String, dynamic> _$SubCommentToJson(SubComment instance) =>
    <String, dynamic>{
      'commentId': instance.commentId,
      'type': instance.type,
      'user': instance.user,
      'comment': instance.comment,
      'commentTime': instance.commentTime,
    };
