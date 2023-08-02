import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soon_sak/data/api/channel/request/channel_contents_request.dart';
import 'package:soon_sak/data/api/channel/response/channel_paged_response.dart';
import 'package:soon_sak/data/dataSource/channel/channel_data_source.dart';
import 'package:soon_sak/data/repository/channel/channel_repository.dart';
import 'package:soon_sak/domain/model/channel/channel_content_list.dart';
import 'package:soon_sak/domain/model/channel/channel_model.dart';
import 'package:soon_sak/domain/model/content/home/content_poster_shell.dart';
import 'package:soon_sak/utilities/result.dart';

class ChannelRepositoryImpl implements ChannelRepository {
  ChannelRepositoryImpl(this._dataSource);

  final ChannelDataSource _dataSource;

  @override
  Future<Result<List<ChannelModel>>> loadChannelsBaseOnSubscribers() async {
    try {
      final response = await _dataSource.loadChannelsBaseOnSubscribers();
      return Result.success(
          response.map((e) => ChannelModel.fromResponse(e)).toList());
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<ChannelPagedResponse>> loadPagedChannels(
      DocumentSnapshot? lastDocument) async {
    try {
      final response = await _dataSource.loadPagedChannels(lastDocument);
      return Result.success(response);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<ChannelContentList>> loadPagedChannelContents(
      ChannelContentsRequest request) async {
    try {
      final response = await _dataSource.loadChannelContents(request);
      if (response.isEmpty) {
        return Result.failure(Exception('콘텐츠 데이터를 불러오는데 실패했습니다0'));
      }
      return Result.success(ChannelContentList(
          contents: response
              .map((e) => ContentPosterShell.fromChannelContents(e))
              .toList(),
          lastDocument: response.last.originDoc));
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<List<ContentPosterShell>>> loadChannelContentsWithLimit(
      {required String channelId, required String currentContentId}) async {
    try {
      final response = await _dataSource.loadChannelContents(
          ChannelContentsRequest(channelId: channelId, lastDocument: null));
      if (response.isEmpty) {
        return Result.failure(Exception('콘텐츠 데이터를 불러오는데 실패했습니다'));
      }
      final result = response
          .map((e) => ContentPosterShell.fromRelatedContents(e))
          .toList();
      result.removeWhere((element) => element.originId == currentContentId);

      return Result.success(result);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<ChannelModel>> loadChannelById(String contentId) async {
    try {
      final response = await _dataSource.loadChannelById(contentId);
      final data = ChannelModel.fromResponse(response);
      return Result.success(data);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }
}
