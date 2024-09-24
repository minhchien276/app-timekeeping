class ApiUrl {
  static const baseUrl = 'https://e-tmsc-b34f03795739.herokuapp.com/api/';

  // static const baseUrl =
  //     "https://etmsc-product-cd30255dba28.herokuapp.com/api/";

  //endpoint
  //auth
  static const refreshToken = 'auth/refreshToken';
  static const login = 'auth/login';
  static const logout = 'auth/logout';

  //timekeeping
  static const checkIn = 'user/checkin/create';
  static const checkOut = 'user/checkout/create';

  //employee
  static const getEmployeeAll = 'employee/get-all-employee';
  static const getEmployeeDetail = 'employee/get-employee-details';
  static const getEmployeeOnline = 'admin/employee/get-employee-online';
  static const getEmployeeDayoff = 'admin/employee/get-employee-dayoff';
  static const getEmployeeSalary = 'user/salary/get-salary';
  static const getEmployeeLastSalary = 'user/salary/get-last-salary';
  static const getEmployeeBirthdayToday = 'employee/get-birthday-today';
  static const getEmployeeOnboardToday = 'employee/get-on-board-today';

  //blog
  static const getAllBlog = 'blog/get-all-blog';
  static const getBlogDetail = 'blog/get-blog-details';

  //calendar
  static const getCalender = 'user/calendar/calendar';
  static const getOvertime = 'user/over-time/get-over-time';

  //application
  static const createApplication = 'user/application/create';
  static const getReceiver = 'user/application/get-receiver';
  static const getApplicationById = 'application/get-by-id';
  static const getPeopleApplication = 'admin/application/get-by-approve-id';
  static const applicationUpdateStatus = 'admin/application/update-status';
  static const getApplicationDetail = 'application/get-application-details';
  static const getApproveApplication =
      'admin/application/get-approve-application';
  static const getPendingApplication =
      'admin/application/get-pending-application';

  //noti
  static const getNotification = 'user/notification/get-notification';
  static const getNotificationDetails =
      'user/notification/get-notification-details';
  static const updateSeen = 'admin/notification/update-seen';
  static const getApprove = 'admin/get-approve';
  static const updateDeviceToken = 'notification/update-device-token';

  //test
  static const getEmployeeTests = 'user/test/get-employee-tests';
  static const getAllTests = 'user/test/get-all-tests';
  static const saveEmployeeTest = 'user/test/save-employee-test';
  static const getTestsScore = 'user/test/get-tests-score';
  static const beginTest = 'user/test/begin-test';
  static const getTestDetails = 'user/test/get-test-details';

  //salary
  static const getSalaryByNotification =
      'user/salary/get-salary-by-notification';

  //room
  static const createRoom = 'user/room/create';
  static const getRoomApproved = 'user/room/get-room-approved';
  static const getRoomPending = 'user/room/get-room-pending';

  //task
  static const createTask = 'user/task/create';
  static const getListTask = 'user/task/get-tasks';
}
