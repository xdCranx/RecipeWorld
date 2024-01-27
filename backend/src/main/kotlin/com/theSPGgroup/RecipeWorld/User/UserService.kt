package com.theSPGgroup.RecipeWorld.User

import com.theSPGgroup.RecipeWorld.Recipe.RecipeDTO
import com.theSPGgroup.RecipeWorld.Recipe.RecipeDTOMapper.Companion.mapRecipeToRecipeDTO
import com.theSPGgroup.RecipeWorld.Recipe.RecipeRepository
import jakarta.persistence.EntityNotFoundException
import jakarta.transaction.Transactional
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Service
import java.util.UUID

@Service
class UserService(
    @Autowired val userRepository: UserRepository,
    @Autowired val recipeRepository: RecipeRepository
) {

    fun getAllUsers(): Iterable<User> {
        return userRepository.findAll()
    }

    fun logInAuthUser(userCredentials: UserCredentials): String {
        val user = userRepository.findUserByUsername(userCredentials.username)
            ?: throw EntityNotFoundException("User ${userCredentials.username} not found")

        if (user.username == userCredentials.username &&
            user.password != userCredentials.password) {
            throw IllegalStateException("Invalid password")
        }
        else {
            return user.id.toString()
            }
    }

    fun addUser(user: User) {
        val usernameExists:Boolean = userRepository.existsUserByUsername(user.username)
        if (usernameExists) {
            throw IllegalArgumentException("User with username ${user.username} already exists.")
        }
        if (user.username.isEmpty() || user.password.isEmpty()) {
            throw IllegalArgumentException("Credentials missing.")
        }
        userRepository.save(user)
    }

    @Transactional
    fun deleteUser(userId: String) {
        try {
            val id:UUID = UUID.fromString(userId)
            val userById: User = userRepository.findById(id)
                .orElseThrow{ EntityNotFoundException("User not found") }

            val recipes = recipeRepository.findByAuthor(userById)
            recipeRepository.deleteAll(recipes)

            if(userById.id == UUID.fromString(userId)) {
                userRepository.deleteUserById(userById.id)
            } else {
                throw IllegalStateException("ID mismatch")
            }
        } catch (e: IllegalArgumentException) {
            throw IllegalStateException("Invalid UUID format")
        } catch (e: Exception) {
            throw IllegalStateException("An error occurred: ${e.message}")
        }
    }

    fun getUserFavoriteRecipes(userId: String): List<RecipeDTO> {
        val user = userRepository.findById(UUID.fromString(userId))
            .orElseThrow { EntityNotFoundException("User not found") }

        val favorites = user.favoriteRecipes.map { recipe ->
            mapRecipeToRecipeDTO(recipe)
        }

        return favorites
    }

    fun addRecipeToFavorites(userId:String, recipeId: String) {
        val user = userRepository.findById(UUID.fromString(userId))
            .orElseThrow {EntityNotFoundException("User not found") }

        val recipe = recipeRepository.findById(recipeId.toLong())
            .orElseThrow { EntityNotFoundException("Recipe not found") }

        if(recipe.author == user){
            throw IllegalArgumentException("Cannot add your own recipe to favourites")
        }
        user.favoriteRecipes.add(recipe)
        userRepository.save(user)
    }

    fun removeRecipeFromFavorites(userId: String, recipeId: String) {
        val user = userRepository.findById(UUID.fromString(userId))
            .orElseThrow { EntityNotFoundException("User not found") }

        val recipe = recipeRepository.findById(recipeId.toLong())
            .orElseThrow { EntityNotFoundException("Recipe not found") }

        user.favoriteRecipes.remove(recipe)
        userRepository.save(user)
    }
}