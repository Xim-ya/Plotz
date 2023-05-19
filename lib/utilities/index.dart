/* Created By Ximya - 2022.11.04
*  Single exports로 패키지 및 소스파일 관리
*  TODO: 중복된 export 구문 있음. 삭제 필요
* */

// Flutter Packages
export 'package:flutter/material.dart';
export 'package:flutter/rendering.dart';
export 'package:flutter_svg/svg.dart';
export 'dart:async';

export 'package:flutter/services.dart';

// External Packages
export 'package:pub_semver/pub_semver.dart';
export 'package:package_info_plus/package_info_plus.dart';
export 'package:flutter_dotenv/flutter_dotenv.dart';
export 'package:firebase_core/firebase_core.dart';
export 'package:flutter_easyloading/flutter_easyloading.dart';
export 'package:cupertino_will_pop_scope/cupertino_will_pop_scope.dart';
export 'package:get/get.dart';
export 'package:connectivity_plus/connectivity_plus.dart';
export 'package:cached_network_image/cached_network_image.dart';
export 'package:shimmer_animation/shimmer_animation.dart';
export 'package:carousel_slider/carousel_slider.dart';
export 'package:url_launcher/url_launcher.dart';
export 'package:json_annotation/json_annotation.dart';
export 'package:youtube_explode_dart/youtube_explode_dart.dart';
export 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
export 'package:firebase_auth/firebase_auth.dart';
export 'package:google_sign_in/google_sign_in.dart';
export 'package:sign_in_with_apple/sign_in_with_apple.dart';
export 'package:cloud_firestore/cloud_firestore.dart';
export 'package:polygon/polygon.dart';
export 'package:firebase_crashlytics/firebase_crashlytics.dart';
export 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
export 'package:get_it/get_it.dart';

// BaseModule
export 'package:soon_sak/presentation/base/new_base_view_model.dart';
export 'package:soon_sak/presentation/base/new_base_screen.dart';
export 'package:soon_sak/presentation/base/base_view_model.dart';
export 'package:soon_sak/domain/base/base_use_case.dart';
export 'package:soon_sak/domain/base/base_no_param_use_case.dart';
export 'package:soon_sak/domain/base/base_two_param_use_case.dart';

// App
export 'package:soon_sak/app/analytics/app_analytics.dart';
export 'package:soon_sak/app/config/theme_config.dart';
export 'package:soon_sak/app/di/app_binding.dart';
export 'package:soon_sak/app/routes/app_pages.dart';
export 'package:soon_sak/data/api/tmdb/response/newResponse/tmdb_movie_content_list_wrapped_response.dart';
export 'package:soon_sak/data/api/tmdb/response/newResponse/tmdb_tv_content_list_wrapped_response.dart';
export 'package:soon_sak/app/config/font_config.dart';
export 'package:soon_sak/app/config/color_config.dart';
export 'package:soon_sak/app/routes/app_routes.dart';
export 'package:soon_sak/app/config/app_space_config.dart';
export 'package:soon_sak/app/config/size_config.dart';
export 'package:soon_sak/app/modules/data_modules.dart';
export 'package:soon_sak/app/modules/domain_modules.dart';
export 'package:soon_sak/app/modules/presentation_modules.dart';

// Data
export 'package:soon_sak/data/api/version/response/version_response.dart';
export 'package:soon_sak/data/api/user/response/user_watch_history_item_response.dart';
export 'package:soon_sak/data/mixin/isolate_helper_mixin.dart';
export 'package:soon_sak/data/mixin/firebase_isolate_helper_mixin.dart';
export 'package:soon_sak/data/api/content/response/explore_content_response.dart';
export 'package:soon_sak/data/api/user/response/user_response.dart';
export 'package:soon_sak/data/dataSource/user/user_data_source.dart';
export 'package:soon_sak/data/api/user/user_api.dart';
export 'package:soon_sak/data/api/content/response/curation_content_response.dart';
export 'package:soon_sak/data/api/user/response/user_curation_summary_response.dart';
export 'package:soon_sak/domain/exception/auth_exception.dart';
export 'package:soon_sak/data/api/content/response/basic_content_info_response.dart';
export 'package:soon_sak/data/api/content/response/video_response.dart';
export 'package:soon_sak/data/api/staticContent/response/content_key_response.dart';
export 'package:soon_sak/data/repository/youtube/youtube_repository_impl.dart';
export 'package:soon_sak/data/api/auth/auth_api.dart';
export 'package:soon_sak/data/api/auth/auth_api_impl.dart';
export 'package:soon_sak/data/dataSource/staticContent/static_content_data_source_impl.dart';
export 'package:soon_sak/data/api/content/content_api.dart';

