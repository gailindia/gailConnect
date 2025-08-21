// Created By Amit Jangid on 12/11/21

import 'package:flutter/material.dart';
import 'package:gail_connect/ui/styles/color_controller.dart';
import 'package:get/get.dart';
import 'package:multiutillib/utils/ui_helpers.dart';

typedef ItemWidgetBuilder<T> = Widget Function(BuildContext contet, T item);

class SearchableListViewBuilder<T> extends StatelessWidget {
  final List<T> items;
  final String? searchHint;
  final String? noRecordsMessage;
  final ItemWidgetBuilder<T> itemBuilder;

  const SearchableListViewBuilder({
    Key? key,
    this.noRecordsMessage,
    this.searchHint = 'Search...',
    required this.items,
    required this.itemBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ColorController colorController = Get.put(ColorController());
    if (items.isNotEmpty) {
      return GetBuilder<SearchController<T>>(
        id: 'SearchableListView',
        init: SearchController<T>(list: items),
        builder: (_controller) {
          return Column(
            children: [
              TextField(
                controller: _controller.searchController,
                onChanged: (_searchQuery) => _controller.onSearchTermEntered = _searchQuery,
                decoration: InputDecoration(
                  hintText: searchHint,
                  suffixIcon: IconButton(
                    color: colorController.kPrimaryColor,
                    icon: const Icon(Icons.clear),
                    // calling clear search tem method
                    onPressed: _controller.clearSearchTerm,
                  ),
                ),
              ),
              verticalSpace12,
              Expanded(
                child: ListView.builder(
                  itemCount: _controller.filteredList.length,
                  itemBuilder: (context, index) => itemBuilder(context, _controller.filteredList[index]),
                ),
              ),
            ],
          );
        },
      );
    }

    return EmptyContent(noRecordsMessage: noRecordsMessage);
  }
}

class EmptyContent extends StatelessWidget {
  final String? noRecordsMessage;

  const EmptyContent({Key? key, this.noRecordsMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(noRecordsMessage ?? 'No Records Found', style: const TextStyle(fontSize: 32, color: Colors.black54)),
    );
  }
}

class SearchController<T> extends GetxController {
  final List<T> list;
  List<T> filteredList = [];

  final _onSearchTermEntered = ''.obs;

  SearchController({required this.list});

  get onSearchTermEntered => _onSearchTermEntered.value;

  set onSearchTermEntered(value) => _onSearchTermEntered.value = value;

  final TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();

    filteredList = list;

    debounce(
      _onSearchTermEntered,
      // calling on search method
      (String _enteredSearchQuery) => onSearch(_enteredSearchQuery),
      onError: () => debugPrint('error while performing search on list'),
      time: const Duration(milliseconds: 200),
    );
  }

  clearSearchTerm() {
    onSearchTermEntered = '';
    searchController.text = '';
  }

  onSearch(String _searchQuery) async {
    if (_searchQuery.isNotEmpty) {
      final List<T> _tempList = [];

      for (final _item in list) {
        if (_item.toString().toLowerCase().contains(_searchQuery)) {
          _tempList.add(_item);
        }
      }

      filteredList = _tempList;
      update(['SearchableListView']);
    } else {
      filteredList = list;
      update(['SearchableListView']);
    }
  }

  @override
  void dispose() {
    searchController.dispose();

    super.dispose();
  }
}
