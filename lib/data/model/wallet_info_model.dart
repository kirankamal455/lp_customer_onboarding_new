import 'dart:convert';

class Walletinfomodel {
  final String walletId;
  final String walletNumber;
  final String walletCardType;
  final String walletAccountType;
  final String currencyOpted;
  final String nameOnWalletCard;
  final int availableBalance;
  final bool isWalletActive;
  final String walletExpiryDate;
  final String createdOn;
  Walletinfomodel({
    required this.walletId,
    required this.walletNumber,
    required this.walletCardType,
    required this.walletAccountType,
    required this.currencyOpted,
    required this.nameOnWalletCard,
    required this.availableBalance,
    required this.isWalletActive,
    required this.walletExpiryDate,
    required this.createdOn,
  });

  Walletinfomodel copyWith({
    String? walletId,
    String? walletNumber,
    String? walletCardType,
    String? walletAccountType,
    String? currencyOpted,
    String? nameOnWalletCard,
    int? availableBalance,
    bool? isWalletActive,
    String? walletExpiryDate,
    String? createdOn,
  }) {
    return Walletinfomodel(
      walletId: walletId ?? this.walletId,
      walletNumber: walletNumber ?? this.walletNumber,
      walletCardType: walletCardType ?? this.walletCardType,
      walletAccountType: walletAccountType ?? this.walletAccountType,
      currencyOpted: currencyOpted ?? this.currencyOpted,
      nameOnWalletCard: nameOnWalletCard ?? this.nameOnWalletCard,
      availableBalance: availableBalance ?? this.availableBalance,
      isWalletActive: isWalletActive ?? this.isWalletActive,
      walletExpiryDate: walletExpiryDate ?? this.walletExpiryDate,
      createdOn: createdOn ?? this.createdOn,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'walletId': walletId,
      'walletNumber': walletNumber,
      'walletCardType': walletCardType,
      'walletAccountType': walletAccountType,
      'currencyOpted': currencyOpted,
      'nameOnWalletCard': nameOnWalletCard,
      'availableBalance': availableBalance,
      'isWalletActive': isWalletActive,
      'walletExpiryDate': walletExpiryDate,
      'createdOn': createdOn,
    };
  }

  factory Walletinfomodel.fromMap(Map<String, dynamic> map) {
    return Walletinfomodel(
      walletId: map['walletId'] as String,
      walletNumber: map['walletNumber'] as String,
      walletCardType: map['walletCardType'] as String,
      walletAccountType: map['walletAccountType'] as String,
      currencyOpted: map['currencyOpted'] as String,
      nameOnWalletCard: map['nameOnWalletCard'] as String,
      availableBalance: map['availableBalance'].toInt() as int,
      isWalletActive: map['isWalletActive'] as bool,
      walletExpiryDate: map['walletExpiryDate'] as String,
      createdOn: map['createdOn'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Walletinfomodel.fromJson(String source) =>
      Walletinfomodel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Walletinfomodel(walletId: $walletId, walletNumber: $walletNumber, walletCardType: $walletCardType, walletAccountType: $walletAccountType, currencyOpted: $currencyOpted, nameOnWalletCard: $nameOnWalletCard, availableBalance: $availableBalance, isWalletActive: $isWalletActive, walletExpiryDate: $walletExpiryDate, createdOn: $createdOn)';
  }

  @override
  bool operator ==(covariant Walletinfomodel other) {
    if (identical(this, other)) return true;

    return other.walletId == walletId &&
        other.walletNumber == walletNumber &&
        other.walletCardType == walletCardType &&
        other.walletAccountType == walletAccountType &&
        other.currencyOpted == currencyOpted &&
        other.nameOnWalletCard == nameOnWalletCard &&
        other.availableBalance == availableBalance &&
        other.isWalletActive == isWalletActive &&
        other.walletExpiryDate == walletExpiryDate &&
        other.createdOn == createdOn;
  }

  @override
  int get hashCode {
    return walletId.hashCode ^
        walletNumber.hashCode ^
        walletCardType.hashCode ^
        walletAccountType.hashCode ^
        currencyOpted.hashCode ^
        nameOnWalletCard.hashCode ^
        availableBalance.hashCode ^
        isWalletActive.hashCode ^
        walletExpiryDate.hashCode ^
        createdOn.hashCode;
  }
}
