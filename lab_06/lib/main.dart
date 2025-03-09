// Импортируем пакет Flutter Material, который содержит виджеты для создания Material Design интерфейса.
import 'package:flutter/material.dart';

// Точка входа в приложение.
void main() {
  // Запускаем приложение, передавая корневой виджет MyApp.
  runApp(const MyApp());
}

/// Корневой виджет приложения.
class MyApp extends StatefulWidget {
  // Конструктор с возможностью передачи ключа.
  const MyApp({Key? key}) : super(key: key);

  @override
  // Создаем состояние для виджета MyApp.
  State<MyApp> createState() => _MyAppState();
}

// Класс состояния для MyApp.
class _MyAppState extends State<MyApp> {
  // Переменная для хранения текущего режима темы (false – светлая, true – тёмная).
  bool _isDarkTheme = false;

  // Геттер для получения настроек светлой темы.
  ThemeData get _lightTheme {
    return ThemeData(
      brightness: Brightness.light, // Устанавливаем светлую яркость.
      primarySwatch: Colors.green, // Основной цвет приложения – зеленый.
      scaffoldBackgroundColor: Colors.white, // Фон основного контейнера – белый.
      appBarTheme: const AppBarTheme(
        elevation: 0, // Без тени.
        backgroundColor: Colors.green, // Фон AppBar – зеленый.
        foregroundColor: Colors.white, // Цвет текста и иконок в AppBar – белый.
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green, // Фон кнопок – зеленый.
          foregroundColor: Colors.white, // Цвет текста кнопок – белый.
        ),
      ),
    );
  }

  // Геттер для получения настроек тёмной темы.
  ThemeData get _darkTheme {
    return ThemeData(
      brightness: Brightness.dark, // Устанавливаем тёмную яркость.
      primarySwatch: Colors.green, // Основной цвет приложения – зеленый.
      scaffoldBackgroundColor: Colors.black, // Фон основного контейнера – черный.
      appBarTheme: const AppBarTheme(
        elevation: 0, // Без тени.
        backgroundColor: Colors.green, // Фон AppBar – зеленый.
        foregroundColor: Colors.white, // Цвет текста и иконок в AppBar – белый.
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green, // Фон кнопок – зеленый.
          foregroundColor: Colors.white, // Цвет текста кнопок – белый.
        ),
      ),
    );
  }

  // Функция для переключения темы.
  void _toggleTheme(bool value) {
    setState(() {
      // Обновляем переменную _isDarkTheme в соответствии с переданным значением.
      _isDarkTheme = value;
    });
  }

  @override
  // Метод построения UI для MyApp.
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Отключаем отладочный баннер.
      title: 'Калькулятор площади', // Заголовок приложения.
      theme: _lightTheme, // Устанавливаем светлую тему.
      darkTheme: _darkTheme, // Устанавливаем тёмную тему.
      // Выбираем тему в зависимости от значения _isDarkTheme.
      themeMode: _isDarkTheme ? ThemeMode.dark : ThemeMode.light,
      // Главная страница приложения.
      home: HomePage(
        isDarkTheme: _isDarkTheme, // Передаем текущий режим темы.
        onThemeChanged: _toggleTheme, // Передаем функцию для изменения темы.
      ),
      // Определяем маршруты для навигации.
      routes: {
        '/achievements': (ctx) => const AchievementsPage(), // Маршрут для страницы достижений.
      },
    );
  }
}

/// Главная страница приложения.
class HomePage extends StatefulWidget {
  // Флаг, определяющий, используется ли тёмная тема.
  final bool isDarkTheme;
  // Callback, который вызывается при изменении темы.
  final ValueChanged<bool> onThemeChanged;

  const HomePage({
    Key? key,
    required this.isDarkTheme, // Обязательный параметр для режима темы.
    required this.onThemeChanged, // Обязательный параметр для функции смены темы.
  }) : super(key: key);

  @override
  // Создаем состояние для HomePage.
  State<HomePage> createState() => _HomePageState();
}

// Класс состояния для главной страницы.
class _HomePageState extends State<HomePage> {
  // Обработчик переключения темы.
  void _handleThemeSwitch(bool value) {
    setState(() {
      // Вызываем переданный callback для смены темы.
      widget.onThemeChanged(value);
    });
  }

