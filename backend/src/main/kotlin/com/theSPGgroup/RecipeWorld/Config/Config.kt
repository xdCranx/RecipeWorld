package com.theSPGgroup.RecipeWorld.Config

import com.theSPGgroup.RecipeWorld.Category.Category
import com.theSPGgroup.RecipeWorld.Category.CategoryName
import com.theSPGgroup.RecipeWorld.Category.CategoryRepository
import com.theSPGgroup.RecipeWorld.Ingredients.Ingredient
import com.theSPGgroup.RecipeWorld.Ingredients.IngredientUnit
import com.theSPGgroup.RecipeWorld.Ingredients.IngredientsRepository
import com.theSPGgroup.RecipeWorld.User.UserRepository
import com.theSPGgroup.RecipeWorld.User.User
import com.theSPGgroup.RecipeWorld.Recipe.Recipe
import com.theSPGgroup.RecipeWorld.Recipe.RecipeRepository
import com.theSPGgroup.RecipeWorld.RecipeIngredient.RecipeIngredientService
import com.theSPGgroup.RecipeWorld.Review.Review
import com.theSPGgroup.RecipeWorld.Review.ReviewRepository
import org.springframework.boot.CommandLineRunner
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import java.time.LocalDateTime

@Configuration
class Config(
    private val userRepository: UserRepository,
    private val recipeRepository: RecipeRepository,
    private val reviewRepository: ReviewRepository,
    private val ingredientsRepository: IngredientsRepository,
    private val categoryRepository: CategoryRepository,
    private val recipeIngredientService: RecipeIngredientService,
) {

    @Bean
    fun commandLineRunner(): CommandLineRunner {
        return CommandLineRunner {
//===USERS===
            val user1 = User(
                username = "Major1",
                password = "Pajor1"
            )
            val user2 = User(
                username = "julix12",
                password = "delfinek123"
            )
            val user3 = User(
                username = "Smiley001",
                password = "haslo123"
            )
            val user4 = User(
                username = "KszycheU",
                password = "csvfilefan"
            )
            val user5 = User(
                username = "Not_Broken",
                password = "drzwisaspoko98"
            )
            val user6 = User(
                username = "rol-ex",
                password = "piwoiburger30938"
            )
            val user7 = User(
                username = "KolekcjonerDusz",
                password = "PDWiSLU997"
            )
            val user8 = User(
                username = "nugla3371",
                password = "HolowniaGigaChad"
            )
            val user9 = User(
                username = "KapitanTorpeda1",
                password = "chcewiecejdymu"
            )
            val user10 = User(
                username = "glupia_foliara",
                password = "wkleslablondyna123"
            )
            userRepository.saveAll(
                listOf(
                    user1,
                    user2,
                    user3,
                    user4,
                    user5,
                    user6,
                    user7,
                    user8,
                    user9,
                    user10
                )
            )
//===INGREDIENTS===
            val ingredient1 = Ingredient(
                name = "Flour",
                unit = IngredientUnit.GRAMS
            )
            val ingredient2 = Ingredient(
                name = "Sugar",
                unit = IngredientUnit.GRAMS
            )
            val ingredient3 = Ingredient(
                name = "Milk",
                unit = IngredientUnit.MILLILITERS
            )
            val ingredient4 = Ingredient(
                name = "Bread",
                unit = IngredientUnit.SLICE
            )
            val ingredient5 = Ingredient(
                name = "Cheese",
                unit = IngredientUnit.SLICE
            )
            val ingredient6 = Ingredient(
                name = "Meat",
                unit = IngredientUnit.GRAMS
            )
            val ingredient7 = Ingredient(
                name = "Water",
                unit = IngredientUnit.MILLILITERS
            )
            val ingredient8 = Ingredient(
                name = "Pasta",
                unit = IngredientUnit.GRAMS
            )
            val ingredient9 = Ingredient(
                name = "Tomato",
                unit = IngredientUnit.SLICE
            )
            val ingredient10 = Ingredient(
                name = "Lettuce",
                unit = IngredientUnit.NONE
            )
            val ingredient11 = Ingredient(
                name = "Cocoa powder",
                unit = IngredientUnit.GRAMS
            )
            val ingredient12 = Ingredient(
                name = "Baking powder",
                unit = IngredientUnit.GRAMS
            )
            val ingredient13 = Ingredient(
                name = "Butter",
                unit = IngredientUnit.GRAMS
            )
            val ingredient14 = Ingredient(
                name = "Salt",
                unit = IngredientUnit.PINCHES
            )
            val ingredient15 = Ingredient(
                name = "Pepper",
                unit = IngredientUnit.PINCHES
            )
            val ingredient16 = Ingredient(
                name = "Egg",
                unit = IngredientUnit.NONE
            )
            val ingredient17 = Ingredient(
                name = "Chocolate",
                unit = IngredientUnit.GRAMS
            )
            val ingredient18 = Ingredient(
                name = "Powdered sugar",
                unit = IngredientUnit.GRAMS
            )
            val ingredient19 = Ingredient(
                name = "Chicken breast",
                unit = IngredientUnit.GRAMS
            )
            val ingredient20 = Ingredient(
                name = "Mayo",
                unit = IngredientUnit.TABLESPOON
            )
            val ingredient21 = Ingredient(
                name = "Garlic",
                unit = IngredientUnit.SLICE
            )
            val ingredient22 = Ingredient(
                name = "Canned tomatoes",
                unit = IngredientUnit.GRAMS
            )
            val ingredient23 = Ingredient(
                name = "Onion",
                unit = IngredientUnit.NONE
            )
            val ingredient24 = Ingredient(
                name = "Olive oil",
                unit = IngredientUnit.TABLESPOON
            )
            val ingredient25 = Ingredient(
                name = "Pickle",
                unit = IngredientUnit.NONE
            )
            val ingredient26 = Ingredient(
                name = "Carrot",
                unit = IngredientUnit.NONE
            )
            val ingredient27 = Ingredient(
                name = "Potato",
                unit = IngredientUnit.NONE
            )
            val ingredient28 = Ingredient(
                name = "Celery root",
                unit = IngredientUnit.GRAMS
            )
            val ingredient29 = Ingredient(
                name = "Leek",
                unit = IngredientUnit.NONE
            )
            val ingredient30 = Ingredient(
                name = "Sour Cream",
                unit = IngredientUnit.TABLESPOON
            )
            val ingredient31 = Ingredient(
                name = "Yeast",
                unit = IngredientUnit.GRAMS
            )
            val ingredient32 = Ingredient(
                name = "Ice cube",
                unit = IngredientUnit.GRAMS
            )
            val ingredient33 = Ingredient(
                name = "Lime",
                unit = IngredientUnit.NONE
            )
            val ingredient34 = Ingredient(
                name = "Brown Sugar",
                unit = IngredientUnit.GRAMS
            )
            val ingredient35 = Ingredient(
                name = "Bacardi",
                unit = IngredientUnit.MILLILITERS
            )
            val ingredient36 = Ingredient(
                name = "Mint",
                unit = IngredientUnit.SLICE
            )
            val ingredient37 = Ingredient(
                name = "Coffee",
                unit = IngredientUnit.MILLILITERS
            )

            ingredientsRepository.saveAll(
                listOf(
                    ingredient1,
                    ingredient2,
                    ingredient3,
                    ingredient4,
                    ingredient5,
                    ingredient6,
                    ingredient7,
                    ingredient8,
                    ingredient9,
                    ingredient10,
                    ingredient11,
                    ingredient12,
                    ingredient13,
                    ingredient14,
                    ingredient15,
                    ingredient16,
                    ingredient17,
                    ingredient18,
                    ingredient19,
                    ingredient20,
                    ingredient21,
                    ingredient22,
                    ingredient23,
                    ingredient24,
                    ingredient25,
                    ingredient26,
                    ingredient27,
                    ingredient28,
                    ingredient29,
                    ingredient30,
                    ingredient31,
                    ingredient32,
                    ingredient33,
                    ingredient34,
                    ingredient35,
                    ingredient36,
                    ingredient37,
                )
            )
//===CATEGORY===
            val dinner = Category(
                name = CategoryName.DINNER
            )
            val drink = Category(
                name = CategoryName.DRINK
            )
            val lunch = Category(
                name = CategoryName.LUNCH
            )
            val dessert = Category(
                name = CategoryName.DESSERT
            )
            val breakfast = Category(
                name = CategoryName.BREAKFAST
            )
            categoryRepository.saveAll(
                listOf(
                    dinner,
                    drink,
                    lunch,
                    dessert,
                    breakfast
                )
            )
//===RECIPE===

            val chocolateCake = Recipe(
                title = "Chocolate Cake",
                description = "Preheat the oven to 350°F (175°C) and grease a bundt cake pan.\n" +
                        "In a bowl, sift together flour, cocoa powder, and baking powder.\n" +
                        "In another bowl, cream together butter and sugar until light and fluffy.\n" +
                        "Add eggs one at a time, beating well after each addition. Stir in vanilla extract.\n" +
                        "Gradually mix in the dry ingredients, alternating with milk, until well combined.\n" +
                        "Melt the dark chocolate and let it cool slightly. Fold it into the batter.\n" +
                        "In a separate bowl, mix cinnamon and a bit of sugar for the filling.\n" +
                        "Pour half of the batter into the prepared pan, sprinkle the cinnamon mixture, and cover with the remaining batter.\n" +
                        "Use a knife to create a swirling pattern in the batter.\n" +
                        "Bake for about 50-60 minutes or until a toothpick inserted into the center comes out clean.\n" +
                        "Allow the cake to cool in the pan for 15 minutes, then transfer to a wire rack to cool completely.\n" +
                        "Dust with powdered sugar before serving.",
                date = LocalDateTime.now(),
                author = user1,
                category = dessert,
                prepTime = 40,
            )
            recipeRepository.save(chocolateCake)
            val listOfCCakeIngr: MutableList<Pair<Long,Float>> = mutableListOf(
                1L to 500F,
                11L to 30F,
                12L to 20F,
                2L to 100F,
                13L to 80F,
                16L to 2F
            )
            recipeIngredientService.addRecipeIngredient(chocolateCake, listOfCCakeIngr)

            //====================

            val omlette = Recipe(
                title = "Omlette",
                description = "Whisk eggs in a bowl, add milk, salt, and pepper.\n" +
                        "Heat a bit of oil or butter in a pan.\n" +
                        "Pour the eggs into the pan and wait until they set around the edges.\n" +
                        "Add chosen fillings (like cheese, ham or tomato) on one half of the omelette.\n" +
                        "Gently fold the omelette in half and cook for a minute.",
                date = LocalDateTime.now(),
                author = user1,
                category = breakfast,
                prepTime = 10,
            )
            recipeRepository.save(omlette)
            val listOfOmletteIngr: MutableList<Pair<Long,Float>> = mutableListOf(
                16L to 2F, //eggs
                3L to 10F, //milk
                14L to 1F, //salt
                15L to 1F, //pepper
            )
            recipeIngredientService.addRecipeIngredient(omlette, listOfOmletteIngr)

            //====================

            val caesarSalad = Recipe(
                title = "Caesar Salad",
                description = "Chop the lettuce, cook the chicken, and cut it into cubes.\n" +
                        "Bake the bread in the oven.\n" +
                        "Prepare the dressing: mix mayonnaise, crushed garlic, salt, and pepper.\n" +
                        "Combine lettuce, chicken, and bread, drizzle with the dressing.",
                date = LocalDateTime.now(),
                author = user2,
                category = lunch,
                prepTime = 35,
            )
            recipeRepository.save(caesarSalad)
            val listOfCaesarSaladIngr: MutableList<Pair<Long,Float>> = mutableListOf(
                10L to 1F, //lettuce
                4L to 3F, //bread
                19L to 200F, //chicken breast
                20L to 2F, //mayo
                21L to 1F, //garlic
                14L to 1F, //salt
                15L to 1F, //pepper
            )
            recipeIngredientService.addRecipeIngredient(caesarSalad, listOfCaesarSaladIngr)

            //====================

            val pancakes = Recipe(
                title = "Pancakes",
                description = "In a blender, combine 200g of all-purpose flour, 2 large eggs, 500ml of milk, 100ml of water, and a pinch of salt. Blend until smooth.\n" +
                        "Let the batter rest for about 30 minutes to an hour in the refrigerator.\n" +
                        "Heat a non-stick skillet over medium heat and add a small amount of butter to coat the pan.\n" +
                        "Pour a ladleful of batter (approximately 60-70g) into the center of the pan, swirling it to spread evenly.\n" +
                        "Cook until the edges start to lift and the bottom is golden brown (about 1-2 minutes).\n" +
                        "Flip the pancake and cook the other side until golden.\n" +
                        "Remove from the pan and repeat the process with the remaining batter.\n" +
                        "Fill each pancake with your favorite sweet or savory filling, fold or roll them, and serve.",
                date = LocalDateTime.now(),
                author = user2,
                category = breakfast,
                prepTime = 20,
            )
            recipeRepository.save(pancakes)
            val listOfPancakesIngr: MutableList<Pair<Long,Float>> = mutableListOf(
                16L to 2F, //eggs
                2L to 500F, //sugar
                14L to 1F, //salt
                1L to 200F, //flour
                7L to 100F, //water
                13L to 10F, //butter
            )
            recipeIngredientService.addRecipeIngredient(pancakes, listOfPancakesIngr)

            //====================

            val tomatoPasta = Recipe(
                title = "Tomato Pasta",
                description = "Cook pasta according to the package instructions.\n" +
                        "Heat olive oil in a pan, add chopped onion and garlic, sauté for a few minutes.\n" +
                        "Add canned tomatoes, season with salt, pepper and simmer for about 15 minutes.\n" +
                        "Serve the tomato sauce over the pasta.",
                date = LocalDateTime.now(),
                author = user3,
                category = dinner,
                prepTime = 30,
            )
            recipeRepository.save(tomatoPasta)
            val listOfTomatoPastaIngr: MutableList<Pair<Long,Float>> = mutableListOf(
                8L to 250F, //pasta
                22L to 400F, //canned tomatoes
                23L to 1F, //onion
                21L to 2F, //garlic
                24L to 2F, //olive oil
                14L to 1F, //salt
                15L to 1F, //pepper
            )
            recipeIngredientService.addRecipeIngredient(tomatoPasta, listOfTomatoPastaIngr)

            //====================

            val pickleSoup = Recipe(
                title = "Pickle Soup",
                description = "In a large pot, melt butter or heat oil over medium heat. Add the chopped onion and leek, sauté until softened.\n" +
                        "Add the diced carrots, celery root, and potatoes to the pot. Stir and cook for a few minutes until slightly tender.\n" +
                        "Pour in the pickle brine and add enough water to cover the vegetables. Bring the mixture to a boil.\n" +
                        "Once boiling, reduce the heat to a simmer and add the grated dill pickle, bay leaf, peppercorns, and dried marjoram. If using chicken, add it at this stage.\n" +
                        "Simmer the soup for about 20-25 minutes or until the vegetables are fully cooked.\n" +
                        "Season the soup with salt and pepper to taste. Adjust the acidity by adding more pickle brine if desired.\n" +
                        "Remove the bay leaf and peppercorns. Taste and adjust the seasoning if needed.\n" +
                        "Serve the soup hot, garnished with a dollop of sour cream and fresh dill.",
                date = LocalDateTime.now(),
                author = user3,
                category = lunch,
                prepTime = 70,
            )
            recipeRepository.save(pickleSoup)
            val listOfPickleSoupIngr: MutableList<Pair<Long,Float>> = mutableListOf(
                30L to 3F, //sour cream
                29L to 1F, //leek
                28L to 1F, //celery root
                27L to 2F, //potato
                26L to 2F, //carrot
                25L to 2F, //pickle
                19L to 350F, //chicken breast
                23L to 1F, //onion
            )
            recipeIngredientService.addRecipeIngredient(pickleSoup, listOfPickleSoupIngr)

            //====================

            val pizza = Recipe(
                title = "Pizza",
                description = "Mix yeast, sugar, and warm water. Wait for it to get frothy.\n" +
                        "Combine flour and salt in a bowl.\n" +
                        "Make a well in the center; pour in yeast mixture and olive oil.\n" +
                        "Mix until it forms a dough.\n" +
                        "Knead the dough for 5-7 minutes until smooth.\n" +
                        "Let the dough rise in an oiled bowl until doubled (1-1.5 hours).\n" +
                        "Preheat your oven to the highest temperature.\n" +
                        "Roll out the dough on a floured surface.\n" +
                        "Spread pizza sauce on the dough.\n" +
                        "Arrange fresh mozzarella and basil.\n" +
                        "Drizzle with olive oil, season with salt and pepper.\n" +
                        "Bake for 12-15 minutes or until golden.\n" +
                        "Remove, cool for a minute, then slice and serve hot.",
                date = LocalDateTime.now(),
                author = user4,
                category = dinner,
                prepTime = 120,
            )
            recipeRepository.save(pizza)
            val listOfPizzaIngr: MutableList<Pair<Long,Float>> = mutableListOf(
                31L to 2F, //yeast
                14L to 2F, //salt
                1L to 250F, //flour
                7L to 150F, //water
                2L to 5F, //sugar
                24L to 2F, //olive oil
            )
            recipeIngredientService.addRecipeIngredient(pizza, listOfPizzaIngr)

            //====================

            val cCCookies = Recipe(
                title = "Chocolate Chip Cookies",
                description = "Preheat oven to 180°C (350°F).\n" +
                        "Cream together butter and sugar until smooth. Add the egg and mix well.\n" +
                        "In a separate bowl, mix flour, baking powder, and salt.\n" +
                        "Gradually add dry ingredients to the butter mixture, mixing until combined.\n" +
                        "Fold in the chocolate chunks.\n" +
                        "Drop spoonfuls of dough onto a baking sheet lined with parchment paper.\n" +
                        "Bake for 10-12 minutes until golden brown around the edges.\n" +
                        "Let the cookies cool on the tray for a few minutes before transferring them to a wire rack to cool completely.",
                date = LocalDateTime.now(),
                author = user4,
                category = dessert,
                prepTime = 25,
            )
            recipeRepository.save(cCCookies)
            val listOfCCCookiesIngr: MutableList<Pair<Long,Float>> = mutableListOf(
                16L to 1F, //egg
                1L to 200F, //flour
                13L to 100F, //butter
                2L to 100F, //sugar
                12L to 5F, //baking powder
                14L to 1F, //salt
                17L to 100F, //chocolate
            )
            recipeIngredientService.addRecipeIngredient(cCCookies, listOfCCCookiesIngr)

            //====================

            val icedCoffee = Recipe(
                title = "Iced Coffee",
                description = "Brew coffee and let it cool in the refrigerator.\n" +
                        "Fill a glass with ice cubes.\n" +
                        "Pour chilled coffee over the ice.\n" +
                        "Add sugar and stir until dissolved.\n" +
                        "Add milk or cream to taste.\n" +
                        "Stir and enjoy your iced coffee.",
                date = LocalDateTime.now(),
                author = user5,
                category = drink,
                prepTime = 8,
            )
            recipeRepository.save(icedCoffee)
            val listOfIcedCoffeeIngr: MutableList<Pair<Long,Float>> = mutableListOf(
                3L to 100F, //milk
                37L to 80F, //coffee
                2L to 5F, //sugar
                32L to 10F, //ice cubes
            )
            recipeIngredientService.addRecipeIngredient(icedCoffee, listOfIcedCoffeeIngr)

            //====================

            val mojito = Recipe(
                title = "Mojito",
                description = "Muddle fresh mint leaves with sugar in a glass.\n" +
                        "Add fresh lime juice.\n" +
                        "Fill the glass with ice cubes.\n" +
                        "Pour in white rum.\n" +
                        "Stir to combine and chill.\n" +
                        "Top with soda water.\n" +
                        "Garnish with a slice of lime and a sprig of fresh mint.\n" +
                        "Stir gently before serving.\n",
                date = LocalDateTime.now(),
                author = user5,
                category = drink,
                prepTime = 10,
            )
            recipeRepository.save(mojito)
            val listOfMojitoIngr: MutableList<Pair<Long,Float>> = mutableListOf(
                34L to 10F, //sugar
                32L to 10F, //ice cubes
                35L to 60F,
                33L to 2F,
                36L to 20f,
                7L to 100F
            )
            recipeIngredientService.addRecipeIngredient(mojito, listOfMojitoIngr)

            //====================

//===REVIEW===
            val review1 = Review(
                user = user1,
                comment = "Very good, gave me butterflies!",
                recipe = chocolateCake
            )
            val review2 = Review(
                user = user7,
                comment = "So bad, diarrhea guaranteed!",
                recipe = pancakes
            )
            val review3 = Review(
                user = user8,
                comment = "I got sooo drunk",
                recipe = mojito
            )
            val review4 = Review(
                user = user9,
                comment = "Mamma mia!",
                recipe = pizza
            )
            val review5 = Review(
                user = user10,
                comment = "My italian neighbour Luigi says it is not pizza",
                recipe = pizza
            )
            val review6 = Review(
                user = user10,
                comment = "Molto tomato amore mia",
                recipe = tomatoPasta
            )

            reviewRepository.saveAll(
                listOf(
                    review1,
                    review2,
                    review3,
                    review4,
                    review5,
                    review6
                )
            )

        }
    }
}
