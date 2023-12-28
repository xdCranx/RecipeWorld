package com.theSPGgroup.RecipeWorld.User

import com.theSPGgroup.RecipeWorld.Recipe.RecipeRepository
import jakarta.persistence.EntityNotFoundException
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Service
import java.util.UUID

@Service
class UserService(@Autowired val userRepository: UserRepository, @Autowired val recipeRepository: RecipeRepository) {

    fun getAllUsers(): List<User> {
        return userRepository.findAll()
    }

    fun logInAuthUser(userCredentials: UserCredentials): String {
        val user = userRepository.findUserByUsername(userCredentials.username)
            ?: throw NoSuchElementException("User ${userCredentials.username} not found")

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
        userRepository.save(user)
    }

    fun deleteUser(userId: String) {
        try {
            val id:UUID = UUID.fromString(userId)
            val userById: User? = userRepository.findUserById(id)

            if (userById != null) {
                if(userById.id == UUID.fromString(userId)) {
                    userRepository.delete(userById)
                } else {
                    throw IllegalStateException("ID mismatch")
                }
            } else {
                throw IllegalStateException("Could not find user")
            }
        } catch (e: IllegalArgumentException) {
            throw IllegalStateException("Invalid UUID format")
        } catch (e: Exception) {
            throw IllegalStateException("An error occurred: ${e.message}")
        }
    }

    fun addRecipeToFav(userId:String, recipeId: String) {
        val user = userRepository.findById(UUID.fromString(userId))
            .orElseThrow {EntityNotFoundException("User not found") }

        val recipe = recipeRepository.findRecipeById(recipeId.toLong())
            .orElseThrow { EntityNotFoundException("Recipe not found") }

        user.favouriteRecipes.add(recipe)
        userRepository.save(user)
    }
}