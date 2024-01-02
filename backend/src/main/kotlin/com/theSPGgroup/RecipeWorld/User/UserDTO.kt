package com.theSPGgroup.RecipeWorld.User

import java.util.UUID

data class UserDTO(
    val id: UUID,
    val username: String,
    val favouriteRecipes: MutableSet<Long>
) {}