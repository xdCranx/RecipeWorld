package com.theSPGgroup.RecipeWorld.User

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Service
import java.util.UUID

@Service
class UserService(@Autowired val userRepository: UserRepository) {

    fun getUsers(): List<User> {
        return userRepository.findAll()
    }

    fun addNewUser(user: User) {
        val userByUsername:User? = userRepository.findUserByUsername(user.username)

        if(userByUsername != null){
            throw IllegalStateException("Username already taken")
        }
        userRepository.save(user )
    }

    fun deleteUser(userId: String) {
        try {
            val id:UUID = UUID.fromString(userId)
            val userById: User? = userRepository.findUserById(id)

            if (userById != null) {
                if(userById.id == UUID.fromString(userId)) {
                    userRepository.delete(userById)
                    println("Deleted")
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
}