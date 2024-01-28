package com.theSPGgroup.RecipeWorld.Category

import org.springframework.data.jpa.repository.JpaRepository
import java.util.*

interface CategoryRepository : JpaRepository<Category, Long> {
    fun findByName(name: CategoryName): Optional<Category>
}
