import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(const FashionStylingApp());

class FashionStylingApp extends StatelessWidget {
  const FashionStylingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fashion Stylist',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pinkAccent),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? uploadedImage;
  bool showSuggestions = false;

  final List<Map<String, String>> outfitSuggestions = [
    {
      'title': 'Casual Chic',
      'description': 'White tee, ripped jeans, sneakers.',
      'image':
          'https://images.pexels.com/photos/2983464/pexels-photo-2983464.jpeg?auto=compress&cs=tinysrgb&w=600',
      'link': 'https://www2.hm.com/'
    },
    {
      'title': 'Business Smart',
      'description': 'Blazer, trousers, and formal shoes.',
      'image':
          'https://images.pexels.com/photos/3775538/pexels-photo-3775538.jpeg?auto=compress&cs=tinysrgb&w=600',
      'link': 'https://www.zara.com/'
    },
    {
      'title': 'Streetwear Vibe',
      'description': 'Hoodie, cargo pants, and chunky sneakers.',
      'image':
          'https://images.pexels.com/photos/845434/pexels-photo-845434.jpeg?auto=compress&cs=tinysrgb&w=600',
      'link': 'https://www.asos.com/'
    },
    {
      'title': 'Elegant Evening',
      'description': 'Flowy dress, heels, and subtle jewelry.',
      'image':
          'https://images.pexels.com/photos/1488463/pexels-photo-1488463.jpeg?auto=compress&cs=tinysrgb&w=600',
      'link': 'https://www.myntra.com/'
    },
  ];

  void _simulateUpload() {
    setState(() {
      uploadedImage =
          'https://images.pexels.com/photos/7679720/pexels-photo-7679720.jpeg?auto=compress&cs=tinysrgb&w=600';
      showSuggestions = true;
    });
  }

  Future<void> _openLink(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not open $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fashion Styling App 👗'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Smaller uploaded image box
            AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              height: 180, // reduced from 250
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: uploadedImage != null
                    ? DecorationImage(
                        image: NetworkImage(uploadedImage!),
                        fit: BoxFit.cover,
                      )
                    : null,
                color: Colors.grey[300],
              ),
              child: uploadedImage == null
                  ? const Center(
                      child: Text(
                        'No Image Uploaded',
                        style: TextStyle(fontSize: 18, color: Colors.black54),
                      ),
                    )
                  : null,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _simulateUpload,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pinkAccent,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              icon: const Icon(Icons.upload),
              label: const Text('Upload Outfit Image'),
            ),
            const SizedBox(height: 25),
            if (showSuggestions)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '✨ Outfit Suggestions',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  ...outfitSuggestions.map((outfit) => Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  outfit['image']!,
                                  height: 90, // smaller height
                                  width: 90, // fixed width
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      outfit['title']!,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.pinkAccent),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      outfit['description']!,
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: TextButton(
                                        onPressed: () =>
                                            _openLink(outfit['link'] ?? ''),
                                        style: TextButton.styleFrom(
                                            foregroundColor: Colors.pink),
                                        child: const Text('Shop Now →'),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ))
                ],
              )
          ],
        ),
      ),
    );
  }
}
