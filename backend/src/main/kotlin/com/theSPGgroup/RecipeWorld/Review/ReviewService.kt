package com.theSPGgroup.RecipeWorld.Review


import com.theSPGgroup.RecipeWorld.Recipe.RecipeRepository
import com.theSPGgroup.RecipeWorld.User.UserRepository
import jakarta.persistence.EntityNotFoundException
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.stereotype.Service
import java.util.*

@Service
class ReviewService(
    @Autowired val reviewRepository: ReviewRepository,
    @Autowired val userRepository: UserRepository,
    @Autowired val recipeRepository: RecipeRepository
) {

    fun addReview(userId: String, recipeId: Long, comment: String): ResponseEntity<Any> {
        val user = userRepository.findById(UUID.fromString(userId))
            .orElseThrow { EntityNotFoundException("User not found") }

        val recipe = recipeRepository.findById(recipeId)
            .orElseThrow { EntityNotFoundException("Recipe not found") }

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
