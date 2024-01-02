package com.theSPGgroup.RecipeWorld.User

import com.theSPGgroup.RecipeWorld.Recipe.Recipe
import java.util.UUID

data class UserDTO(
    val id: UUID,
    val username: String,
    val favouriteRecipes: MutableSet<Long>
) {}