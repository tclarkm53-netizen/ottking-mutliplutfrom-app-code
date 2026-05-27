import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // অ্যান্ড্রয়েড টিভির জন্য প্রপার ফোকাস এনভায়রনমেন্ট তৈরি করা
  SystemChannels.textInput.invokeMethod('TextInput.hide');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ottking',
      debugShowCheckedModeBanner: false,
      // প্রিমিয়াম ডার্ক থিম সেটআপ
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0密1A1A2E), // Deep Dark Purple Blue
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFE94560), // Premium Coral/Red Accent
          secondary: Color(0xFF0F3460),
          surface: Color(0xFF16213E),
        ),
        useMaterial3: true,
      ),
      home: const MainTVHomeScreen(),
    );
  }
}

class MainTVHomeScreen extends StatefulWidget {
  const MainTVHomeScreen({super.key});

  @override
  State<MainTVHomeScreen> createState() => _MainTVHomeScreenState();
}

class _MainTVHomeScreenState extends State<MainTVHomeScreen> {
  // ডেমো ক্যাটাগরি এবং চ্যানেল ডেটা
  final List<String> categories = ["সব চ্যানেল", "স্পোর্টস", "মুভিজ", "নিউজ", "এন্টারটেইনমেন্ট"];
  
  final List<Map<String, String>> channels = [
    {"name": "OTT-KING 1 (HD)", "desc": "লাইভ স্ট্রিমিং ১", "logo": "📺"},
    {"name": "Sports Action", "desc": "সরাসরি খেলাধুলা", "logo": "⚽"},
    {"name": "Cinema Gold", "desc": "ব্লকবাস্টার মুভি", "logo": "🎬"},
    {"name": "Global News 24", "desc": "সর্বশেষ খবর", "logo": "📰"},
    {"name": "Music Box", "desc": "নন-স্টপ মিউজিক", "logo": "🎵"},
    {"name": "Kids Zone", "desc": "কার্টুন ও অ্যানিমেশন", "logo": "🧸"},
  ];

  int selectedCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // ১. বাম পাশের ন্যাভিগেশন বার (টিভি সাইডবার মেনু)
          Container(
            width: 240,
            color: Theme.of(context).colorScheme.surface,
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ব্র্যান্ড লোগো টেক্সট
                const Text(
                  "oTtking",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFE94560),
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 40),
                // ক্যাটাগরি লিস্ট (রিমোট ফোকাস সাপোর্টেড)
                Expanded(
                  child: ListView.builder(
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      final isSelected = selectedCategoryIndex == index;
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              selectedCategoryIndex = index;
                            });
                          },
                          borderRadius: BorderRadius.circular(10),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                            decoration: BoxDecoration(
                              color: isSelected ? const Color(0xFFE94560) : Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              categories[index],
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                color: isSelected ? Colors.white : Colors.white70,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // ২. ডান পাশের মেইন কন্টেন্ট এরিয়া (চ্যানেল গ্রিড ভিউ)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // হেডার সেকশন
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        categories[selectedCategoryIndex],
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const Row(
                        children: [
                          Icon(Icons.wifi, color: Colors.greenAccent, size: 20),
                          SizedBox(width: 8),
                          Text("অনলাইন", style: TextStyle(color: Colors.greenAccent)),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  
                  // চ্যানেল কার্ড গ্রিড
                  Expanded(
                    child: GridView.builder(
                      itemCount: channels.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3, // টিভিতে ৩ কলামে দেখাবে, মোবাইলে ল্যান্ডস্কেপেও সুন্দর লাগবে
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                        childAspectRatio: 1.4,
                      ),
                      itemBuilder: (context, index) {
                        final channel = channels[index];
                        return Focus(
                          onFocusChange: (hasFocus) {
                            // রিমোট দিয়ে যখন কার্ড সিলেক্ট হবে, তখন বর্ডার বা কালার চেঞ্জের জন্য এটি কাজ করবে
                          },
                          child: InkWell(
                            onTap: () {
                              // চ্যানেল প্লে করার লজিক বা প্লেয়ার স্ক্রিন এখানে ওপেন হবে
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("${channel['name']} প্লে হচ্ছে...")),
                              );
                            },
                            borderRadius: BorderRadius.circular(15),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.surface,
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(color: Colors.white10),
                              ),
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF1A1A2E),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Text(
                                          channel['logo']!,
                                          style: const TextStyle(fontSize: 24),
                                        ),
                                      ),
                                      const Icon(Icons.play_circle_fill, color: Color(0xFFE94560), size: 30),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        channel['name']!,
                                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        channel['desc']!,
                                        style: const TextStyle(fontSize: 12, color: Colors.white50),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}