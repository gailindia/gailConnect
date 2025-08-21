// Created By Amit Jangid on 26/11/21

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gail_connect/models/utilization.dart';
import 'package:gail_connect/rest/gail_connect_services.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';

class UtilizationController extends GetxController {
  bool isLoading = true;
  String selectedListTitle = '';

  final ScrollController scrollController = ScrollController();

  List<Utilization> _utilizationList = [];
  List<Utilization> pieChartUtilizationList = [];
  List<Utilization> pieChartDetailsUtilizationList = [];

  final List<Utilization> hospitalsScreenUtilizationList = [];
  final List<Utilization> employeesScreenUtilizationList = [];
  final List<Utilization> dashboardScreenUtilizationList = [];
  final List<Utilization> guestHousesScreenUtilizationList = [];
  final List<Utilization> usefulLinksScreenUtilizationList = [];
  final List<Utilization> newsDashboardScreenUtilizationList = [];
  final List<Utilization> healthScreenUtilizationList = [];
  final List<Utilization> homeScreenUtilizationList = [];
  final List<Utilization> testScreenUtilizationList = [];

  @override
  void onInit() {
    super.onInit();

    // calling get utilization list api method
    getUtilizationList();
  }

  @override
  void onReady() {
    super.onReady();

    // calling hit count api method
    // GailConnectServices.to.hitCountApi(activity: 'Utilization Screen');
  }

  getUtilizationList() async {
    isLoading = true;
    update([kUtilization]);

    // calling get utilization api method
    _utilizationList = await GailConnectServices.to.getUtilizationApi();

    // calling generate pie chart data method
    _generatePieChartData();
  }

