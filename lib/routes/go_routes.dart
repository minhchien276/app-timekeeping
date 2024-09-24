import 'package:e_tmsc_app/data/models/blog_model.dart';
import 'package:e_tmsc_app/data/models/employee_model.dart';
import 'package:e_tmsc_app/data/models/notification_model.dart';
import 'package:e_tmsc_app/data/models/room_model.dart';
import 'package:e_tmsc_app/data/models/salary_model.dart';
import 'package:e_tmsc_app/data/models/task_model.dart';
import 'package:e_tmsc_app/data/models/test_model.dart';
import 'package:e_tmsc_app/presentation/screens/application/application_create.dart';
import 'package:e_tmsc_app/presentation/screens/application/application_detail.dart';
import 'package:e_tmsc_app/presentation/screens/application/application_screen.dart';
import 'package:e_tmsc_app/presentation/screens/auth/login_screen.dart';
import 'package:e_tmsc_app/presentation/screens/auth/sign_up.dart';
import 'package:e_tmsc_app/presentation/screens/auth/splash_screen.dart';
import 'package:e_tmsc_app/presentation/screens/calendar/calendar_screen.dart';
import 'package:e_tmsc_app/presentation/screens/calendar/feedback/feedback_submit.dart';
import 'package:e_tmsc_app/presentation/screens/home/home_screen.dart';
import 'package:e_tmsc_app/presentation/screens/home/noti/noti_detail.dart';
import 'package:e_tmsc_app/presentation/screens/home/noti/noti_screen.dart';
import 'package:e_tmsc_app/presentation/screens/home/post/post_detail.dart';
import 'package:e_tmsc_app/presentation/screens/home/post/post_screen.dart';
import 'package:e_tmsc_app/presentation/screens/profile/profile_all_employee.dart';
import 'package:e_tmsc_app/presentation/screens/profile/profile_detail_screen.dart';
import 'package:e_tmsc_app/presentation/screens/profile/profile_rule.dart';
import 'package:e_tmsc_app/presentation/screens/profile/profile_screen.dart';
import 'package:e_tmsc_app/presentation/screens/profile/salary/salary_detail.dart';
import 'package:e_tmsc_app/presentation/screens/profile/salary/salary_screen.dart';
import 'package:e_tmsc_app/presentation/screens/tests/test_admin_exams_screen.dart';
import 'package:e_tmsc_app/presentation/screens/tests/test_client_exams_screen.dart';
import 'package:e_tmsc_app/presentation/screens/tests/test_detail_screen.dart';
import 'package:e_tmsc_app/presentation/screens/tests/test_score.dart';
import 'package:e_tmsc_app/presentation/screens/tests/test_screen.dart';
import 'package:e_tmsc_app/presentation/screens/timekeeping/timekeeping_qr_screen.dart';
import 'package:e_tmsc_app/presentation/screens/timekeeping/timekeeping_screen.dart';
import 'package:e_tmsc_app/presentation/screens/work/work_create_group.dart';
import 'package:e_tmsc_app/presentation/screens/work/work_group_detail.dart';
import 'package:e_tmsc_app/presentation/screens/work/work_screen.dart';
import 'package:e_tmsc_app/presentation/screens/work/work_search.dart';
import 'package:e_tmsc_app/presentation/screens/work/work_task_detail.dart';
import 'package:e_tmsc_app/presentation/widgets/common/common_bottom_tabbar.dart';
import 'package:e_tmsc_app/shared/enums/check_enum.dart';
import 'package:e_tmsc_app/shared/enums/role_enum.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../presentation/screens/home/list_application_pending/list_application_pending.dart';
import '../presentation/screens/home/list_employee_off/list_employee_off.dart';
import '../presentation/screens/home/list_employee_online/list_employee_online.dart';
import '../presentation/screens/home/list_employee_online/list_employee_online_detail.dart';

enum AppRoute {
  //DASHBOARD
  splash,
  login,
  signup,

  //HOME => nav1
  home,
  noti,
  notiDetails,
  post,
  postDetail,
  listEmployeeOnline,
  listEmployeeOff,
  listEmployeeOnlineDetail,
  listApplicationPending,

  //CALENDAR => nav2
  calendar,
  feedbackSubmit,

  //TIMEKEEPING => nav3
  timekeeping,
  timekeepingQr,

  //APPLICATION => nav4
  application,
  applicationCreate,
  applicationDetail,

  //PROFILE => nav5
  profile,
  profileDetail,
  profileEmployee,
  profileRule,
  salary,
  salaryDetail,
  work,
  workCreateGroup,
  workSearch,
  workGroupDetail,
  workCreateTask,
  workTaskDetail,

  //TESTS
  testDetail,
  testClientExams,
  testAdminExams,
  testScore,
  test,
}

