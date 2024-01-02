package com.theSPGgroup.RecipeWorld.Recipe

data class RecipeRequest(
    val userId: String,
    val categoryId: Long,
    val recipeTitle: String,
    val recipeDescription: String,
    val recipeIngredients: MutableList<Pair<Long, Float>>,
    val recipePrepTime: Int
)