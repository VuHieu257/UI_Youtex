class BankAccountResponse {
  final String message;
  final List<BankCard> cards;

  BankAccountResponse({
    required this.message,
    required this.cards,
  });

  factory BankAccountResponse.fromJson(Map<String, dynamic> json) {
    return BankAccountResponse(
      message: json['message'] as String,
      cards: (json['cards'] as List)
          .map((card) => BankCard.fromJson(card))
          .toList(),
    );
  }
}

class BankCard {
  final int id;
  final String bank;
  final String number;
  final int isDefault;

  BankCard({
    required this.id,
    required this.bank,
    required this.number,
    required this.isDefault,
  });

  factory BankCard.fromJson(Map<String, dynamic> json) {
    return BankCard(
      id: json['id'] as int,
      bank: json['bank'] as String,
      number: json['number'] as String,
      isDefault: json['is_default'] as int,
    );
  }
}