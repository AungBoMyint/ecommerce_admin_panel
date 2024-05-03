part of 'shipping_bloc.dart';

class ShippingState extends BaseState<ShippingZone, ShippingState> {
  final RequiredDropdown zoneName;
  final RequiredObjectList<String> zoneRegionList;
  final RequiredObject<String?> shippingMethod;
  final List<String> zoneRegions;
  final List<String> zoneNames;
  final int? cost;
  final FreeShippingType? shippingType;
  const ShippingState({
    this.zoneName = const RequiredDropdown.pure(),
    this.zoneRegionList = const RequiredObjectList<String>.pure(),
    this.shippingMethod = const RequiredObject<String?>.pure(),
    this.cost = 0,
    this.shippingType,
    this.zoneRegions = const [],
    this.zoneNames = const [
      "Myanmar",
      "Thailand",
    ],
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
        zoneName,
        zoneRegionList,
        shippingMethod,
        zoneRegions,
        zoneNames,
        cost ?? "",
        shippingType ?? "",
        ...super.props,
      ];

  @override
  ShippingState copyWith({
    List<ShippingZone>? items,
    int? paginateIndex,
    ShippingZone? editItem,
    List<int>? selectedItems,
    String? selectedAction,
    ActionStatus? actionStatus,
    FormzSubmissionStatus? submitStatus,
    bool? isValid,
    RequiredDropdown? zoneName,
    RequiredObjectList<String>? zoneRegionList,
    RequiredObject<String?>? shippingMethod,
    List<String>? zoneRegions,
    bool? isFirstTimePressed,
    int? cost,
    FreeShippingType? shippingType,
  }) {
    return ShippingState(
      editItem: editItem ?? this.editItem,
      cost: cost ?? this.cost,
      shippingType: shippingType ?? this.shippingType,
      items: items ?? this.items,
      paginateIndex: paginateIndex ?? this.paginateIndex,
      selectedItems: selectedItems ?? this.selectedItems,
      selectedAction: selectedAction ?? this.selectedAction,
      actionStatus: actionStatus ?? this.actionStatus,
      submitStatus: submitStatus ?? this.submitStatus,
      isValid: isValid ?? this.isValid,
      zoneName: zoneName ?? this.zoneName,
      zoneRegionList: zoneRegionList ?? this.zoneRegionList,
      shippingMethod: shippingMethod ?? this.shippingMethod,
      isFirstTimePressed: isFirstTimePressed ?? this.isFirstTimePressed,
      zoneRegions: zoneRegions ?? this.zoneRegions,
    );
  }
}
