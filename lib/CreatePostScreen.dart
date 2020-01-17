import 'package:flutter/material.dart';
import 'dart:math';
import 'AppTheme.dart';
import 'DateTimeHelper.dart';
import 'LandingScreenBloc.dart';
import 'LoggedInUser.dart';
import 'beans/Post.dart';
import 'beans/User.dart';

class CreatePostScreen extends StatefulWidget {
  static String route = "/post";

  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  String currentSelected = "";
  var height;
  var width;
  User _user;
  String _title = "";
  String _description;
  Function onNewPostCreated;
  LandingScreenBloc _landingScreenBloc = LandingScreenBloc.getInstance;
  bool _isPostActive = false;

  _CreatePostScreenState() {
    print("Constructor PostUiState");
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _user = LoggedInUser().user;
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(AppTheme.appBarRegular),
        child: AppBar(
          elevation: 0.0,
          title: Text(
            'Create Post',
            style: TextStyle(
                color: AppTheme.primaryBlack, fontSize: AppTheme.fontLarge),
          ),
          backgroundColor: AppTheme.primaryWhite,
          iconTheme: IconThemeData(color: AppTheme.primaryBlack),
        ),
      ),
      body: SafeArea(
        top: true,
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 60.0),
          child: Column(
            children: <Widget>[
              _header,
              Container(
                decoration: new BoxDecoration(
                  borderRadius: new BorderRadius.circular(20.0),
                  color: AppTheme.boxLightColor,
                ),
                width: MediaQuery.of(context).size.width - 32,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 20.0,
                    right: 8.0,
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Title here...",
                        hintStyle: TextStyle(
                          color: AppTheme.textHint,
                          fontSize: AppTheme.fontRegular,
                          letterSpacing: 0.1,
                        )),
                    style: TextStyle(
                        color: AppTheme.textHintDark,
                        fontSize: AppTheme.fontLargeMedium),
                    keyboardType: TextInputType.multiline,
                    maxLines: 1,
                    onChanged: (value) => _onTitleChanged(value),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: 15, bottom: 20),
                child: Container(
//                  height: MediaQuery.of(context).size.height / 6,
                  decoration: new BoxDecoration(
                    borderRadius: new BorderRadius.circular(16.0),
                    color: AppTheme.boxLightColor,
                  ),
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 20.0,
                      right: 8.0,
                    ),
                    child: TextField(
                      minLines: 4,
                      textAlign: TextAlign.justify,
                      scrollPhysics: ScrollPhysics(),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Post here...",
                          hintStyle: TextStyle(
                            color: AppTheme.textHint,
                            fontSize: AppTheme.fontRegular,
                            letterSpacing: 0.1,
                          )),
                      style: TextStyle(
                          color: AppTheme.textHintDark,
                          fontSize: AppTheme.fontLargeMedium),
                      keyboardType: TextInputType.multiline,
                      maxLines: 12,
                      onChanged: (value) => _onDescriptionChanged(value),
                    ),
                  ),
                ),
              ),
              _postButton
            ],
          ),
        ),
      ),
    );
  }

  get _postButton => Hero(
    tag: "new_post",
    child: MaterialButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(color: Colors.transparent)),
          color: AppTheme.colorPrimary,
          disabledColor: Colors.grey,
          height: 40,
          minWidth: double.infinity,
          textColor: Colors.white,
          child: Text(
            'POST',
            style: TextStyle(fontSize: 18),
          ),
           onPressed: _isPostActive?_onPostClicked:null,
          splashColor: Colors.black12,
        ),
  );

  get _header => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: height / 50.0),
                child: Container(
                  width: 35,
                  height: 35,
                  margin: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                      color: Colors.cyan,
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                      image: DecorationImage(
                          image: NetworkImage(
                            _user?.imgUrl ?? '',
                          ),
                          fit: BoxFit.fill)),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8.0, top: height / 75.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      _user.name,
                      style: TextStyle(
                          fontSize: AppTheme.fontLargeMedium,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      );

  void _onDescriptionChanged(String newtext) {
    _description = newtext;
    _checkPostBtnActivate();
  }

  _checkPostBtnActivate(){
    if (_title.isNotEmpty && _description.isNotEmpty && !_isPostActive)
      setState(() {
        _isPostActive = true;
      });
    else if((_title.isEmpty || _description.isEmpty) && _isPostActive)
      setState(() {
        _isPostActive=false;
      });
  }

  _onTitleChanged(String value) {
    _title = value;
    _checkPostBtnActivate();
  }

  _onPostClicked() {
    if (_title.isNotEmpty && _description.isNotEmpty) {
      _landingScreenBloc.onNewPostCreated(Post(
          id: Random().nextInt(9999),
          title: _title,
          postTime:
              DateTimeHelper.toMMMDDHHMM(DateTime.now().millisecondsSinceEpoch),
          post: _description,
          user: LoggedInUser().user,
          comments: []));
      Navigator.pop(context);
    }
  }
}
