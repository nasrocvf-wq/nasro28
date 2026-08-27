import 'package:flutter/material.dart';

void main() {
  runApp(const VoiceRoomApp());
}

class VoiceRoomApp extends StatelessWidget {
  const VoiceRoomApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'الغرفة الصوتية',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.deepPurple,
        fontFamily: 'Arial',
      ),
      home: const HomePage(),
    );
  }
}

// ==================== الصفحة الرئيسية ====================

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  final List<Widget> pages = const [
    RoomsPage(),
    UsersPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'الغرفة الصوتية',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.admin_panel_settings),
            tooltip: 'لوحة التحكم',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AdminDashboard(),
                ),
              );
            },
          ),
        ],
      ),
      body: pages[currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.meeting_room_outlined),
            selectedIcon: Icon(Icons.meeting_room),
            label: 'الغرف',
          ),
          NavigationDestination(
            icon: Icon(Icons.people_outline),
            selectedIcon: Icon(Icons.people),
            label: 'المستخدمون',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'حسابي',
          ),
        ],
      ),
    );
  }
}

// ==================== الغرف ====================

class RoomsPage extends StatelessWidget {
  const RoomsPage({super.key});

  final List<Map<String, dynamic>> rooms = const [
    {
      'name': 'غرفة الأصدقاء',
      'users': 24,
      'icon': Icons.groups,
    },
    {
      'name': 'النقاش العام',
      'users': 57,
      'icon': Icons.forum,
    },
    {
      'name': 'غرفة الموسيقى',
      'users': 18,
      'icon': Icons.music_note,
    },
    {
      'name': 'التقنية والبرمجة',
      'users': 31,
      'icon': Icons.computer,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Colors.deepPurple,
                Colors.purpleAccent,
              ],
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'مرحباً بك 👋',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'اختر غرفة صوتية للانضمام إليها',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'الغرف الصوتية',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),
            FilledButton.icon(
              onPressed: () {
                showCreateRoomDialog(context);
              },
              icon: const Icon(Icons.add),
              label: const Text('غرفة'),
            ),
          ],
        ),

        const SizedBox(height: 12),

        ...rooms.map(
          (room) => RoomCard(
            name: room['name'],
            users: room['users'],
            icon: room['icon'],
          ),
        ),
      ],
    );
  }
}

// ==================== بطاقة الغرفة ====================

class RoomCard extends StatelessWidget {
  final String name;
  final int users;
  final IconData icon;

  const RoomCard({
    super.key,
    required this.name,
    required this.users,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: CircleAvatar(
          radius: 28,
          child: Icon(icon),
        ),
        title: Text(
          name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        subtitle: Row(
          children: [
            const Icon(
              Icons.people,
              size: 16,
            ),
            const SizedBox(width: 4),
            Text('$users مستخدم'),
            const SizedBox(width: 10),
            const Icon(
              Icons.circle,
              size: 9,
              color: Colors.green,
            ),
            const SizedBox(width: 4),
            const Text('مباشرة'),
          ],
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => VoiceRoomPage(roomName: name),
            ),
          );
        },
      ),
    );
  }
}

// ==================== الغرفة الصوتية ====================

class VoiceRoomPage extends StatefulWidget {
  final String roomName;

  const VoiceRoomPage({
    super.key,
    required this.roomName,
  });

  @override
  State<VoiceRoomPage> createState() => _VoiceRoomPageState();
}

class _VoiceRoomPageState extends State<VoiceRoomPage> {
  bool microphoneOn = false;

