// Created By Amit Jangid 24/08/21

const String kBaseUrl1 =
    'https://gailebank.gail.co.in/webservices/GAIL_EMP/api/employees/';
const String kPlayStoreUrl =
    'https://play.google.com/store/apps/details?id=com.gail.gailconnect';
const String kHelpDeskBaseUrl =
    'https://gailebank.gail.co.in/webservices/Helpdesk/api/Helpdesk/';
const String kDispensaryHistoryUrl =
    'https://gailebank.gail.co.in/common_api/api/GARMINDailies/EMP_Request_DETAILS?cpfNo=';
// 'https://gailebank.gail.co.in/common_api/api/GARMINDailies/EMP_Request_DETAILS?cpfNo=';
const String kMedicalStoreUrl =
    'https://gailebank.gail.co.in/common_api/api/GARMINDailies/MED_STORE_DETAILS';
const String kMedicalPharmacyUrl =
    'https://gailebank.gail.co.in/common_api/api/GARMINDailies/MED_PHARMACY';
const String kMedicalDeliveryUrl =
    'https://gailebank.gail.co.in/common_api/api/GARMINDailies/MED_DELIVERY_MODE';
const String kAppStoreUrl =
    'https://gailebank.gail.co.in/testiosappp.html?myParam:GAIL%20Connect';
const String kBaseUrl =
    'https://gailebank.gail.co.in/webservices/contactinfo/pipelineinfoservice.svc/';
const String kHealthBaseUrl =
    "https://gailebank.gail.co.in/GAIL_APIs/api/Health/";

const String kSecureBaseUrl =
    "https://gailebank.gail.co.in/GAIL_APIs/api/GARMINDailies/";

const String kGetSideDrawerElements =
    'https://gailebank.gail.co.in/common_api/api/GARMINDailies/get_side_drawer/';

const String kTwitterUrl = 'https://twitter.com/GAILindia';
const String kFacebookUrl = 'https://www.facebook.com/GAILIndia/';
const String kFileUrl = 'https://gailebank.gail.co.in/WebServices/';
const String kImageUrl =
    'https://gailebank.gail.co.in/WebServices/Consolidated/';
const String kMyLibraryUrl =
    'https://gailcorintra.gail.co.in/e-library/My_library.asp?emp_id=';
const String kSendErrorLogsApi =
    'https://gailebank.gail.co.in/webservices/gail_emp/api/ErrorLogs/Logs';

const String kNewsImageURL =
    "https://gailebank.gail.co.in/GAIL_Connect_News_all/UploadedImage/";
const String kNewsImageURLIND =
    "https://gailebank.gail.co.in/GAIL_Connect_News_holiday/UploadedImage/";

const String kOneSignalNotificationApi =
    'https://onesignal.com/api/v1/notifications';
const String kENoteBoxApi =
    'https://gailebank.gail.co.in/webservices/gail_emp/api/enotes/';
const String kNewsPdfApi =
    'https://gailebank.gail.co.in/Gail_Connect_News_Holiday/UploadedPDF/';
const String kNewsPDFURL =
    "https://gailebank.gail.co.in/GAIL_Connect_News_all/UploadedPDF/";
const String kNewsPDFURLIND =
    "https://gailebank.gail.co.in/GAIL_Connect_News_Holiday/UploadedPDF/";
const String kHitCountApi =
    'https://gailebank.gail.co.in/webservices/gail_emp/api/hitcount/CNTP_HIT_SCREEN';
const String kGetBannerApi =
    'https://gailebank.gail.co.in/webservices/gail_emp/api/banner/get_banner';
const String kGetBannerTestApi =
    'https://gailebank.gail.co.in/webservices/gail_emp/api/banner/get_banner_Test';
const String kGetBannerImageApi =
    'https://gailebank.gail.co.in/webservices/gail_emp/api/banner/get_banner_events_activity';
const String kGetBannerNewApiTest =
    'https://gailebank.gail.co.in/common_api_test/api/GARMINDailies/get_banner_Test_2';
const String kGetBannerNewApi =
    'https://gailebank.gail.co.in/common_api_test/api/GARMINDailies/get_banner_Test';
const String kInsertWhatsNew =
    "https://gailebank.gail.co.in/common_api_jai/api/GARMINDailies/whats_new_insert_update";

const String kGetConsentSavedApi =
    "https://gailebank.gail.co.in/GAIL_APIs/api/Universal/Consent_SavedData?cpf_no=";

const String kFeedbackAPI =
    "https://gailebank.gail.co.in/common_api_jai/api/GARMINDailies/gc_feedback_insert_update";
const String kSendPlayerId =
    "https://gailebank.gail.co.in/common_api_jai/api/GARMINDailies/player_id_insert_update";

const String kWhatsNewIsClicked =
    "https://gailebank.gail.co.in/common_api_jai/api/GARMINDailies/Get_whats_new_is_clicked?cpf_no=";

const String kMyNotesSendDataAPI =
    "https://gailebank.gail.co.in/common_api_jai/api/GARMINDailies/gailconnect_my_notes";
const String kMyNotesGetDataAPI =
    "https://gailebank.gail.co.in/common_api_jai/api/GARMINDailies/get_my_notes?cpf_no=";
