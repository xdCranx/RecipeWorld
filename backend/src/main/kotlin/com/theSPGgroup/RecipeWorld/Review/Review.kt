package com.theSPGgroup.RecipeWorld.Review

import com.theSPGgroup.RecipeWorld.User.User
import com.theSPGgroup.RecipeWorld.Recipe.Recipe
import jakarta.persistence.*

@Entity
data class Review(
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    val id: Long = 0,

    @ManyToOne
    @JoinColumn(name = "user_id", nullable = false)
    val user: User,

    @ManyToOne
    @JoinColumn(name = "recipe_id", nullable = false)
    val recipe: Recipe,

    @Column(nullable = false)
    val comment: String
)
