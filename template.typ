#let Bachelor(
  title: "Platzhaltertitel für eine Bachelorarbeit: Eine Vorläufige Betrachtung",
  authors: (
    (
      name: "Max Julian Mustermann", 
      email: "max.mustermann@stud-provadis-hochschule.de", 
      postal: "Hauptstraße 10, D-10341 Hauptstadt",
      matrikel: "XXXX"
    ),
  ),
  logo: image("img/t-systems.png", width: 120pt),
  abstract: lorem(100),
  document-type: "Bachelorarbeit",
  reason: [
    zur Erlangung des akademischen Grades ’Bachelor of Science’
    B.Sc. im Studiengang Informatik \ \
    vorgelegt dem Fachbereich Informatik der \
    Provadis School of International Management and Technology \
    von
  ],
  first_appraiser: "Prof. Müller",
  second_appraiser: "Dr. Kunze",
  supervisor: "Dr. Peter",
  appendix: (
    [
      #heading("Wichtiger Anhang",supplement: [Appendix])
      #lorem(100)
    ],
     [
      #heading("Weiterer Wichtiger Anhang",supplement: [Appendix])
      #lorem(100)
    ]
  ),
  location: "Berlin" ,
  body
  ) = {
  set document(author: authors.map(a => a.name), title: title)
  set text(font: "Linux Libertine", lang: "de", weight: 500, size: 12pt,)
  set heading(numbering: "1.1")

  grid(
    columns: (1fr,1fr),
    align(left ,image("img/provadis.png", width: 120pt)),
    align(right,logo),
  )

  v(0.5fr)

  align(center, text(1.25em, weight: 600, document-type)) 

  v(0.5fr)

  align(center,
    text(1.5em, title)
  )

  v(1.5fr)

  align(center, 
    text(1.25em, reason),
  ) 
  
  v(.5fr)
  set block(spacing: 1em)
  align(
    center,
    grid(
      ..authors.map(author => align(center)[
        *#author.name* 

        #author.matrikel 

        #author.email 

        #author.postal 

        #{if author.keys().contains("affiliation") {
          author.affiliation
        }}
      ]),
    )
  )

  v(2.4fr)
  grid(
  columns: (auto, auto),
  rows: (auto, auto),
  row-gutter: 15pt,
  column-gutter: 5pt,
  [Erstgutacher:],
  [#first_appraiser],
  [Zweitgutachter:],
  [#second_appraiser],
  [Betreuung:],
  [#supervisor]
  )
 
  v(.5fr)
  text(
    [
      Frankfurt am Main, im #datetime.today().display("[month repr:long] [year]")
    ]
  )
  v(.5fr)
  pagebreak()
    
  set block(spacing: .65em)
  set text(font: "Linux Libertine", lang: "de", weight: 400, size: 12pt)

  show outline.entry.where(
  level: 1
): it => {
  v(12pt, weak: true)
  strong(it)
}

  outline(
    depth: 3,
    indent: true,
    title:"Inhaltsverzeichnis",
    target: heading.where(supplement: [Kapitel])
  )

  if appendix.len() > 0 {
    outline(
      title: [Appendix],
      depth: 3,
      indent: true,
      target: heading.where(supplement: [Appendix]),
    )
  }

  outline(
    title: [Abbildungsverzeichnis],
    depth: 3,
    indent: true,
    target: figure,
  )

  pagebreak()
  // Main body.
  set par(justify: true, leading: 1em)
  set page(numbering: "1")
  set page(numbering: "1", number-align: center)
  counter(page).update(1)
  set heading(supplement: [Kapitel])

  body

  set page(numbering: "I")
  counter(page).update(1)
  bibliography("sources.bib")

  pagebreak()

  //Appendix

  if appendix.len() > 0 {
    counter(heading).update(0)
    set heading(numbering: none)
    set page(numbering: "I")
    heading("Appendix",outlined: false)
    set heading(numbering: "A")

    appendix.join()

    pagebreak()
  }

  set heading(numbering: none)
  set page(numbering: none)
  heading("Eigenständigkeitserklärung", outlined: false)
  [Ich versichere hiermit, dass ich die vorliegende Arbeit selbständig verfasst und keine anderen als die angegebenen Quellen benutzt habe. Alle Stellen, die wörtlich oder sinngemäß anderen Quellen entnommen wurden, sind als solche kenntlich gemacht. Die Zeichnungen, Abbildungen und Tabellen in dieser Arbeit sind von mir selbst erstellt oder wurden mit einem entsprechenden Quellennachweis versehen. Diese Arbeit wurde weder in gleicher noch in ähnlicher Form von mir an dieser oder an anderen Hochschulen eingereicht.]

  v(8%)
  line(length: 50%)
  [#strong(authors.map(author => author.name).join(", "))
  #linebreak()
  #location, den #datetime.today().display("[day].[month].[year]")]


}