const String kGetActiveNewsApi =
    "https://gailebank.gail.co.in/common_api/api/GARMINDailies/get_activenews";
const String kGetGailNewsApi =
    "https://gailebank.gail.co.in/common_api/api/GARMINDailies/get_gail_news";
const String kGetINDNewsApi =
    "https://gailebank.gail.co.in/common_api_jai/api/GARMINDailies/get_gail_industry_news";
const String kFmsInboxApi =
    'https://gailebank.gail.co.in/webservices/prms_mob/api/Login/FMS_SHOW_INBOX';
const String kSendOtpApi =
    'https://gailebank.gail.co.in/webservices/gail_emp/api/employees/send_otp?cpf=';
const String kFmsOutboxApi =
    'https://gailebank.gail.co.in/webservices/prms_mob/api/Login/FMS_SHOW_OUTBOX';
const String kENoteSearchApi =
    'https://gailebank.gail.co.in/webservices/GAIL_EMP/api/enotes/search_files';
const String kBwsDashCountApi =
    'https://gailebank.gail.co.in/webservices/prms_mob/api/bws/Get_depcounts?';
const String kFmsDetailsByIdApi =
    'https://gailebank.gail.co.in/webservices/prms_mob/api/Login/FMS_SHOW_ID';
const String kENoteInboxApi =
    'https://gailebank.gail.co.in/webservices/prms_mob/api/enotes/get_inboxcount/';
const String kCreateNewGroupApi =
    'https://gailebank.gail.co.in/webservices/gail_emp/api/GC_GROUPS/NewGroup';
const String kENoteSentApi =
    'https://gailebank.gail.co.in/webservices/prms_mob/api/enotes/get_sentboxcount/';
const String kGetGroupsApi =
    'https://gailebank.gail.co.in/webservices/gail_emp/api/GC_GROUPS/GetGroups?cpf=';
const String kFcmTokenApi =
    'https://gailebank.gail.co.in/webservices/gail_emp/api/banner/CheckFCM_TOKEN?cpf=';
const String kValidateOtpApi =
    'https://gailebank.gail.co.in/webservices/gail_emp/api/employees/Validate_OTP/';
const String kBwsDashDetailsApi =
    'https://gailebank.gail.co.in/webservices/PRMS_MOB/api/BWS/Get_countdetails';
const String kDeleteGroupApi =
    'https://gailebank.gail.co.in/webservices/gail_emp/api/GC_GROUPS/DeleteGroup?ID=';
const String kFmsChartCountApi =
    'https://gailebank.gail.co.in/webservices/prms_mob/api/Login/GET_FMS_BAR_COUNT';
const String kSubmitFeedbackApi =
    'https://gailebank.gail.co.in/webservices/PRMS_MOB/api/GC_Feedback/SubmitSurvey';
const String kFeedbackApi =
    'https://gailebank.gail.co.in/webservices/PRMS_MOB/api/GC_Feedback/feedbackSurvey?cpf=';

const String kGetFeedbackQuestionsApi =
    "https://gailebank.gail.co.in/common_api_jai/api/GARMINDailies/get_feedback";
const String kgetWishes =
    "https://gailebank.gail.co.in/common_api_jai/api/GARMINDAILIES/Get_wishes?cpf_no=";
const String kGuestHouseApi =
    'https://gailebank.gail.co.in/GailconnectLiveEvents/api/liveevents/GuestHouseDetails';
const String kFmsChartDetailsApi =
    'https://gailebank.gail.co.in/webservices/prms_mob/api/Login/GET_FMS_BAR_DETAILS';
const String kNewsCatApi =
    'https://gailebank.gail.co.in/GailconnectLiveEvents/api/liveevents/getgailnewsbycategory/';
const String kENoteBarCountApi =
    'https://gailebank.gail.co.in/webservices/gail_emp/api/enotes/get_initiateBarCount/';
const String kGetGroupDetailsApi =
    'https://gailebank.gail.co.in/webservices/gail_emp/api/GC_GROUPS/GetGroupByID?ID=';
const String kLiveEventApi =
    'https://gailebank.gail.co.in/GailconnectLiveEvents/api/liveevents/GetLiveEvents?cpf_no=';
const String kUtilizationApi =
    'https://gailebank.gail.co.in/webservices/gail_emp/api/Apputilisation/GetAppUtilisation';
const String kENoteByFileIdApi =
    'https://gailebank.gail.co.in/webservices/GAIL_EMP/api/enotes/GetfileInfoById?fileid=';
// const String kEmpGroupAdminCheckApi =
//     'https://gailebank.gail.co.in/common_api/api/GARMINDailies/checkChatAdmin?cpfNo=';

const String kUpdateGroupIconNameApi =
    'https://gailebank.gail.co.in/webservices/gail_emp/api/GC_GROUPS/UpdateGroupIcon';

const String kAddNewMemberInGroupApi =
    'https://gailebank.gail.co.in/webservices/gail_emp/api/GC_GROUPS/AddMemberTo_Group';

const String kRemoveGroupMemberApi =
    'https://gailebank.gail.co.in/webservices/gail_emp/api/GC_GROUPS/RemoveMemberFrom_Group';

