package com.theSPGgroup.RecipeWorld.Review

data class ReviewRequest(
    val userId: String,
    val recipeId: String,
    val comment: String
)