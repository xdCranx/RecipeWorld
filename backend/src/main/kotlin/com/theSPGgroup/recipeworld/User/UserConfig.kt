package com.theSPGgroup.RecipeWorld.User

import org.springframework.boot.CommandLineRunner
import org.springframework.context.annotation.Bean
import org.springframework.context.annotation.Configuration
import java.util.*

@Configuration
class UserConfig {
    @Bean
    fun commandLineRunner(repository: UserRepository):CommandLineRunner{
        return CommandLineRunner {args ->
            val user1 = User(
                UUID.randomUUID(),
                "Major1",
                "Pajor1"
            )
            val user2 = User(
                UUID.randomUUID(),
                "Major2",
                "Pajor2"
            )
            repository.saveAll(
                listOf(user1, user2)
            )
        }
    }
}