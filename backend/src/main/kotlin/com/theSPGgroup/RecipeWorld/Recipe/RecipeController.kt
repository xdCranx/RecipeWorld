package com.theSPGgroup.RecipeWorld.Recipe

import com.theSPGgroup.RecipeWorld.Category.CategoryName
import jakarta.persistence.EntityNotFoundException
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*
import org.springframework.web.server.ResponseStatusException
import java.util.*

@RestController
@RequestMapping("/api/recipe")
class RecipeController(@Autowired val recipeService: RecipeService) {

    @GetMapping
    fun getAllRecipes(): List<RecipeDTO> {
        return recipeService.getAllRecipes()
    }

    @GetMapping("{id}")
    fun getRecipeById(@PathVariable("id") recipeId: Long): RecipeDTO {
        return recipeService.getRecipeById(recipeId)
    }

    @GetMapping("/title/{title}")
    fun getRecipesByTitle(@PathVariable("title") recipeTitle: String): List<RecipeDTO> {
        return recipeService.getRecipesByTitle(recipeTitle)
    }

    @PostMapping
    fun addNewRecipe(@RequestBody recipeRequest: RecipeRequest): ResponseEntity<Any> {
        try {
            recipeService.addNewRecipe(recipeRequest)
        } catch (ex: EntityNotFoundException) {
            throw ResponseStatusException(HttpStatus.NOT_FOUND, ex.message)
        } catch (ex: IllegalArgumentException) {
            throw ResponseStatusException(HttpStatus.NOT_ACCEPTABLE, ex.message)
        } catch(ex: Exception) {
            throw ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, ex.message)
        }
        return ResponseEntity.ok("Recipe created")
    }

    @DeleteMapping("{id}")
    fun deleteRecipe(@PathVariable("id") recipeId: Long): ResponseEntity<Any> {
        try {
            recipeService.deleteRecipe(recipeId)
        } catch (ex: EntityNotFoundException) {
            throw ResponseStatusException(HttpStatus.NOT_ACCEPTABLE, ex.message)
        } catch (ex: Exception) {
            throw ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, ex.message)
        }
        return ResponseEntity.ok("Recipe deleted")
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

    @GetMapping("/author/{userId}")
    fun getRecipesByAuthor(@PathVariable("userId") userId: UUID): List<RecipeDTO> {
        return recipeService.getRecipesByAuthor(userId)
    }
}
