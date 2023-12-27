package com.theSPGgroup.RecipeWorld.User

import com.theSPGgroup.RecipeWorld.Recipe.Recipe
import jakarta.persistence.*
import java.util.UUID
@Entity
@Table
data class User(
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)

    val id: UUID = UUID.randomUUID(),
    val username: String,
    val password: String,

    @ManyToMany
    @JoinTable(
        name = "user_favourites",
        joinColumns = [JoinColumn(name = "user_id")],
        inverseJoinColumns = [JoinColumn(name = "recipe_id")]
    )
    val favouriteRecipes: MutableSet<Recipe> = mutableSetOf()
)