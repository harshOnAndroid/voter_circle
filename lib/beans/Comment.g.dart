// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) {
  return Comment(
    id: json['id'] as int,
    type: json['type'] as String,
    user: json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>),
    comment: json['comment'] as String,
    replies: (json['replies'] as List)
        ?.map((e) =>
            e == null ? null : SubComment.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    commentTime: json['commentTime'] as String,
  );
}

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'user': instance.user,
      'comment': instance.comment,
      'replies': instance.replies,
      'commentTime': instance.commentTime,
    };