  @override
  // Метод построения UI для главной страницы.
  Widget build(BuildContext context) {
    // Выбираем иконку для темы: луна для тёмной темы, солнце для светлой.
    final themeIcon =
    widget.isDarkTheme ? Icons.brightness_2 : Icons.brightness_high;

    return Scaffold(
      // Верхняя панель приложения.
      appBar: AppBar(
        elevation: 0, // Без тени.
        // Заголовок AppBar в виде строки (Row).
        title: Row(
          children: [
            Icon(themeIcon), // Иконка, отражающая текущую тему.
            const SizedBox(width: 8), // Отступ между иконкой и текстом.
            const Text('Калькулятор площади'), // Текст заголовка.
          ],
        ),
        // Элементы в правой части AppBar.
        actions: [
          // Переключатель темы.
          Switch(
            value: widget.isDarkTheme, // Текущее состояние темы.
            onChanged: _handleThemeSwitch, // Обработчик изменения состояния.
            activeColor: Colors.white, // Цвет активного переключателя.
          ),
        ],
      ),
      // Основной контент страницы.
      body: SafeArea(
        // Обеспечивает корректное расположение виджетов внутри безопасной зоны экрана.
        child: SingleChildScrollView(
          // Позволяет прокручивать содержимое страницы.
          child: Padding(
            padding: const EdgeInsets.all(16.0), // Отступы вокруг содержимого.
            child: AreaCalculatorWidget(
              isDarkMode: widget.isDarkTheme, // Передаем информацию о текущей теме.
            ),
          ),
        ),
      ),
      // Нижняя панель, отображается только в тёмном режиме.
      bottomNavigationBar: widget.isDarkTheme
          ? InkWell(
        // Обработчик нажатия на нижнюю панель.
        onTap: () {
          // Переход на страницу достижений по маршруту '/achievements'.
          Navigator.of(context).pushNamed('/achievements');
        },
        child: Container(
          color: Colors.green, // Зеленый фон нижней панели.
          height: 50, // Высота панели.
          alignment: Alignment.center, // Центрирование содержимого.
          child: const Text(
            'Ачивки', // Текст кнопки.
            style: TextStyle(
              color: Colors.white, // Белый цвет текста.
              fontSize: 18, // Размер шрифта.
              fontWeight: FontWeight.bold, // Жирное начертание.
            ),
          ),
        ),
      )
          : null, // Если тема светлая, нижняя панель не отображается.
    );
  }
}

/// Основная логика калькулятора.
class AreaCalculatorWidget extends StatefulWidget {
  // Флаг, указывающий, активна ли тёмная тема.
  final bool isDarkMode;

  const AreaCalculatorWidget({Key? key, required this.isDarkMode})
      : super(key: key);

  @override
  // Создаем состояние для AreaCalculatorWidget.
  State<AreaCalculatorWidget> createState() => _AreaCalculatorWidgetState();
}

// Класс состояния для калькулятора площади.
class _AreaCalculatorWidgetState extends State<AreaCalculatorWidget> {
  // Ключ формы для валидации.
  final _formKey = GlobalKey<FormState>();
  // Контроллер для ввода ширины.
  final TextEditingController _widthController = TextEditingController();
  // Контроллер для ввода высоты.
  final TextEditingController _heightController = TextEditingController();

  // Список единиц измерения для ввода.
  final List<String> _unitsForInput = ['м', 'см', 'мм'];
  // Список единиц измерения для вывода.
  final List<String> _unitsForOutput = ['м', 'см', 'мм'];

  // Текущая единица измерения для ввода.
  String _inputUnit = 'м';
  // Текущая единица измерения для вывода.
  String _outputUnit = 'м';
  // Строка для отображения результата вычисления.
  String _resultText = '';
  // Режимы округления.
  final List<String> _roundModes = ['Авто', 'В большую', 'В меньшую'];
  // Выбранный режим округления (по умолчанию "Авто").
  String _selectedRoundMode = 'Авто';

  // Счетчик ошибок валидации ввода.
  int _validationErrorCount = 0;

  // Факторы преобразования для единиц длины.
  static const Map<String, double> _dimensionFactor = {
    'м': 1.0,
    'см': 0.01,
    'мм': 0.001,
  };

  // Факторы преобразования для единиц площади.
  static const Map<String, double> _areaFactor = {
    'м': 1.0,
    'см': 10000.0,
    'мм': 1000000.0,
  };

