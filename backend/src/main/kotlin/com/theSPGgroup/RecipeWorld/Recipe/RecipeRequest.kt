package com.theSPGgroup.RecipeWorld.Recipe

data class RecipeRequest(
    val userId: String,
    val categoryId: Long,
    val title: String,
    val description: String,
    val ingredients: MutableList<Pair<Long, Float>>,
    val prepTime: Int
)