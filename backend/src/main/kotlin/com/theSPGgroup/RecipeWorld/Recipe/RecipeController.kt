package com.theSPGgroup.RecipeWorld.Recipe

import com.theSPGgroup.RecipeWorld.Category.CategoryName
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*
import java.util.*

@RestController
@RequestMapping("/api/recipe")
class RecipeController(@Autowired val recipeService: RecipeService) {

    @GetMapping
    fun getAllRecipes(): List<Recipe> {
        return recipeService.getAllRecipes()
    }

    @GetMapping("{id}")
    fun getRecipeById(@PathVariable("id") recipeId: Long): ResponseEntity<Any> {
        return recipeService.getRecipeById(recipeId)
    }

    @GetMapping("/title/{title}")
    fun getRecipeByTitle(@PathVariable("title") recipeTitle: String): ResponseEntity<List<Recipe>> {
        return recipeService.getRecipesByTitle(recipeTitle)
    }

    @PostMapping
    fun addNewRecipe(@RequestBody recipeRequest: RecipeRequest): ResponseEntity<Any> {
        return recipeService.addNewRecipe(recipeRequest)
    }

    @DeleteMapping("{id}")
    fun deleteRecipe(@PathVariable("id") recipeId: Long) {
        recipeService.deleteRecipe(recipeId)
    }

    @GetMapping("/category/{category}")
    fun getRecipesByCategory(@PathVariable("category") categoryName: CategoryName): List<Recipe> {
        return recipeService.getRecipesByCategory(categoryName)
    }

    @GetMapping("/prep-time/{prepTime}")
    fun getRecipesByPrepTime(@PathVariable("prepTime") prepTime: Int): List<Recipe> {
        return recipeService.getRecipesByPrepTime(prepTime)
    }

    @GetMapping("/ingredient/{ingredient}")
    fun getRecipesByIngredient(@PathVariable("ingredient") ingredient: String): List<Recipe> {
        return recipeService.getRecipesByIngredient(ingredient)
    }

    @GetMapping("/user-favorites/{userId}")
    fun getRecipesByUserFavorites(@PathVariable("userId") userId: UUID): List<Recipe> {
        return recipeService.getRecipesByUserFavorites(userId)
    }
}
