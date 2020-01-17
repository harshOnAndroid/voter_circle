import 'dart:convert';

import 'package:http/http.dart' as http;
import 'LandingScreenServiceContract.dart';
import 'beans/Post.dart';

class LandingScreenService{
  static LandingScreenService _instance;
  LandingScreenServiceContract _serviceContract;

  LandingScreenService._(this._serviceContract);

  static LandingScreenService getInstance(LandingScreenServiceContract viewContract) => _instance = _instance?? LandingScreenService._(viewContract);

  getPosts() async {
    var response = await http.get(
      "https://demo2224830.mockable.io/posts",
    );


    if (response.statusCode == 200) {
      var r = jsonDecode(response.body);
      print("json decode $r");
      var list = List<Post>.from(r.map((_)=>Post.fromJson(_)));
      print("post list is ${list.runtimeType}");
      _serviceContract.onPostsFetchSuccessful(list);
    } else {
      print("Failure call in homescreen service.");
      _serviceContract.onPostsFetchFailure();
    }

  }

}