library swagger.api;

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart';

part 'api_client.dart';

part 'api_helper.dart';

part 'api_exception.dart';

part 'auth/authentication.dart';

part 'auth/api_key_auth.dart';

part 'auth/oauth.dart';

part 'auth/http_basic_auth.dart';

part 'api/account_api.dart';

part 'api/admin_customer_api.dart';

part 'api/admin_dashboard_api.dart';

part 'api/admin_report_api.dart';

part 'api/admin_restaurant_api.dart';

part 'api/admin_review_api.dart';

part 'api/admin_service_api.dart';

part 'api/admin_visitor_api.dart';

part 'api/customer_api.dart';

part 'api/customer_configuration_api.dart';

part 'api/customer_event_api.dart';

part 'api/customer_menu_api.dart';

part 'api/customer_offer_api.dart';

part 'api/customer_paprica_item_api.dart';

part 'api/customer_service_api.dart';

part 'api/customer_report_api.dart';

part 'api/customer_reservation_api.dart';

part 'api/customer_pickup_api.dart';

part 'api/customer_poll_api.dart';

part 'api/customer_delivery_api.dart';

part 'api/customer_restaurant_api.dart';

part 'api/customer_review_api.dart';

part 'api/customer_search_api.dart';

part 'api/customer_visitor_api.dart';

part 'api/manager_configuration_api.dart';

part 'api/manager_dashboard_api.dart';

part 'api/manager_event_api.dart';

part 'api/manager_gallery_api.dart';

part 'api/manager_menu_api.dart';

part 'api/manager_offer_api.dart';

part 'api/manager_report_api.dart';

part 'api/manager_reservation_api.dart';

part 'api/manager_restaurant_api.dart';

part 'api/manager_review_api.dart';

part 'api/notifications_api.dart';

part 'api/places_api.dart';

part 'api/role_api.dart';

part 'api/session_api.dart';

part 'api/tenant_api.dart';

part 'api/token_auth_api.dart';

part 'api/upload_api.dart';

part 'api/user_api.dart';

part 'model/add_favorite_restaurant_dto.dart';

part 'model/change_restaurant_notifications_dto.dart';

part 'model/add_regular_customer_dto.dart';

part 'model/admin_dashboard_dto.dart';

part 'model/alter_restaurant_service_dto.dart';

part 'model/antd_image_dto.dart';

part 'model/application_info_dto.dart';

part 'model/authenticate_model.dart';

part 'model/authenticate_result_model.dart';

part 'model/cancel_reservation_dto.dart';

part 'model/cancel_pickup_dto.dart';

part 'model/cancel_delivery_dto.dart';

part 'model/category_dto.dart';

part 'model/change_event_status_dto.dart';

part 'model/update_pickup_meal_request_dto.dart';

part 'model/update_delivery_meal_request_dto.dart';

part 'model/update_pickup_request_dto.dart';

part 'model/update_delivery_request_dto.dart';

part 'model/update_pickup_dto.dart';

part 'model/update_delivery_dto.dart';

part 'model/update_pickup_meal_dto.dart';

part 'model/update_delivery_meal_dto.dart';

part 'model/change_free_space_indicator.dart';

part 'model/change_offer_status_dto.dart';

part 'model/change_password_dto.dart';

part 'model/reset_forgotten_password_dto.dart';

part 'model/send_forget_password_code_dto.dart';

part 'model/change_restaurant_settings_dto.dart';

part 'model/change_setting_dto.dart';

part 'model/change_status_dto.dart';

part 'model/change_ui_theme_input.dart';

part 'model/change_user_language_dto.dart';

part 'model/city_dto.dart';

part 'model/configuration_city_dto.dart';

part 'model/configuration_country_dto.dart';

part 'model/configuration_region_dto.dart';

part 'model/confirm_phone_number_dto.dart';

part 'model/country_dto.dart';

part 'model/create_category_dto.dart';

part 'model/create_customer_dto.dart';

part 'model/create_pickup_meal_dto.dart';

part 'model/create_delivery_meal_dto.dart';

part 'model/create_pickup_dto.dart';

part 'model/create_delivery_dto.dart';

part 'model/create_customer_report_dto.dart';

