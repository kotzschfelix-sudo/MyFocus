# MyFocus

MyFocus ist die Fokus- und Pausen-App innerhalb von MyDigital.

## Funktionen
- Fokus-Timer sowie kurze und lange Pausen
- Einstellbare Zeitlängen
- Start, Pause, Fortsetzen, Zurücksetzen und vorzeitiges Speichern
- Tages- und Wochenstatistik
- Verlauf der letzten Fokus-Sessions
- Gemeinsame Anmeldung über MyDigital / Supabase Auth
- Persönliche Sitzungen mit Row Level Security (RLS)
- Installierbare PWA mit zwischengespeicherter App-Oberfläche

## Datenbank
Die Tabelle `public.focus_sessions` ist in `supabase/schema.sql` dokumentiert. RLS begrenzt jede Abfrage auf den angemeldeten Eigentümer. Der Browser verwendet ausschließlich den öffentlichen Publishable Key; kein Service-Role-Schlüssel ist enthalten.

## Lokal testen
`index.html` über einen lokalen Webserver oder GitHub Pages öffnen. Für die Datenbank muss die SQL-Datei im zugehörigen Supabase-Projekt ausgeführt sein.

## Hinweis zum Offline-Modus
Der Service Worker cached die App-Oberfläche. Anmeldung und Synchronisierung der Sitzungen benötigen eine Internetverbindung.
