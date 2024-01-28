package com.theSPGgroup.RecipeWorld.User

import org.springframework.data.jpa.repository.JpaRepository
import org.springframework.data.jpa.repository.Modifying
import org.springframework.data.jpa.repository.Query
import org.springframework.stereotype.Repository
import java.util.*

@Repository
interface UserRepository : JpaRepository<User, UUID>{
    fun findUserByUsername(username:String):User?
    fun existsUserByUsername(username: String): Boolean
    fun deleteUserById(id: UUID)

    @Modifying
    @Query(value = "DELETE FROM users_favorites WHERE recipe_id = ?1", nativeQuery = true)
    fun clearFav(Id: Long)
}