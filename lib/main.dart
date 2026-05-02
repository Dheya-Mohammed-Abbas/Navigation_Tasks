import 'package:flutter/material.dart';

void main() {
  runApp(const MyProfessionalApp());
}

class MyProfessionalApp extends StatelessWidget {
  const MyProfessionalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'تمارين المهندس عمر الساكت',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const MainMenu(),
    );
  }
}

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('قائمة التكاليف  '), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildMenuButton(
              context,
              title: 'التكليف الأول: التنقل البسيط',
              subtitle: 'Push & Pop Navigation',
              icon: Icons.alt_route_rounded,
              color: Colors.blue.shade700,
              target: const ExerciseOneMain(),
            ),
            const SizedBox(height: 20),
            _buildMenuButton(
              context,
              title: 'التكليف الثاني: تمرير البيانات',
              subtitle: 'Passing & Returning Data',
              icon: Icons.data_exploration_rounded,
              color: Colors.purple.shade700,
              target: const ExerciseTwoListScreen(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuButton(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required Widget target,
  }) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => target),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 40),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
          ],
        ),
      ),
    );
  }
}

class ExerciseOneMain extends StatelessWidget {
  const ExerciseOneMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('التمرين الأول')),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(20)),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ExerciseOneDetails()),
          ),
          child: const Text('الذهاب لشاشة التفاصيل (Push)'),
        ),
      ),
    );
  }
}

class ExerciseOneDetails extends StatelessWidget {
  const ExerciseOneDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('شاشة التفاصيل')),
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade100),
          onPressed: () => Navigator.pop(context),
          child: const Text('العودة للرئيسية (Pop)'),
        ),
      ),
    );
  }
}

class Product {
  final String name;
  final String description;
  final double price;
  final IconData icon;

  Product({
    required this.name,
    required this.description,
    required this.price,
    required this.icon,
  });
}

class ExerciseTwoListScreen extends StatelessWidget {
  const ExerciseTwoListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // قائمة منتجات "مدلعة"
    final List<Product> products = [
      Product(
        name: 'ماك بوك برو 16',
        description: 'أقوى حاسوب للمبرمجين مع شاشة Retina.',
        price: 2500,
        icon: Icons.laptop_mac,
      ),
      Product(
        name: 'ايفون 15',
        description: 'كاميرا سينمائية وأداء جبار.',
        price: 1100,
        icon: Icons.phone_iphone,
      ),
      Product(
        name: ' سماعة رأس Bose',
        description: 'نقاء صوت خيالي مع عزل للضوضاء.',
        price: 550,
        icon: Icons.headphones,
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('قائمة المنتجات')),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final p = products[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: ListTile(
              leading: CircleAvatar(child: Icon(p.icon)),
              title: Text(
                p.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('${p.price} \$'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ExerciseTwoDetailsScreen(product: p),
                  ),
                );

                // عرض النتيجة في SnackBar "مدلع"
                if (result != null && context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(' $result'),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.green.shade600,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}

class ExerciseTwoDetailsScreen extends StatelessWidget {
  final Product product;
  const ExerciseTwoDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product.name)),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Icon(product.icon, size: 100, color: Colors.indigo),
            const SizedBox(height: 20),
            Text(
              product.name,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              product.description,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            Text(
              '${product.price} \$',
              style: const TextStyle(
                fontSize: 24,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.all(15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: () {
                  // ⭐️ الدقة: إرجاع رسالة تأكيد ⭐️
                  Navigator.pop(context, 'تمت معاينة ${product.name} بنجاح ');
                },
                icon: const Icon(Icons.check_circle),
                label: const Text(
                  'رجوع مع تأكيد',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
