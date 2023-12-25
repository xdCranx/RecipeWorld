package com.theSPGgroup.RecipeWorld.Recipe

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.web.bind.annotation.*

@RestController
@RequestMapping("/api/recipe")
class RecipeController(@Autowired val recipeService: RecipeService) {

    @GetMapping
    fun getRecipes(): List<Recipe> {
        return recipeService.getRecipes()
    }

    @PostMapping
    fun addNewRecipe(@RequestBody recipe: Recipe) {
        recipeService.addNewRecipe(recipe)
    }

    @DeleteMapping("{id}")
    fun deleteRecipe(@PathVariable("id") recipeId: Long) {
        recipeService.deleteRecipe(recipeId)
    }
}