extension PathName on AppRoute {
  String get path {
    switch (this) {
      case AppRoute.home:
        return "/";
      case AppRoute.splash:
      case AppRoute.signup:
      case AppRoute.login:
      case AppRoute.calendar:
      case AppRoute.timekeeping:
      case AppRoute.timekeepingQr:
      case AppRoute.application:
      case AppRoute.profile:
      case AppRoute.test:
      case AppRoute.workGroupDetail:
      case AppRoute.workCreateTask:
      case AppRoute.workTaskDetail:
        return "/$name";
      default:
        return name;
    }
  }
}

class AppNavigator {
  AppNavigator._();
  static final _rootNavigator = GlobalKey<NavigatorState>();

  static GlobalKey<NavigatorState> get rootNavigator => _rootNavigator;

  static final _clientHome = GlobalKey<NavigatorState>(debugLabel: 'Home');
  static final _clientCalendar =
      GlobalKey<NavigatorState>(debugLabel: 'Calendar');
  static final _clientTimekeeping =
      GlobalKey<NavigatorState>(debugLabel: 'Timekeeping');
  static final _clientApplication =
      GlobalKey<NavigatorState>(debugLabel: 'Application');
  static final _clientProfile =
      GlobalKey<NavigatorState>(debugLabel: 'Profile');