const String kEmpNotHavingAppApi =
    'https://gailebank.gail.co.in/webservices/gail_emp/api/Apputilisation/NON_GCAPP_USERS';

const String kEmpHavingAppApi =
    'https://gailebank.gail.co.in/webservices/gail_emp/api/Apputilisation/GCAPP_USERS';

const String kcountAppByGradeApi =
    'https://gailebank.gail.co.in/webservices/gail_emp/api/Apputilisation/Get_TotalCount';

const String kMostUsedLinksApi =
    'https://gailebank.gail.co.in/common_api_test/api/GARMINDailies/get_MostUsedLinks?empNo='; //17405';

const String kIsDashboardAdminApi =
    'https://gailebank.gail.co.in/webservices/gail_emp/api/Apputilisation/IsDashboardadmin?cpf=';

const String kENoteBarCountDetailsApi =
    'https://gailebank.gail.co.in/webservices/gail_emp/api/enotes/get_initiateCountdetails?cpf=';

const String kGetBannerDetailsApi =
    'https://gailebank.gail.co.in/webservices/gail_emp/api/banner/get_subbanner?SerialNo=';
const String kGetWhatsNewApi =
    'https://gailebank.gail.co.in/common_api_jai/api/GARMINDailies/Get_whats_new';
const String kGetNotificationApi =
    'https://gailebank.gail.co.in/common_api_jai/api/GARMINDailies/get_notification_details';

const String kGetFresherZoneApi =
    'https://gailebank.gail.co.in/common_api_jai/api/GARMINDailies/Get_Fresher_zone?type=';

const String kBwsBillDetailsApi =
    'https://gailebank.gail.co.in/webservices/PRMS_MOB/api/bws/getdetails_byrec_no?receipt_no=';

const String kGetReportingEmployeeApi =
    'https://gailebank.gail.co.in/webservices/prms_mob/api/login/get_reporting_employees?cpf=';

const String kHospitalApi =
    'https://gailebank.gail.co.in/WebServices/MYGAIL/Service1.svc/Get_MOBILE_GAIL_HOSPITAL_MASTER';

const String kSugamUrl = 'https://sugam.gail.co.in/';
const String kGailWebsiteUrl = 'https://gailonline.com/';
const String kGailTendersUrl = 'https://gailtenders.in/Gailtenders/Home.asp';
const String kGailIntranetUrl = 'https://mygail.gail.co.in/';
const String kGailWfhUrl = 'https://gailebank.gail.co.in/gailattendance.html';
const String kHindiShabdavaliUrl =
    'https://gailebank.gail.co.in/webservices/words_for_Standardization.pdf';
const String kMMTCodeUrl =
    'https://gailebank.gail.co.in/webservices/LIST_OF_SAP_IMPORTANT_T_CODES.pdf';
const String kGailPrashashanikShabadKoshUrl =
    'https://gailebank.gail.co.in/webservices/GAIL_Admin_Terminology.pdf';

const String kGailATCalenderURL =
    'https://gailebank.gail.co.in/GTI%20Calendar%20Final_Gail_Book.pdf';

const String kHolidayListApi =
    'https://gailebank.gail.co.in/GailconnectLiveEvents/api/liveevents/GetHolidayListPdf?cpf=';

const String kEmpIsAdminApi =
    'https://gailebank.gail.co.in/common_api/api/GARMINDailies/checkChatAdmin?cpfNo=';

const String kGetAreaApi =
    'https://gailebank.gail.co.in/webservices/helpdesk_admin/api/dashboard/getarea';

const String kGetTypeByAreaApi =
    'https://gailebank.gail.co.in/webservices/helpdesk_admin/api/dashboard/gettype_byarea';

const String kGetEngineersByAreaApi =
    'https://gailebank.gail.co.in/webservices/helpdesk_admin/api/DetailReports/Get_EngineersByArea';

const String kGetDependantsApi =
    'https://gailebank.gail.co.in/common_api/api/GARMINDailies/EMP_DEPEND_DETAILS?cpfNo=';

const String kAddressDetailsApi =
    "https://gailebank.gail.co.in/common_api/api/GARMINDailies/pharmacyApolloAddressList?cpfNo=";

const String kGetDispensaryHistoryApi =
// 'https://gailebank.gail.co.in/common_api/api/GARMINDailies/EMP_Request_DETAILS?cpfNo=';
    'https://gailebank.gail.co.in/common_api/api/GARMINDailies/EMP_Request_DETAILS?cpfNo=';

const String kGetDispensaryRequestDetailsApi =
    'https://gailebank.gail.co.in/common_api/api/GARMINDailies/EMP_Request_no_DETAILS?reqNo=';
const String kGetDispensaryRequesthistoryAppi =
    'https://gailebank.gail.co.in/common_api_test/api/GARMINDailies/pharmacyRequestHistoryApi?reqno=';
const String kGetDispensaryCancelOrderApi =
    "https://online.apollopharmacy.org/UAT/OrderPlace.svc/CANCELORDERS";

const String kGetContactDetailsApi =
    'https://gailebank.gail.co.in/common_api/api/GARMINDailies/MED_CONTACT_DETAILS?cpfNo=';

const String kBISGetReportCountApi =
    'https://gailebank.gail.co.in/webservices/helpdesk_admin/api/DetailReports/Get_ReportCounts';

