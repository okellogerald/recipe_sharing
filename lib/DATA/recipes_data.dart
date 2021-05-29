class RecipesData {
  String title, recipeImage, videoLink, authorImage, authorName, recipeDescription,difficulty;
  DateTime posted;
  int length, chilling, baking;
  List<Map<String, dynamic>> ingredients;
  List<Map<String, dynamic>> steps;
  int servings;
  RecipesData(
      {this.title,
      this.length,
      this.recipeImage,
      this.videoLink,
      this.authorImage,
      this.authorName,
      this.posted,
      this.recipeDescription,
      this.chilling,
      this.baking,
      this.ingredients,
      this.steps,
      this.servings,
      this.difficulty});
}
