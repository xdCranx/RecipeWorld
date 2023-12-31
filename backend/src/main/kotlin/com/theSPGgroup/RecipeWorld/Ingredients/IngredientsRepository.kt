package com.theSPGgroup.RecipeWorld.Ingredients

import org.springframework.data.jpa.repository.JpaRepository

interface IngredientsRepository : JpaRepository<Ingredient, Long> {
    fun findAllByIdIn(ids: MutableList<Long>): MutableList<Ingredient>
}
