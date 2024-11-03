import 'package:moooney/Screens/BottomNavBar.dart';
import 'package:moooney/data/model/AddData.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final box = Hive.box<AddData>('name');

  var categoryType = 'Доходы';

  List<IconData> categoryIcon = [
    Icons.commute_outlined,
    Icons.festival_outlined,
    Icons.emergency_outlined,
    Icons.dinner_dining_outlined,
    Icons.ice_skating_outlined,
    Icons.work_outline,
    Icons.cottage_outlined,
    Icons.shopping_bag_outlined,
    Icons.phone_android_outlined,
    Icons.theater_comedy_outlined,
    Icons.redeem_outlined,
    Icons.soap_outlined,
    Icons.monetization_on_outlined,
    Icons.account_balance_outlined,
    Icons.fastfood_outlined,
    Icons.shopping_cart_outlined,
    Icons.sports_esports_outlined,
    Icons.personal_injury_outlined,
    Icons.fitness_center_outlined,
    Icons.currency_exchange_outlined,
    Icons.request_quote_outlined,
    Icons.savings_outlined,
    Icons.airport_shuttle_outlined,
    Icons.flight_outlined,
    Icons.extension_outlined,
    Icons.local_fire_department_outlined,
    Icons.candlestick_chart_outlined,
    Icons.contactless_outlined,
    Icons.gavel_outlined,
    Icons.question_mark_outlined,
  ];

  List<String> categoryName = [
    'Транспорт',
    'Развлечения',
    'Медицина',
    'Продукты',
    'Хобби',
    'Работа',
    'Дом',
    'Покупки',
    'Телефон',
    'Досуг',
    'Подарки',
    'Уход',
    'Долги',
    'Кредиты',
    'Гадость',
    'Хуита',
    'Игры',
    'Одежда',
    'Спорт',
    'Инвестиции',
    'Подработка',
    'Накопления',
    'Поездки',
    'Путешествия',
    'Образование',
    'Непредвиденные расходы',
    'Трейдинг',
    'Подписки',
    'Штрафы',
    'Прочее',
  ];

  List<String> numbers = [
    '7',
    '8',
    '9',
    '4',
    '5',
    '6',
    '1',
    '2',
    '3',
    '.',
    '0',
    '⌫',
  ];

  String input = ' ';

  int tappedIndex = -1;

  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: SizedBox(
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const Navbar(),
                                ),
                              );
                            },
                            child: const Icon(
                              Icons.arrow_back_outlined,
                              size: 40,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                categoryType,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    categoryType = categoryType == 'Расходы'
                                        ? 'Доходы'
                                        : 'Расходы';
                                  });
                                },
                                child: const Icon(Icons.sync_outlined,
                                    color: Colors.green, size: 40),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              if (tappedIndex == -1) {
                                popUpMessage(
                                    context: context,
                                    message: "Выберите категорию!");
                              } else if (input.isEmpty) {
                                popUpMessage(
                                    context: context,
                                    message: "Введите сумму!");
                              } else {
                                var add = AddData(
                                  categoryIcon[tappedIndex].codePoint,
                                  '${categoryIcon[tappedIndex].fontFamily}',
                                  categoryName[tappedIndex],
                                  input,
                                  categoryType,
                                  date,
                                );
                                box.add(add);
                                popUpMessage(context: context);
                              }
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 14, 10, 218),
                                  borderRadius: BorderRadius.circular(15)),
                              child: const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Сохранить',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  //category tiles
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 3,
                    width: MediaQuery.of(context).size.width,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ),
                      itemCount: categoryIcon.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              tappedIndex = index;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Container(
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(17),
                                color: index == tappedIndex
                                    ? const Color(0xffd3d0fb)
                                    : Colors.white10,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    tappedIndex == index
                                        ? categoryIcon[tappedIndex]
                                        : categoryIcon[index],
                                    size: 30,
                                    color:
                                        const Color.fromARGB(255, 14, 10, 218),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(top: 5),
                                  ),
                                  Text(
                                    tappedIndex == index
                                        ? categoryName[tappedIndex]
                                        : categoryName[index],
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Color.fromARGB(255, 14, 10, 218),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  //NumPad
                  Container(
                    width: double.maxFinite,
                    height: 60,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 14, 10, 218),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Icon(
                                Icons.home_mini_outlined,
                                size: 30,
                                color: Colors.white,
                              ),
                              Padding(padding: EdgeInsets.only(left: 5)),
                              Text(
                                'Сумма',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            input,
                            style: TextStyle(
                              fontSize: input.length > 5 ? 16 : 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height / 2,
                    width: MediaQuery.of(context).size.width,
                    child: GridView.builder(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 45,
                        vertical: 5,
                      ),
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: numbers.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 35,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return NumPadButton(numbers[index]);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget NumPadButton(String text) {
    return InkWell(
      onTap: () {
        setState(() {
          NumPadInput(text);
        });
      },
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  NumPadInput(String text) {
    if (text == "⌫") {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
        return;
      } else {
        return null;
      }
    }
    if (input.endsWith(".0 ")) {
      input = input.replaceAll(".0 ", " ");
      return;
    }
    input = input + text;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('input', input));
  }
}

Future<void> popUpMessage({required BuildContext context, String? message}) {
  return showDialog<String>(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: message == null
          ? const Text('Транзакция успешно добавлена!')
          : Text(message),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => const Navbar(),
              ),
            );
          },
          child: const Text('Хорошо!'),
        ),
      ],
    ),
  );
}