export 'package:soon_sak/data/firebase/app_fire_store.dart';
export 'package:soon_sak/data/repository/auth/auth_repository.dart';
export 'package:soon_sak/data/repository/auth/auth_repository_impl.dart';
export 'package:soon_sak/data/repository/staticContent/static_content_repository_impl.dart';
export 'package:soon_sak/data/api/staticContent/response/category_content_collection_response.dart';
export 'package:soon_sak/data/dataSource/staticContent/static_content_data_source.dart';
export 'package:soon_sak/data/repository/youtube/youtube_repository.dart';
export 'package:soon_sak/data/api/tmdb/response/newResponse/tmdb_content_credit_response.dart';
export 'package:soon_sak/data/api/tmdb/response/newResponse/tmdb_tv_detail_response.dart';
export 'package:soon_sak/data/api/tmdb/tmdb_api.dart';
export 'package:soon_sak/data/api/tmdb/response/newResponse/tmdb_movie_detail_response.dart';
export 'package:soon_sak/data/api/tmdb/response/newResponse/tmdb_content_image_response.dart';
export 'package:soon_sak/data/dataSource/content/content_data_source.dart';
export 'package:soon_sak/data/dataSource/content/content_data_source_impl.dart';
export 'package:soon_sak/data/dataSource/tmdb/tmdb_data_source.dart';
export 'package:soon_sak/data/dataSource/tmdb/tmdb_data_source_impl.dart';
export 'package:soon_sak/data/repository/content/content_repository.dart';
export 'package:soon_sak/data/repository/content/content_repository_impl.dart';
export 'package:soon_sak/data/repository/tmdb/tmdb_repository.dart';
export 'package:soon_sak/data/repository/tmdb/tmdb_repository_impl.dart';
export 'package:soon_sak/data/api/staticContent/response/banner_response.dart';
export 'package:soon_sak/data/api/staticContent/static_content_api.dart';
export 'package:soon_sak/data/repository/staticContent/static_content_repository.dart';
export 'package:soon_sak/data/api/staticContent/response/top_ten_content_response.dart';
export 'package:soon_sak/data/mixin/fire_store_error_handler_mixin.dart';
export 'package:soon_sak/domain/useCase/auth/sign_in_and_up_handler_use_case.dart';
export 'package:soon_sak/domain/useCase/auth/sign_out_use_case.dart';
export 'package:soon_sak/domain/useCase/content/home/load_cached_top_ten_contents_use_case.dart';
export 'package:soon_sak/domain/useCase/explore/load_random_paged_explore_contents_use_case.dart';
export 'package:soon_sak/domain/useCase/search/search_paged_content_impl.dart';
export 'package:soon_sak/domain/useCase/search/validate_video_url_use_case_impl.dart';
export 'package:soon_sak/data/mixin/fire_store_helper_mixin.dart';
export 'package:soon_sak/data/repository/user/user_repository.dart';
export 'package:soon_sak/data/api/staticContent/static_content_api_impl.dart';
export 'package:soon_sak/data/api/user/user_api_impl.dart';
export 'package:soon_sak/data/api/youtube/youtube_api.dart';
export 'package:soon_sak/data/api/youtube/youtube_api_impl.dart';
export 'package:soon_sak/data/dataSource/auth/auth_data_source.dart';
export 'package:soon_sak/data/dataSource/auth/auth_data_source_impl.dart';
export 'package:soon_sak/data/dataSource/user/user_data_source_impl.dart';
export 'package:soon_sak/data/dataSource/youtube/youtube_data_sourc_impl.dart';
export 'package:soon_sak/data/dataSource/youtube/youtube_data_source.dart';
export 'package:soon_sak/data/repository/user/user_repository_impl.dart';
export 'package:soon_sak/data/api/user/request/watching_history_request.dart';
export 'package:soon_sak/data/api/user/request/user_profile_request.dart';
export 'package:soon_sak/data/dataSource/version/version_data_source.dart';
export 'package:soon_sak/data/repository/version/version_repository.dart';
export 'package:soon_sak/data/api/content/response/channel_response.dart';

