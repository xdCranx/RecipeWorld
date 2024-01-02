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
    fun getAllRecipes(): List<RecipeDTO> {
        return recipeService.getAllRecipes()
    }

    @GetMapping("{id}")
    fun getRecipeById(@PathVariable("id") recipeId: Long): ResponseEntity<Any> {
        return recipeService.getRecipeById(recipeId)
    }

    @GetMapping("/title/{title}")
    fun getRecipeByTitle(@PathVariable("title") recipeTitle: String): ResponseEntity<List<RecipeDTO>> {
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
    fun getRecipesByCategory(@PathVariable("category") categoryName: CategoryName): List<RecipeDTO> {
        return recipeService.getRecipesByCategory(categoryName)
    }

    @GetMapping("/prep-time/{prepTime}")
    fun getRecipesByPrepTime(@PathVariable("prepTime") prepTime: Int): List<RecipeDTO> {
        return recipeService.getRecipesByPrepTime(prepTime)
    }

    @GetMapping("/ingredient/{ingredient}")
    fun getRecipesByIngredient(@PathVariable("ingredient") ingredient: String): List<RecipeDTO> {
        return recipeService.getRecipesByIngredient(ingredient)
    }

    @GetMapping("/user-favorites/{userId}")
    fun getRecipesByUserFavorites(@PathVariable("userId") userId: UUID): List<RecipeDTO> {
        return recipeService.getRecipesByUserFavorites(userId)
    }

    @GetMapping("/user-recipes/{userId}")
    fun getRecipesByUser(@PathVariable("userId") userId: UUID): List<RecipeDTO> {
        return recipeService.getRecipesByUser(userId)
    }
}
