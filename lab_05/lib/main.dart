import 'package:flutter/material.dart'; // Подключение библиотеки для UI Flutter
import 'dart:math'; // Подключение библиотеки для математических вычислений

// Главная функция, которая запускает приложение
void main() {
  runApp(const MyApp()); // Запуск Flutter-приложения
}

// Основной класс приложения, наследуется от StatelessWidget
class MyApp extends StatelessWidget {
  const MyApp({super.key}); // Конструктор класса

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Отключение дебаг-баннера
      title: 'Flutter List Demo', // Название приложения
      theme: ThemeData(
        primarySwatch: Colors.green, // Основная цветовая схема
        scaffoldBackgroundColor: Colors.green[50], // Фон всего приложения
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.green[700], // Цвет AppBar
          foregroundColor: Colors.white, // Цвет текста в AppBar
        ),
        listTileTheme: ListTileThemeData(
          tileColor: Colors.green[100], // Фон элементов списка
          textColor: Colors.green[900], // Цвет текста в элементах списка
        ),
      ),
      home: const HomePage(), // Установка главного экрана приложения
    );
  }
}

// Главный экран с тремя кнопками перехода на другие списки
class HomePage extends StatelessWidget {
  const HomePage({super.key}); // Конструктор класса

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Lists')), // Заголовок AppBar
      body: ListView(
        children: [
          _buildListTile(context, 'Простой список', const SimpleList()), // Кнопка перехода в простой список
          _buildListTile(context, 'Бесконечный список', const InfinityList()), // Кнопка перехода в бесконечный список
          _buildListTile(context, 'Бесконечный список (2^N)', const InfinityMathList()), // Кнопка перехода в список степеней двойки
        ],
      ),
    );
  }

  // Функция для создания элементов списка с навигацией на другие экраны
  Widget _buildListTile(BuildContext context, String title, Widget page) {
    return ListTile(
      title: Text(title), // Текст заголовка списка
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => page), // Открытие нового экрана
      ),
    );
  }
}

// Экран с простым списком из трех элементов
class SimpleList extends StatelessWidget {
  const SimpleList({super.key}); // Конструктор класса

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Простой список')), // Заголовок AppBar
      body: ListView.builder(
        itemCount: 3, // Количество элементов списка
        itemBuilder: (context, index) {
          return ListTile(title: Text('Элемент ${index + 1}')); // Создание строки списка
        },
      ),
    );
  }
}

// Экран с бесконечным списком
class InfinityList extends StatelessWidget {
  const InfinityList({super.key}); // Конструктор класса

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Бесконечный список')), // Заголовок AppBar
      body: ListView.builder(
        cacheExtent: 500, // Оптимизация загрузки элементов списка
        itemBuilder: (context, index) {
          return ListTile(title: Text('Строка $index')); // Создание строки списка с индексом
        },
      ),
    );
  }
}

// Экран с бесконечным списком чисел 2^N
class InfinityMathList extends StatefulWidget {
  const InfinityMathList({super.key}); // Конструктор класса

  @override
  _InfinityMathListState createState() => _InfinityMathListState();
}

class _InfinityMathListState extends State<InfinityMathList> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 10), () {
      setState(() {}); // Задержка перед обновлением UI для предотвращения перерисовки
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('2^N список')), // Заголовок AppBar
      body: ListView.builder(
        cacheExtent: 500, // Оптимизация загрузки элементов списка
        itemCount: 1000, // Ограничение на 1000 элементов
        itemBuilder: (context, index) {
          BigInt value = BigInt.from(2).pow(index); // Вычисление 2^N
          return ListTile(title: Text('2^$index = $value')); // Вывод значения 2^N в списке
        },
      ),
    );
  }
}
