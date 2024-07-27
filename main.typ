#import "template.typ": Template, code
#import "@preview/glossarium:0.4.1": gls
#let translations = json("translations.json").at("de")

#show: Template.with(
  bib: arguments("sources.bib", style: "frontiers"), 
  appendix: (
    [
      #heading("Wichtiger Anhang",supplement: [#translations.appendix])
      #lorem(100)
    ],
    [
      #heading("Weiterer Wichtiger Anhang",supplement: [#translations.appendix]) <ref>
      #lorem(100)
    ]
  ),
  show_lists_after_content: false,
  confidental_clause: true,
  abbreviation_entries: (
    ( key: "oidc", short: "OIDC", long: "Open ID Connect" ),
  ),
  glossary_entries: (
    ( key: "haus", short: "Haus", long: "Konstruktion bestehend aus 4 Wänden und einem Dach" ),
  ),
  ai_entries: (
    ( "OpenAI ChatGPT", "Schreib meine Bachelorarbeit", "Bachelorarbeit schreiben lassen und lieber Fortnite zocken" ),
    ( "Google Gemini", "Gib mir Motivationstipps", "Die Nerven beibehalten" )
  ),
  abstract: [Im Nachfolgenden Text lesen Sie eine sehr gute Arbeit über ein sehr gutes Thema welches ich sehr gut bearbeitet habe.],
  preface: [bitte bitte bitte bitte bewerten sie gut]
)

= Einleitung
#lorem(15)

Wenn ich @oidc zum ersten mal erwähne wird es ausgeschrieben. \
Beim zweiten Mal wird @oidc nur abgekürzt. 

Übrigens gibt es eine @haus

#pagebreak()

= Grundlagen
#lorem(100)
== Unterpunkt
#lorem(100)
#figure(
  image("img/provadis.png", width: 80%),
  caption: [A curious figure.],
) <glacier>
#pagebreak()
#code(
  ```java
    class HelloWorld {
      public static void main(String[] args) {
          System.out.println("Hello, World!"); 
      }
    }
  ```,
  supplement: translations.codeausschnitt,
  caption: [java hello world.],
) <glacier>
== Unterpunkt
@Effectiv92:online
#lorem(100)
=== Unter-Unterpunkt
#lorem(100)
=== Unter-Unterpunkt
#pagebreak()

== Unterpunkt
#lorem(100)

=== Unter-Unterpunkt
#figure(
  table(
    columns: 4,
    [t], [1], [2], [3],
    [y], [0.3s], [0.4s], [0.8s],
  ),
  caption: [Timing results],
)

#lorem(100)

= Zusammenfassung
#lorem(100)

