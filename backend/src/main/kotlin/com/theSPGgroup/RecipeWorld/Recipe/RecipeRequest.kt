package com.theSPGgroup.RecipeWorld.Recipe

data class RecipeRequest(
    val userId: String,
    val categoryId: Long,
    val recipe: Recipe
)