const String kBISGetReportCountDetailsApi =
    'https://gailebank.gail.co.in/webservices/helpdesk_admin/api/DetailReports/Get_ReportCountsDetails';

const String kBISGetReportCallDetailsApi =
    'https://gailebank.gail.co.in/webservices/helpdesk_admin/api/dashboard/calldetails?callID=';

const String kPharmacyRequestCancel =
    "https://gailebank.gail.co.in/common_api/api/GARMINDailies/pharmacyRequestCancel?orderNo=";

const String kAttendanceRequest =
    "https://gailebank.gail.co.in/common_api_jai/api/GARMINDailies/Get_Attendance?cpf_no=";
const String kwisheslist =
    "https://gailebank.gail.co.in/common_api_jai/api/GARMINDAILIES/Get_wishes?cpf_no=";

const String ksendWishesPost =
    'https://gailebank.gail.co.in/common_api_jai/api/GARMINDAILIES/gail_connect_wishes';

const String kSuperAnnuation =
    "https://gailebank.gail.co.in/common_api_jai/api/Employees/SuperAnnuation";

const String kAcknowledgeUrl =
    "https://gailebank.gail.co.in/common_api_jai/api/GARMINDAILIES/cashlessMedicineAcknowledgement?cpfNo=";

const String kAppStoreData =
    "https://gailebank.gail.co.in/common_api_jai/api/Universal/Get_App_Data";

const String kDashboardListAccessData =
    "https://gailebank.gail.co.in/common_api_jai/api/Universal/Get_Dashboard_Access";
const String kIDViewListAPI =
    'https://gailebank.gail.co.in/common_api_jai/api/Universal/Get_IDCards?cpf_no=';

const String kCMDOpenHouseApi =
    "https://gailebank.gail.co.in/common_api_jai/api/Universal/CMDHOUSE";
const String kConcentFormApi =
    "https://gailebank.gail.co.in/common_api_jai/api/Universal/GC_Consent";
const String kGetConsentDataApi =
    "https://gailebank.gail.co.in/common_api_jai/api/Universal/Get_ConsentData";

const String kIsValidUserApi = 'IsValidUserData';
const String kGetTelInfoUsingOracleApi = 'GetTelInfoUsingOracle';

const String kGetUrl =
    "https://gailebank.gail.co.in/common_api_jai/api/Universal/GetUrl";

//secure URL
const String BaseURLS = "https://gailebank.gail.co.in/GAIL_APIs/api/";
const String kBannerS = "GARMINDailies/get_banner_Test";
const String kSuperannuationS = "Employees/SuperAnnuation";
const String kNotificationDetails = "GARMINDailies/Get_notification_details";
const String kWhatsNewS = "GARMINDailies/Get_whats_new";
const String kGetFresherZoneSearchS = "GARMINDailies/Get_Fresher_zone_search";
const String kGetFresherZoneType = "GARMINDailies/Get_Fresher_zone?type=";
const String kGetSubbaner = "GailConnect/get_subbanner?SerialNo=";
const String kEnotesS = "";
const String kGetFileInfoByIDS = "GailConnect/GetfileInfoById?fileid=";
const String kGetWhatsNewIsClickedS =
    "GARMINDailies/Get_whats_new_is_clicked?cpf_no=";
const String ksearchFilesS = "GailConnect/search_files";
const String kEnotesGetInboxCountS = "GailConnect/get_inboxcount/";
const String kWhstanewInsertUpdateS = "GARMINDailies/whats_new_insert_update";
const String kfeedbackinsertupdateS = "GARMINDailies/gc_feedback_insert_update";
const String kPlayerIDInsertUpdateS = "GARMINDailies/player_id_insert_update";
const String kGailCOnnectmyNotesS = "GARMINDailies/GailConnect_my_notes";
const String kGetMyNotes = "GARMINDailies/Get_my_notes?cpf_no=";
const String KMedContactDetailS = "GARMINDailies/medContactDetails?cpfNo=";
const String kEMPDependDetailsS = "GARMINDailies/empDependDetails?cpfNo=";
const String kPharmacyApolloS =
    "GARMINDailies/pharmacyApolloAddressList?cpfNo=";
const String kMedDeliveryModeS = "GARMINDailies/medDeliveryMode";
const String kMedPharmacy = "GARMINDailies/MED_PHARMACY";
const String kGetAreaS = "GailConnect/getarea";
const String kTypeByArea = "GailConnect/gettype_byarea";
const String kGetEngeersByArea = "GailConnect/Get_EngineersByArea";
const String kGetReportCount = "ailConnect/Get_ReportCounts";
const String kGetReportCountDetails = "GailConnect/Get_ReportCountsDetails";
const String kCallDetailS = "GailConnect/calldetails?callID=";
const String kExceptionLogS = "GARMINDailies/Exception_Log";
const String kRequestnoDetails = "GARMINDailies/empRequestNoDetails?reqNo=";
const String kPharmacyRequestHistory =
    "GARMINDailies/pharmacyRequestHistoryApi?reqno=";
const String kpharmacyRequestAckStatus =
    "GARMINDailies/pharmacyRequestAckStatus?orderNo=";
