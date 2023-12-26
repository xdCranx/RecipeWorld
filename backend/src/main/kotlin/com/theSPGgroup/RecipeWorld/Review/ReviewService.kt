package com.theSPGgroup.RecipeWorld.Review

import com.theSPGgroup.RecipeWorld.Recipe.Recipe
import com.theSPGgroup.RecipeWorld.User.User
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.stereotype.Service
import java.util.*

@Service
class ReviewService(@Autowired val reviewRepository: ReviewRepository) {

    fun addReview(user: User, recipe: Recipe, comment: String): ResponseEntity<Any> {
        val review = Review(
            user = user,
            recipe = recipe,
            comment = comment
        )
        reviewRepository.save(review)
        return ResponseEntity.ok("Review added successfully")
    }

    fun getReviewsByRecipe(recipeId: Long): List<Review> {
        return reviewRepository.findByRecipeId(recipeId)
    }

    fun deleteReview(reviewId: Long): ResponseEntity<Any> {
        return if (reviewRepository.existsById(reviewId)) {
            reviewRepository.deleteById(reviewId)
            ResponseEntity.ok("Review deleted successfully")
        } else {
            ResponseEntity.status(HttpStatus.NOT_FOUND).body("Review with id $reviewId not found")
        }
    }

    fun getReviewsByUser(userId: UUID): List<Review> {
        return reviewRepository.findByUserId(userId)
    }
}
