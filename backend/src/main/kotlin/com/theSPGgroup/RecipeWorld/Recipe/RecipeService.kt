package com.theSPGgroup.RecipeWorld.Recipe

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.stereotype.Service
import java.util.*


@Service
class RecipeService(@Autowired val recipeRepository: RecipeRepository) {

    fun getRecipes(): List<Recipe> {
        return recipeRepository.findAll()
    }

    fun getRecipeById(recipeId: Long): ResponseEntity<Any> {
        val recipe: Optional<Recipe> = recipeRepository.findById(recipeId)

        return if (recipe.isPresent) {
            ResponseEntity.ok(recipe.get())
        } else {
            ResponseEntity.status(HttpStatus.NOT_FOUND).body("Recipe with id $recipeId not found")
        }
    }

    fun getRecipeByTitle(title: String): ResponseEntity<Any> {
        val recipes: List<Recipe> = recipeRepository.findByTitleIgnoreCaseContaining(title)

        return if (recipes.isNotEmpty()) {
            ResponseEntity.ok(recipes)
        } else {
            ResponseEntity.status(HttpStatus.NOT_FOUND).body("No recipes found with title: $title")
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
}

