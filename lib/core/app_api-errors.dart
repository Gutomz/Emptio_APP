class AppApiErrors {
  static final Map<String, String> _errors = {
    'unimplemented_error': 'Em desenvolvimento...',
    'internal_server_error':
        'Oops! Ocorreu um problema! Tente novamente mais tarde.',
    'unauthorized_error': 'Você não está autenticado!',
    'not_allowed_error': 'Você não tem permissão!',
    'user_not_found_error': 'Usuário não encontrado!',
    'friendship_not_found_error': 'Essa amizade não existe!',
    'market_not_found_error': 'Mercado não encontrado!',
    'purchase_not_found_error': 'Compra não encontrada!',
    'purchase_item_not_found_error': 'Item de compra não encontrado!',
    'product_not_found_error': 'Produto não encontrado!',
    'favorite_not_found_error': 'Favorito não encontrado!',
    'invalid_field_error': 'Os seguintes campos estão inválidos:',
    'missing_field_error': 'Os seguintes campos são obrigatórios:',
    'unique_field_error': 'Os seguintes campos já estão sendo utilizados:',
    'duplicated_document_error': 'Documento duplicado!',
    'duplicated_item_error': 'Este produto já existe na lista de compra!',
    'duplicated_favorite_error':
        'Este produto já está nos seus favoritos Favorito!',
  };

  static final List _fieldErrors = [
    'invalid_field_error',
    'missing_field_error',
    'unique_field_error',
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
