import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Demo extends StatefulWidget {
  const Demo({super.key});

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  late PageController controller;
  Timer? _timer;
  int _currentPage = 0;
  List<String> courseList = [
    "https://d1jnx9ba8s6j9r.cloudfront.net/imgver.1551437392/img/co_img_1539_1633434090.png",
    "https://www.livewireindia.com/blog/wp-content/uploads/2019/05/image-11.png",
    "https://www.interviewbit.com/blog/wp-content/uploads/2023/05/Artboard-1-copy-2.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQu5viOIdVWNUgxxJVbqUzTTwX7YNOuPF5eyA&s",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR-QyFdB6plrbYCWN8nz4E_gcd5UQI8FTkeWQ&s",
    "https://ehuwt7zd2je.exactdn.com/wp-content/uploads/2023/12/data-science-course-benefits.jpg",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTVk3IWrpUq30w6XpCEna81vHY_EOTizvORmg&s",
  ];

  @override
  void initState() {
    super.initState();
    controller = PageController();

    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (!mounted) return;

      _currentPage++;

      if (_currentPage >= courseList.length) {
        _currentPage = 0;
        controller.jumpToPage(0);
      }

      controller.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 200,
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,

            flexibleSpace: LayoutBuilder(
              builder: (context, constraints) {
                final top = constraints.biggest.height;

                return Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      'https://mdbcdn.b-cdn.net/img/Photos/Slides/img%20(35).webp',
                      fit: BoxFit.cover,
                    ),

                    Positioned(
                      left: 16,
                      bottom: 16,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hello!",
                            style: TextStyle(
                              fontSize: top > kToolbarHeight + 70 ? 32 : 20,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Lucky Singh Parihar",
                            style: TextStyle(
                              fontSize: top > kToolbarHeight + 70 ? 24 : 14,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),

          /// Horizontal list section
          SliverToBoxAdapter(
            child: SizedBox(
              height: 200,
              child: PageView.builder(
                onPageChanged: (value) {
                  _currentPage = value;
                },
                controller: controller,
                scrollDirection: Axis.horizontal,
                itemCount: courseList.length,
                itemBuilder: (context, index) {
                  return Container(
                    height: 200,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                    ),
                    margin: const EdgeInsets.all(8),
                    width: MediaQuery.of(context).size.width - 20,

                    child: CachedNetworkImage(
                      imageUrl: courseList[index],
                      fit: BoxFit.fill,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Center(
                            child: CircularProgressIndicator(
                              value: downloadProgress.progress,
                            ),
                          ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  );
                },
              ),
            ),
          ),

          /// Vertical list section
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return ListTile(
                title: const Text("This is title"),
                subtitle: const Text("subtitle"),
              );
            }, childCount: 20),
          ),
        ],
      ),
    );
  }
}