  @override
  // Освобождаем ресурсы при уничтожении виджета.
  void dispose() {
    _widthController.dispose(); // Освобождаем контроллер для ширины.
    _heightController.dispose(); // Освобождаем контроллер для высоты.
    super.dispose(); // Вызываем метод dispose базового класса.
  }

  // Универсальный валидатор для числового ввода с логикой разблокировки достижений.
  String? _validateNumber(String? value) {
    if (value == null || value.isEmpty) {
      // Если поле пустое, увеличиваем счетчик ошибок и возвращаем сообщение.
      _incrementValidationError();
      return 'Пожалуйста, введите значение';
    }
    // Пытаемся преобразовать строку в число.
    final n = num.tryParse(value);
    if (n == null) {
      // Если преобразование не удалось, увеличиваем счетчик ошибок и возвращаем сообщение.
      _incrementValidationError();
      return 'Введите корректное число';
    }
    if (n <= 0) {
      // Если число меньше или равно нулю, увеличиваем счетчик ошибок и возвращаем сообщение.
      _incrementValidationError();
      return 'Число должно быть больше 0';
    }
    // Если ошибок нет, возвращаем null.
    return null;
  }

  // Функция для увеличения счетчика ошибок валидации и разблокировки достижений.
  void _incrementValidationError() {
    _validationErrorCount++; // Увеличиваем счетчик ошибок.
    if (_validationErrorCount == 1) {
      // Если это первая ошибка, пытаемся разблокировать достижение "Первый провал".
      if (Achievements.unlock(Achievements.testerFirstFail)) {
        _showAchievementNotification(context, Achievements.testerFirstFail);
      }
    }
    if (_validationErrorCount >= 3) {
      // Если ошибок три или более, пытаемся разблокировать достижения "Энтузиаст ошибок" и "Мастер валидации".
      if (Achievements.unlock(Achievements.errorEnthusiast)) {
        _showAchievementNotification(context, Achievements.errorEnthusiast);
      }
      if (Achievements.unlock(Achievements.validationMaster)) {
        _showAchievementNotification(context, Achievements.validationMaster);
      }
    }
  }

  // Проверка высокой точности ввода (больше 4 знаков после запятой).
  bool _hasHighPrecision(String value) {
    if (value.contains('.')) {
      // Разбиваем число по точке.
      final parts = value.split('.');
      // Если дробная часть длиннее 4 символов – возвращаем true.
      return parts[1].length > 4;
    }
    return false; // Если точка отсутствует, возвращаем false.
  }

  // Функция вычисления площади.
  void _calculateArea() {
    // Проверяем корректность ввода ширины.
    final widthError = _validateNumber(_widthController.text);
    // Проверяем корректность ввода высоты.
    final heightError = _validateNumber(_heightController.text);
    if (widthError != null || heightError != null) {
      // Если есть ошибки ввода, обновляем состояние и выводим сообщение.
      setState(() {
        _resultText = 'Ошибка ввода. Проверьте значения.';
      });
      return; // Прерываем вычисление.
    }

    // Если введены числа с высокой точностью, разблокируем достижение "Гуру точности".
    if (_hasHighPrecision(_widthController.text) ||
        _hasHighPrecision(_heightController.text)) {
      if (Achievements.unlock(Achievements.precisionGuru)) {
        _showAchievementNotification(context, Achievements.precisionGuru);
      }
    }

    // Преобразуем введенные строки в числа.
    final widthRaw = double.parse(_widthController.text);
    final heightRaw = double.parse(_heightController.text);

    // Пересчитываем ширину и высоту в метры, используя коэффициенты преобразования.
    final widthInMeters = widthRaw * _dimensionFactor[_inputUnit]!;
    final heightInMeters = heightRaw * _dimensionFactor[_inputUnit]!;

    // Вычисляем площадь в квадратных метрах.
    final areaInMeters2 = widthInMeters * heightInMeters;
    // Преобразуем площадь в выбранные единицы вывода.
    final areaOut = areaInMeters2 * _areaFactor[_outputUnit]!;

    double finalValue; // Переменная для хранения итогового результата.
    // Определяем режим округления в зависимости от выбранного пользователем варианта.
    switch (_selectedRoundMode) {
      case 'В большую':
        finalValue = (areaOut * 1000).ceil() / 1000; // Округление в большую сторону до 3 знаков.
        break;
      case 'В меньшую':
        finalValue = (areaOut * 1000).floor() / 1000; // Округление в меньшую сторону до 3 знаков.
        break;
      default:
        finalValue = double.parse(areaOut.toStringAsFixed(3)); // Стандартное округление до 3 знаков.
    }

    setState(() {
      // Формируем строку с результатом вычисления.
      _resultText =
      'S = $widthRaw $_inputUnit * $heightRaw $_inputUnit = $finalValue $_outputUnit²';
    });

    // Показываем уведомление о том, что вычисление прошло успешно.
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Вычисление прошло успешно!'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );

    // Вычисляем абсолютную разницу между исходным и округленным значениями.
    final difference = (areaOut - finalValue).abs();
    // Если разница значительна и активна тёмная тема, разблокируем достижение "Уровень обезьян".
    if (difference > 0.000001 && widget.isDarkMode) {
      if (Achievements.unlock(Achievements.megaAchievement)) {
        _showAchievementNotification(context, Achievements.megaAchievement);
      }
    }
  }

