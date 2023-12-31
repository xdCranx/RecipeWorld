package com.theSPGgroup.RecipeWorld.RecipeIngredient

import com.theSPGgroup.RecipeWorld.Ingredients.Ingredient
import com.theSPGgroup.RecipeWorld.Recipe.Recipe
import jakarta.persistence.*

@Entity
data class RecipeIngredient (
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    val id: Long = 0,

    @ManyToOne
    @JoinColumn(name = "recipe_id")
    val recipe: Recipe,

    @ManyToOne
    @JoinColumn(name = "ingredient_id")
    val ingredient: Ingredient,

    val quantity: Float
)