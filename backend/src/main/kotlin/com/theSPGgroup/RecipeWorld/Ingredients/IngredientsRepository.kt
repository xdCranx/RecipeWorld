package com.theSPGgroup.RecipeWorld.Ingredients

import org.springframework.data.jpa.repository.JpaRepository

interface IngredientsRepository : JpaRepository<Ingredient, Long>
