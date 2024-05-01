part of 'coupon_bloc.dart';

enum CouponDataTab {
  general,
  usageRestriction,
}

class CouponState extends BaseState {
  final List<Map<String, dynamic>> includeProducts;
  final List<Map<String, dynamic>> excludeProducts;
  final List<Map<String, dynamic>> includeCategories;
  final List<Map<String, dynamic>> excludeCategories;
  final RequiredText couponCode;
  final String description;
  final CouponDataTab dataTab;
  final RequiredObject<CouponTypeModel> couponType;
  final RequiredText amount;
  final bool allowFreeShipping;
  final RequiredObject<DateTime> expireDate;
  final int minumumSpend;
  final int maximumSpend;
  const CouponState({
    this.includeCategories = const [],
    this.excludeCategories = const [],
    this.includeProducts = const [],
    this.excludeProducts = const [],
    this.dataTab = CouponDataTab.general,
    this.couponCode = const RequiredText.pure(),
    this.description = "",
    this.couponType = const RequiredObject<CouponTypeModel>.dirty(
      value: CouponTypeModel.empty,
    ),
    this.amount = const RequiredText.pure(),
    this.allowFreeShipping = false,
    this.expireDate = const RequiredObject<DateTime>.pure(),
    this.minumumSpend = 0,
    this.maximumSpend = 0,
    super.isFirstTimePressed,
    super.actionStatus,
    super.isValid,
    super.items,
    super.paginateIndex,
    super.selectedAction,
    super.selectedItems,
    super.submitStatus,
    super.editItem,
  });

  @override
  List<Object> get props => [
        includeCategories,
        excludeCategories,
        includeProducts,
        excludeProducts,
        dataTab,
        couponCode,
        required,
        couponType,
        amount,
        allowFreeShipping,
        expireDate,
        minumumSpend,
        maximumSpend,
        ...super.props,
      ];

  @override
  CouponState copyWith({
    CouponDataTab? dataTab,
    List? items,
    editItem,
    int? paginateIndex,
    List<int>? selectedItems,
    String? selectedAction,
    ActionStatus? actionStatus,
    FormzSubmissionStatus? submitStatus,
    bool? isValid,
    bool? isFirstTimePressed,
    RequiredText? couponCode,
    String? description,
    RequiredObject<CouponTypeModel>? couponType,
    RequiredText? amount,
    bool? allowFreeShipping,
    RequiredObject<DateTime>? expireDate,
    int? minumumSpend,
    int? maximumSpend,
    List<Map<String, dynamic>>? includeProducts,
    List<Map<String, dynamic>>? excludeProducts,
    List<Map<String, dynamic>>? includeCategories,
    List<Map<String, dynamic>>? excludeCategories,
  }) {
    return CouponState(
      includeCategories: includeCategories ?? this.includeCategories,
      excludeCategories: excludeCategories ?? this.excludeCategories,
      includeProducts: includeProducts ?? this.includeProducts,
      excludeProducts: excludeProducts ?? this.excludeProducts,
      dataTab: dataTab ?? this.dataTab,
      items: items ?? this.items,
      editItem: editItem ?? this.editItem,
      paginateIndex: paginateIndex ?? this.paginateIndex,
      selectedItems: selectedItems ?? this.selectedItems,
      selectedAction: selectedAction ?? this.selectedAction,
      actionStatus: actionStatus ?? this.actionStatus,
      submitStatus: submitStatus ?? this.submitStatus,
      isValid: isValid ?? this.isValid,
      isFirstTimePressed: isFirstTimePressed ?? this.isFirstTimePressed,
      couponCode: couponCode ?? this.couponCode,
      description: description ?? this.description,
      couponType: couponType ?? this.couponType,
      amount: amount ?? this.amount,
      allowFreeShipping: allowFreeShipping ?? this.allowFreeShipping,
      expireDate: expireDate ?? this.expireDate,
      minumumSpend: minumumSpend ?? this.minumumSpend,
      maximumSpend: maximumSpend ?? this.maximumSpend,
    );
  }
}
