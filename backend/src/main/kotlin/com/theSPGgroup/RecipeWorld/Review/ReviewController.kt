package com.theSPGgroup.RecipeWorld.Review

import com.theSPGgroup.RecipeWorld.Recipe.RecipeDTOMapper
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*
import java.util.UUID

@RestController
@RequestMapping("/api/review")
class ReviewController(@Autowired val reviewService: ReviewService) {

    @PostMapping("/add")
    fun addReview(@RequestBody reviewRequest: ReviewRequest): ResponseEntity<Any> {
        return reviewService.addReview(reviewRequest.userId, reviewRequest.recipeId, reviewRequest.comment)
    }

    @GetMapping("/recipe/{recipeId}")
    fun getReviewsByRecipe(@PathVariable("recipeId") recipeId: Long): List<ReviewDTO> {
        return reviewService.getReviewsByRecipe(recipeId).map { review ->
            ReviewDTO(
                review.id,
                UserDTOMapper.mapUserToUserDTO(review.user),
                RecipeDTOMapper.mapRecipeToRecipeDTO(review.recipe),
                review.comment
            )
        }
    }

    @DeleteMapping("/{id}")
    fun deleteReview(@PathVariable("id") reviewId: Long): ResponseEntity<Any> {
        return reviewService.deleteReview(reviewId)
    }

    @GetMapping("/user/{userId}")
    fun getReviewsByUser(@PathVariable("userId") userId: String): List<ReviewDTO> {
        return reviewService.getReviewsByUser(UUID.fromString(userId)).map { review ->
            ReviewDTO(
                review.id,
                UserDTOMapper.mapUserToUserDTO(review.user),
                RecipeDTOMapper.mapRecipeToRecipeDTO(review.recipe),
                review.comment
            )
        }
    }
}
