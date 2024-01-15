import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipe_world2/DTOs/review_dto.dart';
import 'package:recipe_world2/controllers/user_controller.dart';
import 'package:recipe_world2/pages/recipe_page.dart';

class MyReviewsPage extends StatefulWidget {
  const MyReviewsPage({super.key});

  @override
  State<MyReviewsPage> createState() => _MyReviewsPageState();
}

class _MyReviewsPageState extends State<MyReviewsPage> {
  UserController userController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My reviews"),
        centerTitle: true,
        backgroundColor: Colors.purple.shade900,
        foregroundColor: Colors.grey[400],
      ),
      body: FutureBuilder<List<ReviewDTO>>(
        future: userController.getMyReviews(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            List<ReviewDTO> myReviews = snapshot.data!;
            return SingleChildScrollView(
              child: Column(
                children: myReviews.map((review) =>
                  ReviewList(
                    review: review,
                    delete: () async {
                      await userController.deleteMyReview(review.id);
                      await userController.getMyReviews();
                      setState(() {});
                    },
                  ),
                ).toList(),
              ),
            );
          }
        },
      ),
    );
  }
}


class ReviewList extends StatelessWidget {
  final ReviewDTO review;
  final VoidCallback delete;
  const ReviewList({Key? key, required this.review, required this.delete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: OutlinedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => RecipePage(recipeId: review.recipe.id)),
          );
        },
        style: OutlinedButton.styleFrom(
          side: const BorderSide(width: 0.01, color: Colors.transparent),
          shape: const RoundedRectangleBorder(),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(
                      review.recipe.title,
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.grey[800],
                      ),
                    ),
                    const SizedBox(height: 1),
                    Text(
                      review.recipe.author.username,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[400],
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      "💭: ${review.comment}",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                iconSize: 30,
                onPressed: delete,
                icon: const Icon(Icons.delete),
              )
            ],
          ),
        ),
      ),
    );
  }
}