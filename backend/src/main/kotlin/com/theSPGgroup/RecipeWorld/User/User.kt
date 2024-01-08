package com.theSPGgroup.RecipeWorld.User

import com.fasterxml.jackson.annotation.JsonIgnore
import com.theSPGgroup.RecipeWorld.Recipe.Recipe
import com.theSPGgroup.RecipeWorld.Review.Review
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

    @OneToMany(mappedBy = "user", cascade = [CascadeType.ALL], orphanRemoval = true)
    @JsonIgnore
    val reviews: MutableList<Review> = mutableListOf(),

    @OneToMany(mappedBy = "author", cascade = [CascadeType.ALL], orphanRemoval = true)
    @JsonIgnore
    val userRecipes: MutableSet<Recipe> = mutableSetOf(),

    @ManyToMany(cascade = [CascadeType.ALL])
    @JoinTable(
        name = "users_favorites",
        joinColumns = [JoinColumn(name = "user_id")],
        inverseJoinColumns = [JoinColumn(name = "recipe_id")]
    )
    val favoriteRecipes: MutableSet<Recipe> = mutableSetOf()
)