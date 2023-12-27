package com.theSPGgroup.RecipeWorld.Ingredients

import com.fasterxml.jackson.annotation.JsonValue

enum class IngredientUnit(@JsonValue val unit: String) {
    GRAMS("g"),
    KILOGRAMS("kg"),
    LITERS("l"),
    MILLILITERS("ml"),
    TABLESPOON("tbs"),
    SLICE("slice"),
}