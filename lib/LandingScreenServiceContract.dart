
import 'beans/Post.dart';

abstract class LandingScreenServiceContract{
  onPostsFetchSuccessful(List<Post> newPosts);
  onPostsFetchFailure();
}