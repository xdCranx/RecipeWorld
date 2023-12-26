package com.theSPGgroup.RecipeWorld.User

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.DeleteMapping
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RequestParam
import org.springframework.web.bind.annotation.RestController
import org.springframework.web.server.ResponseStatusException


@RestController
@RequestMapping("/api/user/")
class UserController(@Autowired val userService: UserService) {

    @GetMapping("getall")
    fun getAllUsers():List<User>{
        return userService.getAllUsers()
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
}