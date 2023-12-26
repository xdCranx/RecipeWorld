package com.theSPGgroup.RecipeWorld.Review

import com.theSPGgroup.RecipeWorld.Recipe.Recipe
import com.theSPGgroup.RecipeWorld.User.User
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*
import java.util.UUID

@RestController
@RequestMapping("/api/reviews")
class ReviewController(@Autowired val reviewService: ReviewService) {

    @PostMapping("/add")
    fun addReview(
        @RequestBody user: User,
        @RequestBody recipe: Recipe,
        @RequestBody comment: String
    ): ResponseEntity<Any> {
        return reviewService.addReview(user, recipe, comment)
    }

    @GetMapping("/recipe/{recipeId}")
    fun getReviewsByRecipe(@PathVariable("recipeId") recipeId: Long): List<Review> {
        return reviewService.getReviewsByRecipe(recipeId)
    }

    @DeleteMapping("/{id}")
    fun deleteReview(@PathVariable("id") reviewId: Long): ResponseEntity<Any> {
        return reviewService.deleteReview(reviewId)
    }

    @GetMapping("/user/{userId}")
    fun getReviewsByUser(@PathVariable("userId") userId: UUID): List<Review> {
        return reviewService.getReviewsByUser(userId)
    }
}
