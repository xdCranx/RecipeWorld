package com.theSPGgroup.RecipeWorld.User

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.web.bind.annotation.DeleteMapping
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PathVariable
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController


@RestController
@RequestMapping("/api/user")
class UserController(@Autowired val userService: UserService) {

    @GetMapping
    fun getUser():List<User>{
        return userService.getUsers()
    }
    @PostMapping
    fun registerNewUser(@RequestBody user:User){
        userService.addNewUser(user)
    }
    @DeleteMapping("{id}")
    fun deleteUser(@PathVariable("id") userId:String){
        userService.deleteUser(userId)
    }
}