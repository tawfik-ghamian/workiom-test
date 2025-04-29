import 'package:dio/dio.dart';

import '../models/editions/editions_model.dart';
import '../models/password/complexity_settings_model.dart';
import '../models/sign_in/current_sign_in_info_model.dart';
import '../models/sign_in/sign_in_request_model.dart';
import '../models/sign_in/sign_in_response_model.dart';
import '../models/signup/signup_request_model.dart';
import '../models/signup/signup_response_model.dart';
import '../utils/callback.dart';
import '../utils/constants.dart';
import '../utils/dio_client.dart';
import '../utils/set_local_timezone.dart';
import '../utils/shared_prefs.dart';

class AuthRepository {
  Future<SignInResponseModel> signIn({
    required SignInRequestModel requestModel,
  }) async {
    return await callEndpoint<SignInResponseModel>(
      () async {
        final response = await DioClient.getInstance().post(
          ApiConstant.signInUrl,
          data: SignInRequestModel.toJson(requestModel),
        );
        final result =
            SignInResponseModel.fromJson(response.data["result"] ?? {});
        return result;
      },
    );
  }

  Future<SignUpResponseModel> signUp({
    required SignUpRequestModel requestModel,
  }) async {
    return await callEndpoint<SignUpResponseModel>(
      () async {
        final response = await DioClient.getInstance().post(
          ApiConstant.registerTenant,
          data: SignUpRequestModel.toJson(requestModel),
          queryParameters: {
            "timeZone": await setupTimeZone(),
          },
        );
        final result =
            SignUpResponseModel.fromJson(response.data["result"] ?? {});
        return result;
      },
    );
  }

  Future<CurrentSignInInfo> checkAuth() async {
    return await callEndpoint<CurrentSignInInfo>(
      () async {
        final response = await DioClient.getInstance().get(
            ApiConstant.checkAuth,
            options: Options(headers: {
              "Authorization": "Bearer ${await SharedPrefs().getAccessToken()}"
            }));

        final result =
            CurrentSignInInfo.fromJson(response.data["result"] ?? {});
        return result;
      },
    );
  }

  Future<List<EditionModel>> getEditions() async {
    return await callEndpoint<List<EditionModel>>(
      () async {
        final response = await DioClient.getInstance().get(
          ApiConstant.getEditions,
        );
        if (response.data["result"] != null) {
          final result = EditionModel.fromList(
              response.data["result"]["editionsWithFeatures"]);
          return result;
        }
        return EditionModel.fromList([]);
      },
    );
  }

  Future<PassCompSettingsModel> getPassCompSettings() async {
    return await callEndpoint<PassCompSettingsModel>(
      () async {
        final response = await DioClient.getInstance().get(
          ApiConstant.passwordComplexity,
        );
        final result = PassCompSettingsModel.fromJson(
            response.data["result"] != null
                ? response.data["result"]["setting"]
                : {});
        return result;
      },
    );
  }

  Future<int> checkTenantAvailability(String tenantName) async {
    return await callEndpoint<int>(
      () async {
        final response = await DioClient.getInstance().post(
          ApiConstant.checkTenantAvailable,
          data: {
            "tenancyName": tenantName,
          },
        );
        final result = int.tryParse(response.data["result"] != null
                ? response.data["result"]["tenantId"] ?? "-1"
                : "-1") ??
            -1;
        return result;
      },
    );
  }
}
