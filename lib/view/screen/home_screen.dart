import 'package:ecommerce/view/widgets/category_widget.dart';
import 'package:ecommerce/view/widgets/home_widget.dart';
import 'package:ecommerce/view/widgets/top_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 16,
              ),
              child: TopBar(size: size),
            ),
            TabBar(
              overlayColor: WidgetStateProperty.resolveWith<Color>((
                Set<WidgetState> states,
              ) {
                return Colors.transparent;
              }),

              splashBorderRadius: BorderRadius.circular(10),
              controller: _tabController,
              tabs: [Tab(text: "Home"), Tab(text: "Category")],
              dividerColor: Colors.transparent,
            ),

            SizedBox(height: size.height * 0.03),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [HomeWidget(), CategoryWidget()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