  final List<String> users = [
    'Nasro',
    'محمد',
    'أحمد',
    'سارة',
    'ياسين',
    'ليلى',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.roomName),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),

          const Text(
            '🎙️ الغرفة الصوتية',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          Text(
            '${users.length} مستخدم متصل',
            style: const TextStyle(
              color: Colors.grey,
            ),
          ),

          const SizedBox(height: 25),

          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: users.length,
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 20,
              ),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    CircleAvatar(
                      radius: 34,
                      child: Text(
                        users[index][0],
                        style: const TextStyle(fontSize: 25),
                      ),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      users[index],
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Icon(
                      Icons.mic,
                      size: 16,
                      color: Colors.green,
                    ),
                  ],
                );
              },
            ),
          ),

          Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  heroTag: 'mic',
                  backgroundColor:
                      microphoneOn ? Colors.green : null,
                  onPressed: () {
                    setState(() {
                      microphoneOn = !microphoneOn;
                    });
                  },
                  child: Icon(
                    microphoneOn ? Icons.mic : Icons.mic_off,
                  ),
                ),

                FloatingActionButton(
                  heroTag: 'leave',
                  backgroundColor: Colors.red,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.call_end),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ==================== المستخدمون ====================

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final users = [
      'Nasro',
      'محمد',
      'أحمد',
      'سارة',
      'ياسين',
      'ليلى',
      'عمر',
    ];

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'المستخدمون',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 15),
        ...users.map(
          (user) => Card(
            child: ListTile(
              leading: CircleAvatar(
                child: Text(user[0]),
              ),
              title: Text(user),
              subtitle: const Text('متصل الآن'),
              trailing: const Icon(
                Icons.circle,
                color: Colors.green,
                size: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ==================== الحساب ====================

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const CircleAvatar(
          radius: 55,
          child: Icon(
            Icons.person,
            size: 55,
          ),
        ),
        const SizedBox(height: 15),
        const Center(
          child: Text(
            'Nasro',
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 30),
        Card(
          child: ListTile(
            leading: const Icon(Icons.person),
            title: const Text('الملف الشخصي'),
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
        ),
        Card(
          child: ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('الإعدادات'),
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
        ),
        Card(
          child: ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('تسجيل الخروج'),
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
        ),
      ],
    );
  }
}

// ==================== لوحة التحكم ====================

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('لوحة تحكم الإدارة'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.admin_panel_settings,
                  color: Colors.white,
                  size: 45,
                ),
                SizedBox(height: 10),
                Text(
                  'لوحة الإدارة',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'إدارة التطبيق والغرف والمستخدمين',
                  style: TextStyle(
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          Row(
            children: [
              Expanded(
                child: StatCard(
                  title: 'المستخدمون',
                  value: '1,250',
                  icon: Icons.people,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: StatCard(
                  title: 'الغرف',
                  value: '48',
                  icon: Icons.meeting_room,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          Row(
            children: [
              Expanded(
                child: StatCard(
                  title: 'متصل الآن',
                  value: '327',
                  icon: Icons.online_prediction,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: StatCard(
                  title: 'بلاغات',
                  value: '12',
                  icon: Icons.report,
                ),
              ),
            ],
          ),

          const SizedBox(height: 25),

          const Text(
            'إدارة التطبيق',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          AdminButton(
            icon: Icons.people,
            title: 'إدارة المستخدمين',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ManageUsersPage(),
                ),
              );
            },
          ),

          AdminButton(
            icon: Icons.meeting_room,
            title: 'إدارة الغرف',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ManageRoomsPage(),
                ),
              );
            },
          ),

          AdminButton(
            icon: Icons.report,
            title: 'البلاغات',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('لا توجد بلاغات جديدة'),
                ),
              );
            },
          ),

          AdminButton(
            icon: Icons.settings,
            title: 'إعدادات التطبيق',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

// ==================== إحصائيات ====================

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Icon(
              icon,
              size: 30,
              color: Colors.deepPurple,
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(title),
          ],
        ),
      ),
    );
  }
}

// ==================== زر الإدارة ====================

class AdminButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const AdminButton({
    super.key,
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(icon),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
}

// ==================== إدارة المستخدمين ====================

class ManageUsersPage extends StatelessWidget {
  const ManageUsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final users = [
      'Nasro',
      'محمد',
      'أحمد',
      'سارة',
      'ياسين',
      'ليلى',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('إدارة المستخدمين'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: users.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                child: Text(users[index][0]),
              ),
              title: Text(users[index]),
              subtitle: const Text('حساب نشط'),
              trailing: PopupMenuButton<String>(
                onSelected: (value) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        '$value: ${users[index]}',
                      ),
                    ),
                  );
                },
                itemBuilder: (context) => const [
                  PopupMenuItem(
                    value: 'حظر',
                    child: Text('حظر المستخدم'),
                  ),
                  PopupMenuItem(
                    value: 'كتم',
                    child: Text('كتم الصوت'),
                  ),
                  PopupMenuItem(
                    value: 'مشرف',
                    child: Text('جعله مشرفاً'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// ==================== إدارة الغرف ====================

class ManageRoomsPage extends StatelessWidget {
  const ManageRoomsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final rooms = [
      'غرفة الأصدقاء',
      'النقاش العام',
      'غرفة الموسيقى',
      'التقنية والبرمجة',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('إدارة الغرف'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: rooms.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: const CircleAvatar(
                child: Icon(Icons.meeting_room),
              ),
              title: Text(rooms[index]),
     
