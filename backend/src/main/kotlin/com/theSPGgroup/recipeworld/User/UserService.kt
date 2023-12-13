package com.theSPGgroup.RecipeWorld.User

import org.springframework.stereotype.Service
import org.springframework.web.bind.annotation.GetMapping
import java.util.*

@Service
class UserService {
    final lateinit var userRepository: UserRepository
    @GetMapping
    fun getUsers(): List<User> {
        return userRepository.findAll()
    }
}