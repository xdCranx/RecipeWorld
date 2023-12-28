package com.theSPGgroup.RecipeWorld.Recipe

import com.theSPGgroup.RecipeWorld.Category.CategoryName
import com.theSPGgroup.RecipeWorld.Category.CategoryRepository
import com.theSPGgroup.RecipeWorld.User.UserRepository
import jakarta.persistence.EntityNotFoundException
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.stereotype.Service
import java.util.*


@Service
class RecipeService(
    @Autowired val recipeRepository: RecipeRepository,
    @Autowired val categoryRepository: CategoryRepository,
    @Autowired val userRepository: UserRepository,
) {

    fun getAllRecipes(): List<Recipe> {
        return recipeRepository.findAll()
    }

    fun getRecipeById(recipeId: Long): ResponseEntity<Any> {
        val recipe: Optional<Recipe> = recipeRepository.findRecipeById(recipeId)

        return if (recipe.isPresent) {
            ResponseEntity.ok(recipe.get())
        } else {
            ResponseEntity.status(HttpStatus.NOT_FOUND).body("Recipe with id $recipeId not found")
        }
    }

    fun getRecipesByTitle(title: String): ResponseEntity<List<Recipe>> {
        val recipes: List<Recipe> = recipeRepository.findByTitleIgnoreCaseContaining(title)

        return if (recipes.isNotEmpty()) {
            ResponseEntity.ok(recipes)
        } else {
            ResponseEntity.status(HttpStatus.NOT_FOUND).body(emptyList())
        }
    }

    fun addNewRecipe(recipe: Recipe) {
        if (recipe.title.isBlank()) {
            throw IllegalArgumentException("Recipe title cannot be empty")
        }

        recipeRepository.save(recipe)
    }

    fun deleteRecipe(recipeId: Long) {
        try {
            val recipeById: Recipe? = recipeRepository.findById(recipeId).orElse(null)

            if (recipeById != null) {
                recipeRepository.delete(recipeById)
            } else {
                throw IllegalStateException("Recipe not found")
            }
        } catch (e: Exception) {
            throw IllegalStateException("An error occurred: ${e.message}")
        }
    }

    fun getRecipesByCategory(categoryName: CategoryName): List<Recipe> {
        val category = categoryRepository.findByName(categoryName)
            ?: throw EntityNotFoundException("Category not found")
        return recipeRepository.findByCategory(category)
    }

    fun getRecipesByPrepTime(prepTime: Int): List<Recipe> {
        if (prepTime < 0) {
            throw IllegalArgumentException("Preparation time cannot be negative")
        }
        return recipeRepository.findByPrepTimeLessThanEqual(prepTime)
    }

    fun getRecipesByIngredient(ingredient: String): List<Recipe> {
        if (ingredient.isBlank()) {
            throw IllegalArgumentException("Ingredient name cannot be blank")
        }
        return recipeRepository.findByRecipeIngredientsIngredientNameIgnoreCase(ingredient)
    }

    fun getRecipesByUserFavorites(userId: UUID): List<Recipe> {
        val user = userRepository.findById(userId)
            .orElseThrow { EntityNotFoundException("User not found for ID: $userId") }
        return user.favouriteRecipes.toList()
    }
}