  static final router = GoRouter(
    initialLocation: AppRoute.splash.path,
    navigatorKey: rootNavigator,
    routes: <RouteBase>[
      GoRoute(
        path: AppRoute.splash.path,
        name: AppRoute.splash.name,
        builder: (context, state) => SplashScreen(key: state.pageKey),
      ),
      GoRoute(
        path: AppRoute.login.path,
        name: AppRoute.login.name,
        builder: (context, state) => LoginScreen(key: state.pageKey),
      ),
      GoRoute(
        path: AppRoute.signup.path,
        name: AppRoute.signup.name,
        builder: (context, state) => SignUp(key: state.pageKey),
      ),
      GoRoute(
        path: AppRoute.timekeepingQr.path,
        name: AppRoute.timekeepingQr.name,
        builder: (context, state) => TimekeepingQrScreen(
          key: state.pageKey,
          checkEnum: state.extra as CheckEnum,
        ),
      ),
      GoRoute(
        path: AppRoute.test.path,
        name: AppRoute.test.name,
        builder: (context, state) => TestScreen(
          key: state.pageKey,
          testSelected: state.extra as TestModel,
        ),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigation) {
          return MainBottomTabbar(navigationShell: navigation);
        },
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            navigatorKey: _clientHome,
            routes: [
              GoRoute(
                path: AppRoute.home.path,
                name: AppRoute.home.name,
                builder: (context, state) => HomeScreen(
                  key: state.pageKey,
                  role: state.extra as RoleEnum,
                ),
                routes: [
                  GoRoute(
                    path: AppRoute.noti.path,
                    name: AppRoute.noti.name,
                    builder: (context, state) => NotiScreen(key: state.pageKey),
                  ),
                  GoRoute(
                    path: AppRoute.notiDetails.path,
                    name: AppRoute.notiDetails.name,
                    builder: (context, state) => NotiDetails(
                      key: state.pageKey,
                      notification: state.extra as NotificationModel,
                    ),
                  ),
                  GoRoute(
                    path: AppRoute.post.path,
                    name: AppRoute.post.name,
                    builder: (context, state) => PostScreen(
                      key: state.pageKey,
                      posts: state.extra as List<BlogModel>,
                    ),
                  ),
                  GoRoute(
                    path: AppRoute.postDetail.path,
                    name: AppRoute.postDetail.name,
                    builder: (context, state) => PostDetailScreen(
                      key: state.pageKey,
                      blog: state.extra as BlogModel,
                    ),
                  ),
                  GoRoute(
                    path: AppRoute.listEmployeeOnline.path,
                    name: AppRoute.listEmployeeOnline.name,
                    builder: (context, state) =>
                        ListEmployeeOnline(key: state.pageKey),
                  ),
                  GoRoute(
                      path: AppRoute.listEmployeeOnlineDetail.path,
                      name: AppRoute.listEmployeeOnlineDetail.name,
                      builder: (context, state) => ListEmployeeOnlineDetail(
                            key: state.pageKey,
                            parms: state.extra as Map<String, dynamic>,
                          )),
                  GoRoute(
                    path: AppRoute.listEmployeeOff.path,
                    name: AppRoute.listEmployeeOff.name,
                    builder: (context, state) =>
                        ListEmployeeOff(key: state.pageKey),
                  ),
                  GoRoute(
                      path: AppRoute.listApplicationPending.path,
                      name: AppRoute.listApplicationPending.name,
                      builder: (context, state) => ListApplicationPending(
                            key: state.pageKey,
                          )),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _clientCalendar,
            routes: <RouteBase>[
              GoRoute(
                path: AppRoute.calendar.path,
                name: AppRoute.calendar.name,
                builder: (context, state) => CalendarScreen(key: state.pageKey),
                routes: [
                  GoRoute(
                    path: AppRoute.feedbackSubmit.path,
                    name: AppRoute.feedbackSubmit.name,
                    builder: (context, state) =>
                        FeedbackSubmitScreen(key: state.pageKey),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _clientTimekeeping,
            routes: <RouteBase>[
              GoRoute(
                path: AppRoute.timekeeping.path,
                name: AppRoute.timekeeping.name,
                builder: (context, state) =>
                    TimekeepingScreen(key: state.pageKey),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _clientApplication,
            routes: <RouteBase>[
              GoRoute(
                path: AppRoute.application.path,
                name: AppRoute.application.name,
                builder: (context, state) =>
                    ApplicationScreen(key: state.pageKey),
                routes: [
                  GoRoute(
                    path: AppRoute.applicationCreate.path,
                    name: AppRoute.applicationCreate.name,
                    builder: (context, state) =>
                        ApplicationCreate(key: state.pageKey),
                  ),
                  GoRoute(
                    path: AppRoute.applicationDetail.path,
                    name: AppRoute.applicationDetail.name,
                    builder: (context, state) => ApplicationDetail(
                      key: state.pageKey,
                      parms: state.extra as Map<String, dynamic>,
                    ),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _clientProfile,
            routes: [
              GoRoute(
                path: AppRoute.profile.path,
                name: AppRoute.profile.name,
                builder: (context, state) => ProfileScreen(key: state.pageKey),
                routes: [
                  GoRoute(
                    path: AppRoute.salary.path,
                    name: AppRoute.salary.name,
                    builder: (context, state) =>
                        SalaryScreen(key: state.pageKey),
                  ),
                  GoRoute(
                    path: AppRoute.salaryDetail.path,
                    name: AppRoute.salaryDetail.name,
                    builder: (context, state) => SalaryDetailScreen(
                      key: state.pageKey,
                      salary: state.extra as SalaryModel,
                    ),
                  ),
                  GoRoute(
                    path: AppRoute.profileDetail.path,
                    name: AppRoute.profileDetail.name,
                    builder: (context, state) => ProfileDetailScreen(
                      key: state.pageKey,
                      employee: state.extra as EmployeeModel,
                    ),
                  ),
                  GoRoute(
                    path: AppRoute.profileRule.path,
                    name: AppRoute.profileRule.name,
                    builder: (context, state) =>
                        ProfileRule(key: state.pageKey),
                  ),
                  GoRoute(
                    path: AppRoute.testDetail.path,
                    name: AppRoute.testDetail.name,
                    builder: (context, state) => TestDetailScreen(
                      key: state.pageKey,
                      testSelected: state.extra as TestModel,
                    ),
                  ),
                  GoRoute(
                    path: AppRoute.testClientExams.path,
                    name: AppRoute.testClientExams.name,
                    builder: (context, state) =>
                        TestClientExamsScreen(key: state.pageKey),
                  ),
                  GoRoute(
                    path: AppRoute.testAdminExams.path,
                    name: AppRoute.testAdminExams.name,
                    builder: (context, state) =>
                        TestAdminExamsScreen(key: state.pageKey),
                  ),
                  GoRoute(
                    path: AppRoute.testScore.path,
                    name: AppRoute.testScore.name,
                    builder: (context, state) => TestScore(
                      key: state.pageKey,
                      testSelected: state.extra as TestModel,
                    ),
                  ),
                  GoRoute(
                    path: AppRoute.profileEmployee.path,
                    name: AppRoute.profileEmployee.name,
                    builder: (context, state) =>
                        ProfileAllEmployee(key: state.pageKey),
                  ),
                  GoRoute(
                    path: AppRoute.work.path,
                    name: AppRoute.work.name,
                    builder: (context, state) => WorkScreen(key: state.pageKey),
                  ),
                  GoRoute(
                    path: AppRoute.workCreateGroup.path,
                    name: AppRoute.workCreateGroup.name,
                    builder: (context, state) =>
                        WorkCreateGroup(key: state.pageKey),
                  ),
                  GoRoute(
                    path: AppRoute.workSearch.path,
                    name: AppRoute.workSearch.name,
                    builder: (context, state) => WorkSearch(key: state.pageKey),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: AppRoute.workGroupDetail.path,
        name: AppRoute.workGroupDetail.name,
        builder: (context, state) => WorkGroupDetailScreen(
          key: state.pageKey,
          room: state.extra as RoomModel,
        ),
      ),
      GoRoute(
        path: AppRoute.workCreateTask.path,
        name: AppRoute.workCreateTask.name,
        builder: (context, state) => WorkCreateTask(
          key: state.pageKey,
          room: state.extra as RoomModel,
        ),
      ),
      GoRoute(
        path: AppRoute.workTaskDetail.path,
        name: AppRoute.workTaskDetail.name,
        builder: (context, state) => WorkTaskDetail(
          key: state.pageKey,
          task: state.extra as TaskModel,
        ),
      ),
    ],
  );
}
