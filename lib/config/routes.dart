// Created By Amit Jangid 24/08/21
import 'package:flutter/widgets.dart';
import 'package:flutter_intro/flutter_intro.dart';
import 'package:gail_connect/core/bindings/app_store_binding.dart';
import 'package:gail_connect/core/bindings/cmd_open_binding.dart';
import 'package:gail_connect/core/bindings/concent_form_binding.dart';
import 'package:gail_connect/core/bindings/depentdent_list_binding.dart';
import 'package:gail_connect/core/bindings/fresher_category_binding.dart';
import 'package:gail_connect/core/bindings/fresher_zone_binding.dart';
import 'package:gail_connect/core/bindings/health_binding.dart';
import 'package:gail_connect/core/bindings/notification_bindings.dart';
import 'package:gail_connect/core/bindings/whatsnew_binding.dart';
import 'package:gail_connect/ui/screens/app_store_screen.dart';
import 'package:gail_connect/ui/screens/cmd_open_house_screen.dart';
import 'package:gail_connect/ui/screens/concent_form_screen.dart';
import 'package:gail_connect/ui/screens/dependent_list_screen.dart';
import 'package:gail_connect/ui/screens/emp_screens/emp_list_screens/NewEmployeeJoinees.dart';
import 'package:gail_connect/ui/screens/emp_screens/emp_list_screens/emp_super_annuation_screen.dart';
import 'package:gail_connect/ui/screens/health_screens/health_commingsoon.dart';
import 'package:gail_connect/ui/screens/health_screens/health_screen.dart';
import 'package:gail_connect/ui/screens/notification_detail_screen.dart';
import 'package:gail_connect/ui/screens/useful_links_screens/apps_screen.dart';
import 'package:gail_connect/ui/screens/useful_links_screens/bis_helpdesk_calls_screens/bis_helpdesk_revised_view.dart';
import 'package:gail_connect/ui/screens/useful_links_screens/dispensary_screens/dispensary_add_call.dart';
import 'package:gail_connect/ui/screens/useful_links_screens/dispensary_screens/dispensary_dash_screen.dart';
import 'package:gail_connect/ui/screens/useful_links_screens/dispensary_screens/dispensary_history.dart';

import 'package:gail_connect/ui/screens/useful_links_screens/dispensary_screens/dispensary_history_details.dart';
import 'package:gail_connect/ui/screens/useful_links_screens/freshers_guidebook_screens/fresher_guidebook_category_screen.dart';
import 'package:gail_connect/ui/screens/useful_links_screens/freshers_guidebook_screens/fresher_guidebook_screen.dart';
import 'package:gail_connect/ui/screens/useful_links_screens/freshers_guidebook_screens/fresher_zone_screen.dart';
import 'package:gail_connect/ui/screens/useful_links_screens/my_notes_screen.dart';
import 'package:gail_connect/ui/screens/whatsnew_screen.dart';
import 'package:get/get.dart';
import 'package:gail_connect/ui/screens/screens.dart';
import 'package:gail_connect/core/bindings/bindings.dart';
import 'package:gail_connect/utils/constants/app_constants.dart';

import '../ui/screens/dashboard_screens/admin_dash_screens/emp_not_having_app_screens/emp_not_having_app_install_count.dart';
import '../ui/screens/emp_screens/emp_attendance_screens/emp_attendance_screen.dart';
import '../ui/screens/useful_links_screens/dispensary_screens/dispensary_pending.dart';

