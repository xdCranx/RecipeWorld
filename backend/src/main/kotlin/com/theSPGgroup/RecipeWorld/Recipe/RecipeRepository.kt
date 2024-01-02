package com.theSPGgroup.RecipeWorld.Recipe

import com.theSPGgroup.RecipeWorld.Category.Category
import com.theSPGgroup.RecipeWorld.User.User
import org.springframework.data.jpa.repository.JpaRepository
import java.util.*

interface RecipeRepository : JpaRepository<Recipe, Long> {
    fun findByTitleIgnoreCaseContaining(title: String): List<Recipe>
    fun findRecipeById(id: Long): Optional<Recipe>
    fun findByCategory(category: Category): List<Recipe>

    fun findByPrepTimeLessThanEqual(prepTime: Int): List<Recipe>

    fun findByRecipeIngredientsIngredientNameIgnoreCase(ingredient: String): List<Recipe>

    fun findByAuthor(user: User): List<Recipe>
}
