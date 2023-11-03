import 'package:hshh/models/m_group_info.dart';
import 'package:hshh/services/s_group_info.dart';
import '../util/tri/tri_cubit.dart';

class GroupInfoCubit extends TriCubit<GroupInfo> {
  static const provider = TriCubit.provider<GroupInfoCubit>;
  static const builder = TriCubit.builder<GroupInfoCubit, GroupInfo>;

  GroupInfoCubit(String groupName)
      : super(() => GroupInfoService.getInfo(groupName));
}
