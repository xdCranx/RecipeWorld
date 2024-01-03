package com.theSPGgroup.RecipeWorld.Recipe

import com.theSPGgroup.RecipeWorld.Category.Category
import com.theSPGgroup.RecipeWorld.RecipeIngredient.RecipeIngredientDTO
import com.theSPGgroup.RecipeWorld.User.UserDTO
import java.time.LocalDateTime

data class RecipeDTO(
    val id: Long,
    val title: String,
    val description: String,
    val date: LocalDateTime,
    val prepTime: Int,
    val category: Category,
    val author: UserDTO,
    val recipeIngredients: List<RecipeIngredientDTO>
) {}
