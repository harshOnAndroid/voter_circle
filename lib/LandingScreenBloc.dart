
import 'dart:convert';

import 'package:rxdart/subjects.dart';

import 'beans/Post.dart';


class LandingScreenBloc {
  static var _instance;
  final _postsSubject  = BehaviorSubject<List<Post>>();

  List<Post> _posts;
  Stream<List<Post>>  postsStream ;

  LandingScreenBloc._(){
    _instance = this;
    postsStream = _postsSubject.stream;
  }

  static LandingScreenBloc get getInstance => _instance??LandingScreenBloc._();



  void onNewPostsReceived(List<Post> newPosts) {
    _posts ??= List();
    _posts = _posts..addAll(newPosts);
    _postsSubject.add(_posts.reversed.toList());
  }

  void onNewComment(Post newPost, int index) {
    _posts[index] = newPost;
    print('on new comment ${jsonEncode(_posts)}');
    _postsSubject.add(_posts);
  }

//  dispose() {
//    _postsSubject.close();
//    _posts.clear();
//  }

  onNewPostCreated(Post post) {
    _posts.add(post);
    _postsSubject.add(_posts.reversed.toList());
  }
}