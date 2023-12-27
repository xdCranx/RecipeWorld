package com.theSPGgroup.RecipeWorld.Category

import org.springframework.beans.factory.annotation.Autowired
import org.springframework.stereotype.Service

@Service
class CategoryService(@Autowired val categoryRepository: CategoryRepository) {

    fun getAllCategories(): List<Category> {
        return categoryRepository.findAll()
    }
}
