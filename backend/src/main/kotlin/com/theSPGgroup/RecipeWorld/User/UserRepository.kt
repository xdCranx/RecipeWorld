package com.theSPGgroup.RecipeWorld.User

import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.stereotype.Repository
import java.util.*

@Repository
interface UserRepository : JpaRepository<User, UUID>{

    fun findUserByUsername(username:String):User?
    fun existsUserByUsername(username: String): Boolean
}