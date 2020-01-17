import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'AppTheme.dart';
import 'DateTimeHelper.dart';
import 'beans/User.dart';

class PostHeader extends StatefulWidget {
  final User user;
  final String time;

  PostHeader(
    this.user,
    this.time,
  );

  @override
  State<StatefulWidget> createState() {
    return PostHeaderState();
  }
}

class PostHeaderState extends State<PostHeader> {
  User _user;
  String _time;

  @override
  void initState() {
    _user = widget.user;
    _time = widget.time;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag:_user.name+_time,
      child: Container(
          color: Colors.white,
          child: Row(
            children: <Widget>[
              Container(
                      width: AppTheme.avatarMedium,
                      height: AppTheme.avatarMedium,
                      margin: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          image: DecorationImage(
                              image:
                                  NetworkImage(_user.imgUrl ?? "", scale: 0.5),
                          fit: BoxFit.fill)),
                    ),
              Expanded(
                child: Center(
                  child: Row(
                    children: <Widget>[
                      Wrap(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              _user.name.toUpperCase(),
                              maxLines: 1,
                              style: TextStyle(
                                fontFamily: 'Avenir',
                                color: AppTheme.primaryBlack,
                                fontSize: AppTheme.fontMedium,
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
                              _time,
                              maxLines: 1,
                              style: TextStyle(
                                color: AppTheme.textHint,
                                fontSize: AppTheme.fontSmall,
                                fontWeight: FontWeight.w300,
                                fontStyle: FontStyle.normal,
                              )),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
