# Contribuindo para Flutter BLoC Infinite List

Obrigado por considerar contribuir para este projeto! 🎉

## Como Contribuir

### Reportando Bugs

Se você encontrou um bug, por favor abra uma [issue](../../issues) incluindo:

- Descrição clara do problema
- Passos para reproduzir
- Comportamento esperado vs comportamento atual
- Screenshots (se aplicável)
- Versão do Flutter e Dart
- Sistema operacional

### Sugerindo Melhorias

Sugestões de melhorias são sempre bem-vindas! Abra uma [issue](../../issues) com:

- Descrição detalhada da funcionalidade
- Justificativa (por que seria útil?)
- Exemplos de uso
- Possíveis implementações

### Pull Requests

1. **Fork o projeto**
   ```bash
   git clone https://github.com/seu-usuario/flutter_bloc_infinite_list.git
   ```

2. **Crie uma branch para sua feature**
   ```bash
   git checkout -b feature/MinhaNovaFeature
   ```

3. **Faça suas alterações**
   - Siga o estilo de código existente
   - Adicione testes para novas funcionalidades
   - Atualize a documentação se necessário

4. **Teste suas alterações**
   ```bash
   flutter test
   flutter analyze
   dart format .
   ```

5. **Commit suas mudanças**
   ```bash
   git commit -m "feat: adiciona nova funcionalidade X"
   ```

   Use commits semânticos:
   - `feat:` nova funcionalidade
   - `fix:` correção de bug
   - `docs:` mudanças na documentação
   - `test:` adição ou correção de testes
   - `refactor:` refatoração de código
   - `style:` formatação, sem mudança de lógica
   - `chore:` tarefas de manutenção

6. **Push para sua branch**
   ```bash
   git push origin feature/MinhaNovaFeature
   ```

7. **Abra um Pull Request**
   - Descreva suas mudanças claramente
   - Referencie issues relacionadas
   - Aguarde review

## Padrões de Código

### Dart/Flutter

- Use `dart format` para formatação
- Siga as [Effective Dart Guidelines](https://dart.dev/guides/language/effective-dart)
- Mantenha funções pequenas e focadas
- Use nomes descritivos para variáveis e funções
- Documente código público com `///`

### BLoC

- Um BLoC por funcionalidade
- Estados imutáveis
- Eventos representam intenções do usuário
- Use `Equatable` para comparações
- Mantenha a lógica de negócio no BLoC

### Testes

- **Escreva testes** para toda nova funcionalidade
- Mantenha testes unitários rápidos
- Use `mocktail` para mocking
- Teste casos de sucesso e falha
- Organize testes com `group` e `setUp`

### Estrutura de Arquivos

```
lib/
└── feature/
    ├── bloc/
    ├── models/
    ├── view/
    └── widgets/

test/
└── feature/
    ├── bloc/
    ├── models/
    ├── view/
    └── widgets/
```

## Revisão de Código

Todos os PRs passarão por revisão. Esperamos:

- ✅ Testes passando
- ✅ Código formatado
- ✅ Sem warnings do analyzer
- ✅ Documentação atualizada
- ✅ Commits organizados

## Código de Conduta

- Seja respeitoso e inclusivo
- Aceite críticas construtivas
- Foque no que é melhor para a comunidade
- Mostre empatia com outros contribuidores

## Dúvidas?

Se tiver dúvidas, sinta-se à vontade para:

- Abrir uma [issue](../../issues)
- Comentar em PRs existentes
- Entrar em contato com os mantenedores

Obrigado por contribuir! 🚀