  // Функция обработки изменения единиц измерения, при этом разблокируется достижение "Экспериментатор".
  void _onUnitChanged(String? newUnit, bool isInput) {
    if (newUnit != null) {
      setState(() {
        if (isInput) {
          // Обновляем единицу измерения для ввода.
          _inputUnit = newUnit;
        } else {
          // Обновляем единицу измерения для вывода.
          _outputUnit = newUnit;
        }
      });
      // Пытаемся разблокировать достижение "Экспериментатор".
      if (Achievements.unlock(Achievements.unitExperimenter)) {
        _showAchievementNotification(context, Achievements.unitExperimenter);
      }
    }
  }

  // Универсальная функция для показа диалогового окна с уведомлением о разблокированном достижении.
  void _showAchievementNotification(BuildContext context, Achievement achievement) {
    showDialog(
      context: context,
      builder: (ctx) {
        // Получаем ширину экрана.
        final screenWidth = MediaQuery.of(ctx).size.width;
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // Скругляем углы диалога.
          ),
          child: Container(
            width: screenWidth * 0.9, // Ширина диалога – 90% от ширины экрана.
            constraints: const BoxConstraints(maxWidth: 500), // Максимальная ширина диалога.
            color: Colors.yellow, // Фон диалога – желтый.
            padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16), // Внутренние отступы.
            child: Stack(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start, // Выравнивание элементов по верхнему краю.
                  children: [
                    // Изображение медали.
                    Image.asset(
                      'assets/images/medal.png',
                      width: 40,
                      height: 40,
                    ),
                    const SizedBox(width: 12), // Отступ между изображением и текстом.
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start, // Выравнивание текста по левому краю.
                        mainAxisSize: MainAxisSize.min, // Колонка занимает минимально необходимое место.
                        children: [
                          // Заголовок уведомления.
                          Text(
                            'Открыто достижение!',
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 4),
                          // Название достижения.
                          Text(
                            achievement.title,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 4),
                          // Краткое описание достижения.
                          Text(
                            achievement.shortDescription,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                // Кнопка закрытия диалога.
                Positioned(
                  top: 0,
                  right: 0,
                  child: IconButton(
                    icon: const Icon(Icons.close, color: Colors.black54),
                    onPressed: () => Navigator.of(ctx).pop(), // Закрываем диалог при нажатии.
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  // Метод построения UI для калькулятора площади.
  Widget build(BuildContext context) {
    return Form(
      key: _formKey, // Привязываем форму к ключу для валидации.
      child: Column(
        children: [
          // Поле ввода ширины.
          TextFormField(
            controller: _widthController, // Контроллер для поля ввода ширины.
            keyboardType: TextInputType.number, // Ограничиваем ввод только числовыми значениями.
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.swap_horiz), // Иконка для обозначения ввода ширины.
              labelText: 'Ширина', // Метка поля.
              border: OutlineInputBorder(), // Рамка поля ввода.
            ),
            validator: _validateNumber, // Функция валидации введенного значения.
          ),
          const SizedBox(height: 16.0), // Отступ между полями.
          // Поле ввода высоты.
          TextFormField(
            controller: _heightController, // Контроллер для поля ввода высоты.
            keyboardType: TextInputType.number, // Ограничиваем ввод только числовыми значениями.
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.swap_vert), // Иконка для обозначения ввода высоты.
              labelText: 'Высота', // Метка поля.
              border: OutlineInputBorder(), // Рамка поля ввода.
            ),
            validator: _validateNumber, // Функция валидации введенного значения.
          ),
          const SizedBox(height: 16.0), // Отступ между элементами.
          // Выбор единиц измерения для ввода.
          Row(
            children: [
              const Text('Единицы ввода:', style: TextStyle(fontSize: 16.0)),
              const SizedBox(width: 16.0),
              DropdownButton<String>(
                value: _inputUnit, // Текущее выбранное значение.
                items: _unitsForInput.map((String unit) {
                  return DropdownMenuItem<String>(
                    value: unit, // Значение элемента.
                    child: Text(unit), // Текст, отображаемый в элементе.
                  );
                }).toList(),
                onChanged: (newUnit) => _onUnitChanged(newUnit, true), // Обработчик изменения единицы ввода.
              ),
            ],
          ),
          const SizedBox(height: 16.0), // Отступ между элементами.
          // Выбор единиц измерения для вывода.
          Row(
            children: [
              const Text('Единицы вывода:', style: TextStyle(fontSize: 16.0)),
              const SizedBox(width: 16.0),
              DropdownButton<String>(
                value: _outputUnit, // Текущее выбранное значение.
                items: _unitsForOutput.map((String unit) {
                  return DropdownMenuItem<String>(
                    value: unit, // Значение элемента.
                    child: Text(unit), // Текст, отображаемый в элементе.
                  );
                }).toList(),
                onChanged: (newUnit) => _onUnitChanged(newUnit, false), // Обработчик изменения единицы вывода.
              ),
            ],
          ),
          const SizedBox(height: 16.0), // Отступ между элементами.
          // Выбор режима округления.
          Row(
            children: [
              const Text('Округление:', style: TextStyle(fontSize: 16.0)),
              const SizedBox(width: 16.0),
              DropdownButton<String>(
                value: _selectedRoundMode, // Текущее выбранное значение режима округления.
                items: _roundModes.map((String mode) {
                  return DropdownMenuItem<String>(
                    value: mode, // Значение элемента.
                    child: Text(mode), // Текст, отображаемый в элементе.
                  );
                }).toList(),
                onChanged: (newMode) {
                  if (newMode != null) {
                    setState(() {
                      // Обновляем выбранный режим округления.
                      _selectedRoundMode = newMode;
                    });
                  }
                },
              ),
            ],
          ),
          const SizedBox(height: 16.0), // Отступ между элементами.
          // Кнопка для вычисления площади.
          ElevatedButton(
            onPressed: _calculateArea, // Вызываем функцию вычисления площади при нажатии.
            child: const Text('Вычислить'), // Текст кнопки.
          ),
          const SizedBox(height: 24.0), // Отступ перед выводом результата.
          // Текст для отображения результата вычисления.
          Text(
            _resultText,
            style: const TextStyle(
              fontSize: 18.0, // Размер шрифта.
              fontWeight: FontWeight.bold, // Жирное начертание.
            ),
            textAlign: TextAlign.center, // Выравнивание по центру.
          ),
          const SizedBox(height: 24.0), // Отступ снизу.
        ],
      ),
    );
  }
}

/// Класс достижения.
class Achievement {
  // Название достижения.
  final String title;
  // Краткое описание достижения.
  final String shortDescription;
  // Подробное описание достижения.
  final String detail;
  // Флаг, указывающий, заблокировано ли достижение.
  bool locked;

  Achievement({
    required this.title, // Инициализация названия.
    required this.shortDescription, // Инициализация краткого описания.
    required this.detail, // Инициализация подробного описания.
    required this.locked, // Инициализация статуса блокировки.
  });
}

/// Класс управления достижениями.
class Achievements {
  // Достижение "Первый провал".
  static final Achievement testerFirstFail = Achievement(
    title: 'Первый провал',
    shortDescription: 'Ошибка ввода',
    detail:
    'Поздравляем! Твой первый неправильный ввод стал отправной точкой для обучения. Каждая ошибка – это шанс стать лучше, и теперь ты знаешь, как важно внимательно вводить данные.',
    locked: true,
  );

  // Достижение "Энтузиаст ошибок".
  static final Achievement errorEnthusiast = Achievement(
    title: 'Энтузиаст ошибок',
    shortDescription: 'Несколько ошибок подряд',
    detail:
    'Ошибки не пугают тебя – их повторение говорит о твоём стремлении экспериментировать. Несколько подряд неверных вводов – это ценный опыт, который помогает выявить слабые места в логике.',
    locked: true,
  );

  // Достижение "Мастер валидации".
  static final Achievement validationMaster = Achievement(
    title: 'Мастер валидации',
    shortDescription: 'Ошибки – твои друзья',
    detail:
    'Ты не боишься проверять каждый ввод. Система валидации помогает избежать недоразумений, а повторяющиеся ошибки – отличный урок, который делает тебя лучше!',
    locked: true,
  );

  // Достижение "Экспериментатор".
  static final Achievement unitExperimenter = Achievement(
    title: 'Экспериментатор',
    shortDescription: 'Поиграл с единицами измерения',
    detail:
    'Ты переключил все доступные единицы измерения – метры, сантиметры, миллиметры. Любознательность и эксперимент – залог новых открытий!',
    locked: true,
  );

  // Достижение "Гуру точности".
  static final Achievement precisionGuru = Achievement(
    title: 'Гуру точности',
    shortDescription: 'Максимальная точность',
    detail:
    'Ты ввёл значения с множеством знаков после запятой, проверяя пределы точности вычислений. Это достижение показывает, что ты не боишься работать с мельчайшими деталями и стремишься к идеалу.',
    locked: true,
  );

  // Метод для разблокировки достижения. Возвращает true, если достижение было заблокировано и теперь разблокировано.
  static bool unlock(Achievement achievement) {
    if (achievement.locked) {
      achievement.locked = false;
      return true;
    }
    return false;
  }

  // Достижение "Уровень обезьян".
  static final Achievement megaAchievement = Achievement(
    title: 'Уровень обезьян',
    shortDescription: 'Двоичная погрешность',
    detail:
    'При вычислении площади возникла двоичная погрешность, которая обычно не заметна, но ты уловил её. Это говорит о твоей внимательности и мастерстве, даже если дело касается особенностей представления чисел в Dart.',
    locked: true,
  );
}

/// Страница со списком достижений.
class AchievementsPage extends StatelessWidget {
  const AchievementsPage({Key? key}) : super(key: key);

  @override
  // Метод построения UI для страницы достижений.
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Список достижений'), // Заголовок AppBar.
      ),
      // Список достижений в виде прокручиваемого списка.
      body: ListView(
        children: [
          // Элементы списка для каждого достижения.
          _buildListTile(context, Achievements.testerFirstFail),
          _buildListTile(context, Achievements.errorEnthusiast),
          _buildListTile(context, Achievements.validationMaster),
          _buildListTile(context, Achievements.unitExperimenter),
          _buildListTile(context, Achievements.precisionGuru),
          _buildListTile(context, Achievements.megaAchievement),
        ],
      ),
    );
  }

  // Метод для создания отдельного элемента списка достижения.
  ListTile _buildListTile(BuildContext context, Achievement achievement) {
    return ListTile(
      // Отображаем разное изображение в зависимости от того, разблокировано ли достижение.
      leading: achievement.locked
          ? Image.asset('assets/images/case.png', width: 40)
          : Image.asset('assets/images/medal2.png', width: 40),
      title: Text(achievement.title), // Заголовок элемента – название достижения.
      subtitle: Text(achievement.shortDescription), // Подзаголовок – краткое описание.
      onTap: () {
        // Обработчик нажатия на элемент списка.
        if (achievement.locked) {
          // Если достижение заблокировано, показываем уведомление.
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Достижение ещё заблокировано!'),
              duration: Duration(seconds: 1),
            ),
          );
        } else {
          // Если достижение разблокировано, переходим на страницу с подробной информацией.
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) =>
                  AchievementDetailPage(achievement: achievement),
            ),
          );
        }
      },
    );
  }
}

/// Страница с подробной информацией о достижении.
class AchievementDetailPage extends StatelessWidget {
  // Достижение, подробности которого необходимо показать.
  final Achievement achievement;

  const AchievementDetailPage({Key? key, required this.achievement})
      : super(key: key);

  @override
  // Метод построения UI для страницы с подробностями достижения.
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Заголовок AppBar – название достижения.
        title: Text(achievement.title),
      ),
      // Основной контент страницы – подробное описание достижения.
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Отступы вокруг текста.
        child: Text(achievement.detail), // Подробное описание достижения.
      ),
    );
  }
}
