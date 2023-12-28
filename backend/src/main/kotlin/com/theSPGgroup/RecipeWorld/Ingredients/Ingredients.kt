package com.theSPGgroup.RecipeWorld.Ingredients

import com.theSPGgroup.RecipeWorld.Recipe.RecipeIngredient
import jakarta.persistence.*

@Entity
@Table
data class Ingredient(
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    val id: Long = 0,

    @Column(nullable = false, unique = true)
    val name: String,

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    val unit: IngredientUnit,

    @OneToMany(mappedBy = "ingredient")
    val recipeIngredients: MutableSet<RecipeIngredient> = mutableSetOf()
)