const String kOtpRoute = '/otp';
const String kSplashRoute = '/';
const String kNewsRoute = '/news';
const String kLoginRoute = '/login';
const String kFiltersRoute = '/filters';
const String kNewsCatRoute = '/newsCat';
const String kBrowserRoute = '/browser';
const String kOfficesRoute = '/offices';
const String kFmsDashRoute = '/fmsDash';
const String kBwsDashRoute = '/bwsDash';
const String kFeedbackRoute = '/feedback';
const String kMyNotesRoute = '/notes';
const String kMainDashRoute = '/mainDash';
const String kDashboardRoute = '/dashboard';
const String kHospitalsRoute = '/hospitals';
const String kLiveEventRoute = '/liveEvent';
const String kEmployeesRoute = '/employees';
const String kFullImageRoute = '/fullImage';
const String kFmsDetailRoute = '/fmsDetail';
const String kAdminDashRoute = '/adminDash';
const String kSelectEmpRoute = '/selectEmp';
const String kGuestHouseRoute = '/guestHouse';
const String kCityFilterRoute = '/cityFilter';
const String kOfficeDashRoute = '/officeDash';
const String kEmpChatRoomRoute = '/empChatRoom';
const String kUsefulLinksRoute = '/usefulLinks';
const String kAppsRoute = '/apps';
const String kUtilizationRoute = '/utilization';
const String kEmployeeInfoRoute = '/employeeInfo';
const String kEmployeesDashRoute = '/employeesDash';
const String kBannerDetailsRoute = '/bannerDetails';
const String kVehicleSearchRoute = '/vehicleSearch';
const String kFresherZoneRoute = '/FresherZone';

const String kFreshersGuidebookRoute = '/fresherGuidebook';
const String kFreshersCategoryRoute = '/fresherCategory';
const String kBwsDashDetailRoute = '/bwsDashDetail';
const String kBwsBillDetailRoute = '/bwsBillDetail';
const String kFmsChartDetailRoute = '/fmsChartDetail';
const String kENoteSheetDashRoute = '/eNoteSheetDash';
const String kEmpGroupDetailsRoute = '/empGroupDetails';
const String kBISHelpdeskDashRoute = '/bisHelpdeskDash';
const String kEmpNotHavingAppRoute = '/empNotHavingApp';
const String kProfileSettingsRoute = '/profileSettings';
const String kEmpGroupSendMsgRoute = '/empGroupSendMsg';
const String kEmpGroupChatRoomRoute = '/empGroupChatRoom';
const String kEmpGroupChatInfoRoute = '/empGroupChatInfo';
const String kBISHelpdeskCallsRoute = '/bisHelpdeskCalls';
const String kBISHelpdeskDashTabRoute = '/bisHelpdeskDashTab';

const String kEmployeesBirthdayRoute = '/employeesBirthday';
const String kNewJoinedEmployeesRoute = '/newJoinedEmployees';
const String kEmployeesAnnuationRoute = '/employeesAnnuation';
const String kCreateEmpGroupChatRoute = '/createEmpChatGroup';
const String kBISHelpdeskDetailsRoute = '/bisHelpdeskDetails';
const String kBISHelpdeskAddCallRoute = '/bisHelpdeskAddCall';
const String kEmpNotHavingAppFilterRoute = '/empNotHavingAppFilter';
const String kEmpNotHavingAppRouteCount = '/empNotHavingAppFilterCount';
const String kENoteSheetFullDetailsRoute = '/eNoteSheetFullDetails';
const String kBISHelpdeskCallDetailsRoute = '/bisHelpdeskCallDetails';
const String kENoteSheetChartDetailsRoute = '/eNoteSheetChartDetails';
const String kUpdateEmpGroupIconNameRoute = '/updateEmpGroupIconName';
const String kCreateEmpGroupSelectEmpRoute = '/createEmpGroupSelectEmp';
const String kCreateEmpGroupEnterNameRoute = '/createEmpGroupEnterName';
const String kUpdateEmpGroupChatIconNameRoute = '/updateEmpGroupChatIconName';
const String kCreateEmpGroupChatEnterNameRoute = '/createEmpChatGroupEnterName';
const String kBISHelpdeskCallStatusDetailsRoute =
    '/bisHelpdeskCallStatusDetails';

const String kNotifyScreenRoute = '/notificationScreen';

