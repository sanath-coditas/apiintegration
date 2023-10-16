class CarModel {
  int? carId;
  String? rcNumber;
  int? capacity;
  String? model;
  String? remark;
  int? isActive;
  int? createdBy;
  List<Attachment>? attachments;

  CarModel({
    this.carId,
    this.rcNumber,
    this.capacity,
    this.model,
    this.remark,
    this.isActive,
    this.createdBy,
    this.attachments,
  });

  factory CarModel.fromJson(Map<String, dynamic> json) {
    var attachmentsList = json['attachments'] as List?;
    List<Attachment> attachmentList =
        attachmentsList?.map((i) => Attachment.fromJson(i)).toList() ?? [];

    return CarModel(
      carId: json['car_id'],
      rcNumber: json['rc_number'],
      capacity: json['capacity'],
      model: json['model'],
      remark: json['remark'],
      isActive: json['is_active'],
      createdBy: json['created_by'],
      attachments: attachmentList,
    );
  }
}

class Attachment {
  String? attachmentType;
  List<AttachmentUrl>? attachmentUrl;

  Attachment({
    this.attachmentType,
    this.attachmentUrl,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) {
    var attachmentUrlList = json['attachment_url'] as List;
    List<AttachmentUrl> urlList =
        attachmentUrlList.map((i) => AttachmentUrl.fromJson(i)).toList();

    return Attachment(
      attachmentType: json['attachment_type'],
      attachmentUrl: urlList,
    );
  }
}

class AttachmentUrl {
  int? id;
  String? url;

  AttachmentUrl({
    this.id,
    this.url,
  });

  factory AttachmentUrl.fromJson(Map<String, dynamic> json) {
    return AttachmentUrl(
      id: json['id'],
      url: json['url'],
    );
  }
}
