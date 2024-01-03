package com.theSPGgroup.RecipeWorld.RecipeIngredient

class RecipeIngredientDTOMapper {
    companion object {
        fun mapRecipeIngredientToRecipeIngredientDTO(ingredient: RecipeIngredient): RecipeIngredientDTO {
            return RecipeIngredientDTO(
                id = ingredient.id,
                name = ingredient.ingredient.name,
                unit = ingredient.ingredient.unit,
                quantity = ingredient.quantity
            )
        }
    }
}