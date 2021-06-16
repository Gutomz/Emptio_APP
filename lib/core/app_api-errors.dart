import 'package:emptio/core/app_errors.dart';

class AppApiErrors {
  static final Map<String, String> _errors = {
    AppErrors.UNIMPLEMENTED : 'Em desenvolvimento...',
    AppErrors.INTERNAL_SERVER :
        'Oops! Ocorreu um problema! Tente novamente mais tarde.',
    AppErrors.UNAUTHORIZED : 'Você não está autenticado!',
    AppErrors.NOT_ALLOWED : 'Você não tem permissão!',
    AppErrors.USER_NOT_FOUND : 'Usuário não encontrado!',
    AppErrors.FRIENDSHIP_NOT_FOUND : 'Essa amizade não existe!',
    AppErrors.MARKET_NOT_FOUND : 'Mercado não encontrado!',
    AppErrors.PURCHASE_NOT_FOUND : 'Compra não encontrada!',
    AppErrors.PURCHASE_ITEM_NOT_FOUND : 'Item de compra não encontrado!',
    AppErrors.PRODUCT_NOT_FOUND : 'Produto não encontrado!',
    AppErrors.FAVORITE_NOT_FOUND : 'Favorito não encontrado!',
    AppErrors.INVALID_FIELD : 'Os seguintes campos estão inválidos:',
    AppErrors.MISSING_FIELD : 'Os seguintes campos são obrigatórios:',
    AppErrors.UNIQUE_FIELD : 'Os seguintes campos já estão sendo utilizados:',
    AppErrors.DUPLICATED_DOCUMENT : 'Documento duplicado!',
    AppErrors.DUPLICATED_ITEM : 'Este produto já existe na lista de compra!',
    AppErrors.DUPLICATED_FAVORITE :
        'Este produto já está nos seus favoritos Favorito!',
  };

  static final List _fieldErrors = [
    AppErrors.INVALID_FIELD,
    AppErrors.MISSING_FIELD,
    AppErrors.UNIQUE_FIELD,
  ];

  static final Map<String, String> _fields = {
    'email': 'E-mail',
    'name': 'Name',
    'password': 'Senha',
  };

  static _parseFields(List fields) {
    return fields.map((field) => _fields[field]).toString();
  }

  static String handleError(Object error) {
    String description =
        "Oops! Ocorreu um problema! Tente novamente mais tarde.";

    if (error is Map<String, dynamic>) {
      final code = error['code'];
      description = _errors[code]!;

      if (_fieldErrors.contains(code)) {
        List fields = error['fields'];
        description += " ${_parseFields(fields)}.";
      }
    }

    return description;
  }

  static bool isError(Object error) {
    if (error is Map<String, dynamic>) {
      String code = error['code'] ?? "";

      if (code.isNotEmpty) {
        return true;
      }
    }

    return false;
  }

  static String getCode(Object error) {
    String code = "";

    if (error is Map<String, dynamic>) {
      code = error['code'] ?? "";
    }

    return code;
  }
}
