  import 'package:json_annotation/json_annotation.dart';

  part 'user_profile.g.dart';
  @JsonSerializable()
  class Profile {
    final int id;
    @JsonKey(name: 'image', defaultValue: "") // Gán giá trị mặc định nếu null
    final String? image;
    final String name;
    final String email;
    final String phone;
    @JsonKey(name: 'gender', defaultValue: "Không xác định",nullable: true)
    final String? gender;
    @JsonKey(name: 'birthday', defaultValue: "Chưa xác định",nullable: true)
    final String? birthday;
    final String type;
    // @JsonKey(name: 'email_verified_at', nullable: true)
    // final String? emailVerifiedAt;
    // @JsonKey(name: 'created_at')
    // final String createdAt;
    // @JsonKey(name: 'updated_at')
    // final String updatedAt;

    Profile({
      required this.id,
      this.image,
      required this.name,
      required this.email,
      required this.phone,
      this.gender,
      this.birthday,
      required this.type,
      // this.emailVerifiedAt,
      // required this.createdAt,
      // required this.updatedAt,
    });

    factory Profile.fromJson(Map<String, dynamic> json) => _$ProfileFromJson(json);

    Map<String, dynamic> toJson() => _$ProfileToJson(this);

    String get imageUrl {
      return image ?? 'Null'; // Trả về 'Null' nếu image là null
    }

    String get birthdayST {
      return birthday ?? 'Chưa xác định'; // Trả về 'Chưa xác định' nếu birthday là null
    }

    String get genderDisplay {
      return gender ?? 'Không xác định'; // Trả về 'Không xác định' nếu gender là null
    }
  }