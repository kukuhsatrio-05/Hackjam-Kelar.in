# 🚀 Kelar.in - Smart AI Task Manager

**Kelar.in** adalah aplikasi manajemen tugas pintar berbasis Flutter yang memanfaatkan keandalan **Gemini AI Studio** untuk mengekstrak tugas secara otomatis dari input teks maupun gambar, serta **Supabase** sebagai _backend-as-a-service_ untuk autentikasi dan penyimpanan data real-time.

---

## 📌 Fitur Utama

- 🤖 **AI Task Capture**: Ekstraksi tugas otomatis dari foto, instruksi teks, atau catatan menggunakan **Gemini 2.0 Flash**.
- 📅 **Smart Scheduling**: Perhitungan _deadline_ tanggal relatif secara otomatis (seperti "besok", "lusa", atau "minggu depan").
- ⚡ **Priority & Stakeholder Detection**: AI mengenali prioritas tugas (_High_, _Medium_, _Low_) serta pihak terkait (_stakeholder_).
- 📊 **Task Management**: Pengelolaan status dan daftar tugas yang terstruktur.

---

## 🛠️ Tech Stack & Library

- **Framework**: [Flutter](https://flutter.dev/) (Dart)
- **State Management**: [Riverpod](https://riverpod.dev/) (`flutter_riverpod`)
- **AI Engine**: [Google Generative AI Studio](https://ai.google.dev/) (`google_generative_ai`)
- **Backend & Database**: [Supabase](https://supabase.com/) (`supabase_flutter`)
- **Arsitektur**: **MVVM (Model-View-ViewModel) - Feature-Based**

---

## 🏗️ Arsitektur Proyek (MVVM Feature-Based)

Proyek ini mengadopsi arsitektur **MVVM berbasis Fitur (Feature-Based)** agar struktur kode bersih, modular, _scalable_, dan mudah dikembangkan oleh tim.

```text
lib/
├── core/
├── services/                 # GeminiService, SupabaseClient
├── data/                     # Data Layer Terpusat (Shared Data)
│   ├── models/               # task_model.dart, user_model.dart
│   └── repositories/         # task_repository.dart, auth_repository.dart
├── ui/                       # Presentation Layer (Views & ViewModels)
│   ├── auth/
│   │   ├── viewmodels/
│   │   └── views/
│   ├── capture_ai/
│   │   ├── models/           # state & result khusus UI AI
│   │   ├── viewmodels/
│   │   └── views/
│   └── tugas/
│       ├── viewmodels/
│       └── views/
```

---

## ⚙️ Panduan Memulai (Getting Started)

### 1. Prasyarat

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (Versi stable terbaru)
- Dart SDK
- API Key dari [Google AI Studio](https://aistudio.google.com/)
- Proyek aktif di [Supabase](https://supabase.com/)

### 2. Konfigurasi Environment Variable (`.env`)

Buat file bernama `.env` di direktori _root_ proyek (sejajar dengan `pubspec.yaml`), kemudian isi variabel berikut:

```env
GEMINI_API_KEY=your_gemini_api_key_here
SUPABASE_URL=your_supabase_project_url
SUPABASE_ANON_KEY=your_supabase_anon_key
```

Jangan lupa menambahkan `.env` ke dalam file `.gitignore` dan mendaftarkannya di `pubspec.yaml`:

```yaml
flutter:
  assets:
    - .env
    - assets/icons/
```

### 3. Instalasi Dependency

Jalankan perintah berikut pada terminal:

```bash
flutter pub get
```

### 4. Menjalankan Aplikasi

```bash
flutter run
```

---

## 📄 Lisensi & Kredit

Dikembangkan untuk kebutuhan **Hackjam Raion Community** oleh _Team 9 Apps_.
