// Импортируем пакет material для создания Material Design приложений.
import 'package:flutter/material.dart';

// Главная функция, точка входа в приложение.
void main() {
  // Запускаем приложение, передавая корневой виджет MyApp.
  runApp(MyApp());
}

// Корневой виджет приложения, наследуется от StatelessWidget, так как состояние не изменяется.
class MyApp extends StatelessWidget {
  // Переопределяем метод build для построения виджета.
  @override
  Widget build(BuildContext context) {
    // Возвращаем MaterialApp – базовый виджет для Material Design приложений.
    return MaterialApp(
      // Заголовок приложения.
      title: 'Интересное приложение',
      // Отключаем отладочный баннер (debug banner).
      debugShowCheckedModeBanner: false,
      // Задаем тему приложения.
      theme: ThemeData(
        // Используем зеленую палитру в качестве основного цвета.
        primarySwatch: Colors.green,
        // Создаем схему цветов, устанавливая вторичный цвет (accent) как мятный.
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green)
            .copyWith(secondary: Color(0xFF98FF98)), // Мятный цвет (mint)
      ),
      // Задаем начальный экран приложения.
      home: FirstScreen(),
      // Генерируем маршруты для навигации с кастомной анимацией перехода.
      onGenerateRoute: (settings) {
        // Если запрошен маршрут '/second', создаем кастомный переход на второй экран.
        if (settings.name == '/second') {
          return PageRouteBuilder(
            // Определяем, какой виджет будет показан.
            pageBuilder: (context, animation, secondaryAnimation) =>
                SecondScreen(),
            // Определяем анимацию перехода с использованием эффекта затухания.
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              // Создаем tween для изменения прозрачности от 0.0 до 1.0.
              final tween = Tween<double>(begin: 0.0, end: 1.0)
                  .chain(CurveTween(curve: Curves.easeInOut));
              // Применяем FadeTransition, чтобы создать эффект плавного появления.
              return FadeTransition(
                opacity: animation.drive(tween),
                child: child,
              );
            },
          );
        }
        // Если маршрут не найден, возвращаем null.
        return null;
      },
    );
  }
}

// Первый экран приложения реализован как StatefulWidget, так как содержит изменяемое состояние.
class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

