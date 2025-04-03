// Created By Amit Jangid 06/09/21

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gail_connect/models/city.dart';
import 'package:multiutillib/widgets/material_card.dart';
import 'package:gail_connect/ui/styles/text_styles.dart';
import 'package:gail_connect/ui/widgets/custom_app_bar.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';
import 'package:gail_connect/core/controllers/hospitals_controller.dart';

class CityFilterScreen extends StatelessWidget {
  const CityFilterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:  CustomAppBar(title: kSelectFilters),
      body: GetBuilder<HospitalsController>(
        id: kSelectCity,
        builder: (_hospitalsController) {
          return Column(
            children: [
              MaterialCard(
                borderRadius: 12,
                padding: const EdgeInsets.only(),
                margin: const EdgeInsets.only(top: 12, left: 12, right: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        autocorrect: false,
                        controller: _hospitalsController.searchCityController,
                        // calling on states search method
                        onChanged: _hospitalsController.onCitySearch,
                        decoration: const InputDecoration(
                          hintText: kSearch,
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.clear, color: Colors.black),
                      // calling clear city search method
                      onPressed: () => _hospitalsController.clearCitySearch(),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: _hospitalsController.filteredCityList.length,
                  padding: const EdgeInsets.only(top: 18, left: 12, right: 12, bottom: 48),
                  separatorBuilder: (BuildContext context, int index) => Divider(color: Colors.grey[400]),
                  itemBuilder: (context, _position) {
                    final City _city = _hospitalsController.filteredCityList[_position];

                    return InkWell(
                      // calling on city selected method
                      onTap: () => _hospitalsController.onCitySelected(selectedCity: _city),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text(_city.cityName!, style: textStyle14Normal),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
