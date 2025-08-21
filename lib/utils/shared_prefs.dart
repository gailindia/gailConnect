// // Created By Amit Jangid 13/07/21
//
// import 'package:get/instance_manager.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:gail_connect/utils/constants/app_constants.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
//
//
// class SharedPrefs {
//   static SharedPrefs get to => Get.find<SharedPrefs>();
//
//   final _email = ''.val('email');
//   final _baName = ''.val('baName');
//   final _fcmToken = ''.val('fcmToken');
//   final _userName = ''.val('username');
//   final _password = ''.val('password');
//   final _cpfNumber = ''.val('cpfNumber');
//   final _iosVersion = ''.val('iosVersion');
//   final _apkVersion = ''.val('apkVersion');
//   final _userAccess = ''.val('userAccess');
//   final _gstInNumber = ''.val('gstInNumber');
//   final _gstLocation = ''.val('gstLocation');
//   final _isLoggedIn = false.val('isLoggedIn');
//   final _businessArea = ''.val('businessArea');
//   final _lastSyncDate = ''.val('lastSyncDate');
//   final _isFcmTokenSent = false.val('isTokenSent');
//   final _isTokenFromApi = ''.val('isFcmToken');
//   final _currentChatRoomId = ''.val('currentChatRoomId');
//   final _isDashboardAdmin = false.val('isDashboardAdmin');
//   final _reqNumber = ''.val('reqNumber');
//   final _isSwitched = false.val('isSwitch');
//
//   final _isGroupAdmin = false.val('isGroupAdmin');
//   final _isBISHelpdeskAdmin = ''.val('isBISHelpdeskAdmin');
//   final _notificationTokenId = ''.val('notificationTokenId');
//
//   final _authToken = ''.val('token');
//
//
//   final _contactListBy = kMyLocationAndDepartment.val('contactListBy');
//   final _sortContactListBy = kAlphabetWiseSorting.val('sortContactListBy');
//   final _isEmployeeDataSyncedAfterAlter =
//       false.val('isEmployeeDataSyncedAfterAlter');
//   final allSearches = [].val('recentSearches');
//   final _isLight = false.val('isLight');
//
//
//   final _isTargetSteps = ''.val('isTargetSteps');
//
//
//   final _isPhoneConsent = ''.val("isPhoneConsent");
//   final _isEmailConsent = ''.val("isEmailConsent");
//   final _isDobConsent = ''.val("isDobConsent");
//   final _isSuperannuationConsent = ''.val("isSuperannuationConsent");
//
//   String get email => _email.val;
//
//   String get baName => _baName.val;
//
//   String get fcmToken => _fcmToken.val;
//
//   String get userName => _userName.val;
//
//   String get password => _password.val;
//
//   bool get isLoggedIn => _isLoggedIn.val;
//
//   String get cpfNumber => _cpfNumber.val;
//
//   String get reqNumber => _reqNumber.val;
//
//   bool get isSwitch => _isSwitched.val;
//
//   String get apkVersion => _apkVersion.val;
//
//   String get iosVersion => _iosVersion.val;
//
//   String get userAccess => _userAccess.val;
//
//   String get gstInNumber => _gstInNumber.val;
//
//   String get gstLocation => _gstLocation.val;
//
//   String get businessArea => _businessArea.val;
//
//   String get lastSyncDate => _lastSyncDate.val;
//
//   bool get isFcmTokenSent => _isFcmTokenSent.val;
//
//   String get contactListBy => _contactListBy.val;
//
//   bool get isDashboardAdmin => _isDashboardAdmin.val;
//
//   bool get isGroupAdmin => _isGroupAdmin.val;
//
//   bool get isLight => _isLight.val;
//
//   String get currentChatRoomId => _currentChatRoomId.val;
//
//   String get sortContactListBy => _sortContactListBy.val;
//
//   String get isBISHelpdeskAdmin => _isBISHelpdeskAdmin.val;
//
//   String get notificationTokenId => _notificationTokenId.val;
//
//   String get isTokenFromApi => _isTokenFromApi.val;
//
//   String get isTagetSteps => _isTargetSteps.val;
//
//   bool get isEmployeeDataSyncedAfterAlter =>
//       _isEmployeeDataSyncedAfterAlter.val;
//
//   String get authToken => _authToken.val;
//
//   String get isPhoneConsent => _isPhoneConsent.val ;
//   String get isEmailConsent => _isEmailConsent.val ;
//   String get isDobConsent => _isDobConsent.val ;
//   String get isSuperannuationConsent => _isSuperannuationConsent.val ;
//
//
//   set isPhoneConsent(value) => _isPhoneConsent.val = value;
//   set isEmailConsent(value) => _isEmailConsent.val = value;
//   set isDobConsent(value) => _isDobConsent.val = value;
//   set isSuperannuationConsent(value) => _isSuperannuationConsent.val = value;
//
//   set authToken(value) => _authToken.val = value;
//
//   set email(value) => _email.val = value;
//
//   set isLight(value) => _isLight.val = value;
//
//   set baName(value) => _baName.val = value;
//
//   set fcmToken(value) => _fcmToken.val = value;
//
//   set userName(value) => _userName.val = value;
//
//   set password(value) => _password.val = value;
//
//   set cpfNumber(value) => _cpfNumber.val = value;
//
//   set reqNumber(value) => _reqNumber.val = value;
//
//   set isSwitch(value) => _isSwitched.val = value;
//
//   set apkVersion(value) => _apkVersion.val = value;
//
//   set iosVersion(value) => _iosVersion.val = value;
//
//   set userAccess(value) => _userAccess.val = value;
//
//   set isLoggedIn(value) => _isLoggedIn.val = value;
//
//   set gstInNumber(value) => _gstInNumber.val = value;
//
//   set gstLocation(value) => _gstLocation.val = value;
//
//   set businessArea(value) => _businessArea.val = value;
//
//   set lastSyncDate(value) => _lastSyncDate.val = value;
//
//   set contactListBy(value) => _contactListBy.val = value;
//
//   set isFcmTokenSent(value) => _isFcmTokenSent.val = value;
//
//   set isDashboardAdmin(value) => _isDashboardAdmin.val = value;
//
//   set isGroupAdmin(value) => _isGroupAdmin.val = value;
//
//   set currentChatRoomId(value) => _currentChatRoomId.val = value;
//
//   set sortContactListBy(value) => _sortContactListBy.val = value;
//
//   set isBISHelpdeskAdmin(value) => _isBISHelpdeskAdmin.val = value;
//
//   set notificationTokenId(value) => _notificationTokenId.val = value;
//
//   set isEmployeeDataSyncedAfterAlter(value) =>
//       _isEmployeeDataSyncedAfterAlter.val = value;
//
//   set isTokenFromApi(value) => _isTokenFromApi.val = value;
//   set isTargetSteps(value) => _isTargetSteps.val = value;
// }
