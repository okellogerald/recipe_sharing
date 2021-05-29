//import 'package:http/http.dart' as http;
import 'package:recipes_sharing/DATA/recipes_data.dart';

class RecipesApiFunctions {
//  final String _recipesApiKey = '53a58165d04048e8ba73c24b579fe497';

  Future<List<RecipesData>> fetchFeaturedRecipes() async {
    List<RecipesData> recipesData = [];
    recipesList.forEach((element) async {
      print(element['title']);
      recipesData.add(RecipesData(
          title: element['title'],
          authorImage: element['authorImage'],
          videoLink: element['videoLink'],
          authorName: element['authorName'],
          recipeImage: element['recipeImage'],
          chilling: element['chilling'],
          servings: element['servings'],
          difficulty: element['difficulty'],
          recipeDescription: element['recipeDescription'],
          baking: element['baking'],
          steps: element['steps'],
          ingredients: element['ingredients'],
          length: element['length']));
    });

    return recipesData;
  }

  List<Map<String, dynamic>> recipesList = [
    {
      'title': 'Honey Garlic Glazed Salmon',
      'authorImage':
          'https://images.pexels.com/photos/3435323/pexels-photo-3435323.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
      'videoLink':
          'https://firebasestorage.googleapis.com/v0/b/best-ever-recipes-app.appspot.com/o/How%20to%20Cook%20Roast%20Chicken%20_%20Jamie%20Oliver.mp4?alt=media&token=043c9d93-bcdc-4035-acf6-f8da26b349fc',
      'authorName': 'Olivia',
      'posted': 89,
      'length': 95,
      'baking': 60,
      'chilling': 0,
      'difficulty': 'Easy',
      'ingredients': [
        {'quantity': 1, 'measure': 'lb', 'ingredient': 'bacon slices'},
        {'quantity': 1, 'measure': 'lb', 'ingredient': 'ground chicken'},
        {
          'quantity': 1,
          'measure': 'tbsp',
          'ingredient': 'barbeque chicken seasoning'
        },
        {'quantity': 3, 'measure': 'slices', 'ingredient': 'Havarti cheese'}
      ],
      'steps': [
        {
          'step':
              'Preheat oven to 425 degrees F (220 degrees C). Measure out a 20-inch square piece of parchment paper on a baking sheet.',
          'step-ingredients': [],
          'image':
              'https://images.pexels.com/photos/3770002/pexels-photo-3770002.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'
        },
        {
          'step':
              'Lay out slices of bacon side-by-side, overlapping slightly, to create an even layer on the parchment paper.',
          'step-ingredients': ['Bacon slices', 'Mustard seeds'],
          'image':
              'https://images.pexels.com/photos/1927377/pexels-photo-1927377.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'
        },
        {
          'step':
              'Combine ground chicken with barbeque seasoning; spread evenly onto the bacon layer from edge to edge. Place Havarti cheese slices lengthwise on top. Lift the parchment paper to help you roll a log, starting with the edge of bacon closest to you.',
          'step-ingredients': ['BBQ seasoning'],
          'image':
              'https://images.pexels.com/photos/6287302/pexels-photo-6287302.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'
        },
        {
          'step':
              'Bake in the preheated oven, rotating baking sheet every 15 minutes, until bacon is crispy and chicken is cooked through; an instant-read thermometer inserted into the center should read at least 165 degrees F (74 degrees C), about 1 hour.',
          'step-ingredients': ['Black Pepper', 'Clove'],
          'image':
              'https://images.pexels.com/photos/3992206/pexels-photo-3992206.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'
        },
        {
          'step':
              'Remove from oven and cool until easily handled, about 15 minutes. Slice into bite-sized "sushi".',
          'step-ingredients': [],
          'image':
              'https://images.pexels.com/photos/821365/pexels-photo-821365.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'
        }
      ],
      'servings': 20,
      'recipeDescription':
          'I saw this bacon sushi idea online somewhere, but I did not save it, so I had to wing it from memory and kept it as simple as possible. I made it for the March Madness final and the whole family loved it! I made it in the toaster oven on convection at 400 degrees F (200 degrees C) and kept a close eye on it.',
      'recipeImage':
          'https://hips.hearstapps.com/del.h-cdn.co/assets/17/39/1506456214-delish-honey-garlic-glazed-salmon.jpg?crop=1xw:1xh;center,top&resize=980:*'
    },
    //
    //
    //
    //1

    {
      'title': 'Black Bean Tostadas',
      'authorImage':
          'https://images.pexels.com/photos/2738919/pexels-photo-2738919.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
      'videoLink':
          'https://player.vimeo.com/external/392885477.sd.mp4?s=bdc3b807545c8c3eb5a633e4e2cdae2f0bed34cf&profile_id=139&oauth2_token_id=57447761',
      'authorName': 'Emma',
      'posted': 89,
      'length': 95,
      'baking': 60,
      'chilling': 0,
      'difficulty': 'Easy',
      'ingredients': [
        {'quantity': 1, 'measure': 'lb', 'ingredient': 'bacon slices'},
        {'quantity': 1, 'measure': 'lb', 'ingredient': 'ground chicken'},
        {
          'quantity': 1,
          'measure': 'tbsp',
          'ingredient': 'barbeque chicken seasoning'
        },
        {'quantity': 3, 'measure': 'slices', 'ingredient': 'Havarti cheese'}
      ],
      'steps': [
        {
          'step':
              'Preheat oven to 425 degrees F (220 degrees C). Measure out a 20-inch square piece of parchment paper on a baking sheet.',
          'step-ingredients': [],
          'image':
              'https://images.pexels.com/photos/3770002/pexels-photo-3770002.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'
        },
        {
          'step':
              'Lay out slices of bacon side-by-side, overlapping slightly, to create an even layer on the parchment paper.',
          'step-ingredients': ['Bacon slices', 'Mustard seeds'],
          'image':
              'https://images.pexels.com/photos/1927377/pexels-photo-1927377.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'
        },
        {
          'step':
              'Combine ground chicken with barbeque seasoning; spread evenly onto the bacon layer from edge to edge. Place Havarti cheese slices lengthwise on top. Lift the parchment paper to help you roll a log, starting with the edge of bacon closest to you.',
          'step-ingredients': ['BBQ seasoning'],
          'image':
              'https://images.pexels.com/photos/6287302/pexels-photo-6287302.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'
        },
        {
          'step':
              'Bake in the preheated oven, rotating baking sheet every 15 minutes, until bacon is crispy and chicken is cooked through; an instant-read thermometer inserted into the center should read at least 165 degrees F (74 degrees C), about 1 hour.',
          'step-ingredients': ['Black Pepper', 'Clove'],
          'image':
              'https://images.pexels.com/photos/3992206/pexels-photo-3992206.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'
        },
        {
          'step':
              'Remove from oven and cool until easily handled, about 15 minutes. Slice into bite-sized "sushi".',
          'step-ingredients': [],
          'image':
              'https://images.pexels.com/photos/821365/pexels-photo-821365.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'
        }
      ],
      'servings': 20,
      'recipeDescription':
          'I saw this bacon sushi idea online somewhere, but I did not save it, so I had to wing it from memory and kept it as simple as possible. I made it for the March Madness final and the whole family loved it! I made it in the toaster oven on convection at 400 degrees F (200 degrees C) and kept a close eye on it.',
      'recipeImage':
          'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/delish-202101-blackbeantostadas-046-ls-1610740382.jpg?crop=0.835xw:1.00xh;0,0&resize=980:*'
    },
    //
    //
    //
    //2

    {
      'title': 'Bacon & Spinach Stuffed Chicken ',
      'authorImage':
          'https://images.pexels.com/photos/1820559/pexels-photo-1820559.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
      'videoLink':
          'https://player.vimeo.com/external/552686372.sd.mp4?s=b27f476ec5fefcaeae45a4b633060a0848da55cf&profile_id=164&oauth2_token_id=57447761',
      'authorName': 'Lily Winston',
      'posted': 89,
      'length': 95,
      'baking': 60,
      'chilling': 0,
      'difficulty': 'Easy',
      'ingredients': [
        {'quantity': 1, 'measure': 'lb', 'ingredient': 'bacon slices'},
        {'quantity': 1, 'measure': 'lb', 'ingredient': 'ground chicken'},
        {
          'quantity': 1,
          'measure': 'tbsp',
          'ingredient': 'barbeque chicken seasoning'
        },
        {'quantity': 3, 'measure': 'slices', 'ingredient': 'Havarti cheese'}
      ],
      'steps': [
        {
          'step':
              'Preheat oven to 425 degrees F (220 degrees C). Measure out a 20-inch square piece of parchment paper on a baking sheet.',
          'step-ingredients': [],
          'image':
              'https://images.pexels.com/photos/3770002/pexels-photo-3770002.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'
        },
        {
          'step':
              'Lay out slices of bacon side-by-side, overlapping slightly, to create an even layer on the parchment paper.',
          'step-ingredients': ['Bacon slices', 'Mustard seeds'],
          'image':
              'https://images.pexels.com/photos/1927377/pexels-photo-1927377.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'
        },
        {
          'step':
              'Combine ground chicken with barbeque seasoning; spread evenly onto the bacon layer from edge to edge. Place Havarti cheese slices lengthwise on top. Lift the parchment paper to help you roll a log, starting with the edge of bacon closest to you.',
          'step-ingredients': ['BBQ seasoning'],
          'image':
              'https://images.pexels.com/photos/6287302/pexels-photo-6287302.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'
        },
        {
          'step':
              'Bake in the preheated oven, rotating baking sheet every 15 minutes, until bacon is crispy and chicken is cooked through; an instant-read thermometer inserted into the center should read at least 165 degrees F (74 degrees C), about 1 hour.',
          'step-ingredients': ['Black Pepper', 'Clove'],
          'image':
              'https://images.pexels.com/photos/3992206/pexels-photo-3992206.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'
        },
        {
          'step':
              'Remove from oven and cool until easily handled, about 15 minutes. Slice into bite-sized "sushi".',
          'step-ingredients': [],
          'image':
              'https://images.pexels.com/photos/821365/pexels-photo-821365.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'
        }
      ],
      'servings': 20,
      'recipeDescription':
          'I saw this bacon sushi idea online somewhere, but I did not save it, so I had to wing it from memory and kept it as simple as possible. I made it for the March Madness final and the whole family loved it! I made it in the toaster oven on convection at 400 degrees F (200 degrees C) and kept a close eye on it.',
      'recipeImage':
          'https://hips.hearstapps.com/hmg-prod.s3.amazonaws.com/images/07-bacon-spinach-stuffed-chicken-11866-v-1582648479.jpg?crop=1xw:1xh;center,top&resize=980:*'
    },

    //
    //
    //
    //3

    {
      'title': 'Grilled Berbeque',
      'authorImage':
          'https://images.pexels.com/photos/261941/pexels-photo-261941.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
      'videoLink':
          'https://player.vimeo.com/external/377040570.sd.mp4?s=c2a4ca66fa313528219a3929b90c8f0699d2ad49&profile_id=139&oauth2_token_id=57447761',
      'authorName': 'Sophie',
      'posted': 89,
      'length': 95,
      'baking': 60,
      'chilling': 0,
      'difficulty': 'Easy',
      'ingredients': [
        {'quantity': 1, 'measure': 'lb', 'ingredient': 'bacon slices'},
        {'quantity': 1, 'measure': 'lb', 'ingredient': 'ground chicken'},
        {
          'quantity': 1,
          'measure': 'tbsp',
          'ingredient': 'barbeque chicken seasoning'
        },
        {'quantity': 3, 'measure': 'slices', 'ingredient': 'Havarti cheese'}
      ],
      'steps': [
        {
          'step':
              'Preheat oven to 425 degrees F (220 degrees C). Measure out a 20-inch square piece of parchment paper on a baking sheet.',
          'step-ingredients': [],
          'image':
              'https://images.pexels.com/photos/3770002/pexels-photo-3770002.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'
        },
        {
          'step':
              'Lay out slices of bacon side-by-side, overlapping slightly, to create an even layer on the parchment paper.',
          'step-ingredients': ['Bacon slices', 'Mustard seeds'],
          'image':
              'https://images.pexels.com/photos/1927377/pexels-photo-1927377.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'
        },
        {
          'step':
              'Combine ground chicken with barbeque seasoning; spread evenly onto the bacon layer from edge to edge. Place Havarti cheese slices lengthwise on top. Lift the parchment paper to help you roll a log, starting with the edge of bacon closest to you.',
          'step-ingredients': ['BBQ seasoning'],
          'image':
              'https://images.pexels.com/photos/6287302/pexels-photo-6287302.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'
        },
        {
          'step':
              'Bake in the preheated oven, rotating baking sheet every 15 minutes, until bacon is crispy and chicken is cooked through; an instant-read thermometer inserted into the center should read at least 165 degrees F (74 degrees C), about 1 hour.',
          'step-ingredients': ['Black Pepper', 'Clove'],
          'image':
              'https://images.pexels.com/photos/3992206/pexels-photo-3992206.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'
        },
        {
          'step':
              'Remove from oven and cool until easily handled, about 15 minutes. Slice into bite-sized "sushi".',
          'step-ingredients': [],
          'image':
              'https://images.pexels.com/photos/821365/pexels-photo-821365.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'
        }
      ],
      'servings': 20,
      'recipeDescription':
          'I saw this bacon sushi idea online somewhere, but I did not save it, so I had to wing it from memory and kept it as simple as possible. I made it for the March Madness final and the whole family loved it! I made it in the toaster oven on convection at 400 degrees F (200 degrees C) and kept a close eye on it.',
      'recipeImage':
          'https://images.pexels.com/photos/3186654/pexels-photo-3186654.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'
    },

    //
    //
    //
    //
    //4
    {
      'title': 'Vegetable Salad',
      'authorImage':
          'https://images.pexels.com/photos/2905827/pexels-photo-2905827.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
      'videoLink':
          'https://player.vimeo.com/external/377040570.sd.mp4?s=c2a4ca66fa313528219a3929b90c8f0699d2ad49&profile_id=139&oauth2_token_id=57447761',
      'authorName': 'Ava',
      'posted': 89,
      'length': 95,
      'baking': 60,
      'chilling': 0,
      'difficulty': 'Easy',
      'ingredients': [
        {'quantity': 1, 'measure': 'lb', 'ingredient': 'bacon slices'},
        {'quantity': 1, 'measure': 'lb', 'ingredient': 'ground chicken'},
        {
          'quantity': 1,
          'measure': 'tbsp',
          'ingredient': 'barbeque chicken seasoning'
        },
        {'quantity': 3, 'measure': 'slices', 'ingredient': 'Havarti cheese'}
      ],
      'steps': [
        {
          'step':
              'Preheat oven to 425 degrees F (220 degrees C). Measure out a 20-inch square piece of parchment paper on a baking sheet.',
          'step-ingredients': [],
          'image':
              'https://images.pexels.com/photos/3770002/pexels-photo-3770002.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'
        },
        {
          'step':
              'Lay out slices of bacon side-by-side, overlapping slightly, to create an even layer on the parchment paper.',
          'step-ingredients': ['Bacon slices', 'Mustard seeds'],
          'image':
              'https://images.pexels.com/photos/1927377/pexels-photo-1927377.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'
        },
        {
          'step':
              'Combine ground chicken with barbeque seasoning; spread evenly onto the bacon layer from edge to edge. Place Havarti cheese slices lengthwise on top. Lift the parchment paper to help you roll a log, starting with the edge of bacon closest to you.',
          'step-ingredients': ['BBQ seasoning'],
          'image':
              'https://images.pexels.com/photos/6287302/pexels-photo-6287302.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'
        },
        {
          'step':
              'Bake in the preheated oven, rotating baking sheet every 15 minutes, until bacon is crispy and chicken is cooked through; an instant-read thermometer inserted into the center should read at least 165 degrees F (74 degrees C), about 1 hour.',
          'step-ingredients': ['Black Pepper', 'Clove'],
          'image':
              'https://images.pexels.com/photos/3992206/pexels-photo-3992206.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'
        },
        {
          'step':
              'Remove from oven and cool until easily handled, about 15 minutes. Slice into bite-sized "sushi".',
          'step-ingredients': [],
          'image':
              'https://images.pexels.com/photos/821365/pexels-photo-821365.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'
        }
      ],
      'servings': 20,
      'recipeDescription':
          'I saw this bacon sushi idea online somewhere, but I did not save it, so I had to wing it from memory and kept it as simple as possible. I made it for the March Madness final and the whole family loved it! I made it in the toaster oven on convection at 400 degrees F (200 degrees C) and kept a close eye on it.',
      'recipeImage':
          'https://images.pexels.com/photos/1640777/pexels-photo-1640777.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'
    },
  ];
}
