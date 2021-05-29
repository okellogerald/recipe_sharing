import 'package:recipes_sharing/STATE/FUNCTIONS/recipes_functions.dart';
import 'package:recipes_sharing/source.dart';

abstract class RecipesState {
  void dispose();
}

enum RecipesEvents { startFetching, doneFetching }

class RecipesBloc extends RecipesState {
  final _recipesFunctions = RecipesApiFunctions();
  StreamController<List<RecipesData>> _featuredRecipesStreamController =
      StreamController.broadcast();
  StreamSink<List<RecipesData>> get featuredRecipesSink =>
      _featuredRecipesStreamController.sink;
  Stream<List<RecipesData>> get featuredRecipesStream =>
      _featuredRecipesStreamController.stream;

  StreamController<RecipesEvents> _featuredRecipesEventsStreamController =
      StreamController.broadcast();
  StreamSink<RecipesEvents> get featuredRecipesEventsSink =>
      _featuredRecipesEventsStreamController.sink;
  Stream<RecipesEvents> get featuredRecipesEventsStream =>
      _featuredRecipesEventsStreamController.stream;

  RecipesBloc() {
    featuredRecipesEventsStream.listen((event) async {
      if (event == RecipesEvents.startFetching) {
        List<RecipesData> list = await _recipesFunctions.fetchFeaturedRecipes();
        featuredRecipesSink.add(list);
        featuredRecipesEventsSink.add(RecipesEvents.doneFetching);
      }
    });
  }

  @override
  void dispose() {
    _featuredRecipesStreamController.close();
    _featuredRecipesEventsStreamController.close();
  }
}
