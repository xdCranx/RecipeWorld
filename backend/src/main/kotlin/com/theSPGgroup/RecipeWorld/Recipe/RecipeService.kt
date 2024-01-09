package com.theSPGgroup.RecipeWorld.Recipe

import com.theSPGgroup.RecipeWorld.Category.CategoryName
import com.theSPGgroup.RecipeWorld.Category.CategoryRepository
import com.theSPGgroup.RecipeWorld.RecipeIngredient.RecipeIngredientService
import com.theSPGgroup.RecipeWorld.User.UserRepository
import jakarta.persistence.EntityNotFoundException
import jakarta.transaction.Transactional
import org.springframework.beans.factory.annotation.Autowired
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
        val recipes = recipeRepository.findAll()

        if (recipes.isEmpty())
            throw ( EntityNotFoundException("Recipe database is empty") )

        return recipes.map { RecipeDTOMapper.mapRecipeToRecipeDTO(it) }
    }

    fun getRecipeById(recipeId: Long): RecipeDTO {
        val recipe = recipeRepository.findById(recipeId)
            .orElseThrow{ EntityNotFoundException("Recipe with id: $recipeId not found") }

        return RecipeDTOMapper.mapRecipeToRecipeDTO(recipe)
    }

    fun getRecipesByTitle(title: String): List<RecipeDTO> {
        val recipes = recipeRepository.findByTitleIgnoreCaseContaining(title)
            .orElseThrow{ EntityNotFoundException("Could not find recipes with title containing $title") }

        return recipes.map { RecipeDTOMapper.mapRecipeToRecipeDTO(it) }

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

    @Transactional
    fun deleteRecipe(recipeId: Long) {
        try {
            val recipeById = recipeRepository.findById(recipeId)
                .orElseThrow{ EntityNotFoundException("Recipe with id: $recipeId not found") }

            userRepository.clearFav(recipeId)
            recipeRepository.delete(recipeById)

        } catch (e: Exception) {
            throw IllegalStateException("An error occurred: ${e.message}")
        }
    }

    fun getRecipesByCategory(categoryName: CategoryName): List<RecipeDTO> {
        val category = categoryRepository.findByName(categoryName)
            .orElseThrow{ EntityNotFoundException("Category not found") }

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

    fun getRecipesByAuthor(userId: UUID): List<RecipeDTO> {
        val user = userRepository.findById(userId)
            .orElseThrow { EntityNotFoundException("User not found for ID: $userId") }

        return recipeRepository.findByAuthor(user).map { RecipeDTOMapper.mapRecipeToRecipeDTO(it) }
    }
}