#import "template.typ": Bachelor
#let translations = json("translations.json").at("de")

#show: Bachelor.with(bib: "sources.bib",appendix:
 (
    [
      #heading("Wichtiger Anhang",supplement: [translations.appendix])
      #lorem(100)
    ],
     [
      #heading("Weiterer Wichtiger Anhang",supplement: [translations.appendix])
      #lorem(100)
    ]
  )  
)

= Einleitung
#lorem(100)#pagebreak()

= Grundlagen
#lorem(100)
== Unterpunkt
#lorem(100)
#figure(
  image("img/provadis.png", width: 80%),
  caption: [A curious figure.],
) <glacier>
#pagebreak()

== Unterpunkt
#lorem(100)
=== Unter-Unterpunkt
=== Unter-Unterpunkt
#pagebreak()

== Unterpunkt
#lorem(100)

=== Unter-Unterpunkt
#lorem(100)
= Zusammenfassung

