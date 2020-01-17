import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:voter_circle/AppTheme.dart';

import 'CreatePostScreen.dart';
import 'LandingScreenBloc.dart';
import 'LandingScreenProvider.dart';
import 'LandingScreenService.dart';
import 'LandingScreenServiceContract.dart';
import 'LoggedInUser.dart';
import 'LoginView.dart';
import 'PostView.dart';
import 'beans/Post.dart';
import 'beans/User.dart';

class LandingPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return LandingPageState();
  }

}

class LandingPageState extends State<LandingPage> with AutomaticKeepAliveClientMixin implements LandingScreenServiceContract{
  LandingScreenBloc _landingScreenBloc;
  LandingScreenProvider _landingScreenProvider;
  LandingScreenService _landingScreenService;

  @override
  void initState() {
    super.initState();
    _landingScreenBloc = LandingScreenBloc.getInstance;
    _landingScreenService = LandingScreenService.getInstance(this);
    _landingScreenService.getPosts();
    _landingScreenProvider = LandingScreenProvider(
      landingScreenBloc: _landingScreenBloc,
      child: _getLandingScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        body: SafeArea(
          top: true,
            bottom: true,
            child: Container(
              color: Colors.white,
                child: _landingScreenProvider)
        )
    );
  }

  _getLandingScreen () {
    return Stack(
      children: [
        Container(
        child: Column(
          children: <Widget>[
            _topBar,
            Expanded(
              child: Container(
                color:Colors.white,
                child: StreamBuilder<List<Post>>(
                    initialData: List<Post>(),
                    stream: _landingScreenBloc.postsStream,
                    builder: (context, snapshot) {
                        List<Post> lstPosts = snapshot.data;
                        print('posts ${lstPosts.length}');
                        print('posts ${lstPosts.length} ${jsonEncode(lstPosts)}');

                        return ListView.builder(
                          itemCount: lstPosts.length,
                          key: UniqueKey(),
                          itemBuilder: (BuildContext c, int i) =>
                              PostView(
                                  lstPosts[i],
                                      (Post newPost, int index) =>
                                      _onNewComment(newPost, index),
                                  i),
                        );
                    }),
              ),
            ),
          ],
        ),
      ),
        Positioned(
          right: 15,
          bottom: 15,
          child: Hero(
            tag: "new_post",
            child: GestureDetector(
              onTap:  _newPostClicked,
              child: Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  color:AppTheme.colorPrimary,
                  borderRadius: BorderRadius.all(Radius.circular(22.5)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black38,  blurRadius: 2)
                    ]
                ),
                child: Image.asset(
                  "assets/icons/writing.png",
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(10),
              ),
            ),
          ),
        ),]
    );
  }

  get _topBar => Container(
//    width: MediaQuery.of(context).size.width,
    padding: EdgeInsets.only(right: 20.0, left: 10, top: 20, bottom: 20),
    color: Colors.transparent,
    child: Row(
      children: <Widget>[
        _searchField,
      ],
    ),
  );

  get _searchField => Expanded(
    child: Container(
      height: 40,
      decoration: new BoxDecoration(
        color: Color(0xffeeeeee),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 2)
        ],
      ),
      child: TextFormField(
        autofocus: false,
//        focusNode: _searchFocusNode,
        maxLines: 1,
        textAlignVertical: TextAlignVertical.top,
        textCapitalization: TextCapitalization.characters,
        decoration: InputDecoration(
          hintText: 'Search here...',
          hintStyle: TextStyle(
              color: Colors.black.withOpacity(0.5),
              fontSize: 15,
              fontWeight: FontWeight.normal,
              letterSpacing: 1),
          contentPadding: EdgeInsets.all(10),
          border: InputBorder.none,
        ),
        style: TextStyle(
          color: Colors.orange,
          fontWeight: FontWeight.bold,
          fontSize: 17,
          letterSpacing: 1.5,
        ),
        textAlign: TextAlign.center,
//        onChanged: (newText) => _onSearchTextChanged(newText),
      ),
    ),
  );

  _onNewComment(Post newPost, int index) {
    print('callback');
    _landingScreenBloc.onNewComment(newPost, index);
  }

  @override
  onPostsFetchFailure() {
    print("------Fail to load data-------");
  }

  @override
  onPostsFetchSuccessful(List<Post> newPosts) {
    _landingScreenBloc.onNewPostsReceived(newPosts);
  }

  _newPostClicked() {
    if(LoggedInUser().user == null)
      showDialog(
          context: context,
          builder: (BuildContext bc) => LoginView(() => _onLoginSuccessful()),
          barrierDismissible: false);
    else
      Navigator.pushNamed(context, CreatePostScreen.route);
  }

  _onLoginSuccessful() {
    print("on login successful");
    LoggedInUser().user = User(
        imgUrl:"https://shortcut-test2.s3.amazonaws.com/uploads/role/attachment/104775/default_c6db2094dd726abfa6949e482e2eaa47.png",
        name: "Jonny Devito");
    Navigator.pushNamed(context, CreatePostScreen.route);
  }

  @override
  bool get wantKeepAlive => true;
}
