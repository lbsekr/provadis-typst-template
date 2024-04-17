# Provadis Typst Template

Das hier ist ein [Typst](https://typst.app) Template für wissenschaftliche Arbeiten an der *pRoVadIs hOcHscHuLe*. Es orientiert sich an der offiziellen Word Vorlage (aber keine Garantie auf Vollständigkeit).

## Nutzung

### 1. Binde das Template ein

Entweder über einen Download oder als Git-Submodule, falls du ohnehin Git nutzt um deine wissenschaftliche Arbeit zu verwalten (`git submodule add https://github.com/lbsekr/provadis-typst-template.git`)
```
thesis/
├─ provadis-typst-template/ <- this repository
├─ main.typ
```
### 2. Binde das Template in deine `main.typ` Datei ein
```{typst}
#import "template.typ": Template, todo
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
... werden hier ergänzt falls wir entwas finden 🫡