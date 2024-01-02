package com.theSPGgroup.RecipeWorld.User

import com.theSPGgroup.RecipeWorld.UserDTOMapper
import jakarta.persistence.EntityNotFoundException
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*
import org.springframework.web.server.ResponseStatusException


@RestController
@RequestMapping("/api/user/")
class UserController(@Autowired val userService: UserService) {

    @GetMapping("getall")
    fun getAllUsers(): List<UserDTO> {
        return userService.getAllUsers().map { UserDTOMapper.mapUserToUserDTO(it) }
    }

    @PostMapping("register")
    fun registerUser(@RequestBody user:User):ResponseEntity<Any>{
        try {
            userService.addUser(user)
        } catch(ex: IllegalArgumentException) {
            throw ResponseStatusException(HttpStatus.CONFLICT, ex.message)
        }
        return ResponseEntity.ok(HttpStatus.CREATED)
    }

    @PostMapping("login")
    fun logInUser(@RequestBody userCredentials: UserCredentials): String{
        return userService.logInAuthUser(userCredentials)
    }

    @DeleteMapping("delete")
    fun deleteUser(@RequestParam("id") userId:String):ResponseEntity<Any>{
        userService.deleteUser(userId)
        return ResponseEntity.ok(HttpStatus.OK)
    }

    @PostMapping("/{userId}/favorites/{recipeId}/add")
    fun addRecipeToFavorites(
        @PathVariable userId: String,
        @PathVariable recipeId: String
    ): ResponseEntity<Any> {
        try {
            userService.addRecipeToFavorites(userId, recipeId)
        } catch (ex: EntityNotFoundException) {
            throw ResponseStatusException(HttpStatus.NOT_FOUND, ex.message)
        } catch (ex: Exception) {
            throw ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, ex.message)
        }
        return ResponseEntity.ok("Recipe added to favorites successfully")
    }

    @DeleteMapping("/{userId}/favorites/{recipeId}/remove")
    fun removeRecipeFromFavorites(
        @PathVariable userId: String,
        @PathVariable recipeId: String
    ): ResponseEntity<Any> {
        try {
            userService.removeRecipeFromFavorites(userId, recipeId)
        } catch (ex: EntityNotFoundException) {
            throw ResponseStatusException(HttpStatus.NOT_FOUND, ex.message)
        } catch (ex: Exception) {
            throw ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, ex.message)
        }
        return ResponseEntity.ok("Recipe removed from favorites successfully")
    }
}