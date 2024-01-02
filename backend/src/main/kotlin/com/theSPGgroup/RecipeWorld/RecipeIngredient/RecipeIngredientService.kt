package com.theSPGgroup.RecipeWorld.RecipeIngredient

import com.theSPGgroup.RecipeWorld.Ingredients.IngredientsRepository
import com.theSPGgroup.RecipeWorld.Recipe.Recipe
import jakarta.persistence.EntityNotFoundException
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Service

@Service
class RecipeIngredientService(@Autowired val ingredientsRepository: IngredientsRepository,
                                @Autowired val recipeIngredientRepository: RecipeIngredientRepository) {
    fun addRecipeIngredient(recipe: Recipe, reqIngredients: MutableList<Pair<Long, Float>>) {
        reqIngredients.forEach() { (ingredientId, quantity) ->
            val ingredient = ingredientsRepository.findById(ingredientId)
                .orElseThrow{ EntityNotFoundException("Could not find specific ingredient") }
            if(ingredient != null) {
                recipeIngredientRepository.save(
                    RecipeIngredient(
                        recipe = recipe,
                        ingredient = ingredient,
                        quantity = quantity
                    )
                )
            }
        }
    }
}