const String kPharmacyRequestCancelS =
    "GARMINDailies/pharmacyRequestCancel?orderNo=";
const String kEMPrequestDetails = "GARMINDailies/Emp_request_details?cpfNo=";
const String kHelpdeskgetCall = "Helpdesk/getCall/";
const String kHelpdestgetCallByID = "";
const String kGetAppUtilization = "GailConnect/GetAppUtilisation";
const String kNonGCPAUser = "GailConnect/NON_GCAPP_USERS";
const String kGCAppUser = "GailConnect/GCAPP_USERS";
const String kGetgroupByID = "GailConnect/GetGroupByID?ID=";
const String kGetGailNewsByCategory =
    "GailConnect/GetGailNewsByCategory?category=";
const String kRemoveMemberFromGroup = "GailConnect/RemoveMemberFrom_Group";
const String kSubmitSurveyS = "GailConnect/SubmitSurvey";
const String kAddmembertoGroup = "GailConnect/AddMemberTo_Group";
const String kDeleteGroupID = "GailConnect/DeleteGroup?ID=";
const String kGailConnectWishes = "GARMINDailies/gail_connect_wishes";
const String kcashlessMedicineAcknowledgement =
    "GARMINDailies/cashlessMedicineAcknowledgement?cpfNo=";
const String kGetAppData = "Universal/Get_App_Data";
const String kGetTellInfoUsingOracle = "GailConnect/GetTelInfoUsingOracle";
const String kGetDashboardAccess = "Universal/Get_Dashboard_Access";
const String kIDViewListS = "Universal/Get_IDCards?cpf_no=";
const String KCMDHousePostS = "Universal/CMDHOUSE";
const String kGCConsentPostS = "Universal/GC_Consent";
const String kGetConsentData = "Universal/Get_ConsentData";
const String kGetTotalCount = "";
const String kHelpDeskAddCall = 'Helpdesk/RequestCAll';
const String kHelpDeskGetCallById = 'GailConnect/getCallById/';
const String kGetSideDrawer = "GARMINDailies/Get_Side_Drawer";
const String kCNTPHitScreen = "GailConnect/CNTP_HIT_SCREEN?";
const String kGetUrlS = "Universal/GetUrl";
const String kGetWishes = "GARMINDailies/Get_wishes?cpf_no=";
const String kGetAttendance = "GARMINDailies/Get_Attendance?cpf_no=";
const String kGetAttendanceAverage = "GARMINDailies/Get_average?cpf_no=";
const String kgetDetailsByrecno = "GailConnect/getdetails_byrec_no?receipt_no=";
const String kGetCountDetails = "GailConnect/Get_countdetails";
const String kGetdepcounts = "GailConnect/Get_depcounts";
const String kGetFMSbarDetailsS = "GailConnect/GET_FMS_BAR_DETAILS";
const String FMSBarCount = "GailConnect/GET_FMS_BAR_COUNT";
const String kFMSgetReportingEmp = "GailConnect/GET_REPORTING_EMPLOYEES";
const String kFMSShowID = "GailConnect/FMS_SHOW_ID";
const String kValidateOTP = "GailConnect/Validate_OTP/";
const String kSendOTPS = "GailConnect/send_otp?cpf=";
const String kgetTellSubLocation = "GailConnect/GetTEL_SUBLOCATION_DETAIL";
const String KGetTelInfoUsingOracle = "GailConnect/GetTelInfoUsingOracle";
const String KGetSectionList = "Universal/SectionMaster";
const String KGetGailCodeUsingOracle = "ContactInfo/GetGailCodesUsingOracle";
const String KSubmitSurvey = "GailConnect/SubmitSurvey";
const String kGetFeedbackSurvey = "GailConnect/feedbackSurvey?cpf=";
const String kGetFeedback = "GARMINDailies/Get_feedback";
const String kcheckChatAdmin = "GARMINDailies/checkChatAdmin?cpf=";
const String KGetHolidayListPDFS = "liveevents/GetHolidayListPdf?cpf=";
const String kGetMobileGailHospitalMaster =
    "ContactInfo/Get_MOBILE_GAIL_HOSPITAL_MASTER";
const String kGuestHouseDetails = "GailConnect/GuestHouseDetails";
const String kGetLiveEvents = "liveevents/GetLiveEvents?cpf_no=";
const String kgetMostUsedLinks = "GARMINDailies/get_MostUsedLinks?empNo=";
const String kGetGailIndustryNews = "GARMINDailies/get_gail_industry_news";
const String kGetGailnews = "GARMINDailies/get_gail_news";
const String KCheckFCMToken = "GailConnect/CheckFCM_TOKEN?cpf=";
const String kNewGroupS = "GailConnect/NewGroup";
const String KUpdateGroupIconS = "GailConnect/UpdateGroupIcon";

const String kJsonData = 'data';
const String kDependentdata = "lstInfo";
const String kJsonEnggInfo = '_engg_info';
const String kJsonStateList = 'lst_State_all';
const String kJsonHospitalList = 'lst_Hospital_list';
const String kJsonQuestionOptions = 'questionOptions';
const String kJsonFileMovementDetails = '_FileMovementDetails';
const String kJsonUninstalledGailConnectAppUsers =
    'Uninstalled_GAILCONNECT_APP_USERS';
