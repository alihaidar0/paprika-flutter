import 'dart:io';

import 'package:async/async.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:paprica/src/models/countries_model.dart';
import 'package:paprica/src/widgets/login_promotion.dart';
import 'package:paprica/translations.dart';
import 'package:paprica/widgets.dart';
import 'package:path/path.dart';
import 'package:swagger/api.dart';

import '../../error_handlers.dart';
import '../../screens.dart';
import '../../utils.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage();

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with AutomaticKeepAliveClientMixin<ProfilePage> {
  /// If _image is not null, that means the user picked an image and needs tp press upload
  File _image;

  BuildContext context;

  String selectedCountry;
  String selectedCity;
  String selectedRegion;
  Map<int, String> countries;
  Map<int, String> cities;
  Map<int, String> regions;

  TextEditingController _nameController;
  TextEditingController _phoneController;
  TextEditingController _userNameController;

  bool shouldBuildCountryTree;
  bool shouldBuildCityTree;
  Future<CountriesTreeModel> futureCountriesTreeModel;

  ValidationMessage _nameValidationResult;
  ValidationMessage _usernameValidationResult;

  String profileImageUrl;

  Future<CustomerProfileDto> futureCustomerProfileDto;
  CustomerProfileDto _customerProfileDto;

  /// Used to indicate that user's region was extracted at initiation time
  bool _regionLookedUp;

  String _profileImageUrl;

  get _isPhoneNumberConfirmed => ApiTypesHelper().isPhoneNumberConfirmed;

  get _showConfirmationStatus =>
      ApiTypesHelper().phoneNumber != null &&
      ApiTypesHelper().phoneNumber != "";

  get dataChanged =>
      _customerProfileDto?.name != _nameController.text ||
      _customerProfileDto?.phoneNumber != _phoneController.text ||
      _customerProfileDto?.userName != _userNameController.text ||
      (_regionLookedUp &&
          _customerProfileDto?.regionId != _getRegionId(selectedRegion));

  get dataNotChanged => !dataChanged;

  Widget _userImageWidget(BuildContext context) {
    ImageProvider provider;
    if (_image != null) {
      provider = FileImage(_image);
    } else if (_profileImageUrl != null) {
      provider = CachedNetworkImageProvider(_profileImageUrl);
    } else {
      provider = AssetImage("assets/icons/avatar_female.png");
    }
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return FullscreenPhoto(provider: provider);
            });
      },
      child: CircleAvatar(
        radius: 39,
        backgroundColor: Colors.white,
        backgroundImage: provider,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _regionLookedUp = false;
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _userNameController = TextEditingController();
    _nameValidationResult = ValidationMessage(isValid: true);
    _usernameValidationResult = ValidationMessage(isValid: true);

    _nameController.addListener(() {
      setState(() {});
    });
    _phoneController.addListener(() {
      setState(() {});
    });
    _userNameController.addListener(() {
      setState(() {});
    });
    countries = Map();
    shouldBuildCountryTree = true;
    shouldBuildCityTree = true;
    futureCountriesTreeModel = ApiTypesHelper().getCountries();
    if (ApiTypesHelper().isAuthorized) _getProfile(context);
  }

  int _getRegionId(String selectedRegion) {
    if (selectedRegion == null || regions == null) return null;
    return regions.keys.firstWhere((key) => regions[key] == selectedRegion);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    this.context = context;
    if (ApiTypesHelper().isAuthorized) {
      // Update phone number in case the profile page had already been mounted
      // but the phone number has changed outside the profile page
      if (_customerProfileDto != null &&
          ApiTypesHelper().phoneNumber != _customerProfileDto.phoneNumber) {
        setState(() {
          _phoneController.text = ApiTypesHelper().phoneNumber;
          _customerProfileDto.phoneNumber = ApiTypesHelper().phoneNumber;
        });
      }

      return _renderProfile(context);
    } else {
      return Scaffold(
          body: LogInPromotion(loginLine: S.of(context).loginPromotionProfile));
    }
  }

  Widget _renderProfile(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).profile, style: TextStyle(fontSize: 18)),
      ),
      body: Container(
        color: Color(0xFFF2F2F2),
        child: FutureBuilder<CustomerProfileDto>(
            future: futureCustomerProfileDto,
            builder: (context, userDataSnapshot) {
              if (userDataSnapshot.hasData) {
                return Scaffold(
                    body: ScrollConfiguration(
                      behavior: NoGlowScrollBehaviour(),
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: 180,
                              child: Stack(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                          height: 140,
                                          child: Image.asset(
                                            "assets/images/background.png",
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Positioned(
                                    top: 100,
                                    left: 0,
                                    right: 0,
                                    child: CircleAvatar(
                                        radius: 40,
                                        backgroundColor: Colors.black12,
                                        child: _userImageWidget(context)),
                                  ),
                                  Positioned(
                                    top: 152,
                                    left: 60,
                                    right: 0,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        /// Edit profile picture
                                        GestureDetector(
                                          onTap: () =>
                                              _onTapChangeProfile(context),
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(42)),
                                            color:
                                                Theme.of(context).primaryColor,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: SizedBox(
                                                  child: Icon(
                                                Icons.edit,
                                                size: 16,
                                                color: Colors.white,
                                              )),
                                            ),
                                          ),
                                        ),

                                        /// Upload new profile picture
                                        _image != null
                                            ? GestureDetector(
                                                onTap: () =>
                                                    _onTapUploadImage(context),
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              42)),
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: SizedBox(
                                                        child: Icon(
                                                      Icons.check,
                                                      size: 16,
                                                      color: Colors.white,
                                                    )),
                                                  ),
                                                ),
                                              )
                                            : Container(),

                                        /// Cancel update profile image
                                        _image != null
                                            ? GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    _image = null;
                                                  });
                                                },
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              42)),
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            4.0),
                                                    child: SizedBox(
                                                        child: Icon(
                                                      Icons.close,
                                                      size: 16,
                                                      color: Colors.white,
                                                    )),
                                                  ),
                                                ),
                                              )
                                            : Container()
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),

                            /// Location Settings
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 24),
                              child: FutureBuilder(
                                  future: futureCountriesTreeModel,
                                  builder: (context, countriesSnapshot) {
                                    if (countriesSnapshot.hasData) {
                                      if (false == _regionLookedUp) {
                                        _lookUpRegion(countriesSnapshot.data,
                                            userDataSnapshot.data.regionId);
                                        _regionLookedUp = true;
                                      }
                                      if ((countries == null &&
                                              cities == null &&
                                              regions == null) ||
                                          (shouldBuildCountryTree ||
                                              shouldBuildCityTree)) {
                                        _invalidateCountries(
                                            countriesSnapshot.data);
                                      }
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            S.of(context).yourName,
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Color(0xFF747373)),
                                          ),
                                          SizedBox(height: 3),
                                          TextFormField(
                                            controller: _nameController,
                                            style: TextStyle(fontSize: 14),
                                            decoration: InputDecoration(
                                                filled: true,
                                                fillColor: Colors.white,
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 6,
                                                        vertical: 8),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.white)),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color(0xFFaa757f)),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          const Radius.circular(
                                                              3.0)),
                                                ),
                                                errorText: _nameValidationResult
                                                        .isValid
                                                    ? null
                                                    : _nameValidationResult
                                                        .message),
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            S.of(context).phoneNumber,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Color(0xFF747373),
                                            ),
                                          ),
                                          SizedBox(height: 3),
                                          Container(
                                            child: Stack(
                                              alignment: Localizations.localeOf(
                                                              context)
                                                          .languageCode ==
                                                      "en"
                                                  ? Alignment.centerRight
                                                  : Alignment.centerLeft,
                                              children: <Widget>[
                                                TextFormField(
                                                  controller: _phoneController,
                                                  style:
                                                      TextStyle(fontSize: 14),
                                                  keyboardType:
                                                      TextInputType.phone,
                                                  textDirection:
                                                      TextDirection.ltr,
                                                  textAlign: Localizations
                                                                  .localeOf(
                                                                      context)
                                                              .languageCode ==
                                                          "en"
                                                      ? TextAlign.left
                                                      : TextAlign.right,
                                                  decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor: Colors.white,
                                                    contentPadding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 6,
                                                            vertical: 8),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .white)),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Color(
                                                              0xFFaa757f)),
                                                      borderRadius:
                                                          const BorderRadius
                                                                  .all(
                                                              const Radius
                                                                      .circular(
                                                                  3.0)),
                                                    ),
                                                  ),
                                                ),
                                                true == _showConfirmationStatus
                                                    ? false ==
                                                            _isPhoneNumberConfirmed
                                                        ? GestureDetector(
                                                            child: Padding(
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      10),
                                                              child: Icon(Icons
                                                                  .warning),
                                                            ),
                                                            onTap: () {
                                                              _handleConfirmPhoneNumber(
                                                                  context);
                                                            },
                                                          )
                                                        : GestureDetector(
                                                            child: Padding(
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  horizontal:
                                                                      10),
                                                              child: Icon(
                                                                  Icons.check),
                                                            ),
                                                            onTap: () {
                                                              PapricaToast.showToast(
                                                                  S
                                                                      .of(
                                                                          context)
                                                                      .phoneNumberIsConfirmed,
                                                                  ToastType
                                                                      .Normal);
                                                            },
                                                          )
                                                    : EmptyWidget()
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            S.of(context).username,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Color(0xFF747373),
                                            ),
                                          ),
                                          SizedBox(height: 3),
                                          TextFormField(
                                            controller: _userNameController,
                                            style: TextStyle(fontSize: 14),
                                            decoration: InputDecoration(
                                                filled: true,
                                                fillColor: Colors.white,
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        horizontal: 6,
                                                        vertical: 8),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: Colors
                                                                .white)),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color(0xFFaa757f)),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          const Radius.circular(
                                                              3.0)),
                                                ),
                                                errorText:
                                                    _usernameValidationResult
                                                            .isValid
                                                        ? null
                                                        : _usernameValidationResult
                                                            .message),
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            S.of(context).country,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Color(0xFF747373),
                                            ),
                                          ),
                                          SizedBox(height: 3),
                                          GestureDetector(
                                            onTap: () {
                                              _showCountryPicker(context);
                                            },
                                            child: Row(
                                              children: <Widget>[
                                                Expanded(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              3),
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 8,
                                                          vertical: 12),
                                                      child: Text(selectedCountry ??
                                                          "-- " +
                                                              S
                                                                  .of(context)
                                                                  .selectCountry),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Color(0xFF707070),
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        3),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        3))),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 6),
                                                      child: Icon(
                                                        Icons
                                                            .keyboard_arrow_down,
                                                        color: Colors.white,
                                                      ),
                                                    ))
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            S.of(context).city,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Color(0xFF747373),
                                            ),
                                          ),
                                          SizedBox(height: 3),
                                          GestureDetector(
                                            onTap: () {
                                              _showCityPicker(context);
                                            },
                                            child: Row(
                                              children: <Widget>[
                                                Expanded(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              3),
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 8,
                                                          vertical: 12),
                                                      child: Text(selectedCity ??
                                                          "-- " +
                                                              S
                                                                  .of(context)
                                                                  .selectCity),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Color(0xFF707070),
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        3),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        3))),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 6),
                                                      child: Icon(
                                                        Icons
                                                            .keyboard_arrow_down,
                                                        color: Colors.white,
                                                      ),
                                                    ))
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            S.of(context).region,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Color(0xFF747373),
                                            ),
                                          ),
                                          SizedBox(height: 3),
                                          GestureDetector(
                                            onTap: () {
                                              _showRegionPicker(context);
                                            },
                                            child: Row(
                                              children: <Widget>[
                                                Expanded(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              3),
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 8,
                                                          vertical: 12),
                                                      child: Text(selectedRegion ??
                                                          "-- " +
                                                              S
                                                                  .of(context)
                                                                  .selectRegion),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Color(0xFF707070),
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        3),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        3))),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 6),
                                                      child: Icon(
                                                        Icons
                                                            .keyboard_arrow_down,
                                                        color: Colors.white,
                                                      ),
                                                    ))
                                              ],
                                            ),
                                          ),
                                          userDataSnapshot.data.isExternalUser
                                              ? Container()
                                              : GestureDetector(
                                                  behavior:
                                                      HitTestBehavior.opaque,
                                                  onTap: () {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                      return ChangePasswordScreen();
                                                    }));
                                                  },
                                                  child: Center(
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 16),
                                                      child: Text(
                                                        S
                                                            .of(context)
                                                            .changePassword,
                                                        style: TextStyle(
                                                            color: Theme.of(
                                                                    context)
                                                                .primaryColor,
                                                            decoration:
                                                                TextDecoration
                                                                    .underline),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                          Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                0, 60, 0, 0),
                                            child: EmptyWidget(),
                                          )
                                        ],
                                      );
                                    } else if (countriesSnapshot.hasError) {
                                      return Text(S.of(context).errorUnknown);
                                    }
                                    return SpinKitThreeBounce(
                                      color: Theme.of(context).primaryColor,
                                      size: 24,
                                    );
                                  }),
                            )
                          ],
                        ),
                      ),
                    ),
                    floatingActionButton: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CustomizedActiveButton(
                          title: S.of(context).save,
                          onPressed: dataNotChanged
                              ? null
                              : () => _updateProfile(context),
                        ),
                      ],
                    ),
                    floatingActionButtonLocation:
                        FloatingActionButtonLocation.centerFloat);
              }
              return Center(child: CircularProgressIndicator());
            }),
      ),
    );
  }

  void _updateProfile(BuildContext context,
      {FileDto profileImageUrl, isExtraRequest = false}) {
    _nameValidationResult = ValidationMessage(
        isValid: _nameController.text.isNotEmpty,
        message: S.of(context).errorEmptyField);

    _usernameValidationResult = ValidationMessage(
        isValid: _userNameController.text.isNotEmpty,
        message: S.of(context).errorEmptyField);

    if (_nameValidationResult.isValid) {
      ApiClient client = PapricaApiClient();
      CustomerApi api = CustomerApi(client);
      ProgressDialog dialog = ProgressDialog(context);
      dialog.setMessage(S.of(context).processing);
      UpdateCustomerProfileDto data = UpdateCustomerProfileDto.fromJson({
        'name': _nameController.text,
        'phoneNumber':
            _phoneController.text.isEmpty ? null : _phoneController.text,
        'regionId': _getRegionId(selectedRegion),
        'userName': _userNameController.text,
        'profileImage':
            profileImageUrl?.name ?? _profileImageUrl?.split('/')?.last,
      });
      if (!isExtraRequest) dialog.show();
      api.apiServicesAppCustomerUpdateProfilePost(input: data).then((_) {
        dialog.hide();

        // Save new state based on new values
        setState(() {
          _image = null;
          if (profileImageUrl != null) {
            _profileImageUrl = profileImageUrl.fileURL;
          }

          // Change phone number confirmation state if its value has been changed
          if (data.phoneNumber != _customerProfileDto.phoneNumber) {
            ApiTypesHelper().setIsPhoneNumberConfirmed(false);
            ApiTypesHelper().setPhoneNumber(data.phoneNumber);
          }

          _customerProfileDto.name = data.name;
          _customerProfileDto.phoneNumber = data.phoneNumber;
          _customerProfileDto.userName = data.userName;
          _customerProfileDto.regionId = data.regionId;
          _customerProfileDto.profileImage = data.profileImage;
        });

        // Dismiss keyboard
        FocusScope.of(context).requestFocus(FocusNode());

        PapricaToast.showToast(S.of(context).successUpdateProfile);
      }).catchError((err) {
        dialog.hide();
        DefaultErrorHandler.handle(context, err);
      });
    }

    // to show validation error messages
    setState(() {});
  }

  void _getProfile(BuildContext context) {
    ApiClient client = PapricaApiClient();
    CustomerApi api = CustomerApi(client);
    setState(() {
      futureCustomerProfileDto = api.apiServicesAppCustomerGetProfileGet();
    });
    futureCustomerProfileDto.then((data) {
      if (mounted)
        setState(() {
          _customerProfileDto = data;
          if (data.name != null) {
            _nameController.text = data.name;
          }
          if (data.phoneNumber != null) {
            _phoneController.text = data.phoneNumber;
          }
          if (data.userName != null) {
            _userNameController.text = data.userName;
          }
          if (data.profileImage != null && data.profileImage.isNotEmpty) {
            _profileImageUrl = data.profileImage;
          }
        });
    }).catchError((err) {
      DefaultErrorHandler.handle(context, err);
    });
  }

  void _onTapChangeProfile(BuildContext context) async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (image != null) _image = image;
    });
  }

  _onTapUploadImage(BuildContext context) async {
    if (_image == null) return;
    ApiClient client = PapricaApiClient();
    var stream = http.ByteStream(DelegatingStream.typed(_image.openRead()));
    var length = await _image.length();
    var multipartFile = http.MultipartFile('file', stream, length,
        filename: basename(_image.path));
    UploadApi api = UploadApi(client);
    ProgressDialog dialog = ProgressDialog(context);
    dialog.setMessage(S.of(context).changingImage);
    dialog.show();
    api.apiServicesAppUploadUploadImagePost(multipartFile).then((result) {
      dialog.hide();
      _updateProfile(context, profileImageUrl: result, isExtraRequest: true);
    }).catchError((err) {
      dialog.hide();
      DefaultErrorHandler.handle(context, err);
    });
  }

  void _showCountryPicker(BuildContext context) {
    if (countries == null || countries.length == 0) return;
    Picker(
        adapter: PickerDataAdapter(pickerdata: countries.values.toList()),
        hideHeader: true,
        looping: countries.values.length > 10,
        itemExtent: 50,
        title: Text(S.of(context).selectCountry),
        cancelText: S.of(context).cancel,
        confirmText: S.of(context).ok,
        onSelect: (Picker picker, int i, List<int> list) {},
        onConfirm: (Picker picker, List value) {
          setState(() {
            selectedCountry = picker.getSelectedValues()[0];
          });
        }).showDialog(context);

    // Dismiss keyboard
    FocusScope.of(context).requestFocus(FocusNode());
  }

  void _showCityPicker(BuildContext context) {
    if (cities == null || cities.length == 0) return;
    Picker(
        adapter: PickerDataAdapter(pickerdata: cities.values.toList()),
        hideHeader: true,
        looping: cities.values.length > 10,
        itemExtent: 50,
        title: Text(S.of(context).selectCity),
        cancelText: S.of(context).cancel,
        confirmText: S.of(context).ok,
        onSelect: (Picker picker, int i, List<int> list) {},
        onConfirm: (Picker picker, List value) {
          setState(() {
            selectedCity = picker.getSelectedValues()[0];
          });
        }).showDialog(context);

    // Dismiss keyboard
    FocusScope.of(context).requestFocus(FocusNode());
  }

  void _showRegionPicker(BuildContext context) {
    if (regions == null || regions.length == 0) return;
    Picker(
        adapter: PickerDataAdapter(pickerdata: regions.values.toList()),
        hideHeader: true,
        looping: regions.values.length > 10,
        itemExtent: 50,
        title: Text(S.of(context).selectRegion),
        cancelText: S.of(context).cancel,
        confirmText: S.of(context).ok,
        onSelect: (Picker picker, int i, List<int> list) {},
        onConfirm: (Picker picker, List value) {
          setState(() {
            selectedRegion = picker.getSelectedValues()[0];
          });
        }).showDialog(context);

    // Dismiss keyboard
    FocusScope.of(context).requestFocus(FocusNode());
  }

  void _invalidateCountries(CountriesTreeModel countriesTree) {
    countriesTree.countries?.forEach((country) {
      countries[country.id] = country.name;
    });
    if (selectedCountry != null && shouldBuildCountryTree) {
      cities = Map();
      countriesTree.countries
          .where((country) => country.name == selectedCountry)
          .first
          .cities
          .forEach((city) {
        cities[city.id] = city.name;
      });
    }
    if (selectedCity != null && shouldBuildCityTree) {
      regions = Map();
      countriesTree.countries
          .where((country) => country.name == selectedCountry)
          .first
          .cities
          .where((city) => city.name == selectedCity)
          .first
          .regions
          .forEach((region) {
        regions[region.id] = region.name;
      });
    }
  }

  void _lookUpRegion(CountriesTreeModel countriesTree, int regionId) {
    if (countriesTree == null) return;
    if (regionId == null) return;
    countriesTree.countries.forEach((country) {
      country.cities.forEach((city) {
        city.regions.forEach((region) {
          if (region.id == regionId) {
            selectedCountry = country.name;
            selectedCity = city.name;
            selectedRegion = region.name;
            return;
          }
        });
      });
    });
  }

  void _handleConfirmPhoneNumber(BuildContext context) {
    showDialog(
        context: context,
        builder: (_context) {
          return PapricaSimpleDialog(
            title: S.of(context).phoneNumberConfirmationNeeded,
            yesButton: FlatButton(
                onPressed: () {
                  Navigator.of(_context).pop();
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return ConfirmPhoneNumberScreen();
                  })).then((confirmed) {
                    if (confirmed != null && confirmed) {
                      ApiTypesHelper().setIsPhoneNumberConfirmed(true);
                    }
                  });
                },
                child: Text(S.of(context).ok)),
          );
        });
  }
}
