import 'package:hshh/models/m_group_info.dart';
import 'package:hshh/services/s_group_info.dart';
import 'package:hshh/util/tri/tribit/tribit.dart';

class GroupInfoBit extends TriBit<GroupInfo> {
  static const builder = TriBuilder<GroupInfo, GroupInfoBit>.make;

  GroupInfoBit(String groupName)
      : super(() => GroupInfoService.getInfo(groupName));
}