const String kJsoninstalledGailConnectAppUsers =
    'Installed_GAILCONNECT_APP_USERS';

const String kJsonUserId = 'userid';
const String kJsonPassword = 'password';
const String kJsonDeviceModel = 'DEVICE_MODEL';
const String kJsonDeviceToken = 'Device_Token';
const String kJsonDeviceProperties = 'Device_properties';
const String kJsonFcmToken = 'Fcm_Token';

const String kJsonResponse = 'Response';
const String kJsonCpfNumber = 'Cpf_Number';
const String kJsonUserAccess = 'User_Acess';
const String kJsonApkVersionNo = 'APK_Version_No';
const String kJsonNotification = 'Notification';
const String kJsonBusinessArea = 'Business_Area';
const String kJsonEmail = 'Email';
const String kJsonGstIn = 'Gstin';
const String kJsonIpaVersion = 'Ipa_version';
const String kJsonBaName = 'Ba_Name';
const String kJsonGstLocation = 'Gstn_Location';
const String kJsonToken = 'token';

const String kJsonEmpNoCaps = 'Emp_no';
const String kJsonEmpNoFullCaps = 'EMP_NO';
const String kJsonEmpNameCaps = 'Emp_Name';
const String kJsonDesignation = 'Designation';
const String kJsonDepartment = 'Department';
const String kJsonDirectorate = 'Directorate';
const String kJsonSection = 'Section';
const String kJsonDepartmentFullCaps = 'DEPARTMENT';
const String kJsonLocationCaps = 'Location';
const String kJsonTelNo = 'TelNo';
const String kJsonMobileNo = 'MobileNo';
const String kJsonMobileNo1 = 'MobileNo1';
const String kJsonOfficeTel = 'OfficeTel';
const String kJsonOfficeExt = 'OfficeExt';
const String kJsonHBJExt = 'HBJExt';
const String kJsonLTel = 'LTel';
const String kJsonLGailTel = 'LGailTel';
const String kJsonFaxNo = 'FaxNo';
const String kJsonEmails = 'Emails';
const String kJsonGradeCaps = 'Grade';
const String kJsonGradeFullCaps = 'GRADE';
const String kJsonDateOfBirth = 'DateOfBirth';
const String kJsonImage = 'IMAGE';
const String kJsonVehicleNo = 'VEHICLE_NO';

const String kJsonBody = 'Body';
const String kJsonTitle = 'Title';
const String kJsonEventDate = 'EVENT_DATE';

const String kJsonId = 'id';
const String kJsonDescription = 'description';
const String kJsonStartDate = 'startDate';
const String kJsonEndDate = 'endDate';
const String kJsonNavigationLink = 'navigatioN_LINK';
const String kJsonCpfNo = 'cpF_NO';

const String kJsonLocation = 'location';
const String kJsonAddress = 'address';
const String kJsonHvj = 'hvj';
const String kJsonTelephone = 'telephone';
const String kJsonUniQID = 'uniQ_ID';
const String kJsonLatitude = 'latitude';
const String kJsonLongitude = 'longitude';

const String kJsonWTitke = "TITLE";
const String kJsonWContent = "CONTENT";
const String kJsonWImage = "IMAGE";
const String kJsonWPeriodFrom = "PERIOD_FROM";
const String kJsonWPEriodTo = "PERIOD_TO";

const String kJsonIdCaps = 'ID';
const String kJsonHospitalName = 'HOSPITAL_NAME';
const String kJsonHospitalLoc = 'HOSPITAL_LOC';
const String kJsonStartDateCaps = 'START_DATE';
const String kJsonName = 'Name';
const String kJsonEndDateCaps = 'END_DATE';
const String kJsonHospitalAdd = 'HOSPITAL_ADD';
const String kJsonYYOHC = 'YY_OHC';
const String kJsonWerks = 'WERKS';
const String kJsonLatitudeCaps = 'Latitude';
const String kJsonLongitudeCaps = 'Longitude';
const String kJsonDistance = 'Distance';

const String kJsonStateDesc = 'STATE_DESCRIPTION';

const String kJsonMessage = 'message';
const String kJsonPdfLink = 'pdF_LINK';
const String kJsonStatusCode = 'status_code';
const String kJsonRequestId = 'RequestId';

const String kJsonGailNetCode = 'GailnetCode';
const String kJsonAddressCaps = 'Address';
const String kJsonFax = 'Fax';
const String kJsonEPabX = 'EPABX';

const String kJsonCreatedBy = 'CREATED_BY';
const String kJsonCreatedOn = 'CREATED_ON';
const String kJsonHbjNo = 'HBJNO';
const String kJsonLocationFullCaps = 'LOCATION';
const String kJsonModifiedBy = 'MODIFIED_BY';
const String kJsonModifiedOn = 'MODIFIED_ON';
const String kJsonSubLocation = 'SUBLOCATION';
const String kJsonTel1 = 'TEL1';
const String kJsonTel2 = 'TEL2';
const String kJsonTel3 = 'TEL3';
const String kJsonTel4 = 'TEL4';

