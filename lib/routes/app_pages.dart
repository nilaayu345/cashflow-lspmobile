import 'package:get/get.dart';

import '../modules/add_expense/bindings/add_expense_binding.dart';
import '../modules/add_expense/views/add_expense_view.dart';
import '../modules/add_income/bindings/add_income_binding.dart';
import '../modules/add_income/views/add_income_view.dart';
import '../modules/detail_cash_flow/bindings/detail_cash_flow_binding.dart';
import '../modules/detail_cash_flow/views/detail_cash_flow_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/setting/bindings/setting_binding.dart';
import '../modules/setting/views/setting_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.ADD_INCOME,
      page: () => AddIncomeView(),
      binding: AddIncomeBinding(),
    ),
    GetPage(
      name: _Paths.ADD_EXPENSE,
      page: () => AddExpenseView(),
      binding: AddExpenseBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_CASH_FLOW,
      page: () => DetailCashFlowView(),
      binding: DetailCashFlowBinding(),
    ),
    GetPage(
      name: _Paths.SETTING,
      page: () => SettingView(),
      binding: SettingBinding(),
    ),
  ];
}
