# Poké-Vault Mobile Application's Project.

## 1. Project Overview

**Poké-Vault** The goal is to build a high-performance Flutter application that interacts with the PokeAPI (https://pokeapi.co/). We are looking for clean code, reactive state management, and a smooth user experience.

## 2. Core Requirements

### A. Home Screen (Discovery)

- Fetch Pokémon list from /pokemon endpoint.
- Implement Pagination (20 items at a time).
- Search bar to filter by name.
- Display Name, ID, and Official Artwork.

### B. Detail Screen

- Dynamic background color based on Pokémon type.
- Display Stats (HP, Attack, Defense), Abilities, and Types.

## 3. TECHNICAL CONSTRAINTS

- State Management -> GetX
- Architecture: Layered (Data, Domain, Presentation).
- Networking: Dio or http with prope serialization.
- Image Handling.

## 4. Evaluation Criteria

- Code Readability and Project Structure.
- Error Handling (Loading, Error, Empty states).
- UI/UX responsiveness and performance.
- Bonus: Unit/Widget tests and Offline storage (Hive/Isar).

## 5. Submission

- Public GitHub Repository link.
- README.md with setup instructions and architectural decisions.
