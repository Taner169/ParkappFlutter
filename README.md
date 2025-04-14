# 📱 Parkeringsappen – Flutter & Dart

En mobilapplikation skapad i Flutter som kopplas till ett Dart-backend byggt med Shelf. Syftet är att erbjuda ett användarvänligt gränssnitt för att registrera personer, hantera fordon, boka parkeringsplatser och följa historik.

---

## 🔧 Installationsanvisningar

### 🖥 Backend (Dart server)
1. Navigera till `assignment_1` (eller motsvarande servermapp).
2. Kör:
   ```bash
   dart pub get
   dart run lib/server/main.dart
   ```
3. Servern körs på `http://localhost:8080`

### 📱 Flutter-klient
1. Navigera till `parking_user`
2. Kör:
   ```bash
   flutter pub get
   flutter run
   ```
3. Körs på simulator/emulator. För iOS: Se till att du har öppnat appens **"Local Network Access"** i Systeminställningar > Sekretess.

---

## ✅ Implementerade funktioner

| Funktion | Status | Beskrivning |
|---------|--------|-------------|
| 👤 Användarregistrering/inloggning | ✅ | Lägg till ny person, sök vid inloggning |
| 🚘 Fordonshantering | ✅ | Lägg till, ta bort och lista fordon |
| 🅿️ Parkeringsfunktioner | ✅ | Starta parkering, avsluta och se historik |
| 💬 Felhantering | ✅ | Användarvänlig feedback & validering |
| 📶 Serverkoppling | ✅ | All data skickas till backend via HTTP |

### 🌟 VG-funktioner
- 🔍 Sök i listor (personer, fordon)
- ✏️ Redigering av data (kommande)
- ↕️ Sortering av listor (kommande)
- 🌙 Mörkt/ljust tema (✅)
- 🎯 Extra: Logout & dynamiskt användarnamn i header

---

## ⚠️ Kända begränsningar

- Endast en lokal server – ingen databas, data försvinner vid omstart.
- Enkel inloggning utan säkerhet (ingen autentisering ännu).
- Data måste vara i rätt format (t.ex. regnummer, personnummer).
- Inget stöd för bilder eller geolocation i nuläget.

---

## 📸 Demo

En video bifogas med inlämningen som visar:
- Huvudfunktioner
- Navigation mellan vyer
- Tillägg av användare, fordon, parkeringar
