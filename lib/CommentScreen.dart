import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

import 'AppTheme.dart';
import 'DateTimeHelper.dart';
import 'LoggedInUser.dart';
import 'LoginView.dart';
import 'PostComment.dart';
import 'PostHeader.dart';
import 'beans/Comment.dart';
import 'beans/Post.dart';
import 'beans/SubComment.dart';
import 'beans/User.dart';

class CommentScreen extends StatefulWidget {
  static String route = "commentScreen";

  @override
  State<StatefulWidget> createState() {
    return CommentScreenState();
  }
}

class CommentScreenState
    extends State<CommentScreen> {
  List<Comment> _comments;
  Post _post;
  FocusNode _focusNode;
  TextEditingController _commentTextFieldController;
  int _replyIndex;

  @override
  void initState() {
    _commentTextFieldController = TextEditingController();
    _focusNode = FocusNode(canRequestFocus: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _focusNode.addListener(() {
      setState(() {});
    });
    _post = ModalRoute.of(context).settings.arguments;
    _comments = _post.comments;

    return Material(
      child: SafeArea(
        top: true,
        bottom: true,
        child: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              _header,
              _commentListView,
              LoggedInUser().user == null ? loginButton : newComment
            ],
          ),
        ),
      ),
    );
  }

  get _commentListView => Expanded(
    child: Container(
      margin: EdgeInsets.only(top: 6),
      color: Colors.white,
      child: ListView.builder(
        itemCount: _comments.length,
        itemBuilder: (BuildContext context, int index) =>
            PostComment(_comments[index], () => _onReplyClicked(index)),
      ),
    ),
  );

  get _header => Material(
      elevation: 4,
      child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(6),
          child: PostHeader(_post.user, _post.postTime)));

  get loginButton => Container(
      margin: EdgeInsets.all(10),
      height: 40,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: AppTheme.colorPrimary)),
        onPressed: _onLoginPressed,
        color: AppTheme.colorPrimary,
        textColor: Colors.white,
        child: Text("Login to comment".toUpperCase(),
            style: TextStyle(fontSize: 14)),
      ));

  get newComment => Material(
        elevation: 4,
        child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(top: 6),
            padding: EdgeInsets.all(6),
            child: Column(
              children: <Widget>[
                _replyIndex == null ? Container() : _replyPreview,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 35,
                      height: 35,
                      margin: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                          image: DecorationImage(
                              image: AssetImage(
                            'assets/icons/user.png',
                          ))),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(
                          left: 15,
                          right: 15,
                        ),
                        height: 40,
                        decoration: new BoxDecoration(
                            color: Color(0xffeeeeee),
                            borderRadius: BorderRadius.circular(20)),
                        child: TextFormField(
                          controller: _commentTextFieldController,
                          autofocus: false,
                          focusNode: _focusNode,
                          style: TextStyle(color: AppTheme.primaryBlack),
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Image.asset(
                                'assets/icons/send.png',
                                width: 20,
                                color: AppTheme.colorPrimary.withOpacity(0.9),
                              ),
                              onPressed: _postComment,
                            ),
                            hintText: 'Type Here...',
                            hintStyle: TextStyle(
                              color: AppTheme.textHintDark,
                              fontWeight: FontWeight.w500,
                            ),
                            focusedBorder: InputBorder.none,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

  get _replyPreview => Stack(children: [
        Container(
          padding: EdgeInsets.all(6),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 30,
                  height: 30,
                  margin: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                      image: DecorationImage(
                        image: NetworkImage(
                          _post.comments[_replyIndex].user?.imgUrl ?? '',
                          scale: 0.5,
                        ),
                      )),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                            color: Colors.amber.shade200.withOpacity(0.5)),
                        color: Colors.amber.shade200.withOpacity(0.5)),
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    child: Text(
                      _post.comments[_replyIndex].comment,
//                      maxLines: 2,
                      style: TextStyle(
//                          fontFamily: 'Avenir-Medium',
                          color: Color(0xff4a4a4a),
                          fontSize: 14,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: GestureDetector(
            onTap: _closeReplyPreview,
            child: Container(
              width: 25,
              height: 25,
              padding: EdgeInsets.all(5),
              child: Image.asset('assets/icons/close.png'),
            ),
          ),
        ),
      ]);


  _postComment() {
    if (_replyIndex == null) {
      Comment comment = Comment();
      comment.user = LoggedInUser().user;
      comment.replies = List();
      comment.commentTime=DateTimeHelper.toMMMDDHHMM(DateTime.now().millisecondsSinceEpoch);
    comment.comment = _commentTextFieldController.text;
      _post.comments.add(comment);
    } else {
      SubComment subComment = SubComment();
      subComment.user = LoggedInUser().user;
      subComment.comment = _commentTextFieldController.text;
      subComment.commentTime=DateTimeHelper.toMMMDDHHMM(DateTime.now().millisecondsSinceEpoch);
      _post.comments[_replyIndex].replies.add(subComment);
    }
    _commentTextFieldController.text = "";
    setState(() {
      _replyIndex = null;
    });
  }

  _onReplyClicked(int pos) {
    if(LoggedInUser().user == null)
      _onLoginPressed();

    _focusNode.requestFocus();

    setState(() {
      _replyIndex = pos;
    });
  }

  _closeReplyPreview() {
    setState(() {
      _replyIndex = null;
    });
  }

  _onLoginPressed() {
    showDialog(
        context: context,
        builder: (BuildContext bc) => LoginView(() => _onLoginSuccessful()),
        barrierDismissible: false);
  }

  _onLoginSuccessful() {
    LoggedInUser().user = User(
        imgUrl:"https://shortcut-test2.s3.amazonaws.com/uploads/role/attachment/104775/default_c6db2094dd726abfa6949e482e2eaa47.png",
        name: "Jonny Devito");
    setState(() {});
  }
}