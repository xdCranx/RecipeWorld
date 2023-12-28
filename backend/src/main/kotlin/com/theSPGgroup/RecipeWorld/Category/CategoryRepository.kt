package com.theSPGgroup.RecipeWorld.Category

import org.springframework.data.jpa.repository.JpaRepository

interface CategoryRepository : JpaRepository<Category, Long> {
    fun findByName(name: CategoryName): Category?
}
