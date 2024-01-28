package com.theSPGgroup.RecipeWorld.RecipeIngredient

import com.theSPGgroup.RecipeWorld.Ingredients.IngredientUnit

data class RecipeIngredientDTO(
    val id: Long,
    val name: String,
    val unit: Enum<IngredientUnit>,
    val quantity: Float
)
