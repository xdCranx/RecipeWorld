package com.theSPGgroup.RecipeWorld.Category

import jakarta.persistence.*

@Entity
data class Category(
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    val id: Long = 0,

    @Enumerated(EnumType.STRING)
    @Column(nullable = false)
    val name: CategoryName
)