const String kCalculatorRoute = '/calculator';
const String kCalculatorGasARoute = '/calculatorGasA';
const String kCalculatorGasBRoute = '/calculatorGasB';
const String kCalculatorCrudeOilRoute = '/calculatorCrudeOil';
const String kCalculatorCoalFRoute = '/calculatorCoalF';
const String kCalculatorNapthaRoute = '/Naptha';
const String kCalculatorNaturalGasARoute = '/calculatorNaturalGasA';
const String kCalculatorNaturalGasBRoute = '/calculatorNaturalGasB';
const String kCalculatorOilRoute = '/calculatorOil';
const String kCalculatorLNGRoute = '/calculatorLNG';
const String kDispensaryAddRoute = "/dispensaryAdd";
const String kDispensaryHistoryRoute = "/dispensaryHistory";
const String kDispensaryPendingRoute = "/despensaryPending";
const String kDispensaryHistoryDetailsRoute = "/dispensaryHistoryDetails";
const String kSearchRoute = "/searchScreen";

const String kDispensaryDashRoute = "/dispensaryDash";
const String kWhtsnewRoute = "/whatsNew";
const String kAppStore = "/appStore";
const String kDependentRoute = '/dependent';
const String kcmdopenhouse = '/cmdopenhouseendent';
const String kConcent = '/concent';
const String kHealthMed = '/health';
const String kHealthScreenMed = '/health_screen';
const String kInOutTime = '/inouttime';
// const String KDispensaryHistoryDetails = "/dispensaryHistory"

