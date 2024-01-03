package com.theSPGgroup.RecipeWorld.Recipe

import com.theSPGgroup.RecipeWorld.RecipeIngredient.RecipeIngredientDTOMapper.Companion.mapRecipeIngredientToRecipeIngredientDTO
import com.theSPGgroup.RecipeWorld.UserDTOMapper

class RecipeDTOMapper {
    companion object {
        fun mapRecipeToRecipeDTO(recipe: Recipe): RecipeDTO {
            return RecipeDTO(
                id = recipe.id,
                title = recipe.title,
                description = recipe.description,
                date = recipe.date,
                prepTime = recipe.prepTime,
                category = recipe.category,
                author = UserDTOMapper.mapUserToUserDTO(recipe.author),
                recipeIngredients = recipe.recipeIngredients.map { ingredient ->
                    mapRecipeIngredientToRecipeIngredientDTO(ingredient)
                }
            )
        }
    }
}