part 'model/create_event_dto.dart';

part 'model/create_gallery_dto.dart';

part 'model/create_gallery_item_dto.dart';

part 'model/create_meal_dto.dart';

part 'model/create_offer_dto.dart';

part 'model/create_or_update_review_dto.dart';

part 'model/create_reservation_dto.dart';

part 'model/create_restaurant_dto.dart';

part 'model/create_restaurant_report_dto.dart';

part 'model/create_role_dto.dart';

part 'model/create_service_dto.dart';

part 'model/create_tenant_dto.dart';

part 'model/create_user_dto.dart';

part 'model/create_visitor_contact_info_dto.dart';

part 'model/customer_dto.dart';

part 'model/customer_event_dto.dart';

part 'model/customer_offer_dto.dart';

part 'model/customer_old_pickup_dto.dart';

part 'model/customer_old_pickups_dto.dart';

part 'model/customer_old_delivery_dto.dart';

part 'model/customer_old_deliveries_dto.dart';

part 'model/customer_old_reservation_dto.dart';

part 'model/customer_old_reservations_dto.dart';

part 'model/customer_profile_dto.dart';

part 'model/customer_info_dto.dart';

part 'model/customer_nearest_pickup_dto.dart';

part'model/customer_upcoming_service_dto.dart';

part 'model/customer_nearest_reservation_dto.dart';

part 'model/customer_nearest_delivery_dto.dart';

part 'model/customer_upcoming_pickup_meal_dto.dart';

part 'model/customer_upcoming_delivery_meal_dto.dart';

part 'model/customer_upcoming_pickup_dto.dart';

part 'model/customer_upcoming_delivery_dto.dart';

part 'model/customer_upcoming_pickups_dto.dart';

part 'model/customer_upcoming_deliveries_dto.dart';

part 'model/update_customer_profile_dto.dart';

part 'model/update_phone_number_dto.dart';

part 'model/customer_report_dto.dart';

part 'model/customer_upcoming_reservation_dto.dart';

part 'model/customer_upcoming_reservations_dto.dart';

part 'model/entity_dto_int64.dart';

part 'model/enum_value.dart';

part 'model/external_authenticate_model.dart';

part 'model/external_authenticate_result_model.dart';

part 'model/external_login_provider_info_model.dart';

part 'model/featured_and_nearby_restaurant_dto.dart';

part 'model/file_dto.dart';

part 'model/file_url_dto.dart';

part 'model/flat_permission_dto.dart';

part 'model/gallery_dto.dart';

part 'model/gallery_item_dto.dart';

part 'model/get_current_login_informations_output.dart';

part 'model/get_role_for_edit_output.dart';

part 'model/i_paprica_item_model_dto.dart';

part 'model/i_setting_value.dart';

part 'model/ingredient_dto.dart';

part 'model/initialization_dto.dart';

part 'model/is_tenant_available_input.dart';

part 'model/is_tenant_available_output.dart';

part 'model/list_result_dto_permission_dto.dart';

part 'model/list_result_dto_role_dto.dart';

part 'model/list_result_dto_role_list_dto.dart';

part 'model/lite_search_item_dto.dart';

part 'model/manager_event_dto.dart';

part 'model/manager_offer_dto.dart';

part 'model/massage_dto.dart';

part 'model/meal_dto.dart';

part 'model/meal_rate_dto.dart';

part 'model/media_dto.dart';

part 'model/notification_info_dto.dart';

part 'model/opening_time_dto.dart';

part 'model/paged_result_dto_configuration_city_dto.dart';

part 'model/paged_result_dto_configuration_country_dto.dart';

part 'model/paged_result_dto_configuration_region_dto.dart';

part 'model/paged_result_dto_customer_dto.dart';

part 'model/paged_result_dto_customer_event_dto.dart';

part 'model/paged_result_dto_customer_offer_dto.dart';

part 'model/paged_result_dto_gallery_item_dto.dart';

part 'model/paged_result_dto_manager_event_dto.dart';

part 'model/paged_result_dto_manager_offer_dto.dart';

part 'model/paged_result_dto_report_dto.dart';

part 'model/paged_result_dto_reservation_dto.dart';

