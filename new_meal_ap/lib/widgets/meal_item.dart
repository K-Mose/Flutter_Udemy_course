import 'package:flutter/material.dart';
import 'package:new_meal_ap/model/meal.dart';
import 'package:new_meal_ap/screens/meal_detail_screen.dart';
import 'package:new_meal_ap/widgets/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

class MealItem extends StatelessWidget {
  const MealItem({
    super.key,
    required this.meal,
    required this.selectMeal
    });
  final Meal meal;
  final Function(Meal meal) selectMeal;

  String get complexityText {
    return meal.complexity.name[0].toUpperCase()
        + meal.complexity.name.substring(1);
  }

  String get affordabilityText {
    return meal.affordability.name[0].toUpperCase()
        + meal.affordability.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      // Stack에서 아래 shape 셋팅을 무시함
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12)
      ),
      // 클립을 추가하여 child를 Card 경계에 맞춤
      clipBehavior: Clip.hardEdge,
      elevation: 5,
      child: InkWell(
      onTap: () {
        selectMeal(meal);
      },
      // jetpack의 box와 비슷
      child: Stack(
        children: [
          // placeholder를 사용하지 않으면 로드되지 않은 이미지의 스택 위젯은 크기를 0을 가져서 이미지가 나올 때 화면이 부자연스러움
          // Image.network(meal.imageUrl),
          // 이미지에 fadein 모션과 placeholder를 추가
          FadeInImage(
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
            placeholder: MemoryImage(kTransparentImage),
            image: NetworkImage(meal.imageUrl)
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.black54,
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 40),
              child: Column(
                children: [
                  Text(
                    meal.title, maxLines: 2,
                    textAlign: TextAlign.center,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MealItemTrait(
                        icon: Icons.schedule,
                        label: "${meal.duration} min"
                      ),
                      const SizedBox(width: 12,),
                      MealItemTrait(
                        icon: Icons.accessibility_new,
                        label: complexityText
                      ),
                      const SizedBox(width: 12,),
                      MealItemTrait(
                        icon: Icons.attach_money,
                        label: affordabilityText
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    ),);
  }
}