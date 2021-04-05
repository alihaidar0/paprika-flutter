library swagger_inside.api;

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';

part 'api/customer_after_dish_api.dart';
part 'api/customer_category_api.dart';
part 'api/customer_customer_table_api.dart';
part 'api/customer_meal_api.dart';
part 'api/customer_playlist_api.dart';
part 'api/customer_restaurant_api.dart';
part 'api_client.dart';
part 'api_exception.dart';
part 'api_helper.dart';
part 'auth/api_key_auth.dart';
part 'auth/authentication.dart';
part 'auth/http_basic_auth.dart';
part 'auth/oauth.dart';
part 'model/after_dishes_after_dish_dto.dart';
part 'model/after_dishes_after_dish_request_dto.dart';
part 'model/categories_category_dto.dart';
part 'model/customer_tables_create_customer_table_dto.dart';
part 'model/customer_tables_create_order_dto.dart';
part 'model/customer_tables_create_order_meal_dto.dart';
part 'model/customer_tables_order_dto.dart';
part 'model/customer_tables_order_meal_dto.dart';
part 'model/customer_tables_update_order_dto.dart';
part 'model/invoices_invoice_dto.dart';
part 'model/invoices_invoice_tax_dto.dart';
part 'model/meals_meal_dto.dart';
part 'model/meals_meal_ingredient_dto.dart';
part 'model/meals_meal_variant_dto.dart';
part 'model/playlists_playlist_dto.dart';
part 'model/playlists_track_dto.dart';
part 'model/playlists_track_request_dto.dart';
part 'model/restaurants_feedback_dto.dart';
part 'model/restaurants_restaurant_dto.dart';
part 'model/types_invoice_status.dart';
part 'model/types_order_status.dart';
part 'model/types_pager_type.dart';
part 'model/types_restaurant_status.dart';
part 'model/types_table_status.dart';
part 'model/types_tax_type.dart';

ApiClient defaultApiClient = new ApiClient();
