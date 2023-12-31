package com.theSPGgroup.RecipeWorld.RecipeIngredient

import org.springframework.data.jpa.repository.JpaRepository

interface RecipeIngredientRepository: JpaRepository<RecipeIngredient, Long> {
}