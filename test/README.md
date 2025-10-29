# Testes do Flutter BLoC Infinite List

Este projeto contém uma cobertura completa de testes unitários e de integração para uma aplicação Flutter que implementa uma lista infinita usando o padrão BLoC.

## Estrutura de Testes

### Testes Unitários

#### Models (`test/posts/models/`)
- **post_test.dart**: Testa o modelo `Post`
  - Igualdade de valores
  - Propriedades corretas
  - Diferenciação de posts

#### BLoC (`test/posts/bloc/`)
- **post_event_test.dart**: Testa eventos do PostBloc
  - Igualdade de eventos
  - Propriedades dos eventos

- **post_state_test.dart**: Testa estados do PostBloc
  - Igualdade de estados
  - Método `copyWith`
  - Método `toString`
  - Propriedades dos estados

- **post_bloc_test.dart**: Testa a lógica do PostBloc
  - Estado inicial
  - Carregamento de posts
  - Throttling de eventos
  - Tratamento de erros
  - Carregamento de mais posts
  - Limite máximo alcançado

#### Widgets (`test/posts/widgets/`)
- **post_list_item_test.dart**: Testa o widget de item da lista
  - Renderização correta
  - Exibição de id, título e corpo

- **bottom_loader_test.dart**: Testa o widget de carregamento
  - Renderização do indicador de progresso
  - Tamanho correto
  - Largura do traço

#### Views (`test/posts/view/`)
- **posts_page_test.dart**: Testa a página principal
  - Renderização correta
  - Tipo de widget

- **posts_list_test.dart**: Testa a lista de posts
  - Estado inicial (loading)
  - Estado de erro
  - Lista de posts com sucesso
  - Bottom loader quando não atingiu o máximo
  - Sem bottom loader quando atingiu o máximo
  - Anexo do scroll controller
  - Dispose do scroll controller

#### App (`test/`)
- **app_test.dart**: Testa o app principal
  - Renderização da PostsPage
  - Tipo MaterialApp

### Testes de Integração

#### integration_test/
- **app_test.dart**: Testes end-to-end
  - Carregamento inicial do app
  - Exibição de posts
  - Scroll infinito (carregamento de mais posts)
  - Exibição correta de informações dos posts
  - Scroll através de múltiplos posts

## Executando os Testes

### Todos os testes unitários
```bash
flutter test
```

### Teste específico
```bash
flutter test test/posts/bloc/post_bloc_test.dart
```

### Testes de integração
```bash
flutter test integration_test/app_test.dart
```

## Dependências de Teste

- **flutter_test**: Framework de testes do Flutter
- **bloc_test**: Utilitários para testar BLoCs
- **mocktail**: Framework de mocking
- **integration_test**: Testes de integração do Flutter

## Cobertura de Código

Para gerar relatório de cobertura:

```bash
flutter test --coverage
```

Para visualizar a cobertura:
```bash
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

## Boas Práticas Implementadas

1. **Arrange-Act-Assert**: Estrutura clara de testes
2. **Isolamento**: Cada teste é independente
3. **Mocking**: Uso de mocks para dependências externas (HTTP client)
4. **Nomenclatura Clara**: Nomes descritivos para os testes
5. **Setup e Teardown**: Configuração adequada antes/depois dos testes
6. **Testes de Widget**: Validação da UI
7. **Testes de BLoC**: Validação da lógica de negócio
8. **Testes de Integração**: Validação do fluxo completo

## Resultados

Todos os 39 testes unitários estão passando! ✅

```
00:01 +39: All tests passed!
```
