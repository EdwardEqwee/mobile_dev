import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

/// Главное виджет-приложение.
/// Содержит MaterialApp, тему и домашнюю страницу.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Инкремент', /// Измененное название приложения
      theme: ThemeData(
        primarySwatch: Colors.yellow, /// Выбранная цветовая тема
      ),
      home: MyHomePage(),
    );
  }
}

/// Состояние главной страницы приложения
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

/// Основной класс состояния.
/// Хранит счётчик и обрабатывает +, -  и сброс.
class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  /// Увеличивает значение счётчика на 1
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  /// Уменьшает значение счётчика на 1
  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  /// Сбрасывает значение счётчика на 0
  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// Верхняя панель приложения
      appBar: AppBar(
        title: Text('Инкремент'), /// Измененный заголовок
        backgroundColor: Colors.yellow, /// Цвет верхней панели
      ),
      /// Основная часть экрана
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            /// Надпись перед счётчиком
            Text(
              'Значение инкремента:',
              style: TextStyle(fontSize: 20),
            ),
            /// Текущее значение счётчика
            Text(
              '$_counter',
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            /// Горизонтальный ряд с кнопками "-" и "+"
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// Кнопка уменьшения счётчика
                ElevatedButton(
                  onPressed: _decrementCounter,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red, /// Красная кнопка
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    /// Указываем отсутствие закруглений (квадратные углы)
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                  child: Icon(Icons.remove, size: 30, color: Colors.white),
                ),
                SizedBox(width: 20),
                /// Кнопка увеличения счётчика
                ElevatedButton(
                  onPressed: _incrementCounter,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green, /// Зелёная кнопка
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    /// Тоже делаем углы квадратными
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                  child: Icon(Icons.add, size: 30, color: Colors.white),
                ),
              ],
            ),
            SizedBox(height: 10),
            /// Кнопка сброса счётчика
            TextButton(
              onPressed: _resetCounter,
              child: Text(
                'Сбросить',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
