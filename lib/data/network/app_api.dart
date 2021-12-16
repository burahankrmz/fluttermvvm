import 'package:dio/dio.dart';
import 'package:flutteradvancedmvvm/app/constants.dart';
import 'package:flutteradvancedmvvm/data/responses/responses.dart';
import 'package:retrofit/http.dart';

part 'app_api.g.dart';

@RestApi(baseUrl: Constants.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

  @POST("/customers/login")
  Future<AuthenticationResponse> login(
    @Field('email') String email,
    @Field('password') String password,
    @Field('imei') String imei,
    @Field('deviceType') String deviceType,
  );

  @POST("/customers/register")
  Future<AuthenticationResponse> register(
    @Field("name") String name,
    @Field("country_mobile_code") String countryMobileCode,
    @Field("mobile_number") String mobileNumber,
    @Field("email") String email,
    @Field("password") String password,
    @Field("profile_picture") String profilePicture,
  );

  @POST("/customers/forgotPassword")
  Future<ForgotPasswordResponse> forgotPassword(
    @Field("email") String email,
  );

  @GET("/home")
  Future<HomeResponse> getHome();
  @GET("/storeDetails/1")
  Future<StoreDetailsResponse> getStoreDetails();
}
