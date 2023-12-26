package com.theSPGgroup.RecipeWorld.Recipe

import org.springframework.data.jpa.repository.JpaRepository

interface RecipeRepository : JpaRepository<Recipe, Long> {
    fun findByTitleIgnoreCaseContaining(title: String): List<Recipe>
}