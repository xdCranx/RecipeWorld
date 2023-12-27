package com.theSPGgroup.RecipeWorld.Category

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.web.bind.annotation.GetMapping
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping("/api/categories")
class CategoryController(@Autowired val categoryService: CategoryService) {

    @GetMapping
    fun getAllCategories(): List<Category> {
        return categoryService.getAllCategories()
    }
}