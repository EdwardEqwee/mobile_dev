import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

void main() {
  runApp(MyApp());
}

/// Главный класс приложения
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'КубГАУ - Детали',
      theme: ThemeData(primarySwatch: Colors.green),
      home: HomeScreen(),
    );
  }
}

/// Экран с деталями университета КубГАУ
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLiked = false; // Состояние кнопки "лайк"

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('КубГАУ - Детали'),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Изображение университета
            Image.asset(
              'assets/place.jpg',
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
            ),
            SizedBox(height: 16),

            /// Заголовок с названием и рейтингом
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Кубанский государственный аграрный университет имени И.Т.Трубилина',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),

                  /// Блок с адресом и лайком
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'г. Краснодар, ул. Калинина, 13',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isLiked = !isLiked;
                          });
                        },
                        child: AnimatedSwitcher(
                          duration: Duration(milliseconds: 300),
                          transitionBuilder: (child, animation) {
                            return ScaleTransition(scale: animation, child: child);
                          },
                          child: Icon(
                            isLiked ? Icons.favorite : Icons.favorite_border,
                            key: ValueKey<bool>(isLiked),
                            color: isLiked ? Colors.red : Colors.grey,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  /// Кнопки действий
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildActionButton(Icons.phone, 'Позвонить', () => _makeCall("+78612215942")),
                      _buildActionButton(Icons.map, 'Маршрут', _openMap),
                      _buildActionButton(Icons.share, 'Поделиться', _sharePlace),
                      _buildActionButton(Icons.email, 'Почта', _sendEmail),
                    ],
                  ),

                  SizedBox(height: 20),
                  Text(
                    'КубГАУ — одно из ведущих высших учебных заведений России в области аграрного образования. Основанный в 1922 году, университет имеет богатую историю и традиции. За время существования КубГАУ подготовил более 140 тысяч специалистов.\n\n'
                        'В университете 17 факультетов, около 18 тысяч студентов. Направления подготовки включают агрономию, агроинженерию, ветеринарию, технологии переработки, юриспруденцию и многое другое.\n\n'
                        'КубГАУ активно занимается научными исследованиями и внедрением инноваций. В университете работают два НИИ: биотехнологии и сертификации пищевой продукции, а также прикладной и экспериментальной экологии.\n\n'
                        'Кампус включает 22 учебных корпуса, 20 общежитий, библиотеку, спортивный комплекс, ботанический сад и многое другое. КубГАУ активно участвует в международных проектах, обмениваясь опытом с зарубежными вузами и научными центрами.\n\n'
                        'Таким образом, Кубанский государственный аграрный университет сочетает богатые традиции, современные образовательные и научные подходы, активно внедряя инновации.',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            /// Контакты
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Контакты',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            _buildContactInfo(Icons.phone, 'Приемная ректора', '+7 (861) 221-59-42', 'tel:+78612215942'),
            _buildContactInfo(Icons.fax_sharp, 'Факс', '+7 (861) 221-58-85', 'tel:+78612215885'),
            _buildContactInfo(Icons.phone, 'Приемная комиссия', '+7 (861) 221-58-18', 'tel:+78612215818'),
            _buildContactInfo(Icons.email, 'E-mail', 'mail@kubsau.ru', 'mailto:mail@kubsau.ru'),

            Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: ElevatedButton.icon(
            onPressed: _openWebsite,

            label: Text('Перейти на сайт КубГАУ'),
            style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
            ),
            ),
          ],
        ),
      ),
    );
  }

  /// Открытие экрана вызова с указанным номером
  void _makeCall(String phoneNumber) async {
    final Uri callUri = Uri.parse("tel:$phoneNumber");
    if (await canLaunchUrl(callUri)) {
      await launchUrl(callUri);
    }
  }

  /// Открытие Яндекс.Карт с местоположением КубГАУ
  void _openMap() async {
    Uri mapUri = Uri.parse("https://yandex.ru/maps/-/CHuIIOoJ");
    if (await canLaunchUrl(mapUri)) {
      await launchUrl(mapUri, mode: LaunchMode.externalApplication);
    }
  }

  /// Функция для кнопки "Поделиться"
  void _sharePlace() {
    String message = "🎓 КубГАУ - один из ведущих аграрных университетов России! 📍 Посмотрите на карту: https://yandex.ru/maps/-/CHuIIOoJ";
    Share.share(message);
  }

  /// Функция для отправки письма
  void _sendEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'mail@kubsau.ru',
      queryParameters: {
        'subject': 'Вопрос по обучению в КубГАУ',
        'body': 'Здравствуйте! Хотел бы узнать подробнее о программах обучения.'
      },
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    }
  }

  /// Виджет для отображения контактной информации
  Widget _buildContactInfo(IconData icon, String title, String subtitle, String link) {
    return ListTile(
      leading: Icon(icon, color: Colors.green),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle, style: TextStyle(color: Colors.blue)),
      onTap: () async {
        Uri uri = Uri.parse(link);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri);
        }
      },
    );
  }

  /// Виджет кнопки действий (звонок, маршрут, поделиться, почта)
  Widget _buildActionButton(IconData icon, String label, VoidCallback onPressed) {
    return Column(
      children: [
        IconButton(
          icon: Icon(icon, size: 32, color: Colors.green),
          onPressed: onPressed,
        ),
        SizedBox(height: 8),
        Text(label, style: TextStyle(fontSize: 14, color: Colors.green)),
      ],
    );
  }

  /// 🌍 Открытие сайта КубГАУ
  void _openWebsite() async {
    Uri websiteUri = Uri.parse("https://www.kubsau.ru/");
    if (await canLaunchUrl(websiteUri)) {
      await launchUrl(websiteUri);
    }
  }
}
