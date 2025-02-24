import 'package:flutter/material.dart'; // Импортируем библиотеку Flutter для работы с UI

// Главная функция приложения, точка входа
void main() {
  runApp(MyApp()); // Запускает приложение, используя класс MyApp
}



/// Главное виджет-приложение.
/// Создаёт MaterialApp с заданной темой и главной страницей.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Отключаем отладочный баннер
      title: 'Инкремент', // Название приложения
      theme: ThemeData(
        primarySwatch: Colors.yellow, // Устанавливаем основную цветовую тему (жёлтый)
      ),
      home: MyHomePage(), // Устанавливаем главную страницу
    );
  }
}

/// Главный экран приложения.
/// Является StatefulWidget, так как содержит изменяемые данные.
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState(); // Создаёт состояние экрана
}

/// Класс состояния главной страницы.
/// Здесь хранятся переменные и методы для управления состоянием.
class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0; // Переменная-счётчик

  /// Метод увеличивает значение счётчика на 1
  void _incrementCounter() {
    setState(() {
      _counter++; // Увеличиваем значение переменной
    });
  }

  /// Метод уменьшает значение счётчика на 1
  void _decrementCounter() {
    if (_counter > 0) {
      setState(() {
        _counter--; // Уменьшаем значение переменной
      });
    }
  }

  /// Метод сбрасывает счётчик в 0
  void _resetCounter() {
    setState(() {
      _counter = 0; // Устанавливаем значение 0
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// Верхняя панель приложения
      appBar: AppBar(
        title: Text('Инкремент'), // Заголовок в AppBar
        backgroundColor: Colors.yellow, // Устанавливаем цвет AppBar
      ),
      /// Основная часть экрана
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Выравниваем по центру
          children: <Widget>[
            /// Текст перед счётчиком
            Text(
              'Значение инкремента:',
              style: TextStyle(fontSize: 20), // Устанавливаем размер текста
            ),
            /// Отображение текущего значения счётчика
            Text(
              '$_counter', // Выводим значение переменной _counter
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20), // Добавляем отступ

            /// Горизонтальный ряд кнопок "-" и "+"
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// Кнопка уменьшения счётчика
                ElevatedButton(
                  onPressed: _decrementCounter, // Вызываем _decrementCounter при нажатии
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red, // Устанавливаем красный цвет
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    /// Делаем кнопки квадратными
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                  child: Icon(Icons.remove, size: 30, color: Colors.white), // Иконка "-"
                ),
                SizedBox(width: 20), // Отступ между кнопками

                /// Кнопка увеличения счётчика
                ElevatedButton(
                  onPressed: _incrementCounter, // Вызываем _incrementCounter при нажатии
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green, // Устанавливаем зелёный цвет
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                  child: Icon(Icons.add, size: 30, color: Colors.white), // Иконка "+"
                ),
              ],
            ),
            SizedBox(height: 10), // Отступ перед кнопкой сброса

            /// Кнопка сброса счётчика
            TextButton(
              onPressed: _resetCounter, // Вызываем _resetCounter при нажатии
              child: Text(
                'Сбросить', // Текст кнопки
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
