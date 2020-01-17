import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'AppTheme.dart';
import 'CommentScreen.dart';
import 'PostHeader.dart';
import 'beans/Post.dart';

class PostView extends StatefulWidget {
  final Post post;
  final Function onNewComment;
  final index;

  PostView(this.post, this.onNewComment, this.index) : super();

  @override
  State<StatefulWidget> createState() {
    return PostViewState();
  }
}

class PostViewState extends State<PostView> /*implements PostServiceContract*/ {
  Post _post;
  FocusNode _focusNode;
//  PostService _postService;

  String _newComment = "";

  TextEditingController _commentTextFieldController;

  @override
  void initState() {
    _commentTextFieldController = TextEditingController();
    _post = widget.post;
    print("post no ${widget.index} => ${jsonEncode(_post)}");
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppTheme.primaryWhite,
          boxShadow: [
            BoxShadow(
                color: Colors.black38,offset: Offset(0,1),  blurRadius: 2)
          ]
      ),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: PostHeader(widget.post.user, widget.post.postTime),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12, top:8),
              child: Text(
                widget.post.title,
                maxLines: 1,
                style: TextStyle(
                  color: AppTheme.primaryBlack,
                  fontSize: AppTheme.fontMedium,
                  fontWeight: FontWeight.w800,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:8.0, right:8),
              child: Container(
                padding: EdgeInsets.all(6),
                child: Text(
                  widget.post.post??"NA",
                  maxLines: 10,
                  style: TextStyle(
                    color: AppTheme.primaryLightBlack,
                    fontSize: AppTheme.fontNormal,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
            Padding(padding: EdgeInsets.only(left: 8.0), child: viewMore()),
          ],
        ),
      ),
    );
  }

  viewMore() => GestureDetector(
        onTap: () => Navigator.of(context)
            .pushNamed(CommentScreen.route, arguments: _post),
        child: Container(
          margin: EdgeInsets.only(top: 5),
          padding: EdgeInsets.all(6),
          width: MediaQuery.of(context).size.width,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("Comments",
                  style: TextStyle(
                    color: AppTheme.colorPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                  )),
              Image.asset(
                'assets/icons/next.png',
                fit: BoxFit.contain,
                height: 10,
                width: 10,
                color: AppTheme.colorPrimary,
              ),
            ],
          ),
        ),
      );

}
