import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'AppTheme.dart';
import 'LoggedInUser.dart';
import 'SubCommentPreview.dart';
import 'beans/Comment.dart';


class PostComment extends StatefulWidget {

  final Comment _comment;
  final Function function;

  const PostComment(this._comment, this.function);

  @override
  State<StatefulWidget> createState() {
    return PostCommentState();
  }
}

class PostCommentState extends State<PostComment> {

  Comment _comment;
Function function;

  @override
  void initState() {
    _comment = widget._comment;
    function = widget.function;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
      Container(
            padding: EdgeInsets.all(6),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 50,
                        height: 50,
                        margin: EdgeInsets.symmetric(horizontal: 6),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            image: DecorationImage(
                                image: NetworkImage(
                                    _comment.user?.imgUrl??'',
                                    scale: 0.5,
                                ),)),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Row(
                              children: <Widget>[
                                Wrap(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        widget._comment.user.name.toUpperCase(),
                                        maxLines: 1,
                                        style: TextStyle(
                                          color: AppTheme.primaryBlack,
                                          fontSize: AppTheme.fontSmall,
                                          fontWeight: FontWeight.w700,
                                          fontStyle: FontStyle.normal,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                        widget._comment.commentTime,
                                        maxLines: 1,
                                        style: TextStyle(
                                          color: AppTheme.textHint,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                          fontStyle: FontStyle.normal,
                                        )),
                                  ),
                                )
                              ],
                            ),
                            Container(
                              width: double.maxFinite,
                              constraints: BoxConstraints(
                                minHeight: 35,
                              ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: Colors.amber.shade200.withOpacity(0.5)),
                                color: Colors.amber.shade200.withOpacity(0.5)),
                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                            child: Text(_comment.comment,
//                      maxLines: 2,
                              style: TextStyle(
                                  color: Color(0xff4a4a4a),
                                  fontSize: 14,
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w400
                              ),
                                textAlign: TextAlign.justify,
                            ),
                            )],
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: function,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 17,vertical: 2),
                      margin: EdgeInsets.symmetric(horizontal: 10,),
                      decoration:BoxDecoration(
                        color: LoggedInUser().user==null?Colors.grey:AppTheme.colorPrimary,
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5))
                      ),
                      child: Text('Reply', style: TextStyle(color:Colors.white, fontSize: 12),),
                    ),
                  )
                ],
              ),
            ),
          ),
          getCommentReplies()
        ],
      ),
    );
  }

  getCommentReplies() {
    return Container(
      padding: EdgeInsets.only(left:40,right: 6),
      child:ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemCount: _comment?.replies?.length??0,
        itemBuilder: (BuildContext context, int index) => SubCommentPreview(_comment.replies[index]),),
    );

  }
}
