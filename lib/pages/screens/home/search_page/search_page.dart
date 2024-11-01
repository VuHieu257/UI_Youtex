import 'package:flutter/material.dart';

import '../../../../core/assets.dart';
import '../../../../core/colors/color.dart';
import '../../shopping_cart_page/shopping_cart_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<String> recentSearches = ['Vải áo thun', 'Vải áo sơ mi', 'Vải áo khoác'];
  List<String> searchResults = [];
  bool showRecentSearches = true; // Flag to toggle between recent and results

  TextEditingController searchController = TextEditingController();

  // Hàm tìm kiếm (giả lập kết quả tìm kiếm)
  void performSearch(String query) {
    setState(() {
      searchResults = [
        'Sản phẩm 1 liên quan đến $query',
        'Sản phẩm 2 liên quan đến $query',
        'Sản phẩm 3 liên quan đến $query',
      ];
      showRecentSearches = false;
    });
  }

  // Xóa một lịch sử tìm kiếm
  void removeSearchItem(int index) {
    setState(() {
      recentSearches.removeAt(index);
    });
  }

  // Xóa tất cả lịch sử tìm kiếm
  void clearAllSearches() {
    setState(() {
      recentSearches.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Bar
          Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 10,
              left: 10,
              right: 10,
              bottom: 15,
            ),
            color: Styles.blue,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    onSubmitted: (query) {
                      if (query.isNotEmpty) {
                        performSearch(query); // Thực hiện tìm kiếm
                      }
                    },
                    decoration: InputDecoration(
                      hintText: 'Tìm kiếm',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                      hintStyle: const TextStyle(color: Colors.grey),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ShoppingCartPage(),
                    ),
                  ),
                  child: const Icon(
                    Icons.shopping_cart_outlined,
                    color: Styles.light,
                  ),
                ),
                const SizedBox(width: 10),
                Image.asset(
                  Asset.iconMessage,
                  width: MediaQuery.of(context).size.width * 0.06,
                ),
              ],
            ),
          ),
          // Recent Searches / Search Results
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  showRecentSearches ? 'Recent Searches' : 'Search Results',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                if (showRecentSearches)
                  TextButton(
                    onPressed: clearAllSearches,
                    child: Text(
                      'Xóa tất cả',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
              ],
            ),
          ),
          // Hiển thị danh sách lịch sử tìm kiếm hoặc kết quả tìm kiếm
          Expanded(
            child: showRecentSearches
                ? ListView.builder(
                    itemCount: recentSearches.length,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Row(
                          children: [
                            Text(
                              recentSearches[index],
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            const Spacer(),
                            IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                removeSearchItem(index);
                              },
                            ),
                          ],
                        ),
                        subtitle: const Divider(),
                      );
                    },
                  )
                : ListView.builder(
                    itemCount: searchResults.length,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          searchResults[index],
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        onTap: () {
                          // Điều hướng đến trang sản phẩm nếu cần
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