const String kJsonQuestionId = 'questioN_ID';
const String kJsonQuestionText = 'questioN_TEXT';
const String kJsonQuestionType = 'questioN_TYPE';
const String kJsonSurveyId = 'surveY_ID';
const String kJsonSurveyTitle = 'surveY_TITLE';
const String kJsonValue = 'value';

const String kJsonUserIdCaps = 'USER_ID';
const String kJsonSurveyIdCaps = 'SURVEY_ID';
const String kJsonQuestionIdCaps = 'QUESTION_ID';
const String kJsonAnswerTextCaps = 'ANSWER_TEXT';

const String kJsonFileNo = 'filE_NO';
const String kJsonSubject = 'subject';
const String kJsonStatus = 'status';
const String kJsonReceivedFrom = 'receiveD_FROM';
const String kJsonPresentlyWith = 'presentlY_WITH';
const String kJsonReceivedDate = 'receiveD_DATE';

const String kJsonSender = 'sender';
const String kJsonReceiver = 'receiver';
const String kJsonDaysInTransit = 'dayS_IN_TRANSIT';
const String kJsonPendingWithRecipient = 'pendinG_WITH_RECEIPENT';
const String kJsonActionTakenCode = 'actioN_TAKEN_CODE';
const String kJsonSentFor = 'senT_FOR';
const String kJsonSentDate = 'senT_DATE';
const String kJsonRecDate = 'recV_DATE';

const String kJsonEmpNo = 'emP_NO';
const String kJsonEmpName = 'emP_NAME';

const String kJsonDataA = 'dataA';
const String kJsonDataB = 'dataB';
const String kJsonDataC = 'dataC';
const String kJsonDataD = 'dataD';
const String kJsonDataE = 'dataE';
const String kJsonEmpCpf = 'emP_CPF';
const String kJsonGrade = 'grade';
const String kJsonVendorCode = 'vendoR_CODE';
const String kJsonVendorMobile = 'vendoR_MOBILE';
const String kJsonVendorPhone = 'vendoR_PHONE';

const String kJsonPendingDays = 'pendingDays';

const String kJsonDept = 'dept';
const String kJsonDeptCloseCount = 'deptClosecount';
const String kJsonDeptReturnCount = 'deptReturncount';
const String kJsonDeptPendingCount = 'deptPendingcount';

const String kJsonCpf = 'cpf';
const String kJsonUser = 'user';
const String kJsonDays = 'days';
const String kJsonToDate = 'TODATE';
const String kJsonFromDate = 'FROMDATE';

const String kJsonPlantCode = 'planT_CODE';
const String kJsonPoNumber = 'pO_NUMBER';
const String kJsonReceiptNo = 'receipT_NO';
const String kJsonInvoiceNo = 'invoicE_NO';
const String kJsonInvoiceDate = 'invoicE_DATE';
const String kJsonInvoiceAmount = 'invoicE_AMOUNT';
const String kJsonDateOfEntry = 'datE_OF_ENTRY';
const String kJsonTransDate = 'tranS_DATE';

const String kJsonForwardedBy = 'forwardeD_BY';
const String kJsonForwardedDate = 'forwardeD_DATE';
const String kJsonReason = 'reason';
const String kJsonReceivedBy = 'receiveD_BY';

const String kJsonPhoneNo = 'Phone_No';

const String kJsonSerialNo = 'SERIALNO';
const String kJsonBannerTitle = 'BANNERTITLE';
const String kJsonFromDate_ = 'FROM_DATE';
const String kJsonToDate_ = 'TO_DATE';

const String kJsonImageSerial = 'IMAGESERIAL';

const String kJsonOpenCount = 'opencount';
const String kJsonCloseCount = 'closecount';

const String kJsonFileId = 'FileId';
const String kJsonFileIdCaps = 'FILE_ID';
const String kJsonSubjectCaps = 'Subject';
const String kJsonInitiator = 'Initiator';
const String kJsonInitiatorCaps = 'INITIATOR';
const String kJsonDateOfInitiation = 'DateOfInitiation';
const String kJsonFileStatus = 'FILE_STATUS';
const String kJsonFileNoCaps = 'FILE_NO';
const String kJsonFileSubject = 'FILE_SUBJECT';
const String kJsonSecondCpfNo = 'SECOND_CPF_NO';
const String kJsonFileIdMain = 'FILE_ID_MAIN';
const String kJsonFirstCpfNo = 'FIRST_CPF_NO';
const String kJsonReceivedOn = 'RECEIVEDON';
const String kJsonReceivedFromCaps = 'RECEIVEDFROM';

const String kJsonSentBy = 'SENT_BY';
const String kJsonSentOn = 'SENT_ON';
const String kJsonSentTo = 'SENT_TO';
const String kJsonFileDate = 'FILE_DATE';
const String kJsonSentForCaps = 'SENT_FOR';

const String kJsonText = 'Text';
const String kJsonSlNo = 'SL_NO';
const String kJsonFirstSentOn = 'FIRST_SENT_ON';
const String kJsonFinancialImp = 'FINACIAL_IMP';
const String kJsonFirstCpfName = 'FIRST_CPF_NAME';
const String kJsonSecondCpfName = 'SECOND_CPF_NAME';
const String kJsonInitiatorName = 'INITIATOR_NAME';

const String kJsonArea = 'area';
const String kJsonType = 'type';
const String kJsonTextCaps = 'Text';
const String kJsonValueCaps = 'Value';

