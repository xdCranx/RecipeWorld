package com.theSPGgroup.RecipeWorld.Recipe

import com.theSPGgroup.RecipeWorld.Category.CategoryName
import com.theSPGgroup.RecipeWorld.Category.CategoryRepository
import com.theSPGgroup.RecipeWorld.RecipeIngredient.RecipeIngredientService
import com.theSPGgroup.RecipeWorld.User.UserRepository
import jakarta.persistence.EntityNotFoundException
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.stereotype.Service
import java.time.LocalDateTime
import java.util.*


@Service
class RecipeService(
    @Autowired val recipeRepository: RecipeRepository,
    @Autowired val categoryRepository: CategoryRepository,
    @Autowired val userRepository: UserRepository,
    @Autowired val recipeIngredientService: RecipeIngredientService
) {

    fun getAllRecipes(): List<RecipeDTO> {
        return recipeRepository.findAll().map { RecipeDTOMapper.mapRecipeToRecipeDTO(it) }
    }

    fun getRecipeById(recipeId: Long): ResponseEntity<Any> {
        val recipe: Optional<Recipe> = recipeRepository.findRecipeById(recipeId)

        return if (recipe.isPresent) {
            ResponseEntity.ok(recipe.map { RecipeDTOMapper.mapRecipeToRecipeDTO(it) })
        } else {
            ResponseEntity.status(HttpStatus.NOT_FOUND).body("Recipe with id $recipeId not found")
        }
    }

    fun getRecipesByTitle(title: String): ResponseEntity<List<RecipeDTO>> {
        val recipes: List<Recipe> = recipeRepository.findByTitleIgnoreCaseContaining(title)

        return if (recipes.isNotEmpty()) {
            ResponseEntity.ok(recipes.map { RecipeDTOMapper.mapRecipeToRecipeDTO(it) })
        } else {
            ResponseEntity.status(HttpStatus.NOT_FOUND).body(emptyList())
        }
    }

    fun addNewRecipe(newRecipe: RecipeRequest) {
        if (newRecipe.title.isBlank()) {
            throw IllegalArgumentException("Recipe title cannot be empty")
        }

        if (newRecipe.ingredients.isEmpty()) {
            throw IllegalArgumentException("Recipe must have ingredients")
        }

        val user = userRepository.findById(UUID.fromString(newRecipe.userId))
            .orElseThrow { EntityNotFoundException("User not found") }

        val category = categoryRepository.findById(newRecipe.categoryId)
            .orElseThrow { EntityNotFoundException("Category not found") }

        val recipeSend = Recipe(
            title = newRecipe.title,
            description = newRecipe.description,
            author = user,
            category = category,
            date = LocalDateTime.now(),
            prepTime = newRecipe.prepTime,
        )
        recipeRepository.save(recipeSend)

        recipeIngredientService.addRecipeIngredient(recipeSend, newRecipe.ingredients)

    }

    fun deleteRecipe(recipeId: Long): ResponseEntity<Any> {
        try {
            val recipeById: Recipe? = recipeRepository.findById(recipeId).orElse(null)

            if (recipeById != null) {
                recipeRepository.delete(recipeById)
                return ResponseEntity.ok("Recipe deleted")
            } else {
                throw IllegalStateException("Recipe not found")
            }
        } catch (e: Exception) {
            throw IllegalStateException("An error occurred: ${e.message}")
        }
    }

    fun getRecipesByCategory(categoryName: CategoryName): List<RecipeDTO> {
        val category = categoryRepository.findByName(categoryName)
            ?: throw EntityNotFoundException("Category not found")
        return recipeRepository.findByCategory(category).map { RecipeDTOMapper.mapRecipeToRecipeDTO(it) }
    }

    fun getRecipesByPrepTime(prepTime: Int): List<RecipeDTO> {
        if (prepTime < 0) {
            throw IllegalArgumentException("Preparation time cannot be negative")
        }
        return recipeRepository.findByPrepTimeLessThanEqual(prepTime).map { RecipeDTOMapper.mapRecipeToRecipeDTO(it) }
    }

    fun getRecipesByIngredient(ingredient: String): List<RecipeDTO> {
        if (ingredient.isBlank()) {
            throw IllegalArgumentException("Ingredient name cannot be blank")
        }
        return recipeRepository.findByRecipeIngredientsIngredientNameIgnoreCase(ingredient).map { RecipeDTOMapper.mapRecipeToRecipeDTO(it) }
    }

    fun getRecipesByUserFavorites(userId: UUID): List<RecipeDTO> {
        val user = userRepository.findById(userId)
            .orElseThrow { EntityNotFoundException("User not found for ID: $userId") }
        return user.favoriteRecipes.toList().map { RecipeDTOMapper.mapRecipeToRecipeDTO(it) }
    }

    fun getRecipesByUser(userId: UUID): List<RecipeDTO> {
        val user = userRepository.findById(userId)
            .orElseThrow { EntityNotFoundException("User not found for ID: $userId") }
        return recipeRepository.findByAuthor(user).map { RecipeDTOMapper.mapRecipeToRecipeDTO(it) }
    }
}