  _scrollToEnd() async {
    await Future.delayed(const Duration(milliseconds: 400));

    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 400),
    );
  }

  _generatePieChartData() {
    for (final Utilization _utilization in _utilizationList) {
      switch (_utilization.screen) {
        case kEmployeesScreen:
        case kEmployeesAdvanceFilterScreen:
        case kSelectContactScreen:
        case kEmployeesGroupsScreen:
        case kEmployeeChatListScreen:
        case kCreateEmployeeGroupScreen:
        case kEmployeesGroupSendMsgScreen:
        case kEmployeesGroupDetailsScreen:
        case kSelectContactForGroupScreen:
        case kEmployeeGroupChatRoomScreen:
        case kEmployeesGroupChatDetailsScreen:
        case kUpdateEmployeeGroupIconNameScreen:
        case kUpdateEmployeeGroupChatInfoScreen:
          employeesScreenUtilizationList.add(_utilization);
          break;

        case kTwitterScreen:
        case kFacebookScreen:
        case kGailNewsScreen:
        case kIndustryNewsScreen:
        case kNewsDashboardScreen:
          newsDashboardScreenUtilizationList.add(_utilization);
          break;

        case kFMSChartScreen:
        case kFMSInboxScreen:
        case kFMSOutboxScreen:
        case kFMSSearchScreen:
        case kDashboardScreen:
        case kFMSDetailsScreen:
        case kENoteInboxScreen:
        case kENoteChartScreen:
        case kENoteSearchScreen:
        case kENoteSentBoxScreen:
        case kBWSDashboardScreen:
        case kFMSDashboardScreen:
        case kDashboardOTPScreen:
        case kENoteDashboardScreen:
        case kBWSBillDetailsScreen:
        case kFMSChartDetailsScreen:
        case kBWSCountDetailsScreen:
        case kENoteChartDetailsScreen:
        case kENoteInboxDetailsScreen:
        case kENoteSentBoxDetailsScreen:
        case kBISHelpdeskCallDetailsScreen:
        case kBISHelpdeskReportCountScreen:
        case kBISHelpdeskReportCountDetailsScreen:
          dashboardScreenUtilizationList.add(_utilization);
          break;

        case kSugam:
        case kGailWfh:
        case kMyLibrary:
        case kGailWebsite:
        case kGailTenders:
        case kGailIntranet:
        case kOfficesScreen:
        case kFeedbackScreen:
        case kControlRoomScreen:
        case kUsefulLinksScreen:
        case kVehicleSearchScreen:
        case kBISHelpdeskCallsScreen:
        case 'BISHelpdeskScreen':
        case kBISHelpdeskAddCallScreen:
        case kBISHelpdeskCallsDetailsScreen:
          usefulLinksScreenUtilizationList.add(_utilization);
          break;

        case kHospitalsScreen:
          hospitalsScreenUtilizationList.add(_utilization);
          break;

        case kGuestHouseScreen:
          guestHousesScreenUtilizationList.add(_utilization);
          break;

        case kHealth:
          healthScreenUtilizationList.add(_utilization);
          break;

        case kHomeScreen:
          homeScreenUtilizationList.add(_utilization);
        break;

        default:
          break;
      }
    }

    pieChartUtilizationList.add(
      _calculateCountTotal(
          screen: kEmployeesScreen,
          utilizationList: employeesScreenUtilizationList),
    );

    pieChartUtilizationList.add(
      _calculateCountTotal(
          screen: kNewsDashboardScreen,
          utilizationList: newsDashboardScreenUtilizationList),
    );

    pieChartUtilizationList.add(
      _calculateCountTotal(
          screen: kDashboardScreen,
          utilizationList: dashboardScreenUtilizationList),
    );

    pieChartUtilizationList.add(
      _calculateCountTotal(
          screen: kUsefulLinksScreen,
          utilizationList: usefulLinksScreenUtilizationList),
    );

    pieChartUtilizationList.add(
      _calculateCountTotal(
          screen: kHospitalsScreen,
          utilizationList: hospitalsScreenUtilizationList),
    );

    pieChartUtilizationList.add(
      _calculateCountTotal(
          screen: kGuestHouseScreen,
          utilizationList: guestHousesScreenUtilizationList),
    );

    pieChartUtilizationList.add(
      _calculateCountTotal(
          screen: kHealth ,
          utilizationList: healthScreenUtilizationList),
    );

    pieChartUtilizationList.add(
      _calculateCountTotal(
          screen: kHomeScreen ,
          utilizationList: homeScreenUtilizationList),
    );


    isLoading = false;
    update([kUtilization]);
  }

  onPieChartSectionSelected({required int pointIndex}) {
    // calling scroll to end method
    _scrollToEnd();

    final Utilization _utilization = pieChartUtilizationList[pointIndex];

    switch (pointIndex) {
      case 0:
        // pieChartDetailsUtilizationList = employeesScreenUtilizationList;
        pieChartDetailsUtilizationList = _getEmpScreensCount(
            utilizationList: employeesScreenUtilizationList);
        break;

      case 1:
        pieChartDetailsUtilizationList = newsDashboardScreenUtilizationList;
        break;

      case 2:
        pieChartDetailsUtilizationList = _getDashboardScreenCount(
            utilizationList: dashboardScreenUtilizationList);
        break;

      case 3:
        pieChartDetailsUtilizationList = _getUsefulLinksScreenCount(
            utilizationList: usefulLinksScreenUtilizationList);
        break;

      case 4:
        pieChartDetailsUtilizationList = [];
        break;

      case 5:
        pieChartDetailsUtilizationList = [];
        break;
    }

    selectedListTitle = _utilization.screen;
    update([kUtilization]);
  }

  List<Utilization> _getEmpScreensCount(
      {required List<Utilization> utilizationList}) {
    final List<Utilization> _empScreensUtilizationList = [];
    final List<Utilization> _empListScreensUtilizationList = [];
    final List<Utilization> _empGroupScreensUtilizationList = [];
    final List<Utilization> _empGroupChatScreensUtilizationList = [];

    for (final Utilization _utilization in utilizationList) {
      switch (_utilization.screen) {
        case kEmployeesScreen:
        case kEmployeesAdvanceFilterScreen:
          _empListScreensUtilizationList.add(_utilization);
          break;

        case kSelectContactScreen:
        case kEmployeesGroupsScreen:
        case kCreateEmployeeGroupScreen:
        case kEmployeesGroupSendMsgScreen:
        case kEmployeesGroupDetailsScreen:
        case kUpdateEmployeeGroupIconNameScreen:
          _empGroupScreensUtilizationList.add(_utilization);
          break;

        case kEmployeeChatListScreen:
        case kSelectContactForGroupScreen:
        case kEmployeeGroupChatRoomScreen:
        case kEmployeesGroupChatDetailsScreen:
        case kUpdateEmployeeGroupChatInfoScreen:
          _empGroupChatScreensUtilizationList.add(_utilization);
          break;

        default:
          break;
      }
    }

    _empScreensUtilizationList.add(
      _calculateCountTotal(
          screen: kEmployeesScreen,
          utilizationList: _empListScreensUtilizationList),
    );

    _empScreensUtilizationList.add(
      _calculateCountTotal(
          screen: kEmployeesGroupsScreen,
          utilizationList: _empGroupScreensUtilizationList),
    );

    _empScreensUtilizationList.add(
      _calculateCountTotal(
          screen: kEmployeeChatListScreen,
          utilizationList: _empGroupChatScreensUtilizationList),
    );

    return _empScreensUtilizationList;
  }

  List<Utilization> _getDashboardScreenCount(
      {required List<Utilization> utilizationList}) {
    final List<Utilization> _dashboardUtilizationList = [];
    final List<Utilization> _dashboardOtpUtilizationList = [];
    final List<Utilization> _fmsDashboardUtilizationList = [];
    final List<Utilization> _bwsDashboardUtilizationList = [];
    final List<Utilization> _eNoteDashboardUtilizationList = [];
    final List<Utilization> _bisHelpdeskDashboardUtilizationList = [];

    for (final Utilization _utilization in utilizationList) {
      switch (_utilization.screen) {
        case kDashboardOTPScreen:
          _dashboardOtpUtilizationList.add(_utilization);
          break;

        case kFMSInboxScreen:
        case kFMSChartScreen:
        case kFMSOutboxScreen:
        case kFMSSearchScreen:
        case kFMSDetailsScreen:
        case kFMSDashboardScreen:
        case kFMSChartDetailsScreen:
          _fmsDashboardUtilizationList.add(_utilization);
          break;

        case kBWSDashboardScreen:
        case kBWSBillDetailsScreen:
        case kBWSCountDetailsScreen:
          _bwsDashboardUtilizationList.add(_utilization);
          break;

        case kENoteInboxScreen:
        case kENoteChartScreen:
        case kENoteSearchScreen:
        case kENoteSentBoxScreen:
        case kENoteChartDetailsScreen:
        case kENoteInboxDetailsScreen:
        case kENoteSentBoxDetailsScreen:
          _eNoteDashboardUtilizationList.add(_utilization);
          break;

        case kBISHelpdeskReportCountScreen:
        case kBISHelpdeskCallDetailsScreen:
        case kBISHelpdeskReportCountDetailsScreen:
          _bisHelpdeskDashboardUtilizationList.add(_utilization);
          break;

        default:
          break;
      }
    }

    _dashboardUtilizationList.add(
      _calculateCountTotal(
          screen: kDashboardOTPScreen,
          utilizationList: _dashboardOtpUtilizationList),
    );

    _dashboardUtilizationList.add(
      _calculateCountTotal(
          screen: kFMSDashboardScreen,
          utilizationList: _fmsDashboardUtilizationList),
    );

    _dashboardUtilizationList.add(
      _calculateCountTotal(
          screen: kBWSDashboardScreen,
          utilizationList: _bwsDashboardUtilizationList),
    );

    _dashboardUtilizationList.add(
      _calculateCountTotal(
          screen: kENoteDashboardScreen,
          utilizationList: _eNoteDashboardUtilizationList),
    );

    _dashboardUtilizationList.add(
      _calculateCountTotal(
        screen: kBISHelpdeskReportCountScreen,
        utilizationList: _bisHelpdeskDashboardUtilizationList,
      ),
    );

    return _dashboardUtilizationList;
  }

  List<Utilization> _getUsefulLinksScreenCount(
      {required List<Utilization> utilizationList}) {
    final List<Utilization> _officesUtilizationList = [];
    final List<Utilization> _usefulLinksUtilizationList = [];
    final List<Utilization> _allUsefulLinksUtilizationList = [];
    final List<Utilization> _bisHelpdeskCallsUtilizationList = [];

    for (final Utilization _utilization in utilizationList) {
      switch (_utilization.screen) {
        case kOfficesScreen:
        case kControlRoomScreen:
          _officesUtilizationList.add(_utilization);
          break;

        case kBISHelpdeskCallsScreen:
        case kBISHelpdeskAddCallScreen:
        case kBISHelpdeskCallDetailsScreen:
          _bisHelpdeskCallsUtilizationList.add(_utilization);
          break;

        case kSugam:
        case kGailWebsite:
        case kGailTenders:
        case kGailIntranet:
        case kFeedbackScreen:
        case kUsefulLinksScreen:
        case kVehicleSearchScreen:
        case 'BISHelpdeskScreen':
          _usefulLinksUtilizationList.add(_utilization);
          break;

        default:
          break;
      }
    }

    _allUsefulLinksUtilizationList.addAll(_usefulLinksUtilizationList);

    _allUsefulLinksUtilizationList.add(
      _calculateCountTotal(
          screen: kOfficesScreen, utilizationList: _officesUtilizationList),
    );

    _allUsefulLinksUtilizationList.add(
      _calculateCountTotal(
          screen: kBISHelpdeskCallsScreen,
          utilizationList: _bisHelpdeskCallsUtilizationList),
    );

    return _allUsefulLinksUtilizationList;
  }

  Utilization _calculateCountTotal(
      {required String screen, required List<Utilization> utilizationList}) {
    int _totalCount = 0;

    for (final Utilization _utilization in utilizationList) {
      _totalCount += _utilization.count;
    }

    return Utilization(
        count: _totalCount,
        appCode: _utilizationList[0].appCode,
        screen: screen);
  }

  @override
  void dispose() {
    scrollController.dispose();

    super.dispose();
  }
}
