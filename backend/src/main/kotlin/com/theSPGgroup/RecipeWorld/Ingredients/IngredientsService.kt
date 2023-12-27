package com.theSPGgroup.RecipeWorld.Ingredients

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Service

@Service
class IngredientsService(@Autowired val ingredientsRepository: IngredientsRepository) {

    fun getAllIngredients(): List<Ingredient> {
        return try {
            ingredientsRepository.findAll()
        } catch (e: Exception) {
            throw IllegalStateException("Failed to retrieve ingredients", e)
        }
    }

    fun getIngredientById(ingredientId: Long): Ingredient? {
        return try {
            ingredientsRepository.findById(ingredientId).orElse(null)
        } catch (e: Exception) {
            throw IllegalStateException("Failed to retrieve ingredient with ID: $ingredientId", e)
        }
    }
}