// Domain
export 'package:soon_sak/domain/useCase/content/home/load_paged_category_collection_use_case.dart';
export 'package:soon_sak/domain/model/content/contentDetail/channel_info.dart';
export 'package:soon_sak/domain/enum/tab_loading_state_enum.dart';
export 'package:soon_sak/domain/model/version/version_info.dart';
export 'package:soon_sak/domain/model/content/myPage/user_watch_history_item.dart';
export 'package:soon_sak/domain/exception/content/content_exception.dart';
export 'package:soon_sak/domain/exception/user/user_exception.dart';
export 'package:soon_sak/domain/model/content/myPage/user_curation_summary.dart';
export 'package:soon_sak/domain/enum/sns_type_enum.dart';
export 'package:soon_sak/domain/model/content/home/category_content_collection_model.dart';
export 'package:soon_sak/domain/model/content/home/static_content_keys.dart';
export 'package:soon_sak/domain/model/content/home/top_ten_contents_model.dart';
export 'package:soon_sak/domain/model/content/content_id_model.dart';
export 'package:soon_sak/domain/model/content/explore/explore_content_model.dart';
export 'package:soon_sak/domain/model/auth/user_model.dart';
export 'package:soon_sak/domain/model/content/home/banner_model.dart';
export 'package:soon_sak/domain/service/local_storage_service.dart';
export 'package:soon_sak/domain/useCase/content/home/load_cached_banner_content_use_case.dart';
export 'package:soon_sak/domain/useCase/search/search_validate_url_use_case.dart';
export 'package:soon_sak/domain/mixin/paging_handler_mixin.dart';
export 'package:soon_sak/domain/mixin/search_handler_mixin.dart';
export 'package:soon_sak/domain/model/content/content.dart';
export 'package:soon_sak/domain/useCase/search/search_paged_content_use_case.dart';
export 'package:soon_sak/domain/enum/validation_state_enum.dart';
export 'package:soon_sak/domain/model/content/explore/explore_content_detail_info.dart';
export 'package:soon_sak/domain/model/content/explore/explore_content_youtube_info.dart';
export 'package:soon_sak/domain/model/content/explore_content_id_info.dart';
export 'package:soon_sak/domain/model/content/explore/explore_content.dart';
export 'package:soon_sak/domain/model/content/season_info.dart';
export 'package:soon_sak/domain/model/video/content_videos.dart';
export 'package:soon_sak/domain/enum/content_video_format.dart';
export 'package:soon_sak/domain/useCase/video/load_content_of_video_list_use_case.dart';
export 'package:soon_sak/domain/model/video/content_video_item.dart';
export 'package:soon_sak/domain/model/content/content_shell.dart';
export 'package:soon_sak/domain/model/content/simple_content_info.dart';
export 'package:soon_sak/domain/enum/content_type_enum.dart';
export 'package:soon_sak/domain/model/youtube/youtube_content_comment.dart';
export 'package:soon_sak/domain/model/youtube/youtube_video_content_info.dart';
export 'package:soon_sak/domain/model/content/tv_content_credit_info.dart';
export 'package:soon_sak/domain/model/content/content_episode_info_item.dart';
export 'package:soon_sak/domain/useCase/tmdb/load_content_detail_info_use_case.dart';
export 'package:soon_sak/domain/model/content/exposure_content.dart';
export 'package:soon_sak/domain/model/content/youtube_content.dart';
export 'package:soon_sak/domain/model/content/content_main_info.dart';
export 'package:soon_sak/domain/model/content/category_based_content_list.dart';
export 'package:soon_sak/domain/enum/content_season_type_enum.dart';
export 'package:soon_sak/domain/enum/ott_type_enum.dart';
export 'package:soon_sak/domain/model/content/splitted_id_and_type.dart';
export 'package:soon_sak/domain/model/content/content_detail_info.dart';
export 'package:soon_sak/domain/model/content/searched_content.dart';
export 'package:soon_sak/domain/service/content_service.dart';
export 'package:soon_sak/domain/useCase/tmdb/load_content_credit_info_use_case.dart';
export 'package:soon_sak/domain/useCase/tmdb/load_content_img_list_use_case.dart';
export 'package:soon_sak/domain/model/content/content_argument_format.dart';
export 'package:soon_sak/domain/base/base_single_data_model.dart';
export 'package:soon_sak/domain/enum/curation_status.dart';
export 'package:soon_sak/domain/service/user_service.dart';
export 'package:soon_sak/domain/model/content/curation/curation_content.dart';
export 'package:soon_sak/domain/model/content/register/content_registration_request.dart';
export 'package:soon_sak/domain/model/content/search/content_request.dart';

