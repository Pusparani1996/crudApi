import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:testone/model/department_model.dart';
import 'package:testone/model/designationmodel.dart';
import 'package:testone/model/login_model.dart';

import '../model/employeemodel.dart';

class ApiService {
  Future<List<EmployeeModel>> getEmoloyeeModel(
    String token,
  ) async {
    final response = await http.get(
      Uri.parse(
          "http://phpstack-598410-2859373.cloudwaysapps.com/api/employees"),
      headers: {
        "Authorization": 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<EmployeeModel> emp =
          body.map((dynamic item) => EmployeeModel.fromJson(item)).toList();
      return emp;
    } else {
      throw "Failed to load employee list";
    }
  }

  Future<List<EmployeeModel>?> deleteEmployeeModel({
    required String id,
    required String token,
  }) async {
    final response = await http.delete(
      Uri.parse(
          "http://phpstack-598410-2859373.cloudwaysapps.com/api/employees/$id"),
      headers: {
        "Authorization": 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      log("success");
    } else {
      log(response.statusCode.toString());
      throw "Failed to delete employee ";
    }
  }

  Future postEmoloyeeModel({
    //required int id,
    required String name,
    required String deptid,
    required String designid,
    required String dob,
    required String token,
    required String geoLocation,
    required String image,
  }) async {
    var imgtime = DateTime.now().millisecondsSinceEpoch;
    final prefs = await SharedPreferences.getInstance();
    String imgfilename = '$imgtime.jpg';
    final response = await http.MultipartRequest(
        "POST",
        Uri.parse(
            "http://phpstack-598410-2859373.cloudwaysapps.com/api/employees"));
    response.fields["name"] = name;
    response.fields["department_id"] = deptid;
    response.fields["designation_id"] = designid;
    response.fields["date_of_birth"] = dob;
    response.fields["geo_location"] = geoLocation;
    response.files.add(http.MultipartFile.fromBytes(
        "image", File(image).readAsBytesSync(),
        filename: imgfilename));

    response.headers["Authorization"] = 'Bearer $token';
    var request = await response.send();

    if (request.statusCode == 201) {
      log("Create successesfully");
    } else {
      log(request.statusCode.toString());
      throw "Failed to create new employee ";
    }
  }

  Future<List<EmployeeModel>> updateEmployeeModel({
    required String id,
    required String name,
    required String deptid,
    required String designid,
    required String dob,
    required String token,
  }) async {
    final response = await http.patch(
        Uri.parse(
            "http://phpstack-598410-2859373.cloudwaysapps.com/api/employees/$id"),
        // headers: {
        //   "Authorization": 'Bearer $token',
        // },
        body: {
          'name': name,
          "department_id": deptid,
          "designation_id": designid,
          "date_of_birth": dob,
        });

    if (response.statusCode == 200 || response.statusCode == 201) {
      List<dynamic> body = jsonDecode(response.body);
      List<EmployeeModel> emp =
          body.map((dynamic item) => EmployeeModel.fromJson(item)).toList();
      return emp;
    } else {
      log(response.statusCode.toString());
      throw "Failed to create new employee ";
    }
  }

  //CRUD operation Model for Department

  Future<List<DepartmentModel>> getDepartmentModel(
    String token,
  ) async {
    final response = await http.get(
      Uri.parse(
          "http://phpstack-598410-2859373.cloudwaysapps.com/api/departments"),
      headers: {
        "Authorization": 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<DepartmentModel> dept =
          body.map((dynamic item) => DepartmentModel.fromJson(item)).toList();
      return dept;
    } else {
      throw "Failed to get departmentdata";
    }
  }

  Future<List<DepartmentModel>> postDepartmentModl(
      {required String deptid,
      required String deptname,
      required String token}) async {
    final response = await http.post(
        Uri.parse(
            "http://phpstack-598410-2859373.cloudwaysapps.com/api/departments"),
        headers: {
          "Authorization": 'Bearer $token',
        },
        body: {
          "department_id": deptid,
          'name': deptname,
        });

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<DepartmentModel> dept =
          body.map((dynamic item) => DepartmentModel.fromJson(item)).toList();
      return dept;
    } else {
      log(response.statusCode.toString());
      throw "Failed to get departmentdata";
    }
  }

  Future<List<DepartmentModel>> deleteDepartmentModel({
    required String id,
    required String token,
  }) async {
    final response = await http.delete(
        Uri.parse(
            "http://phpstack-598410-2859373.cloudwaysapps.com/api/departments/$id"),
        headers: {
          "Authorization": 'Bearer $token',
        },
        body: {
          "department_id": id,
        });

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<DepartmentModel> dept =
          body.map((dynamic item) => DepartmentModel.fromJson(item)).toList();
      return dept;
    } else {
      log(response.statusCode.toString());
      throw "Failed to delete departmentdata";
    }
  }

  Future<List<DepartmentModel>> updateDepartmentModel({
    required String id,
    required String name,
    required String token,
  }) async {
    final response = await http.put(
        Uri.parse(
            "http://phpstack-598410-2859373.cloudwaysapps.com/api/departments/$id"),
        headers: {
          "Authorization": 'Bearer $token',
        },
        body: {
          //"department_id": id,
          "name": name,
        });

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<DepartmentModel> dept =
          body.map((dynamic item) => DepartmentModel.fromJson(item)).toList();
      return dept;
    } else {
      log(response.statusCode.toString());
      throw "Failed to delete departmentdata";
    }
  }

