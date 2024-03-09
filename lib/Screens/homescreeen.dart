import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeContent(),
    BlogsPostScreen(),
    CropsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Kisan Setu',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green,
      ),
      backgroundColor: Colors.lightGreen[50], // Main background color
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              padding: EdgeInsets.only(top: 8, left: 16, right: 16, bottom: 4),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',
                ),
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.cloud, size: 32, color: Colors.green),
              title: Text(
                'Weather Forecast',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WeatherForecastScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.agriculture, size: 32, color: Colors.green),
              title: Text(
                'Crop Management',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CropManagementScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.attach_money, size: 32, color: Colors.green),
              title: Text(
                'Market Prices',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MarketPricesScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.bug_report, size: 32, color: Colors.green),
              title: Text(
                'Pest Control',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PestControlScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'Blogs Post',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grass),
            label: 'Crops',
          ),
        ],
        selectedItemColor: Colors.green, // Selected item color
        unselectedItemColor: Colors.grey[600], // Unselected item color
        backgroundColor: Colors.lightGreen[100], // Background color
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: SizedBox(
                height: 200, // Adjust height of the image container
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 16),
                      child: Image.network(
                        'https://khetibuddy.com/wp-content/uploads/2022/02/image5-1-768x427-1.png',
                        width: 300,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 16),
                      child: Image.network(
                        'https://efarmingodisha.files.wordpress.com/2019/12/efarming1.jpg?w=825&h=510',
                        width: 300,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Image.network(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSAjXfg0C97kUYRxOp1plFd94VAnwV7n0NHlA&usqp=CAU',
                      width: 300,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  children: [
                    GridItem(
                      title: 'Weather Forecast',
                      icon: Icons.cloud,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WeatherForecastScreen()),
                        );
                      },
                    ),
                    GridItem(
                      title: 'Crop Management',
                      icon: Icons.agriculture,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CropManagementScreen()),
                        );
                      },
                    ),
                    GridItem(
                      title: 'Market Prices',
                      icon: Icons.attach_money,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MarketPricesScreen()),
                        );
                      },
                    ),
                    GridItem(
                      title: 'Pest Control',
                      icon: Icons.bug_report,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PestControlScreen()),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class GridItem extends StatefulWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const GridItem({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  _GridItemState createState() => _GridItemState();
}

class _GridItemState extends State<GridItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Card(
          elevation: _isHovered ? 8 : 4, // Change elevation on hover
          color: _isHovered ? Colors.green[100] : Colors.white, // Change color on hover
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(widget.icon, size: 48, color: Colors.green),
                SizedBox(height: 8),
                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: _isHovered ? Colors.green : Colors.black, // Change text color on hover
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
  
  

class BlogsPostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Blogs Post Screen'),
      ),
    );
  }
}

class CropsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Crops Screen'),
      ),
    );
  }
}

class WeatherForecastScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Forecast'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '7-Day Weather Forecast',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Check the weather forecast for the next 7 days in your area.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20),
            Image.network(
              'https://t4.ftcdn.net/jpg/03/85/33/67/360_F_385336747_lCcNeRpqrhmwr3TiToK4DokmwljzEY1q.jpg',
              width: 300,
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Text(
              'Here is a graphical representation of the weather forecast:',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20),
            Image.network(
              'https://img.freepik.com/free-vector/illustration-weather-forecast_53876-20623.jpg?size=626&ext=jpg&ga=GA1.1.1448711260.1706745600&semt=ais',
              width: 300,
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Text(
              'Stay informed and plan your activities accordingly!',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CropManagementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crop Management'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Crop Management',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Manage your crops effectively with our crop management tools.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20),
            Image.network(
              'https://www.cabi.org/wp-content/uploads/International-development/Centres/ICM-Diagram-FINAL.jpg',
              width: 300,
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Text(
              'Stay organized and keep track of your crop-related activities!',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MarketPricesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Market Prices'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Market Prices',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Check the latest market prices for various crops to make informed decisions.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20),
            Image.network(
              'https://www.tbsnews.net/sites/default/files/styles/infograph/public/images/2020/08/11/farmers_not_getting_even_half_of_market_price.jpg',
              width: 300,
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Text(
              'Stay updated with market trends to maximize your profits!',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PestControlScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pest Control'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Pest Control',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Learn about common pests and how to control them to protect your crops.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20),
            Image.network(
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT2_UILQXQcuSb_rFPjdFAbrCucioUCBk5cmJqr1l6Q6NM4XwZ8dqugclJLxPj693RB6ls&usqp=CAU',
              width: 300,
              height: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Text(
              'Keep your crops safe from pests and ensure a healthy yield!',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