// Состояние для FirstScreen, использует SingleTickerProviderStateMixin для анимаций.
class _FirstScreenState extends State<FirstScreen>
    with SingleTickerProviderStateMixin {
  // Флаг для переключения между двумя вариантами отображаемого текста.
  bool _showAlternateText = false;
  // Контроллер анимации.
  late AnimationController _controller;
  // Анимация изменения прозрачности текста.
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    // Инициализируем AnimationController с длительностью 500 мс.
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this, // Используем текущее состояние как источник тикеров (vsync).
    );
    // Создаем анимацию с плавной кривой easeInOut.
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    // Освобождаем ресурсы контроллера анимации.
    _controller.dispose();
    super.dispose();
  }

  // Функция для переключения текста с анимацией.
  void _toggleText() {
    setState(() {
      // Инвертируем значение флага.
      _showAlternateText = !_showAlternateText;
      // Если альтернативный текст должен отображаться, запускаем анимацию вперед, иначе - в обратном направлении.
      _showAlternateText ? _controller.forward() : _controller.reverse();
    });
  }

  // Функция для показа информационного диалога об приложении.
  void _showInfoDialog() {
    showDialog(
      context: context, // Передаем текущий контекст.
      builder: (context) {
        // Создаем AlertDialog с информацией об приложении.
        return AlertDialog(
          title: Text("О приложении"), // Заголовок диалога.
          content: Text(
              "Это расширенное приложение с кастомной анимацией, Drawer и анимированным переключением текста."), // Содержимое диалога.
          actions: [
            // Кнопка для закрытия диалога.
            TextButton(
              child: Text("Закрыть"),
              onPressed: () => Navigator.of(context).pop(), // Закрываем диалог.
            )
          ],
        );
      },
    );
  }

  // Функция для показа диалога с особенностями языка Dart.
  void _showDartFeaturesDialog() {
    showDialog(
      context: context, // Передаем текущий контекст.
      builder: (context) {
        // Создаем AlertDialog с подробным описанием особенностей языка Dart.
        return AlertDialog(
          title: Text("Особенности языка Dart"),
          content: SingleChildScrollView(
            child: Text(
              // Текст с описанием основных возможностей языка Dart.
              "Язык Dart – это современный объектно-ориентированный язык программирования, разработанный компанией Google. "
                  "Он поддерживает статическую типизацию и имеет лаконичный синтаксис, похожий на C-подобные языки. "
                  "Dart позволяет писать асинхронный код с использованием async/await, что упрощает работу с потоками и задержками. "
                  "Одной из ключевых особенностей Dart является поддержка горячей перезагрузки (hot reload), которая значительно ускоряет разработку приложений на Flutter. "
                  "Язык также поддерживает функциональные возможности, такие как замыкания, лямбда-выражения и генераторы, что делает его гибким и мощным инструментом для создания пользовательских интерфейсов.",
              textAlign: TextAlign.justify, // Выравнивание текста по ширине.
            ),
          ),
          actions: [
            // Кнопка для закрытия диалога.
            TextButton(
              child: Text("Закрыть"),
              onPressed: () => Navigator.of(context).pop(), // Закрываем диалог.
            )
          ],
        );
      },
    );
  }

  // Функция для показа SnackBar-подсказки.
  void _showSnackBar() {
    // Создаем SnackBar с текстом подсказки.
    final snackBar = SnackBar(
      content: Text("Это всплывающая подсказка (SnackBar)!"),
      duration: Duration(seconds: 2), // Длительность показа SnackBar.
    );
    // Показываем SnackBar через ScaffoldMessenger.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  // Функция для перехода на второй экран по именованному маршруту.
  void _navigateToSecondScreen() {
    Navigator.of(context).pushNamed('/second');
  }

  @override
  Widget build(BuildContext context) {
    // Строим интерфейс первого экрана.
    return Scaffold(
      // Создаем AppBar с заголовком и кнопкой для показа диалога.
      appBar: AppBar(
        title: Text("Расширенный первый экран"),
        actions: [
          // Кнопка с иконкой информации.
          IconButton(
            icon: Icon(Icons.info_outline),
            tooltip: 'О приложении',
            onPressed: _showInfoDialog, // При нажатии показываем информационный диалог.
          )
        ],
      ),
      // Создаем боковое меню (Drawer).
      drawer: Drawer(
        child: ListView(
          children: [
            // Заголовок Drawer с фоном и текстом.
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.teal, // Фон заголовка.
              ),
              child: Text(
                "Меню",
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            // Пункт меню "Главная".
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Главная"),
              onTap: () => Navigator.of(context).pop(), // Закрываем Drawer.
            ),
            // Пункт меню для перехода ко второму экрану.
            ListTile(
              leading: Icon(Icons.navigate_next),
              title: Text("Перейти ко второму экрану"),
              onTap: () {
                Navigator.of(context).pop(); // Закрываем Drawer.
                _navigateToSecondScreen(); // Выполняем переход.
              },
            ),
            // Пункт меню для отображения диалога с особенностями языка Dart.
            ListTile(
              leading: Icon(Icons.code),
              title: Text("Особенности языка Dart"),
              onTap: () {
                Navigator.of(context).pop(); // Закрываем Drawer.
                _showDartFeaturesDialog(); // Показываем диалог.
              },
            ),
          ],
        ),
      ),
      // Основное тело экрана.
      body: Center(
        // Используем Column для вертикального расположения элементов.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Центрируем содержимое по вертикали.
          children: <Widget>[
            // Кнопка с Tooltip для перехода на второй экран.
            Tooltip(
              message:
              "Нажмите, чтобы перейти на второй экран с анимацией",
              child: ElevatedButton(
                child: Text("Переход на второй экран"),
                onPressed: _navigateToSecondScreen, // Переход по нажатию.
              ),
            ),
            SizedBox(height: 20), // Отступ между элементами.
            // Кнопка для показа SnackBar.
            ElevatedButton(
              child: Text("Показать SnackBar"),
              onPressed: _showSnackBar, // Показываем SnackBar при нажатии.
            ),
            SizedBox(height: 40), // Большой отступ перед анимированным текстом.
            // Обработчик жестов для переключения текста с анимацией.
            GestureDetector(
              onTap: _toggleText, // При нажатии переключаем текст.
              child: FadeTransition(
                opacity: _animation, // Применяем анимацию прозрачности.
                child: Text(
                  // Отображаем альтернативный или исходный текст в зависимости от состояния.
                  _showAlternateText
                      ? "Альтернативный текст"
                      : "Исходный текст",
                  style: TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 10), // Небольшой отступ.
            // Дополнительная инструкция пользователю.
            Text("Нажмите на текст или FAB для переключения"),
          ],
        ),
      ),
      // Кнопка FloatingActionButton для переключения текста.
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleText, // При нажатии вызываем переключение текста.
        tooltip: "Переключить текст",
        child: Icon(Icons.autorenew), // Иконка кнопки.
      ),
    );
  }
}

// Второй экран приложения реализован как StatelessWidget, так как не требует изменения состояния.
class SecondScreen extends StatelessWidget {
  // Конструктор SecondScreen с необязательным параметром key.
  const SecondScreen({Key? key}) : super(key: key);

  // Функция для показа SnackBar на втором экране.
  void _showSnackBar(BuildContext context) {
    // Создаем SnackBar с текстом сообщения.
    final snackBar = SnackBar(
      content: Text("Вы на втором экране!"),
      duration: Duration(seconds: 2), // Длительность показа SnackBar.
    );
    // Показываем SnackBar через ScaffoldMessenger.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    // Строим интерфейс второго экрана.
    return Scaffold(
      // Создаем AppBar с заголовком.
      appBar: AppBar(
        title: Text("Второй экран"),
      ),
      // Основное тело экрана, центрированное по вертикали.
      body: Center(
        // Используем Column для вертикального расположения элементов.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Центрируем содержимое.
          children: <Widget>[
            // Текст приветствия на втором экране.
            Text(
              "Добро пожаловать на второй экран!",
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20), // Отступ между элементами.
            // Кнопка для возврата на первый экран.
            ElevatedButton(
              child: Text("Вернуться на первый экран"),
              onPressed: () => Navigator.of(context).pop(), // Возврат по нажатию.
            ),
            SizedBox(height: 20), // Отступ между элементами.
            // Кнопка для показа SnackBar на втором экране.
            ElevatedButton(
              child: Text("Показать SnackBar"),
              onPressed: () => _showSnackBar(context), // Показываем SnackBar.
            ),
          ],
        ),
      ),
    );
  }
}