  Future<List<DesignationModel>> getDesignationModel(
    String token,
  ) async {
    final response = await http.get(
      Uri.parse(
          "http://phpstack-598410-2859373.cloudwaysapps.com/api/designations"),
      headers: {
        "Authorization": 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<DesignationModel> design =
          body.map((dynamic item) => DesignationModel.fromJson(item)).toList();
      return design;
    } else {
      throw "Failed to get designation";
    }
  }

  Future<List<DesignationModel>> postDesignationModel(
      {required String designid,
      required String designname,
      required String token}) async {
    final response = await http.post(
        Uri.parse(
            "http://phpstack-598410-2859373.cloudwaysapps.com/api/designations"),
        headers: {
          "Authorization": 'Bearer $token',
        },
        body: {
          "designation_id": designid,
          'name': designname,
        });

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<DesignationModel> design =
          body.map((dynamic item) => DesignationModel.fromJson(item)).toList();
      return design;
    } else {
      throw "Failed to get designation";
    }
  }

  Future<List<DesignationModel>> deleteDesignationModel({
    required String id,
    required String token,
  }) async {
    final response = await http.delete(
        Uri.parse(
            "http://phpstack-598410-2859373.cloudwaysapps.com/api/designations/$id"),
        headers: {
          "Authorization": 'Bearer $token',
        },
        body: {
          "designation_id": id,
        });

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<DesignationModel> design =
          body.map((dynamic item) => DesignationModel.fromJson(item)).toList();
      return design;
    } else {
      throw "Failed to delete designation";
    }
  }

  Future<List<DesignationModel>> updateDesignationModel({
    required String id,
    required String name,
    required String token,
  }) async {
    final response = await http.put(
        Uri.parse(
            "http://phpstack-598410-2859373.cloudwaysapps.com/api/designations/$id"),
        headers: {
          "Authorization": 'Bearer $token',
        },
        body: {
          "name": name,
        });

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<DesignationModel> design =
          body.map((dynamic item) => DesignationModel.fromJson(item)).toList();
      return design;
    } else {
      throw "Failed to get designation";
    }
  }

  //LOG_IN
  Future postLogInModel({
    required String username,
    required String password,
  }) async {
    log(username);
    log(password);
    final prefs = await SharedPreferences.getInstance();
    final data = {"username": username, "password": password};
    final response = await http.post(
        Uri.parse("http://phpstack-598410-2859373.cloudwaysapps.com/api/login"),
        body: jsonEncode(data));
    final data1 = jsonDecode(response.body);

    prefs.setInt('response', response.statusCode);
    //return response.statusCode;
    if (response.statusCode == 200) {
      final token = LogInModel.fromJson(data1);
      prefs.setString('token', token.token);

      log(response.statusCode.toString());
    } else {
      log(response.statusCode.toString());
      throw "Fail ";
    }
  }
}
