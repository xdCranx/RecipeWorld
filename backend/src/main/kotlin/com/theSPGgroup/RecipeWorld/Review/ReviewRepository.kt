package com.theSPGgroup.RecipeWorld.Review

import org.springframework.data.jpa.repository.JpaRepository
import java.util.*

interface ReviewRepository : JpaRepository<Review, Long> {
    fun findByRecipeId(recipeId: Long): List<Review>
    fun findByUserId(userId: UUID): List<Review>
}
