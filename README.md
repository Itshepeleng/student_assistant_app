STUDENT ASSISTANT MANAGEMENT APP

A secure mobile application built with Flutter to streamline and manage Student Assistant applications for the Information Technology Department.

FEATURES:

User Authentication: Secure student and administrative staff login.

Role-Based Access Control: Separate views and permissions for students and admins.

Assistant Applications: Authenticated students can apply for 1st, 2nd, and 3rd-year modules.

Eligibility Verification: Built-in forms to validate minimum academic requirements.

Admin Dashboard: Faculty staff can review, approve, or reject applications in real time.

Full CRUD Operations: Create, read, update, and delete application records seamlessly.

TECH STACK:

Frontend: Flutter (Dart)

Architecture: MVVM (Model-View-ViewModel)

State Management: Provider

Backend & Database: Supabase (PostgreSQL, Auth, and Storage)

Version Control: GitHub

PROJECT STRUCTURE:

The project follows the MVVM architecture pattern to ensure clean separation of concerns:

textlib/

│
├── models/         # Data models (e.g., User, Application, Module)

├── viewmodels/     # Business logic and state management (Providers)

├── views/          # UI screens and widgets (Forms, Dashboards)

├── services/       # Supabase API calls and authentication handling

└── utils/          # Helpers, constants, and form validators

SETUP, INSTALLATION AND PREREQUISITES


Flutter SDK installed (latest stable version recommended)

Supabase account and project configured
