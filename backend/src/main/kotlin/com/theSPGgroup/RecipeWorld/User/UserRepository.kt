package com.theSPGgroup.RecipeWorld.User

import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.Query
import org.springframework.stereotype.Repository
import java.util.*

@Repository
interface UserRepository : JpaRepository<User, UUID>{

    @Query("SELECT u FROM User u WHERE u.username = ?1")
    fun findUserByUsername(username:String):User?

    @Query("SELECT i FROM User i WHERE i.id = ?1")
    fun findUserById(userid:UUID):User?
}