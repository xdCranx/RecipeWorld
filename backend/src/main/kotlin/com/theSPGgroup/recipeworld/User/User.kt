package com.theSPGgroup.RecipeWorld.User

import jakarta.persistence.*
import java.util.UUID
@Entity
@Table
data class User(
    @Id @GeneratedValue(strategy = GenerationType.UUID)
    val id: UUID = UUID.randomUUID(),
    var username: String,
    var password: String
)