// Presentation
export 'package:soon_sak/presentation/common/image/image_view_with_play_btn.dart';
export 'package:soon_sak/presentation/screens/search/localWidget/search_scaffold.dart';
export 'package:soon_sak/presentation/screens/search/localWidget/searched_list_item.dart';
export 'package:soon_sak/presentation/screens/search/search_view_model.dart';
export 'package:soon_sak/presentation/screens/curation/curation_view_model.dart';
export 'package:soon_sak/presentation/screens/curation/curation_screen.dart';
export 'package:soon_sak/presentation/screens/register/register_view_model.dart';
export 'package:soon_sak/presentation/screens/explore/explore_screen.dart';
export 'package:soon_sak/presentation/screens/my/my_page_screen.dart';
export 'package:soon_sak/presentation/screens/curation/localWidget/start_curation_button.dart';
export 'package:soon_sak/presentation/screens/register/pageView/confirm_curation_page_view.dart';
export 'package:soon_sak/presentation/common/listView/paging_searched_result_list_view.dart';
export 'package:soon_sak/presentation/screens/register/localWidget/search_content_page_view_scaffold.dart';
export 'package:soon_sak/presentation/screens/register/localWidget/searched_content_item_btn.dart';
export 'package:soon_sak/presentation/screens/register/localWidget/register_video_link_page_view_scaffold.dart';
export 'package:soon_sak/presentation/screens/register/localWidget/url_validation_indicator.dart';
export 'package:soon_sak/presentation/common/button/linear_background_bottom_floating_btn.dart';
export 'package:soon_sak/presentation/common/image/linear_layered_poster_img.dart';
export 'package:soon_sak/presentation/common/keep_alive_view.dart';
export 'package:soon_sak/presentation/screens/login/localWidget/sns_login_button.dart';
export 'package:soon_sak/presentation/screens/login/login_view_model.dart';
export 'package:soon_sak/presentation/screens/home/localWidget/banner_item.dart';
export 'package:soon_sak/presentation/screens/home/localWidget/banner_skeleton_item.dart';
export 'package:soon_sak/presentation/screens/home/localWidget/category_content_section_skeleton_view.dart';
export 'package:soon_sak/presentation/screens/home/localWidget/category_content_section_view.dart';
export 'package:soon_sak/presentation/screens/explore/localWidget/explore_swiper_item_scaffold.dart';
export 'package:soon_sak/presentation/common/youtube/channel_info_view.dart';
export 'package:soon_sak/presentation/screens/curationHistory/localWidget/contents_grid_view.dart';
export 'package:soon_sak/presentation/screens/register/pageView/register_video_link_page_view.dart';
export 'package:soon_sak/presentation/screens/register/pageView/search_content_page_view.dart';
export 'package:soon_sak/presentation/common/dialog/app_dialog.dart';
export 'package:soon_sak/presentation/common/textField/search_bar.dart';
export 'package:soon_sak/presentation/common/animated_index_stack.dart';
export 'package:soon_sak/presentation/common/sticky_delegate_container.dart';
export 'package:soon_sak/presentation/screens/contentDetail/content_detail_scaffold_controller.dart';
export 'package:soon_sak/presentation/screens/contentDetail/content_detail_scaffold.dart';
export 'package:soon_sak/presentation/screens/contentDetail/localWidget/tabView/content_detail_info_tab_view.dart';
export 'package:soon_sak/presentation/screens/contentDetail/content_detail_view_model.dart';
export 'package:soon_sak/presentation/common/image/round_profile_img.dart';
export 'package:soon_sak/presentation/screens/contentDetail/localWidget/section_title.dart';
export 'package:soon_sak/presentation/base/base_screen.dart';
export 'package:soon_sak/presentation/base/base_view.dart';
export 'package:soon_sak/presentation/screens/tabs/tabs_view_model.dart';
export 'package:soon_sak/presentation/screens/tabs/tabs_binding.dart';
export 'package:soon_sak/presentation/screens/tabs/tabs_screen.dart';
export 'package:soon_sak/presentation/common/image/content_post_item.dart';
export 'package:soon_sak/presentation/common/slider/content_post_slider.dart';
export 'package:soon_sak/presentation/common/button/icon_ink_well_button.dart';
export 'package:soon_sak/presentation/screens/home/home_view_model.dart';
export 'package:soon_sak/presentation/screens/contentDetail/content_detail_binding.dart';
export 'package:soon_sak/presentation/screens/contentDetail/content_detail_screen.dart';
export 'package:soon_sak/presentation/screens/contentDetail/localWidget/tabView/main_content_tab_view.dart';
export 'package:soon_sak/presentation/common/skeleton_box.dart';
export 'package:soon_sak/presentation/screens/contentDetail/localWidget/content_video_views_by_case.dart';
export 'package:soon_sak/presentation/screens/contentDetail/localWidget/single_video_skeleton_view.dart';
export 'package:soon_sak/presentation/screens/curationHistory/localWidget/curation_history_scaffold.dart';
export 'package:soon_sak/presentation/screens/curationHistory/curation_history_view_model.dart';
export 'package:soon_sak/presentation/screens/curationHistory/tabview/completed_contents_tab_view.dart';
export 'package:soon_sak/presentation/screens/curationHistory/tabview/in_progress_contents_tab_view.dart';
export 'package:soon_sak/presentation/screens/curationHistory/tabview/pending_contents_tab_view.dart';
export 'package:soon_sak/presentation/screens/explore/explore_view_model.dart';
export 'package:soon_sak/presentation/screens/my/my_page_view_model.dart';
export 'package:soon_sak/presentation/screens/login/login_binding.dart';
export 'package:soon_sak/presentation/screens/login/login_screen.dart';
export 'package:soon_sak/presentation/screens/register/register_binding.dart';
export 'package:soon_sak/presentation/screens/register/register_screen.dart';
export 'package:soon_sak/presentation/screens/curationHistory/curation_history_binding.dart';
export 'package:soon_sak/presentation/screens/curationHistory/curation_history_screen.dart';
export 'package:soon_sak/presentation/screens/splash/splash_screen.dart';
export 'package:soon_sak/presentation/screens/splash/splash_view_model.dart';
export 'package:soon_sak/presentation/screens/curation/localWidget/curation_grid_item_skeleton_view.dart';
export 'package:soon_sak/presentation/screens/curation/localWidget/curation_grid_item_view.dart';
export 'package:soon_sak/presentation/base/state_box.dart';

// Utilities
export 'package:soon_sak/utilities/extensions/random_list_item_extension.dart';
export 'package:soon_sak/utilities/constants/invalid_search_character.dart';
export 'package:soon_sak/utilities/extensions/determine_content_type.dart';
export 'package:soon_sak/utilities/extensions/get_last_character_of_string.extension.dart';
export 'package:soon_sak/utilities/constants/bottom_navigation_constants.dart';
export 'package:soon_sak/data/mixin/api_error_handler_mixin.dart';
export 'package:soon_sak/utilities/result.dart';
export 'package:soon_sak/utilities/youtube_meta_data.dart';
export 'package:soon_sak/app/config/app_insets.dart';
export 'package:flutter_styled_toast/flutter_styled_toast.dart';
export 'package:soon_sak/utilities/extensions/check_null_state_extension.dart';
export 'package:soon_sak/utilities/extensions/tmdb_img_path_extension.dart';
export 'package:soon_sak/utilities/formatter.dart';
export 'package:soon_sak/presentation/common/alert/alert_widget.dart';
export 'package:soon_sak/app/di/locator/locator.dart';
