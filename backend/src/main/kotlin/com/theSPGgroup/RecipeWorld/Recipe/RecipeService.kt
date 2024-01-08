package com.theSPGgroup.RecipeWorld.Recipe

import com.theSPGgroup.RecipeWorld.Category.CategoryName
import com.theSPGgroup.RecipeWorld.Category.CategoryRepository
import com.theSPGgroup.RecipeWorld.RecipeIngredient.RecipeIngredientService
import com.theSPGgroup.RecipeWorld.Review.ReviewRepository
import com.theSPGgroup.RecipeWorld.User.UserRepository
import com.theSPGgroup.RecipeWorld.User.UserService
import jakarta.persistence.EntityManager
import jakarta.persistence.EntityNotFoundException
import jakarta.transaction.Transactional
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.http.HttpStatus
import org.springframework.stereotype.Service
import org.springframework.web.server.ResponseStatusException
import java.time.LocalDateTime
import java.util.*


@Service
class RecipeService(
    @Autowired val recipeRepository: RecipeRepository,
    @Autowired val categoryRepository: CategoryRepository,
    @Autowired val userRepository: UserRepository,
    @Autowired val recipeIngredientService: RecipeIngredientService,
    @Autowired val userService: UserService,
    private val entityManager: EntityManager
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

        if (newRecipe.userId.isEmpty()) {
            throw IllegalArgumentException("Recipe must have author")
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

    fun deleteRecipe(recipeId: Long) {
        try {
            val recipeById: Recipe = recipeRepository.findById(recipeId)
                .orElseThrow { EntityNotFoundException("Recipe not found") }

            println(recipeById.favoritedByUsers.toString())
            recipeById.favoritedByUsers.forEach { it.favoriteRecipes.remove(recipeById) }
            recipeById.favoritedByUsers.clear()
            println(recipeById.favoritedByUsers.toString())

            recipeRepository.delete(recipeById)
            println(recipeById.favoritedByUsers.toString())
        } catch (e: Exception) {
            throw ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "An error occurred: ${e.message}")
        }
    }

//    fun deleteRecipe(recipeId: Long) {
//        try {
//            val recipeById = recipeRepository.findById(recipeId)
//                .orElseThrow { EntityNotFoundException("Recipe with id: $recipeId not found") }
//
////            userService.removeRecipeFromFavorites(recipeById.author.id.toString(), recipeById.id.toString())
//
//            recipeRepository.delete(recipeById)
//        } catch (e: Exception) {
//            throw IllegalStateException("An error occurred: ${e.message}")
//        }
//    }

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