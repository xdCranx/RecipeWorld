package com.theSPGgroup.RecipeWorld.Recipe

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Service


@Service
class RecipeService(@Autowired val recipeRepository: RecipeRepository) {

    fun getRecipes(): List<Recipe> {
        return recipeRepository.findAll()
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
                println("Recipe Deleted")
            } else {
                throw IllegalStateException("Recipe not found")
            }
        } catch (e: Exception) {
            throw IllegalStateException("An error occurred: ${e.message}")
        }
    }
}

