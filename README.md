# Income & Expense Tracker

A cross-platform Flutter application to manage your personal finances by tracking income and expenses, categorizing transactions, and visualizing your financial data.

## Table of Contents
- [Overview](#overview)
- [Features](#features)
- [Project Structure](#project-structure)
- [Getting Started](#getting-started)
- [Assets & Localization](#assets--localization)
- [Contributing](#contributing)
- [License](#license)

## Overview
This app helps users to:
- Record income and expense transactions
- Categorize transactions (e.g., food, transport, entertainment)
- Filter transactions by date range
- Export and import data as CSV
- Visualize spending patterns

## Features
- [x] Add, edit, and delete transactions
- [x] Categorize transactions
- [x] View transaction history
- [x] Dashboard with summary and charts
- [ ] Export data to CSV
- [ ] Import data from CSV
- [ ] Filter transactions by date range
- [ ] Multi-language support (English, Arabic)

## Project Structure
```
lib/
  main.dart                # App entry point
  app/                     # App-level configuration and setup
  data/                    # Data sources, repositories, and models
  features/                # Feature modules (transaction, dashboard, etc.)
  model/                   # Data models
  resources/               # App resources (colors, styles, etc.)
  utils/                   # Utility functions and helpers
assets/
  fonts/                   # Custom fonts
  images/                  # App images and icons
  translations/            # Localization files (en-US.json, ar-JO.json)
```

## Getting Started
1. **Clone the repository:**
   ```bash
   git clone <repo-url>
   cd income_expense_tracker
   ```
2. **Install dependencies:**
   ```bash
   flutter pub get
   ```
3. **Run the app:**
   ```bash
   flutter run
   ```

## Assets & Localization
- Custom fonts and images are in the `assets/` directory.
- Localization files for English and Arabic are in `assets/translations/`.

## Contributing
Contributions are welcome! Please open issues or submit pull requests for new features, bug fixes, or improvements.

## License
This project is licensed under the MIT License.
