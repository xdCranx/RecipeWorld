package com.theSPGgroup.RecipeWorld.Recipe

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*

@RestController
@RequestMapping("/api/recipe")
class RecipeController(@Autowired val recipeService: RecipeService) {

    @GetMapping
    fun getRecipes(): List<Recipe> {
        return recipeService.getRecipes()
    }

    @GetMapping("/{id}")
    fun getRecipeById(@PathVariable("id") recipeId: Long): ResponseEntity<Any> {
        return recipeService.getRecipeById(recipeId)
    }

    @GetMapping("/title/{title}")
    fun getRecipeByTitle(@PathVariable("title") recipeTitle: String): ResponseEntity<Any> {
        return recipeService.getRecipeByTitle(recipeTitle)
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
