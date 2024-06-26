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

**Liste von Argumenten**


| Argument                     | Typ                | Standardwert                         | Verwendungszweck                                                                          |
|------------------------------|--------------------|--------------------------------------|-------------------------------------------------------------------------------------------|
| language                     | String             | "de"                                 | Definiert die Sprache des Dokuments. Momentan nur Deutsch und English unterstützt.                                                 |
| title                        | Liste von Strings  | ["Textvorlage für wissenschaftliche Arbeiten\n\nTitel und Untertitel der Arbeit"]       | Gibt den Titel und Untertitel des Dokuments an.                                            |
| authors                      | Tupel von Tupeln (  name:  string \| content, email: string  \| content, postal: string \| content, matrikel:  string \| content),   | [(name: "Max Julian Mustermann", email: "max.mustermann@stud-provadis-hochschule.de", postal: "Hauptstraße 10, D-10341 Hauptstadt",matrikel: "XXXX")] | Enthält Informationen über die Autoren des Dokuments.                                      |
| logo                         | Bild               | image("img/t-systems.png", width: 180pt, height: 2.06cm, fit: "contain") | 2tes optionales Logo.                |
| abstract                     | String             | lorem(100)                           | Enthält das Abstract des Dokuments.                                                        |
| preface                      | String             | lorem(100)                           | Enthält das Vorwort oder die Einleitung des Dokuments.                                      |
| acknowledgement              | String             | "Für meine Brudis"                   | Danksagung an Personen oder Gruppen für ihre Unterstützung.                                 |
| document-type                | String             | "Wiss. Kurzbericht / WAB / Bachelorarbeit / Masterarbeit" | Spezifiziert den Typ des Dokuments (z.B. Bachelorarbeit, Masterarbeit).                    |
| reason                       | Liste von Strings  | Siehe Template                       | Beschreibt den Grund für die Erstellung des Dokuments, z.B. für Erlangung akademische Grade.          |
| submitted_to                 | Liste von Strings  | Siehe Template                       | Gibt an, wo das Dokument eingereicht wird (z.B. Universitätsabteilung).                    |
| first_appraiser              | String             | "Prof. Müller"                       | Name des ersten Gutachters oder Prüfers des Dokuments.                                      |
| second_appraiser             | String             | "Dr. Kunze"                          | Name des zweiten Gutachters oder Prüfers des Dokuments.                                     |
| supervisor                   | String             | "Dr. Peter"                          | Name des Betreuers oder Beraters, der das Dokument überwacht.                               |
| bib                          | String oder NoneType| none                                | Gibt den Stil für das Literaturverzeichnis an oder zeigt an, dass kein Literaturverzeichnis vorhanden ist (none). |
| appendix                     | Liste von Content           | ()                                   | Enthält Anhänge oder zusätzliches Material, das dem Dokument angehängt ist.                 |
| location                     | String             | "Berlin"                             | Gibt den Ort an, an dem das Dokument erstellt wird.                                         |
| deadline                     | String             | "15.03.2024"                          | Setzt die Abgabefrist für das Dokument.                                                    |
| declaration_of_independence  | Boolean            | true                                 | Gibt an, ob das Dokument eine Unabhängigkeitserklärung enthält.                            |
| confidential_clause          | Boolean            | false                                | Spezifiziert, ob das Dokument eine Vertraulichkeitsklausel enthält.                        |
| glossary_entries             | Liste von ( key: String \| Content, short: String \| Content, long: String \| Content ) | ()                                   | Enthält Einträge für ein Glossar der im Dokument verwendeten Begriffe.                     |
| abbreviation_entries         | Liste von ( key: String \| Content, short: String \| Content, long: String \| Content ) | ()                                   | Enthält Einträge für Abkürzungen, die im Dokument verwendet werden.                         |
| show_lists_after_content     | Boolean            | false                                | Bestimmt, ob Listen (z.B. Literaturverzeichnis) nach dem Hauptinhaltverzeichnis angezeigt werden sollen. |
| ai_entries                   | Liste von (String | Content, String | Content) | ()                                   | Enthält Einträge für verwendete künstliche Intelligenz im Dokument. |



### 4. Optional: Konfiguriere die Github Action
In diesem Repository befindet sich eine [GitHub Action](./.github/workflows/main.yml), die du zum Bauen deines Dokumentes verwenden kannst. Mit dieser GitHub Action wird dein Dokument bei jedem Push (Commit oder Tag) gebaut und als Artefakt hochgeladen. Optional kannst du dieses auch über eine Discord Webhook in einen Discord Channel schicken lassen.

Kopiere hierfür einfach den .github Ordner dieses Projekts in dein Eigenes.

Du kannst zusätzlich folgende Variablen als Action Variablen konfigurieren.

| Variable         | Default | Beschreibung                                           |
|------------------|---------|--------------------------------------------------------|
| FILE_NAME_PREFIX | main_   | Präfix der vor der Versionsinfo angehangen werden soll |
| DISCORD_WEBHOOK  |         | Discord Webhook URL zum Hochladen des PDFs             |

## Weitere praktische Tipps

- Praktisches Package für TODO-Notizen oder allgemein Anmerkungen am Seitenrand: [package/drafting](https://typst.app/universe/package/drafting)

... werden hier ergänzt falls wir etwas finden 🫡

## Known Issuses 
Am Ende des Dokuments wird eine leere Seite angehängt. Das ist ein bekannter [Fehler](https://github.com/typst/typst/issues/2326#issuecomment-2019132332) im Typst-Compiler. Es muss auf einen Fix gewartet werden.
