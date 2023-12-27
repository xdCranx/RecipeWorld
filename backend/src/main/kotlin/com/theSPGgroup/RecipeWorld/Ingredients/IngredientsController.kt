package com.theSPGgroup.RecipeWorld.Ingredients

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping("/api/ingredients")
class IngredientsController(@Autowired val ingredientsService: IngredientsService) {

    @GetMapping
    fun getAllIngredients(): List<Ingredient> {
        return ingredientsService.getAllIngredients()
    }

    @GetMapping("/{id}")
    fun getIngredientById(@PathVariable("id") ingredientId: Long): Ingredient? {
        return ingredientsService.getIngredientById(ingredientId)
    }
}
