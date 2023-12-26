package com.theSPGgroup.RecipeWorld.Config

import com.theSPGgroup.RecipeWorld.User.UserRepository
import com.theSPGgroup.RecipeWorld.User.User
import com.theSPGgroup.RecipeWorld.Recipe.Recipe
import com.theSPGgroup.RecipeWorld.Recipe.RecipeRepository
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
    private val reviewRepository: ReviewRepository
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
            userRepository.saveAll(
                listOf(user1, user2)
            )

            val recipe1 = Recipe(
                title = "Chocolate Cake",
                description = "Delicious chocolate cake recipe",
                date = LocalDateTime.now(),
                author = user1
            )
            val recipe2 = Recipe(
                title = "Spaghetti Bolognese",
                description = "Classic spaghetti bolognese recipe",
                date = LocalDateTime.now(),
                author = user2
            )
            recipeRepository.saveAll(
                listOf(recipe1, recipe2)
            )

            val review1 = Review(
                user = user1,
                comment = "Very good, gave me butterflies!",
                recipe = recipe1
            )
            val review2 = Review(
                user = user2,
                comment = "So bad, diarrhea guaranteed!",
                recipe = recipe2
            )
        }
    }
}
