// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'dart:convert';

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));

String categoryToJson(Category data) => json.encode(data.toJson());

class Category {
    Category({
        this.id,
        this.name,
        this.slug,
        this.orderNumber,
        this.topCategory,
        this.topChild,
        this.photo,
        this.imagephoto,
        this.mobilePhoto,
        this.checkShow,
        this.parentId,
        this.count,
        this.seoTag,
        this.description,
        this.createdAt,
        this.updatedAt,
        this.status,
    });

    int? id;
    String? name;
    String? slug;
    int? orderNumber;
    int? topCategory;
    int? topChild;
    String? photo;
    String? imagephoto;
    String? mobilePhoto;
    int? checkShow;
    int? parentId;
    int? count;
    dynamic seoTag;
    dynamic description;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? status;

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        orderNumber: json["order_number"],
        topCategory: json["top_category"],
        topChild: json["top_child"],
        photo: json["photo"],
        imagephoto: json["imagephoto"],
        mobilePhoto: json["mobile_photo"],
        checkShow: json["check_show"],
        parentId: json["parent_id"],
        count: json["count"],
        seoTag: json["seo_tag"],
        description: json["description"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "order_number": orderNumber,
        "top_category": topCategory,
        "top_child": topChild,
        "photo": photo,
        "imagephoto": imagephoto,
        "mobile_photo": mobilePhoto,
        "check_show": checkShow,
        "parent_id": parentId,
        "count": count,
        "seo_tag": seoTag,
        "description": description,
        "created_at": createdAt==null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt==null ? null : updatedAt!.toIso8601String(),
        "status": status,
    };
}
