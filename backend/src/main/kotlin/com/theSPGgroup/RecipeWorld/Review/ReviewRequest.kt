package com.theSPGgroup.RecipeWorld.Review

data class ReviewRequest(
    val userId: String,
    val recipeId: Long,
    val comment: String
)