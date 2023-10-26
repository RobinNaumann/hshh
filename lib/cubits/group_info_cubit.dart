import 'package:hshh/models/group_info.dart';
import 'package:hshh/services/group_info_service.dart';
import '../util/tri/tri_cubit.dart';

class GroupInfoCubit extends TriCubit<GroupInfo> {
  static const provider = TriCubit.provider<GroupInfoCubit>;
  static const builder = TriCubit.builder<GroupInfoCubit, GroupInfo>;
  static const builderSmall = TriCubit.builderSmall<GroupInfoCubit, GroupInfo>;

  GroupInfoCubit(String groupName)
      : super(() => GroupInfoService.getInfo(groupName));
}
