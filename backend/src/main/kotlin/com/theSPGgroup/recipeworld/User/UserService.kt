package com.theSPGgroup.RecipeWorld.User

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Service

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
}