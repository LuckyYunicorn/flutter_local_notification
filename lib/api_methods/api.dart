import 'dart:convert';
import 'package:flutter_notification/model/posts_model.dart';
import 'package:http/http.dart' as http;

class ApiMethod {
  Future<InvestmentModel?> getPosts({required http.Client client}) async {
    try {
      http.Response response = await client.get(
        Uri.parse("https://api.pixy.club/api/v1/investments/my-referrals"),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization":
              "Bearer oat_MTI4MA.Z3VXQldMTzM2bE1sOU1ERGxOVGxlb21HdXFfU195dVZBZ1NzQ1VDcTM5MzE0Njk2NjA",
        },
      );
      // print(response.statusCode);
      if (response.statusCode == 200) {
        // print(jsonDecode(response.body));
        InvestmentModel investmentModel = InvestmentModel.fromJson(
          jsonDecode(response.body),
        );
        return investmentModel;
      } else {
        // print("Failed to load posts");
        return null;
      }
    } catch (e) {
      // print(e);
      return null;
    }
  }
}
