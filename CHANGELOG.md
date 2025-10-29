# Changelog

Todas as mudanças notáveis neste projeto serão documentadas neste arquivo.

O formato é baseado em [Keep a Changelog](https://keepachangelog.com/pt-BR/1.0.0/),
e este projeto adere ao [Semantic Versioning](https://semver.org/lang/pt-BR/).

## [1.0.0] - 2025-10-28

### ✨ Adicionado

#### Funcionalidades
- Implementação de scroll infinito com BLoC pattern
- Carregamento paginado de posts da API JSONPlaceholder
- Throttling inteligente para evitar múltiplas requisições
- Indicador de carregamento no fim da lista
- Detecção automática quando usuário alcança 90% da lista
- Tratamento de estados (initial, loading, success, failure)

#### Arquitetura
- Estrutura modular seguindo clean architecture
- Separação clara entre UI, lógica de negócio e modelos
- Uso de barrel files para organização de exports
- BLoC pattern com eventos e estados imutáveis
- Models usando Equatable para comparações eficientes

#### Testes
- **39 testes unitários** cobrindo:
  - Models (Post)
  - BLoC (eventos, estados, lógica)
  - Widgets (PostListItem, BottomLoader)
  - Views (PostsPage, PostsList)
  - App principal
- **4 testes de integração** end-to-end
- Cobertura completa com mocks usando Mocktail
- Documentação de testes em `test/README.md`

#### Documentação
- README.md completo com badges e instruções
- Estrutura do projeto documentada
- Guia de contribuição (CONTRIBUTING.md)
- Licença MIT (LICENSE)
- Changelog estruturado

#### Widgets
- `PostsPage`: Página principal com BLoC Provider
- `PostsList`: Lista com scroll infinito
- `PostListItem`: Item individual da lista
- `BottomLoader`: Indicador de carregamento

#### Dependências
- bloc ^9.0.0
- flutter_bloc ^9.1.0
- equatable ^2.0.0
- http ^1.0.0
- bloc_concurrency ^0.3.0
- stream_transform ^2.0.0
- bloc_test ^10.0.0 (dev)
- mocktail ^1.0.0 (dev)
- integration_test (dev)

### 🔧 Técnico
- Flutter SDK 3.9.2+
- Dart SDK 3.9.2+
- Material Design 3
- Null Safety habilitado

---

## Tipos de Mudanças

- **✨ Adicionado** - Novas funcionalidades
- **🔄 Modificado** - Mudanças em funcionalidades existentes
- **⚠️ Descontinuado** - Funcionalidades que serão removidas
- **🗑️ Removido** - Funcionalidades removidas
- **🐛 Corrigido** - Correções de bugs
- **🔒 Segurança** - Correções de vulnerabilidades
