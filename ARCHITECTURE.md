# Arquitetura do Projeto

## 🏗️ Visão Geral

Este projeto segue os princípios de **Clean Architecture** combinados com o padrão **BLoC** para gerenciamento de estado, resultando em uma aplicação escalável, testável e manutenível.

## 📐 Padrão de Arquitetura

### BLoC Pattern

```
┌─────────────────┐
│      View       │  ← UI Layer (Widgets)
└────────┬────────┘
         │ Events
         ↓
┌─────────────────┐
│      BLoC       │  ← Business Logic Layer
└────────┬────────┘
         │ States
         ↓
┌─────────────────┐
│      Model      │  ← Data Layer
└─────────────────┘
```

### Camadas

#### 1. **Presentation Layer** (UI)
- **Responsabilidade**: Exibir dados e capturar interações do usuário
- **Componentes**:
  - Views (Pages)
  - Widgets
  - BlocBuilder/BlocListener

#### 2. **Business Logic Layer** (BLoC)
- **Responsabilidade**: Processar eventos e emitir estados
- **Componentes**:
  - BLoC (Business Logic Component)
  - Events
  - States
  - Transformers (throttle, debounce)

#### 3. **Data Layer** (Models)
- **Responsabilidade**: Representar e manipular dados
- **Componentes**:
  - Models (entidades)
  - Repositories (futuro)
  - Data sources (API, cache)

## 🗂️ Estrutura de Diretórios

```
lib/
├── app.dart                          # Configuração raiz do app
├── main.dart                         # Entry point
├── simple_bloc_observer.dart         # Observer global (logs, debug)
│
└── posts/                            # Feature: Posts
    ├── posts.dart                    # Barrel file (exports)
    │
    ├── bloc/                         # Business Logic
    │   ├── post_bloc.dart           # Lógica principal
    │   ├── post_event.dart          # Eventos do usuário
    │   └── post_state.dart          # Estados da UI
    │
    ├── models/                       # Data Models
    │   ├── models.dart              # Barrel file
    │   └── post.dart                # Entidade Post
    │
    ├── view/                         # Pages & Screens
    │   ├── view.dart                # Barrel file
    │   ├── posts_page.dart          # Página principal (BlocProvider)
    │   └── posts_list.dart          # Lista com scroll infinito
    │
    └── widgets/                      # UI Components
        ├── widgets.dart             # Barrel file
        ├── bottom_loader.dart       # Loading indicator
        └── post_list_item.dart      # Item da lista
```

## 🔄 Fluxo de Dados

### 1. Inicialização
```dart
PostsPage
  └── BlocProvider<PostBloc>
      └── PostBloc(httpClient: Client())
          └── add(PostFetched())  // Evento inicial
```

### 2. Fluxo de Evento → Estado

```
User scrolls                  Event dispatched
     ↓                              ↓
PostsList._onScroll()  →  bloc.add(PostFetched())
                                    ↓
                          PostBloc._onFetched()
                                    ↓
                          _fetchPosts() → HTTP Request
                                    ↓
                          ┌──────────────────┐
                          │  Success?         │
                          └──────────────────┘
                           /              \
                        Yes                No
                         ↓                  ↓
              emit(PostState.success)   emit(PostState.failure)
                         ↓
              BlocBuilder rebuilds PostsList
```

## 🎯 Componentes Principais

### PostBloc

**Responsabilidades**:
- Gerenciar estado da lista de posts
- Fazer requisições HTTP
- Controlar paginação
- Throttling de eventos

**Transformers**:
```dart
throttleDroppable<E>(Duration duration)
```
- Previne múltiplas requisições simultâneas
- Drop eventos enquanto processa um

### PostState

**Estados possíveis**:
```dart
enum PostStatus { initial, success, failure }

PostState {
  PostStatus status;
  List<Post> posts;
  bool hasReachedMax;
}
```

### PostEvent

**Eventos**:
```dart
sealed class PostEvent
final class PostFetched extends PostEvent
```

## 🧩 Princípios Aplicados

### 1. **Single Responsibility Principle (SRP)**
- Cada classe tem uma única responsabilidade
- BLoC: lógica de negócio
- View: renderização
- Model: dados

### 2. **Dependency Inversion Principle (DIP)**
```dart
class PostBloc {
  PostBloc({required this.httpClient}); // Dependency injection
  final Client httpClient;
}
```

### 3. **Separation of Concerns**
- UI não conhece detalhes de implementação
- BLoC não conhece detalhes da UI
- Models são independentes

### 4. **Immutability**
```dart
final class Post extends Equatable {
  const Post({required this.id, ...});
  final int id;
  // Sem setters - imutável
}
```

## 🔌 Integração de Dependências

### Injeção Manual (atual)
```dart
BlocProvider(
  create: (_) => PostBloc(httpClient: Client()),
  child: PostsPage(),
)
```

### Possível evolução: GetIt/Injectable
```dart
@injectable
class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc(@injectable this.httpClient);
}
```

## 🧪 Testabilidade

### Por que é testável?

1. **Injeção de Dependências**: Fácil mock do HTTP client
2. **Estados Imutáveis**: Comparações confiáveis
3. **Eventos Discretos**: Testes determinísticos
4. **Separação de Camadas**: Testes unitários isolados

### Exemplo de Teste
```dart
blocTest<PostBloc, PostState>(
  'emits success when posts are fetched',
  setUp: () {
    when(() => httpClient.get(any()))
      .thenAnswer((_) => /* mock response */);
  },
  build: () => PostBloc(httpClient: httpClient),
  act: (bloc) => bloc.add(PostFetched()),
  expect: () => [PostState(status: PostStatus.success, ...)],
);
```

## 📈 Escalabilidade

### Adição de Novas Features

```
lib/
├── posts/           # Feature existente
└── comments/        # Nova feature
    ├── bloc/
    ├── models/
    ├── view/
    └── widgets/
```

Cada feature é independente e autocontida.

### Adição de Repositories

```dart
abstract class PostRepository {
  Future<List<Post>> fetchPosts({required int start, required int limit});
}

class ApiPostRepository implements PostRepository {
  final Client httpClient;
  // Implementação usando HTTP
}

class CachedPostRepository implements PostRepository {
  // Implementação com cache
}
```

## 🎨 Padrões de Design

### 1. **BLoC Pattern**
- Gerenciamento de estado reativo
- Separação UI/lógica

### 2. **Repository Pattern** (futuro)
- Abstração de data sources
- Facilita testes e mudanças

### 3. **Dependency Injection**
- Inversão de controle
- Testabilidade

### 4. **Event Sourcing**
- Eventos como fonte de verdade
- Histórico de ações

## 📚 Referências

- [BLoC Pattern by Felix Angelov](https://bloclibrary.dev)
- [Clean Architecture by Uncle Bob](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Flutter Architecture Samples](https://github.com/brianegan/flutter_architecture_samples)
- [Effective Dart](https://dart.dev/guides/language/effective-dart)

## 🔮 Próximos Passos

1. ✅ Implementar pattern Repository
2. ✅ Adicionar cache local (Hive/SharedPreferences)
3. ✅ Implementar offline-first
4. ✅ Adicionar testes de integração
5. ✅ Implementar CI/CD
6. ✅ Adicionar analytics e crash reporting
