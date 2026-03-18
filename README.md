# Stock Watchlist Assignment - 021 Trade

This project is a Flutter application that implements a stock watchlist with the ability to reorder and remove stocks using the BLoC architecture pattern.

## Features
- **Watchlist Display**: View a list of stocks with their current price, change, and percentage change.
- **Edit Mode**: Long press on any stock in the watchlist to enter the edit mode.
- **Reorder Stocks**: Drag and drop stocks to change their position in the watchlist.
- **Remove Stocks**: Remove stocks from the watchlist using the delete icon.
- **Responsive UI**: The UI is designed to be clean, modern, and responsive, matching the provided design.
- **BLoC Pattern**: State management is handled using `flutter_bloc` to ensure a clean separation of concerns and reactivity.

## Project Structure
- `lib/models/`: Contains the `Stock` data model.
- `lib/bloc/`: Contains the BLoC implementation (`events`, `states`, and `bloc`).
- `lib/screens/`: Contains the UI screens (`WatchlistScreen` and `EditWatchlistScreen`).
- `lib/main.dart`: Entry point of the application.

## Approach
1. **Data Model**: Created a `Stock` class with `equatable` for value-based comparison.
2. **State Management**: Implemented `WatchlistBloc` to handle `LoadWatchlist`, `ReorderStock`, and `RemoveStock` events.
3. **UI Implementation**:
   - `WatchlistScreen`: Displays the main list. Used `ListView.separated` for performance.
   - `EditWatchlistScreen`: Uses `ReorderableListView` to allow users to swap stock positions.
4. **Navigation**: Simple navigation between the main view and edit view. Long pressing a stock item triggers the edit mode.

## How to Run
1. Ensure you have Flutter installed.
2. Clone the repository.
3. Run `flutter pub get` to install dependencies.
4. Run the app using `flutter run`.

## Technologies Used
- Flutter
- flutter_bloc
- equatable
# stock_watch_assignment
