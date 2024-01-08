package com.theSPGgroup.RecipeWorld.Recipe

import com.fasterxml.jackson.annotation.JsonIgnore
import com.theSPGgroup.RecipeWorld.Category.Category
import com.theSPGgroup.RecipeWorld.RecipeIngredient.RecipeIngredient
import com.theSPGgroup.RecipeWorld.Review.Review
import com.theSPGgroup.RecipeWorld.User.User
import jakarta.persistence.*
import java.time.LocalDateTime

@Entity
@Table
data class Recipe(
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    val id: Long = 0,

    @Column(columnDefinition = "TEXT")
    val description: String,

    val title: String,
    val date: LocalDateTime,
    val prepTime: Int,

    @ManyToOne
    @JoinColumn(name = "category_id")
    var category: Category,

    @ManyToOne
    @JoinColumn(name = "author_id", nullable = true)
    var author: User? = null,

    @OneToMany(mappedBy = "recipe", cascade = [CascadeType.ALL], orphanRemoval = true)
    val recipeIngredients: MutableList<RecipeIngredient> = mutableListOf(),

    @OneToMany(mappedBy = "recipe", cascade = [CascadeType.ALL], orphanRemoval = true)
    @JsonIgnore
    val recipeReviews: MutableList<Review> = mutableListOf(),

    @ManyToMany(mappedBy = "favoriteRecipes")
    val favoritedByUsers: MutableSet<User> = mutableSetOf()
)