const String kJsonCallsLoggedDuringPeriod = 'CallsLoggedDuringPeriod';
const String kJsonPreviousOpenCalls = 'Previousopencalls';
const String kJsonTotalCalls = 'Totalcalls';
const String kJsonCallsClosedDuringPeriod = 'CallsclosedDuringPeriod';
const String kJsonPendingForAssignmentWithHelpdesk =
    'pendingforassignmentWithhelpdesk';
const String kJsonPendingWithAdminForAssignment =
    'PendingWithAdminForAssignment';
const String kJsonPendingWithEng = 'Pendingwitheng';
const String kJsonPendingForCloserWithAdmin = 'PendingforcloserWithAdmin';
const String kJsonPendingForCloserWithUser = 'Pendingforcloserwithuser';
const String kJsonRevertedByUser = 'revertedbyuser';
const String kJsonAverageResolutionTime = 'AverageResolutiontime';

const String kJsonCpfNumberCaps = 'CPF_NUMBER';
const String kJsonUserName = 'USER_NAME';
const String kJsonDesignationCaps = 'DESIGNATION';
const String kJsonUserLocation = 'USER_LOCATION';
const String kJsonAreaCaps = 'AREA';
const String kJsonAreaName = 'AREA_NAME';
const String kJsonTypeCaps = 'TYPE';
const String kJsonTypeName = 'TYPE_NAME';
const String kJsonLogDate = 'LOG_DATE';
const String kJsonDescriptionCaps = 'DESCRIPTION';
const String kJsonStatusCaps = 'STATUS';
const String kJsonIntState = 'INT_STATE';
const String kJsonEngg = 'ENGG';
const String kJsonEngId = 'ENGG_ID';
const String kJsonEngineerName = 'ENGINEERNAME';
const String kJsonCallId = 'CALL_ID';
const String kJsonFileAttachment = 'FILEATTACHMENT';
const String kJsonUserState = 'USERSTATE';
const String kJsonFileCount = 'FILECOUNT';
const String kJsonActionTakenBy = 'ACTIONTAKENBY';
const String kJsonEmpNameFullCaps = 'EMP_NAME';

const String kJsonActionDate = 'action_date';
const String kJsonActionDesc = 'action_desc';
const String kJsonEnggId = 'engg_id';
const String kJsonEnggName = 'ENGG_NAME';

const String kJsonFilePath = 'filePath';
const String kJsonCallIdSmall = 'call_id';
const String kJsonDate = 'date';
const String kJsonDesc = 'desc';
const String kJsonEng = 'eng';
const String kJsonAction = 'action';
const String kJsonFile = 'file';
const String kJsonEmailSmall = 'email';
const String kJsonMobile = 'mobile';
const String kJsonEmpNameSmall = 'emp_name';
const String kJsonPendingForClose = 'pendingForclose';

const String kJsonCounts = 'COUNTS';
const String kJsonAppCode = 'APP_CODE';
const String kJsonActivity = 'ACTIVITY';

const String kJsonGroupName = 'GROUP_NAME';
const String kJsonGroupIcon = 'GROUP_ICON';
const String kJsonCreatedByCpf = 'CreatedByCPF';
const String kJsonCreatedByName = 'CreatedByName';
const String kJsonCreatedByCpfFullCaps = 'CREATEDBYCPF';
const String kJsonCreatedByNameFullCaps = 'CREATEDBYNAME';
const String kJsonCreateDateFullCaps = 'CREATE_DATE';
const String kJsonCreateDate = "create_date";
const String kJsonGroupMembers = "GROUP_Members";

const String kJsonAppId = 'app_id';
const String kJsonHeadings = 'headings';
const String kJsonContents = 'contents';
const String kJsonThreadId = 'thread_id';
const String kJsonSummaryArg = 'summary_arg';
const String kJsonBigPicture = 'big_picture';
const String kJsonChatRoomId = 'chat_room_id';
const String kJsonAndroidGroup = 'android_group';
const String kJsonIosAttachments = 'ios_attachments';
const String kJsonIncludePlayerIds = 'include_player_ids';

const String kSendFrom = 'sent_from';
const String kSendTo = 'sent_to';
const String kSendMessage = 'message';
const String kSendCategory = 'category';

const String kJson = '';

//HealthApp
const String insertHealthData = "Insert_Data";
const String getDetailDataonClick = "GetDetailData_onClick";
const String getWeek_Data = "weekData";
const String getSetTarget = "SetTarget";
const String getDailyDaySchedular = "Daily_Data_Schedular";

const String kOHCView = "Health/OHC_view?EMP_NO=";
const String kOHCPostData = "Health/OHC_insert";
const String kOHCUpdateData = "Health/OHC_update";
const String kHealthInsertData = "Health/Insert_Data";
const String ksetTargetInsertData = "Health/SetTarget";
const String ksetTargetAchievedData = "Health/SetAchievedData";
const String kgetHealthData = "Health/GetData?EMP_NO=";

// const String kAlert = 'Alert';
// const String kAlertMessage = 'Your session has been Expired\n'
//     'Please Re-Login to fetch data.';
// const String kView = 'View';
// const String kUpdate = 'Update';
