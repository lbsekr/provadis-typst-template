# Provadis Typst Template

Das hier ist ein [Typst](https://typst.app) Template für wissenschaftliche Arbeiten an der Provadis Hochschule. Es orientiert sich an der offiziellen Word Vorlage (aber keine Garantie auf Vollständigkeit).

## Nutzung

Verwende nur getaggte [Versionen](https://github.com/lbsekr/provadis-typst-template/tags). Ungetaggte Versionen sind als Entwicklungsversionen anzusehen und möglicherweise nicht benutzbar.

### 1. Binde das Template ein

Entweder über einen Download oder als Git-Submodule, falls du ohnehin Git nutzt um deine wissenschaftliche Arbeit zu verwalten (`git submodule add https://github.com/lbsekr/provadis-typst-template.git`)
```
thesis/
├─ provadis-typst-template/ <- this repository
├─ main.typ
```
Wenn du Git verwendest, solltest du noch eine getaggte Version auschecken.
```
cd provadis-typst-template
git checkout <tag_or_commit_sha>
```

### 2. Binde das Template in deine `main.typ` Datei ein
```{typst}
#import "template.typ": Template
```
### 3. Initialisiere das Template mit deinen eigenen Werten
Für die Referenz der ganzen Werte schaue bitte in der `template.typst` Datei nach. Hier folgt ein Beispiel:
```
#show: Template.with(
  title: "Evaluierung der Nutzung von Typst in einer Bachelor-Arbeit", 
  authors: (
    (
      name: "Max Julian Mustermann", 
      email: "max.mustermann@stud-provadis-hochschule.de", 
      postal: "Hauptstraße 10, D-10341 Superstadt",
      matrikel: "X420"
    ),
  ),
  bib: arguments("literatur.bib", style: "frontiers"),  
  first_appraiser: "Dr. Prof. Manfred Klug", 
  supervisor: "Torsten Betrieb, Infraserv GmbH",
  location: "Frankfurt (Oder)", 
  deadline: "11.09.2001", 
)
```

## Weitere praktische Tipps

- Praktisches Package für TODO-Notizen oder allgemein Anmerkungen am Seitenrand: [package/drafting](https://typst.app/universe/package/drafting)

... werden hier ergänzt falls wir etwas finden 🫡

## Known Issuses 
Am Ende des Dokuments wird eine leere Seite angehängt. Das ist ein bekannter [Fehler](https://github.com/typst/typst/issues/2326#issuecomment-2019132332) im Typst-Compiler. Es muss auf einen Fix gewartet werden.
