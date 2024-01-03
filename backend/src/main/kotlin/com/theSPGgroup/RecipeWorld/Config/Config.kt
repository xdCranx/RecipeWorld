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
import java.util.*

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

            val user1 = User(
                UUID.randomUUID(),
                "Major1",
                "Pajor1"
            )
            val user2 = User(
                UUID.randomUUID(),
                "Major2",
                "Pajor2"
            )
            val user3 = User(
                UUID.randomUUID(),
                "Major3",
                "Pajor3"
            )
            val user4 = User(
                UUID.randomUUID(),
                "Major4",
                "Pajor4"
            )
            userRepository.saveAll(
                listOf(user1, user2, user3, user4)
            )

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
                name = "Tomatoes",
                unit = IngredientUnit.SLICE
            )
            val ingredient10 = Ingredient(
                name = "Lettuce",
                unit = IngredientUnit.SLICE
            )
            ingredientsRepository.saveAll(
                listOf(ingredient1,
                    ingredient2,
                    ingredient3,
                    ingredient4,
                    ingredient5,
                    ingredient6,
                    ingredient7,
                    ingredient8,
                    ingredient9,
                    ingredient10, )
            )

            val category1 = Category(
                name = CategoryName.DINNER
            )
            val category2 = Category(
                name = CategoryName.DRINK
            )
            val category3 = Category(
                name = CategoryName.LUNCH
            )
            val category4 = Category(
                name = CategoryName.DESSERT
            )
            val category5 = Category(
                name = CategoryName.BREAKFAST
            )
            categoryRepository.saveAll(
                listOf(category1, category2, category3, category4, category5)
            )

            val recipe1 = Recipe(
                title = "Chocolate Cake",
                description = "Delicious chocolate cake recipe",
                date = LocalDateTime.now(),
                author = user1,
                category = category4,
                prepTime = 15,
            )
            val recipe2 = Recipe(
                title = "Spaghetti Bolognese",
                description = "Classic spaghetti bolognese recipe",
                date = LocalDateTime.now(),
                author = user2,
                category = category3,
                prepTime = 30,
            )
            val recipe3 = Recipe(
                title = "Bigos",
                description = "You gon luv it",
                date = LocalDateTime.now(),
                author = user1,
                category = category4,
                prepTime = 15,
            )
            val recipe4 = Recipe(
                title = "Schabowy",
                description = "Mom's like recipe",
                date = LocalDateTime.now(),
                author = user1,
                category = category4,
                prepTime = 15,
            )

            recipeRepository.saveAll(
                listOf(recipe1, recipe2, recipe3, recipe4)
            )

            val listOfCCakeIngr: MutableList<Pair<Long,Float>> = mutableListOf(
                1L to 200F,
                2L to 10F,
                3L to 0.5F
            )
            recipeIngredientService.addRecipeIngredient(recipe1, listOfCCakeIngr)

            val listOfSpaghettiIngr: MutableList<Pair<Long,Float>> = mutableListOf(
                5L to 4F,
                6L to 400F,
                7L to 500F,
                8L to 500F,
                9L to 10F
            )
            recipeIngredientService.addRecipeIngredient(recipe2, listOfSpaghettiIngr)

            val listOfBigosIngr: MutableList<Pair<Long,Float>> = mutableListOf(
                10L to 20F,
                6L to 500F,
                4L to 3F
            )
            recipeIngredientService.addRecipeIngredient(recipe3, listOfBigosIngr)

            val listOfSchabowyIngr: MutableList<Pair<Long,Float>> = mutableListOf(
                6L to 1000F
            )
            recipeIngredientService.addRecipeIngredient(recipe4, listOfSchabowyIngr)


            val review1 = Review(
                user = user1,
                comment = "Very good, gave me butterflies!",
                recipe = recipe2
            )
            val review2 = Review(
                user = user2,
                comment = "So bad, diarrhea guaranteed!",
                recipe = recipe1
            )

            reviewRepository.saveAll(listOf(review1, review2))

//            userService.addRecipeToFavorites(user1.id.toString(), recipe2.id.toString())
//            userService.addRecipeToFavorites(user3.id.toString(), recipe1.id.toString())
//            userService.addRecipeToFavorites(user3.id.toString(), recipe2.id.toString())
//            userService.addRecipeToFavorites(user4.id.toString(), recipe4.id.toString())
//            userService.addRecipeToFavorites(user2.id.toString(), recipe3.id.toString())



        }
    }
}
