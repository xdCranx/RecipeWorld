package com.theSPGgroup.RecipeWorld.Recipe

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
    @JoinColumn(name = "author_id")
    var author: User,

    @OneToMany(mappedBy = "recipe", cascade = [CascadeType.ALL], orphanRemoval = true)
    val recipeIngredients: MutableList<RecipeIngredient> = mutableListOf(),

    @OneToMany(mappedBy = "recipe", cascade = [CascadeType.ALL], orphanRemoval = true)
    val recipeReviews: MutableList<Review> = mutableListOf(),

)