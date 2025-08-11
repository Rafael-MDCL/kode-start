# 🚀 Rick and Morty App

<div align="center">
  <img src="assets/images/Group 119.png" alt="Rick and Morty Logo" width="200"/>
  
  **Uma aplicação Flutter moderna para explorar o universo de Rick and Morty**
  
  Desenvolvido para a **KOBE** no programa **KODE START**
  
  [![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)](https://flutter.dev)
  [![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)](https://dart.dev)
  [![API](https://img.shields.io/badge/Rick%20and%20Morty-API-97ce4c?style=for-the-badge)](https://rickandmortyapi.com)
</div>

---

## 📱 Sobre o Projeto

Este projeto é uma aplicação mobile desenvolvida em **Flutter** que consome a [Rick and Morty API](https://rickandmortyapi.com) para exibir informações sobre personagens da série. A aplicação foi criada como parte do programa **KODE START** da **KOBE**, focando em boas práticas de desenvolvimento, arquitetura limpa e uma experiência de usuário excepcional.

### 🎯 Objetivos do Projeto

- ✅ Implementar arquitetura limpa e escalável
- ✅ Consumir API REST de forma eficiente
- ✅ Criar interface fiel aos designs fornecidos
- ✅ Aplicar boas práticas de desenvolvimento Flutter
- ✅ Implementar funcionalidades modernas (busca, paginação infinita)

---

## ✨ Funcionalidades

### 🏠 **Tela Principal**
- **Lista de Personagens**: Visualização em cards com imagem e nome
- **Paginação Infinita**: Carregamento automático de mais personagens ao rolar
- **Busca em Tempo Real**: Encontre personagens por nome com debounce otimizado
- **Estados de Loading**: Indicadores visuais durante carregamento

### 🔍 **Sistema de Busca**
- **Busca Dinâmica**: Resultados atualizados conforme você digita
- **Debounce Inteligente**: Otimização de performance (500ms)
- **Paginação na Busca**: Scroll infinito também funciona nos resultados
- **Estado Vazio**: Mensagens amigáveis quando não há resultados

### 📱 **Tela de Detalhes**
- **Informações Completas**: Status, espécie, gênero, origem e localização
- **Primeira Aparição**: Nome do primeiro episódio onde o personagem aparece
- **Status Visual**: Indicadores coloridos (🟢 Vivo, 🔴 Morto, 🟠 Desconhecido)
- **Design Unificado**: Card único com imagem, nome e informações

---

## 🏗️ Arquitetura

O projeto segue princípios de **Clean Architecture** com separação clara de responsabilidades:

```
lib/
├── main.dart                 # Ponto de entrada da aplicação
├── models/                   # Modelos de dados da API
│   ├── characters_info.dart  # Modelo Character
│   ├── episode_info.dart     # Modelo Episode
│   └── location_info.dart    # Modelo Location
├── dtos/                     # Data Transfer Objects
│   └── characters_main_info.dart
├── repositories/             # Camada de dados/API
│   └── characters_repository.dart
├── screens/                  # Telas da aplicação
│   └── character_detail_screen.dart
├── widgets/                  # Componentes reutilizáveis
│   ├── characters_card.dart
│   ├── app_bar_widget.dart
│   └── search_bar_widget.dart
└── themes/                   # Cores e estilos
    └── app_colors.dart
```

### 🔧 **Padrões Utilizados**

- **Repository Pattern**: Abstração da camada de dados
- **Singleton Pattern**: Instância única do repository
- **Factory Pattern**: Criação de objetos a partir de JSON
- **DTO Pattern**: Simplificação de dados para as telas

---

## 🛠️ Tecnologias

### **Core**
- **Flutter**: Framework de desenvolvimento mobile
- **Dart**: Linguagem de programação
- **Material Design**: Sistema de design do Google

### **Networking**
- **Dio**: Cliente HTTP robusto com interceptors
- **Rick and Morty REST API**: Fonte de dados oficial

### **Arquitetura**
- **StatefulWidget**: Gerenciamento de estado local
- **Repository Pattern**: Abstração da camada de dados
- **Clean Architecture**: Separação de responsabilidades

---

## 🚀 Como Executar

### **Pré-requisitos**
- Flutter SDK (>=3.8.1)
- Dart SDK
- Android Studio ou VS Code
- Emulador Android/iOS ou dispositivo físico

### **Instalação**

1. **Clone o repositório**
   ```bash
   git clone [URL_DO_REPOSITORIO]
   cd rick_morty
   ```

2. **Instale as dependências**
   ```bash
   flutter pub get
   ```

3. **Execute a aplicação**
   ```bash
   flutter run
   ```

### **Build para Produção**
```bash
# Android
flutter build apk --release

# iOS
flutter build ios --release
```

---

## 📦 Dependências

```yaml
dependencies:
  flutter:
    sdk: flutter
  dio: ^5.4.3              # Cliente HTTP
  cupertino_icons: ^1.0.8  # Ícones iOS

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^5.0.0    # Análise de código
```

---

## 🎨 Design System

### **Cores**
```dart
// Cores principais
primary: #1C1B1F      // Header e AppBar
accent: #23232A       // Cards secundários
background: #000000   // Fundo da aplicação
cards: #87A1FA        // Cards e elementos destacados
text: #FFFFFF         // Texto principal

// Status dos personagens
statusAlive: Green    // Personagem vivo
statusDead: Red       // Personagem morto
statusUnknown: Orange // Status desconhecido
```

### **Tipografia**
- **Fonte**: Lato (todas as variações)
- **Tamanhos**: 16px (corpo), 18px (títulos)

---

## 🔗 API Reference

### **Endpoints Utilizados**

```http
GET https://rickandmortyapi.com/api/character
GET https://rickandmortyapi.com/api/character?page={page}
GET https://rickandmortyapi.com/api/character?name={query}&page={page}
GET https://rickandmortyapi.com/api/episode/{id}
```

### **Exemplo de Response**
```json
{
  "info": {
    "count": 826,
    "pages": 42,
    "next": "https://rickandmortyapi.com/api/character?page=2",
    "prev": null
  },
  "results": [
    {
      "id": 1,
      "name": "Rick Sanchez",
      "status": "Alive",
      "species": "Human",
      "gender": "Male",
      "origin": {
        "name": "Earth (C-137)"
      },
      "location": {
        "name": "Citadel of Ricks"
      },
      "image": "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
      "episode": ["https://rickandmortyapi.com/api/episode/1"]
    }
  ]
}
```

---

## 📱 Screenshots

### Tela Principal
- Lista de personagens com paginação infinita
- Barra de busca integrada
- Cards com design moderno

### Tela de Detalhes
- Informações completas do personagem
- Status visual com indicadores coloridos
- Design unificado conforme mockups

### Sistema de Busca
- Busca em tempo real
- Estados de loading e vazio
- Paginação nos resultados

---

## 🏢 Sobre a KOBE

Este projeto foi desenvolvido como parte do programa **KODE START** da **KOBE**, uma iniciativa focada no desenvolvimento de talentos em tecnologia através de projetos práticos e mentoria especializada.

### **KODE START**
O programa KODE START oferece:
- 📚 Formação prática em desenvolvimento mobile
- 👥 Mentoria de profissionais experientes
- 🚀 Projetos reais com tecnologias modernas
- 🎯 Foco em boas práticas e arquitetura

---

## 👨‍💻 Desenvolvimento

### **Funcionalidades Implementadas**
- [x] Lista de personagens com paginação
- [x] Tela de detalhes completa
- [x] Sistema de busca em tempo real
- [x] Estados de loading e erro
- [x] Design responsivo e moderno
- [x] Arquitetura limpa e escalável

### **Boas Práticas Aplicadas**
- ✅ Clean Architecture
- ✅ Repository Pattern
- ✅ Type Safety completo
- ✅ Error Handling robusto
- ✅ Performance otimizada
- ✅ Código limpo e documentado

---

## 📄 Licença

Este projeto foi desenvolvido para fins educacionais como parte do programa KODE START da KOBE.

---

<div align="center">
  
  **Desenvolvido com ❤️ para a KOBE**
  
  Programa KODE START | 2025
  
</div>
