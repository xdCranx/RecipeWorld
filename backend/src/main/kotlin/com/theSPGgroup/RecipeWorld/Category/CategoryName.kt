package com.theSPGgroup.RecipeWorld.Category

import com.fasterxml.jackson.annotation.JsonValue

enum class CategoryName(@JsonValue val type: String) {
    BREAKFAST("breakfast"),
    LUNCH("lunch"),
    DINNER("dinner"),
    DESSERT("dessert"),
    DRINK("drink")
}
