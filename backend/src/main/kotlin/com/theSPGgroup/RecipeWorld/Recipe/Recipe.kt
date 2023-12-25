package com.theSPGgroup.RecipeWorld.Recipe

import jakarta.persistence.*
import java.time.LocalDateTime

@Entity
@Table(name = "Recipe")
data class Recipe(
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    val id: Long? = null,

    val title: String,
    val description: String,

//    @ManyToOne
//    @JoinColumn(name = "category_id")
//    val category: Category,
//
//    @ManyToOne
//    @JoinColumn(name = "author_id")
//    val author: Author,

    val date: LocalDateTime
)
