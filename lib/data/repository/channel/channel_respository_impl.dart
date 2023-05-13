import 'package:soon_sak/data/dataSource/channel/channel_data_source.dart';
import 'package:soon_sak/data/repository/channel/channel_respoitory.dart';
import 'package:soon_sak/domain/model/channel/channel_model.dart';
import 'package:soon_sak/utilities/result.dart';

class ChannelRepositoryImpl implements ChannelRepository {
  ChannelRepositoryImpl(this._dataSource);

  final ChannelDataSource _dataSource;

  @override
  Future<Result<List<ChannelModel>>> loadChannelsBaseOnSubscribers() async {
    final response = await _dataSource.loadChannelsBaseOnSubscribers();
    try {
      return Result.success(
          response.map((e) => ChannelModel.fromResponse(e)).toList());
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }
}
