import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'AppTheme.dart';
import 'beans/SubComment.dart';


class SubCommentPreview extends StatefulWidget {
  final SubComment reply;

  SubCommentPreview(this.reply);

  @override
  State<StatefulWidget> createState() {
    return SubCommentPreviewState();
  }
}

class SubCommentPreviewState extends State<SubCommentPreview> {
  SubComment reply;

  @override
  void initState() {
    super.initState();
    reply = widget.reply;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 40,
            height: 40,
            margin: EdgeInsets.symmetric(horizontal: 6),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                image: DecorationImage(
                  image: NetworkImage(
                    reply.user?.imgUrl??'',
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
                            widget.reply.user.name.toUpperCase(),
                            maxLines: 1,
                            style: TextStyle(
                              color: AppTheme.primaryBlack,
                              fontSize: 12,
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
                            widget.reply.commentTime,
                            maxLines: 1,
                            style: TextStyle(
                              color: AppTheme.textHint,
                              fontSize: 10,
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
                    minHeight: 30,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.amber.shade200.withOpacity(0.5)),
                      color: Colors.amber.shade200.withOpacity(0.5)),
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Text(reply.comment,
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
    );
  }
}
