class InvestmentModel {
  final String? message;
  final InvestmentData? data;
  final String? timestamp;

  InvestmentModel({this.message, this.data, this.timestamp});

  factory InvestmentModel.fromJson(Map<String, dynamic> json) {
    return InvestmentModel(
      message: json['message'],
      data: json['data'] != null ? InvestmentData.fromJson(json['data']) : null,
      timestamp: json['timestamp'],
    );
  }

  Map<String, dynamic> toJson() => {
    'message': message,
    'data': data?.toJson(),
    'timestamp': timestamp,
  };
}

class InvestmentData {
  final int totalCommission;
  final int monthlyCommission;
  final int totalApprovedReferrals;
  final int monthlyApprovedReferrals;
  final int filteredApprovedReferrals;
  final List<InvestmentItem> referrals;
  final Meta? meta;

  InvestmentData({
    required this.totalCommission,
    required this.monthlyCommission,
    required this.totalApprovedReferrals,
    required this.monthlyApprovedReferrals,
    required this.filteredApprovedReferrals,
    required this.referrals,
    this.meta,
  });

  factory InvestmentData.fromJson(Map<String, dynamic> json) {
    return InvestmentData(
      totalCommission: json['total_commission'] ?? 0,
      monthlyCommission: json['monthly_commission'] ?? 0,
      totalApprovedReferrals: json['total_approved_referrals'] ?? 0,
      monthlyApprovedReferrals: json['monthly_approved_referrals'] ?? 0,
      filteredApprovedReferrals: json['filtered_approved_referrals'] ?? 0,
      referrals: (json['referrals'] as List? ?? [])
          .map((e) => InvestmentItem.fromJson(e))
          .toList(),
      meta: json['meta'] != null ? Meta.fromJson(json['meta']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'total_commission': totalCommission,
    'monthly_commission': monthlyCommission,
    'total_approved_referrals': totalApprovedReferrals,
    'monthly_approved_referrals': monthlyApprovedReferrals,
    'filtered_approved_referrals': filteredApprovedReferrals,
    'referrals': referrals.map((e) => e.toJson()).toList(),
    'meta': meta?.toJson(),
  };
}

class InvestmentItem {
  final int? id;
  final int? investorId;
  final int? statusId;
  final String? investmentDate;
  final String? investmentAmount;
  final String? transactionId;
  final Investor? investor;
  final Status? status;

  InvestmentItem({
    this.id,
    this.investorId,
    this.statusId,
    this.investmentDate,
    this.investmentAmount,
    this.transactionId,
    this.investor,
    this.status,
  });

  factory InvestmentItem.fromJson(Map<String, dynamic> json) {
    return InvestmentItem(
      id: json['id'],
      investorId: json['investorId'],
      statusId: json['statusId'],
      investmentDate: json['investmentDate'],
      investmentAmount: json['investmentAmount'],
      transactionId: json['transactionId'],
      investor: json['investor'] != null
          ? Investor.fromJson(json['investor'])
          : null,
      status: json['status'] != null ? Status.fromJson(json['status']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'investorId': investorId,
    'statusId': statusId,
    'investmentDate': investmentDate,
    'investmentAmount': investmentAmount,
    'transactionId': transactionId,
    'investor': investor?.toJson(),
    'status': status?.toJson(),
  };
}

class Meta {
  final int total;
  final int? lastPage;

  Meta({required this.total, this.lastPage});

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(total: json['total'] ?? 0, lastPage: json['last_page']);
  }

  Map<String, dynamic> toJson() => {'total': total, 'last_page': lastPage};
}

class Investor {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? email;

  Investor({this.id, this.firstName, this.lastName, this.email});

  factory Investor.fromJson(Map<String, dynamic> json) {
    return Investor(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'firstName': firstName,
    'lastName': lastName,
    'email': email,
  };
}

class Status {
  final int? id;
  final String? name;
  final String? type;

  Status({this.id, this.name, this.type});

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(id: json['id'], name: json['name'], type: json['type']);
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'type': type};
}
