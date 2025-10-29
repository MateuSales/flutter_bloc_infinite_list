# Flutter BLoC Infinite List 📱

[![Flutter](https://img.shields.io/badge/Flutter-3.9.2+-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.9.2+-0175C2?logo=dart&logoColor=white)](https://dart.dev)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Tests](https://img.shields.io/badge/tests-39%20passed-success)](test/)
[![BLoC](https://img.shields.io/badge/state-BLoC-blueviolet)](https://bloclibrary.dev)

Uma aplicação Flutter moderna que demonstra a implementação de **scroll infinito** usando o padrão **BLoC** (Business Logic Component) para gerenciamento de estado. O app carrega posts de forma paginada da API JSONPlaceholder, oferecendo uma experiência de usuário fluida e eficiente.

## ✨ Características

- 🔄 **Scroll Infinito**: Carregamento automático de mais posts ao rolar
- 🏗️ **Arquitetura BLoC**: Separação clara entre lógica de negócio e UI
- 🎯 **Throttling Inteligente**: Evita múltiplas requisições simultâneas
- 🧪 **Testes Completos**: 39 testes unitários + testes de integração
- 📦 **API Real**: Integração com JSONPlaceholder API
- ♻️ **Clean Architecture**: Código organizado e manutenível
- 🎨 **Material Design**: Interface moderna e responsiva

## 🚀 Começando

### Pré-requisitos

- Flutter SDK 3.9.2 ou superior
- Dart SDK 3.9.2 ou superior
- IDE (VS Code, Android Studio, ou IntelliJ)

### Instalação

1. **Clone o repositório**
```bash
git clone https://github.com/seu-usuario/flutter_bloc_infinite_list.git
cd flutter_bloc_infinite_list
```

2. **Instale as dependências**
```bash
flutter pub get
```

3. **Execute o app**
```bash
flutter run
```

## 📁 Estrutura do Projeto

```
lib/
├── app.dart                      # Configuração principal do app
├── main.dart                     # Ponto de entrada
├── simple_bloc_observer.dart     # Observer global do BLoC
└── posts/
    ├── bloc/
    │   ├── post_bloc.dart        # Lógica de negócio
    │   ├── post_event.dart       # Eventos do BLoC
    │   └── post_state.dart       # Estados do BLoC
    ├── models/
    │   ├── models.dart           # Barrel file
    │   └── post.dart             # Modelo de dados
    ├── view/
    │   ├── view.dart             # Barrel file
    │   ├── posts_page.dart       # Página principal
    │   └── posts_list.dart       # Lista de posts
    └── widgets/
        ├── widgets.dart          # Barrel file
        ├── bottom_loader.dart    # Indicador de carregamento
        └── post_list_item.dart   # Item da lista
```

## 🧩 Pacotes Utilizados

### Dependências Principais
- **[bloc](https://pub.dev/packages/bloc)** `^9.0.0` - Gerenciamento de estado
- **[flutter_bloc](https://pub.dev/packages/flutter_bloc)** `^9.1.0` - Widgets do BLoC para Flutter
- **[equatable](https://pub.dev/packages/equatable)** `^2.0.0` - Comparação de objetos
- **[http](https://pub.dev/packages/http)** `^1.0.0` - Cliente HTTP
- **[bloc_concurrency](https://pub.dev/packages/bloc_concurrency)** `^0.3.0` - Controle de concorrência
- **[stream_transform](https://pub.dev/packages/stream_transform)** `^2.0.0` - Transformação de streams

### Dependências de Desenvolvimento
- **[bloc_test](https://pub.dev/packages/bloc_test)** `^10.0.0` - Testes de BLoC
- **[mocktail](https://pub.dev/packages/mocktail)** `^1.0.0` - Mocking para testes
- **[flutter_test](https://flutter.dev)** - Framework de testes
- **[integration_test](https://flutter.dev)** - Testes de integração
- **[bloc_lint](https://pub.dev/packages/bloc_lint)** `^0.3.0` - Linting para BLoC

## 🧪 Testes

O projeto possui uma **cobertura completa de testes** com 39 testes unitários e testes de integração.

### Executar todos os testes
```bash
flutter test
```

### Executar testes com cobertura
```bash
flutter test --coverage
```

### Executar testes de integração
```bash
flutter test integration_test/app_test.dart
```

### Estrutura de Testes
- ✅ **Models**: Testes do modelo Post
- ✅ **BLoC**: Testes de eventos, estados e lógica
- ✅ **Widgets**: Testes de componentes UI
- ✅ **Views**: Testes de páginas e listas
- ✅ **Integration**: Testes end-to-end

Para mais detalhes, consulte [test/README.md](test/README.md)

## 🎯 Funcionalidades Técnicas

### Padrão BLoC

O app utiliza o padrão BLoC para separar a lógica de negócio da interface:

- **PostBloc**: Gerencia o estado da lista de posts
- **PostEvent**: Define eventos (PostFetched)
- **PostState**: Representa os estados possíveis (initial, success, failure)

### Throttling de Eventos

```dart
EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}
```

Previne múltiplas requisições ao fazer scroll rapidamente.

### Scroll Infinito

O widget `PostsList` detecta quando o usuário está próximo ao fim da lista (90%) e automaticamente dispara um novo evento para carregar mais posts.

```dart
bool get _isBottom {
  if (!_scrollController.hasClients) return false;
  final maxScroll = _scrollController.position.maxScrollExtent;
  final currentScroll = _scrollController.offset;
  return currentScroll >= (maxScroll * 0.9);
}
```

## 📚 Recursos de Aprendizado

- [BLoC Pattern Documentation](https://bloclibrary.dev)
- [Flutter State Management](https://docs.flutter.dev/development/data-and-backend/state-mgmt)
- [Infinite List Tutorial](https://bloclibrary.dev/#/flutterinfinitelisttutorial)
- [JSONPlaceholder API](https://jsonplaceholder.typicode.com)

## 🛠️ Desenvolvimento

### Análise de Código
```bash
flutter analyze
```

### Formatação
```bash
dart format .
```

### Build para Produção
```bash
# Android
flutter build apk --release

# iOS
flutter build ios --release

# Web
flutter build web --release
```

## 📱 Screenshots

_Em desenvolvimento - Screenshots serão adicionados em breve_

## 🤝 Contribuindo

Contribuições são bem-vindas! Sinta-se à vontade para abrir issues ou pull requests.

1. Fork o projeto
2. Crie uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

## 👨‍💻 Autor

**Mateus Sales**

- GitHub: [@mateussales](https://github.com/mateussales)

## 🙏 Agradecimentos

- [Felix Angelov](https://github.com/felangel) - Criador do BLoC library
- [Flutter Team](https://flutter.dev) - Framework incrível
- [JSONPlaceholder](https://jsonplaceholder.typicode.com) - API fake para testes

---

⭐️ Se este projeto foi útil para você, considere dar uma estrela!
