package com.theSPGgroup.RecipeWorld.Recipe

import com.theSPGgroup.RecipeWorld.User.User
import jakarta.persistence.*
import java.time.LocalDateTime

@Entity
@Table
data class Recipe(
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    val id: Long? = null,

    val title: String,
    val description: String,
    val date: LocalDateTime,

//    @ManyToOne
//    @JoinColumn(name = "category_id")
//    val category: Category,

    @ManyToOne
    @JoinColumn(name = "author_id")
    val author: User,

    )