part 'model/paged_result_dto_restaurant_dto.dart';

part 'model/paged_result_dto_restaurant_lite_dto.dart';

part 'model/paged_result_dto_restaurant_summary_dto.dart';

part 'model/paged_result_dto_review_dto.dart';

part 'model/paged_result_dto_role_dto.dart';

part 'model/paged_result_dto_service_dto.dart';

part 'model/paged_result_dto_tenant_dto.dart';

part 'model/paged_result_dto_user_dto.dart';

part 'model/paged_result_dto_visitor_contact_info_dto.dart';

part 'model/permission_dto.dart';

part 'model/paprica_item_dto.dart';

part 'model/paprica_item_query_dto.dart';

part 'model/paprica_item_stamp_dto.dart';

part 'model/paprica_items_dto.dart';

part 'model/region_dto.dart';

part 'model/register_input.dart';

part 'model/register_output.dart';

part 'model/report_dto.dart';

part 'model/reservation_dto.dart';

part 'model/reset_password_dto.dart';

part 'model/restaurant_dto.dart';

part 'model/restaurant_event_dto.dart';

part 'model/restaurant_home_dto.dart';

part 'model/restaurant_lite_dto.dart';

part 'model/restaurant_old_reservation_dto.dart';

part 'model/restaurant_old_reservations_dto.dart';

part 'model/restaurant_profile_dto.dart';

part 'model/restaurant_raters_dto.dart';

part 'model/restaurant_report_dto.dart';

part 'model/restaurant_reservation_dashboard_dto.dart';

part 'model/restaurant_reviews_summary_dto.dart';

part 'model/restaurant_settings_dto.dart';

part 'model/restaurant_summary_dto.dart';

part 'model/restaurant_upcoming_reservation_dto.dart';

part 'model/restaurant_upcoming_reservations_dto.dart';

part 'model/review_dto.dart';

part 'model/review_summary_dto.dart';

part 'model/role_dto.dart';

part 'model/role_edit_dto.dart';

part 'model/role_list_dto.dart';

part 'model/search_result_dto.dart';

part 'model/service_dto.dart';

part 'model/delivery_region_dto.dart';

part 'model/delivery_regions_dto.dart';

part 'model/tenant_dto.dart';

part 'model/tenant_login_info_dto.dart';

part 'model/tenant_notification_info.dart';

part 'model/types_dto.dart';

part 'model/update_activation_status_dto.dart';

part 'model/update_category_dto.dart';

part 'model/update_customer_dto.dart';

part 'model/update_event_dto.dart';

part 'model/update_gallery_item_dto.dart';

part 'model/update_is_featured_dto.dart';

part 'model/update_meal_dto.dart';

part 'model/update_offer_dto.dart';

part 'model/update_opening_time_dto.dart';

part 'model/update_reservation_dto.dart';

part 'model/update_reservation_request_dto.dart';

part 'model/update_restaurant_profile_dto.dart';

part 'model/update_review_status_dto.dart';

part 'model/update_service_dto.dart';

part 'model/update_status_dto.dart';

part 'model/user_dto.dart';

part 'model/user_login_info_dto.dart';

part 'model/user_notification_info.dart';

part 'model/notifications_info_dto.dart';

part 'model/user_notification_info_with_notification_info.dart';

part 'model/visitor_contact_info_dto.dart';

part 'model/update_opening_times_dto.dart';

part 'model/api_filter_model.dart';

part 'model/event_paprica_item_dto.dart';

part 'model/offer_paprica_item_dto.dart';

part 'model/reservation_paprica_item_dto.dart';

part 'model/restaurant_in_list_paprica_item.dart';

part 'model/published_poll_in_paprica_item.dart';

part 'model/open_poll_in_paprica_item.dart';

part 'model/poll_add_vote_dto.dart';

part 'model/published_poll_item.dart';

part 'model/open_poll_item.dart';

part 'model/restaurant_poll_in_paprica_item.dart';

part 'model/meal_in_published_poll_in_paprica_item.dart';

part 'model/list_paprica_item_dto.dart';

part 'model/paged_result_dto_mypaprica_offer_dto.dart';

part 'model/places_response.dart';

ApiClient defaultApiClient = new ApiClient();
