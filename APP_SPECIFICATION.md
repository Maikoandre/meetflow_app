# MeetFlow Mobile App - Development Specification

This document serves as a comprehensive guide for an AI agent to build the mobile application for the **MeetFlow** project.

## 1. Project Overview
The MeetFlow Mobile App is a client for the MeetFlow event management system. It allows users to browse events, register for them, and manage their participation.

- **Tech Stack**: Flutter (The project is already initialized in this directory).
- **Backend**: Django REST Framework (DRF) API.

## 2. Backend API Details
The mobile app will consume the API provided by the MeetFlow backend.

- **Base URL**: `http://<backend-host>:8000/api/` (Make this configurable).
- **Authentication**:
  - The backend currently uses **Basic Authentication** (`Authorization: Basic <base64(username:password)>`) or Session Authentication.
  - *Note*: There is no Token/JWT authentication configured yet. The app must send credentials with every request or handle session cookies.
- **Pagination**:
  - The API uses `PageNumberPagination` with a **Page Size of 2**.
  - The app **MUST** implement pagination (e.g., Infinite Scroll) to fetch records.
  - Response format for paginated lists:
    ```json
    {
      "count": 10,
      "next": "http://.../?page=2",
      "previous": null,
      "results": [...]
    }
    ```

## 3. Data Models (JSON Structure)

Based on the backend Django models, the API exposes the following structures:

### Evento (Events)
Endpoint: `/api/eventos/`
```json
{
  "id": 1,
  "titulo": "String",
  "descricao": "String",
  "data": "YYYY-MM-DD",
  "local": "String",
  "organizador": 1, // User ID (Django Auth User)
  "aprovado": true,
  "publicado": true
}
```

### Inscricao (Inscriptions)
Endpoint: `/api/inscricoes/`
```json
{
  "id": 1,
  "evento": 1, // Event ID
  "participante": 1, // User ID (Django Auth User)
  "status": "pendente" // choices: pendente, confirmado, cancelado
}
```

### Usuario (User Profile)
Endpoint: `/api/users/`
```json
{
  "id": 1,
  "nome": "String",
  "idade": 25,
  "tipo": "participante", // choices: admin, organizador, participante
  "user": 1 // Django Auth User ID
}
```

### Presenca (Presence)
Endpoint: `/api/presencas/`
```json
{
  "id": 1,
  "inscricao": 1, // Inscription ID
  "presente": false
}
```

### Relatorio (Reports)
Endpoint: `/api/relatorios/`
```json
{
  "id": 1,
  "evento": 1,
  "total_inscritos": 10,
  "total_presentes": 5,
  "data_geracao": "ISO-8601 Timestamp"
}
```

## 4. Key Features & Screens to Implement

### A. Authentication & Onboarding
- **Login Screen**:
  - Fields: Username, Password.
  - Store credentials securely (e.g., using `flutter_secure_storage`).
- **Registration**:
  - *Warning*: The API currently requires authentication to create users (`POST /api/users/`).
  - *Workaround*: Direct user to the web registration page (`/cadastro/`) or update the backend to allow public user creation.

### B. Events (Main Feed)
- **Screen**: List of all approved and published events.
- **Functionality**:
  - Infinite scroll pagination (Page size is 2).
  - Pull-to-refresh.

### C. Event Details
- **Screen**: Detailed view of an event.
- **Functionality**:
  - Show Title, Description, Date, Local.
  - "Join Event" button (Creates an `Inscricao`).
  - Show status of user's inscription if joined.

### D. My Inscriptions
- **Screen**: List of events the logged-in user has registered for.
- **Functionality**:
  - Cancel inscription.

### E. Organizer/Admin Features (Phase 2)
- If `Usuario.tipo` is `admin` or `organizador`:
  - Create an event (`POST /api/eventos/`).
  - Mark presence for participants.
  - View reports.

## 5. Technical Recommendations
- **HTTP Client**: Use `dio` for interceptors (useful for adding Auth headers).
- **State Management**: Use `provider`, `riverpod`, or `flutter_bloc`.
- **UI/UX**: Clean, modern design (Material 3).

## 6. Known API Limitations & Workarounds
1. **No Nested Objects**: The API returns IDs for relationships (e.g., `organizador: 1`). To show names, the app may need to fetch the user list and cache it locally.
2. **Small Page Size**: The page size of 2 will trigger many network requests.
3. **Auth Model**: Consider updating the backend to support Token/JWT Auth for better mobile security.
