package com.theSPGgroup.RecipeWorld.Review

import com.theSPGgroup.RecipeWorld.Recipe.RecipeDTO
import com.theSPGgroup.RecipeWorld.User.UserDTO

data class ReviewDTO(
    val id: Long,
    val user: UserDTO,
    val recipe: RecipeDTO,
    val comment: String
) {}