List<GetPage> getPageList = [
  GetPage(
      name: kSplashRoute,
      binding: SplashBinding(),
      page: () => const SplashScreen()),
  GetPage(
    name: kLoginRoute,
    binding: LoginBinding(),
    page: () => LoginScreen(),
  ),
  GetPage(
      name: kMainDashRoute,
      binding: DashBindings(),
      page: () => Intro(
          padding: EdgeInsets.zero,
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          maskColor: const Color.fromRGBO(0, 0, 0, .6),
          child: MainDashScreen())),
  GetPage(
      name: kEmployeesRoute,
      binding: EmpListBindings(),
      page: () => const EmpListScreen()),
  // GetPage(
  //     name: kEmployeesDashRoute,
  //     binding: EmpChatBindings(),
  //     page: () => const EmpDashScreen()),
  GetPage(
    name: kEmpGroupDetailsRoute,
    page: () => const EmpGroupDetailsScreen(),
  ),
  GetPage(
      name: kCreateEmpGroupSelectEmpRoute,
      page: () => const CreateEmpGroupSelectEmpScreen()),
  GetPage(
      name: kCreateEmpGroupEnterNameRoute,
      page: () => const CreateEmpGroupEnterNameScreen()),
  GetPage(
      name: kUpdateEmpGroupIconNameRoute,
      page: () => const EmpGroupIconNameUpdateScreen()),
  GetPage(
      name: kEmpGroupSendMsgRoute, page: () => const EmpGroupSendMsgScreen()),
  GetPage(
    name: kFullImageRoute,
    page: () => FullImageScreen(
        title: Get.arguments[kTitle], imageUrl: Get.arguments[kImage]),
  ),
  GetPage(name: kFiltersRoute, page: () => const EmpFiltersScreen()),
  GetPage(name: kEmployeesBirthdayRoute, page: () => EmpBirthdayListScreen()),
  GetPage(
      name: kNewJoinedEmployeesRoute, page: () => EmpNewJoinersListScreen()),
  GetPage(
      name: kEmployeesAnnuationRoute, page: () => EmpSuperAnnuationScreen()),
  GetPage(
      name: kNewsRoute,
      binding: NewsBindings(),
      page: () => const NewsScreen()),
  GetPage(name: kNewsCatRoute, page: () => const NewsCatScreen()),
  GetPage(name: kBannerDetailsRoute, page: () => const BannersDetailsScreen()),
  GetPage(name: kLiveEventRoute, page: () => const LiveEventScreen()),
  GetPage(name: kBrowserRoute, page: () => const BrowserScreen()),
  GetPage(name: kGuestHouseRoute, page: () => const GuestHousesScreen()),
  GetPage(name: kHospitalsRoute, page: () => const HospitalsScreen()),
  GetPage(name: kCityFilterRoute, page: () => const CityFilterScreen()),
  GetPage(
      name: kUsefulLinksRoute,
      page: () => UsefulLinks(
            isSearch: true,
          )),
  GetPage(name: kAppsRoute, page: () => const UsefulApps()),
  GetPage(name: kOfficesRoute, page: () => const OfficesScreen()),
  GetPage(name: kFeedbackRoute, page: () => const FeedbackScreen()),
  GetPage(name: kMyNotesRoute, page: () => const MyNotesScreen()),
  GetPage(name: kOfficeDashRoute, page: () => const OfficesDashScreen()),
  GetPage(name: kVehicleSearchRoute, page: () => const VehicleSearchScreen()),

  GetPage(name: kOtpRoute, page: () => const OtpScreen()),
  GetPage(name: kDashboardRoute, page: () => const DashboardScreen()),
  GetPage(name: kENoteSheetDashRoute, page: () => const ENoteSheetDashScreen()),
  GetPage(
      name: kENoteSheetFullDetailsRoute,
      page: () => const ENoteSheetFullDetailsScreen()),
  GetPage(
      name: kENoteSheetChartDetailsRoute,
      page: () => const ENoteSheetChartDetailsScreen()),
  GetPage(name: kFmsDashRoute, page: () => const FmsDashScreen()),
  GetPage(name: kBwsDashRoute, page: () => const BwsDashScreen()),
  GetPage(name: kFmsDetailRoute, page: () => const FmsDetailsScreen()),
  GetPage(
      name: kFmsChartDetailRoute, page: () => const FmsChartDetailsScreen()),
  GetPage(name: kBwsDashDetailRoute, page: () => const BwsDashDetailsScreen()),
  GetPage(name: kBwsBillDetailRoute, page: () => const BwsBillDetailsScreen()),
  GetPage(
      name: kBISHelpdeskDashRoute, page: () => const BISHelpdeskDashScreen()),
  GetPage(
      name: kBISHelpdeskDetailsRoute,
      page: () => const BISHelpdeskDetailsScreen()),
  GetPage(
      name: kBISHelpdeskCallDetailsRoute,
      page: () => const BISHelpdeskCallDetailsScreen()),
  GetPage(
      name: kProfileSettingsRoute, page: () => const ProfileSettingsScreen()),
  GetPage(
      name: kBISHelpdeskCallsRoute, page: () => const BISHelpdeskCallsScreen()),
  GetPage(
      name: kBISHelpdeskDashTabRoute,
      page: () => const BISHelpDeskDashTabScreen()),
  GetPage(
      name: kBISHelpdeskCallStatusDetailsRoute,
      page: () => const BISHelpdeskCallStatusDetailsScreen()),
  GetPage(
      name: kBISHelpdeskAddCallRoute,
      page: () => const BISHelpdeskAddCallScreen()),
  GetPage(name: kAdminDashRoute, page: () => const AdminDashScreen()),
  GetPage(name: kUtilizationRoute, page: () => const UtilizationScreen()),
  GetPage(
      name: kEmpNotHavingAppRoute, page: () => const EmpNotHavingAppScreen()),
  //count admion dashborad screen
  GetPage(
      name: kEmpNotHavingAppRouteCount,
      page: () => EmpNotHavingAppInstallCount()),
  GetPage(
      name: kEmpNotHavingAppFilterRoute,
      page: () => const EmpNotHavingAppFiltersScreen()),
  // GetPage(name: kSelectEmpRoute, page: () => const SelectEmpScreen()),
  // GetPage(name: kEmpChatRoomRoute, page: () => const EmpChatRoomScreen()),
  // GetPage(
  //     name: kEmpGroupChatRoomRoute, page: () => const EmpGroupChatRoomScreen()),
  // GetPage(
  //     name: kCreateEmpGroupChatRoute,
  //     page: () => const CreateEmpGroupChatScreen()),
  // GetPage(
  //     name: kCreateEmpGroupChatEnterNameRoute,
  //     page: () => const CreateEmpGroupChatEnterNameScreen()),
  // GetPage(
  //     name: kEmpGroupChatInfoRoute, page: () => const EmpGroupChatInfoScreen()),
  // GetPage(
  //     name: kUpdateEmpGroupChatIconNameRoute,
  //     page: () => const UpdateEmpGroupChatInfoScreen()),
  GetPage(name: kEmployeeInfoRoute, page: () => const EmpInfoScreen()),
  GetPage(name: kCalculatorRoute, page: () => const Calculator()),
  GetPage(name: kCalculatorGasARoute, page: () => const CalculatorGasA()),
  GetPage(name: kCalculatorGasBRoute, page: () => const CalculatorGasB()),
  GetPage(name: kCalculatorCrudeOilRoute, page: () => const CalculatorCrude()),
  GetPage(name: kCalculatorCoalFRoute, page: () => const CalculatorCoal()),
  GetPage(name: kCalculatorNapthaRoute, page: () => const CalculatorNaptha()),
  GetPage(
      name: kCalculatorNaturalGasARoute, page: () => const CalculatorNGasA()),
  GetPage(
      name: kCalculatorNaturalGasBRoute, page: () => const CalculatorNGasB()),
  GetPage(name: kCalculatorOilRoute, page: () => const CalculatorOil()),
  GetPage(name: kCalculatorLNGRoute, page: () => const CalculatorLNG()),
  GetPage(name: kDispensaryAddRoute, page: () => Dispensary()),
  GetPage(name: kDispensaryHistoryRoute, page: () => const DispensaryHistory()),
  GetPage(name: kDispensaryPendingRoute, page: () => const DispensaryPending()),
  GetPage(
      name: kDispensaryHistoryDetailsRoute,
      page: () => DispensaryDetailsHistory(
            reqNo: Get.arguments[1],
          )),
  GetPage(
      name: kDispensaryDashRoute,
      page: () => DispensaryDashScreen(
            isSearch: true,
          )),

  GetPage(
      name: kWhtsnewRoute,
      binding: WhatsNewBinding(),
      page: () => const WhatsNewScreen()),
  GetPage(
      name: kNotifyScreenRoute,
      binding: NotificationBinding(),
      page: () => const NotificationDetailsScreen(
            image: "",
            title: "",
            content: "",
          )),
  GetPage(
      name: kFresherZoneRoute,
      binding: FresherZoneBinding(),
      page: () => const FresherZoneScreen()),
  GetPage(
      name: kFreshersGuidebookRoute,
      binding: FresherZoneBinding(),
      page: () => FresherGuideBookScreen(
            type: Get.arguments[1],
            title: Get.arguments[2],
          )),

  GetPage(
      name: kFreshersCategoryRoute,
      binding: FresherCategoryBinding(),
      page: () => const FresherCategoryScreen()),

  GetPage(
      name: kAppStore,
      binding: AppStoreBinding(),
      page: () => AppStoreScreen()),
  GetPage(
      name: kDependentRoute,
      binding: DependentListBinding(),
      page: () => DependentListScreen()),

  GetPage(
      name: kcmdopenhouse,
      binding: CMDOpenHouseBinding(),
      page: () => CMDOpenHouseScreen()),

  GetPage(
      name: kConcent,
      binding: ConcentFormBinding(),
      page: () => ConcentFormScreen()),

  GetPage(
      name: kHealthMed, binding: HealthBinding(), page: () => HealthScreen()),

  GetPage(
      name: kHealthScreenMed,
      binding: HealthBinding(),
      page: () => HealthCoominSoonScreen()),

  GetPage(
      name: kInOutTime,
      binding: InoutBinding(),
      page: () => EmpAttendanceScreen()),
  // GetPage(name: kWhtsnewRoute, page: () => WhatsNewScreen()),
  // GetPage(
  //     name: kSearchRoute,
  //     binding: SearchBindings(),
  //     page: () => SearchScreen()),
];
