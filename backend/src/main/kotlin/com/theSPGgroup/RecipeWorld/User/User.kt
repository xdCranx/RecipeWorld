package com.theSPGgroup.RecipeWorld.User

import com.fasterxml.jackson.annotation.JsonIgnoreProperties
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

    @ManyToMany(cascade = [CascadeType.PERSIST, CascadeType.MERGE], fetch = FetchType.LAZY)
    @JoinTable(
        name = "users_favorites",
        joinColumns = [JoinColumn(name = "user_id")],
        inverseJoinColumns = [JoinColumn(name = "recipe_id")]
    )@JsonIgnoreProperties("users") // Avoid circular reference when serializing
    val favoriteRecipes: MutableSet<Recipe> = mutableSetOf()
)