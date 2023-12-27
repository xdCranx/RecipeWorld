package com.theSPGgroup.RecipeWorld.Recipe

import org.springframework.data.jpa.repository.JpaRepository
import java.util.*

interface RecipeRepository : JpaRepository<Recipe, Long> {
    fun findByTitleIgnoreCaseContaining(title: String): List<Recipe>
    fun findRecipeById(id: Long): Optional<Recipe>
}
