import 'package:emptio/core/app_errors.dart';

class AppApiErrors {
  static final Map<String, String> _errors = {
    AppErrors.unimplemented: 'Em desenvolvimento...',
    AppErrors.internalServer:
        'Oops! Ocorreu um problema! Tente novamente mais tarde.',
    AppErrors.unauthorized: 'Você não está autenticado!',
    AppErrors.notAllowed: 'Você não tem permissão!',
    AppErrors.userNotFound: 'Usuário não encontrado!',
    AppErrors.friendshipNotFound: 'Essa amizade não existe!',
    AppErrors.marketNotFound: 'Mercado não encontrado!',
    AppErrors.purchaseNotFound: 'Compra não encontrada!',
    AppErrors.purchaseItemNotFound: 'Item de compra não encontrado!',
    AppErrors.productNotFound: 'Produto não encontrado!',
    AppErrors.favoriteNotFound: 'Favorito não encontrado!',
    AppErrors.productMarketNotFound:
        'Relação produto e mercado não encontrada!',
    AppErrors.postNotFound: 'Publicação não encontrada!',
    AppErrors.invalidField: 'Os seguintes campos estão inválidos:',
    AppErrors.missingField: 'Os seguintes campos são obrigatórios:',
    AppErrors.uniqueField: 'Os seguintes campos já estão sendo utilizados:',
    AppErrors.duplicatedDocument: 'Documento duplicado!',
    AppErrors.duplicatedItem: 'Este produto já existe na lista de compra!',
    AppErrors.duplicatedFavorite:
        'Este produto já está nos seus favoritos Favorito!',
  };

  static final List _fieldErrors = [
    AppErrors.invalidField,
    AppErrors.missingField,
    AppErrors.uniqueField,
  ];

  static final Map<String, String> _fields = {
    'email': 'E-mail',
    'name': 'Name',
    'password': 'Senha',
  };

  static String? getMessage(String code) {
    return _errors[code];
  }

  static String _parseFields(List fields) {
    return fields.map((field) => _fields[field]).toString();
  }

  static String handleError(Object error) {
    String description =
        "Oops! Ocorreu um problema! Tente novamente mais tarde.";

    final code = getCode(error);
    if (code.isNotEmpty) {
      description = _errors[code] ?? description;

      if (_fieldErrors.contains(code)) {
        final List<dynamic> fields =
            (error as Map<String, dynamic>)['fields'] as List<dynamic>;
        description += " ${_parseFields(fields)}.";
      }
    }

    return description;
  }

  static bool isError(Object error) {
    final String code = getCode(error);
    return code.isNotEmpty;
  }

  static String getCode(Object error) {
    String code = "";

    if (error is Map<String, dynamic>) {
      code = error['code'] as String? ?? "";
    }

    return code;
  }
}
