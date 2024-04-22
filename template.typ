#import "@preview/glossarium:0.3.0": print-glossary, make-glossary

#show: make-glossary

#let todo(body: "TODO") = {
  rect(
    fill: yellow,
    radius: 1pt,
    body
  )
}

#let Template(
  language: "de",
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
    zur Erlangung des akademischen Grades \
    ’Bachelor of Science’  B.Sc.\ 
    im Studiengang Informatik \ \
    vorgelegt dem Fachbereich \
    Informatik und Wirtschaftsinformatik \ der \
    Provadis School of International Management and Technology \
    von
  ],
  first_appraiser: "Prof. Müller",
  second_appraiser: "Dr. Kunze",
  supervisor: "Dr. Peter",
  bib: none,
  appendix: (),
  location: "Berlin",
  deadline: "15.03.2024",
  declaration_of_independence: true, // 🇺🇸🇺🇸🇺🇸🇺🇸🦅🦅🦅
  confidental_clause: false,
  glossary_entries: (),
  show_glossary: "before_contents", // none, before_contents, after_contents
  abbreviation_entries: (),
  show_abbreviations: "before_contents", // none, before_contents, after_contents
  show_table_of_figures: "before_contents", // none, before_contents, after_contents
  body
  ) = {
  let translations = json("translations.json").at(language)

  let glossary-page(heading-text, entries) = {
    if entries.len() == 0 {
      return
    }

    heading(heading-text, supplement: [#translations.kapitel],  numbering: none, outlined: true, )
    print-glossary(entries)
    // pagebreak()   
  }

  let glossary() = {
    glossary-page(translations.glossar, glossary_entries)
  }

  let abbreviations() = {
    glossary-page(translations.abkuerzungsverzeichnis, abbreviation_entries)
  }

  let table_of_figures() = {
    locate(loc => {
      if counter(figure).final(loc).at(0) > 0 {
        context {
          show outline: set heading(
            outlined: true,
            supplement:  [#translations.kapitel]
          )
        
          outline(
            title: translations.abbildungsverzeichnis,  
            depth: 3,
            indent: true,
            target: figure.where(kind: image)
          )
        }
        // pagebreak()
      }
    })
  }

  set document(author: authors.map(a => a.name), title: title)
  set text(font: "Times New Roman", lang: language, weight: 500, size: 12pt,)
  set heading(numbering: "1.1")
  show: make-glossary

  // -------------
  //  COVER PAGE
  // -------------
  set page(
    margin: (
      top: 2cm,
      right: 2cm,
      left: 2cm,
      bottom: 1cm
    ))

  grid(
    columns: (1fr,1fr),
    align(left ,image("img/provadis.png", width: 120pt)),
    align(right,logo),
  )

  v(2em)

  align(center, text(1.25em, weight: 600, document-type)) 

  v(2em)

  align(center,
    text(1.5em, title)
  )

  v(1em)

  set par(justify: true, leading: 1em)
  align(center, 
    text(1.25em, reason),
  ) 
  
  v(2em)
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
    column-gutter: 15pt,
    [#translations.erstgutachter:],
    [#first_appraiser],
    ..({if second_appraiser != none {
            (
              [#translations.zweitgutachter:],
              [#second_appraiser]
            )
      }}
    ),    [#translations.betreuung:],
    [#supervisor],
    [#translations.endeDerBearbeitungsfrist:],
    [#deadline]
  )

 
  v(.5fr)
  // Workaroung um Monate in der ausgewählte Sprache (deutsch,english) anzuzeigen, bis Typst es out-of-the-box unterstüzt
  text(
    [
      Frankfurt am Main, #translations.meta.monatZeitPrefix #translations.monate.at(datetime.today().display("[month repr:long]")) #datetime.today().display("[year]")
    ]
  )
  v(.5fr)
  counter(page).update(0)
  set page(
    header: context {
      let section = ""
      let here = here()
      let selector = heading.where(level: 1, supplement: [#translations.kapitel])
      let before = query(
        selector.before(here, inclusive: false)
      )
      let page_sections =  query(
        selector.after(here)
      ).filter((it) => it.location().page() == here.page())

      if before.len() > 0 and page_sections.len() == 0{
        section = before.last().body
      }else if page_sections.len() > 0 {
        section = page_sections.last().body
      }

      stack(
        dir: ttb, [#section #h(1fr) #numbering(here.page-numbering(),counter(page).get().at(0))], [#v(4pt)],[#line(length: 100%)]
      )

    }
  )
  pagebreak()

  // -----------------
  //  PRE-AMBEL STUFF
  // -----------------
  set par(justify: true, leading: 1.1em)
  set page(
    margin: (
      top: 2cm,
      right: 2cm,
      left: 3.5cm,
      bottom: 1cm
    ),
    numbering: "I",
    number-align: top + right
  )

  // Confidental Clause
  if confidental_clause == true {
    heading(translations.confidentalClaus, outlined: false, numbering: none,supplement: [#translations.kapitel])  
    v(1em)
    text(lang: "de", translations.confidentalClausText)
    v(5em)
    line(length: 16em)
    [#strong(authors.map(author => author.name).join(", "))
    #linebreak()
    #location, den #datetime.today().display("[day].[month].[year]")]
    pagebreak()
  }


  // Table of Figures
  if show_table_of_figures == "before_contents" {
    table_of_figures()
    pagebreak()
  }

  // Glossary
  if show_glossary == "before_contents" {
    glossary()
    pagebreak()
  }

  // List of abbrevations
  if show_abbreviations == "before_contents" {
    abbreviations()
    pagebreak()
  }

  set block(spacing: .65em)
  set text(font: "Times New Roman", lang: language, weight: 500, size: 12pt,)

  show outline.entry.where(
    level: 1
  ): it => {
    v(12pt, weak: true)
    strong(it)
  }

  context {
    show outline: set heading(
      outlined: true,
      supplement:  [#translations.kapitel]
    )

    outline(
      depth: 3,
      indent: true,
      target: heading.where(supplement: [#translations.kapitel])
    )
  }

  // i cannot put into words how much i hate this
  // but it is necessary due to how counters (not) work
  if show_table_of_figures != "after_contents"  and show_glossary != "after_contents" and show_abbreviations  != "after_contents" and appendix.len() == 0 {
      counter(page).update(0)
    }
  pagebreak()

  // Table of Figures
  if show_table_of_figures == "after_contents" {
    table_of_figures()

    if show_glossary != "after_contents" and show_abbreviations  != "after_contents" and appendix.len() == 0 {
      counter(page).update(0)
    }
    pagebreak()
  }

  // Glossary
  if show_glossary == "after_contents" {
    glossary()

    if show_abbreviations  != "after_contents" and appendix.len() == 0 {
      counter(page).update(0)
    }
    pagebreak()
  }

  // List of abbrevations
  if show_abbreviations == "after_contents" {
    abbreviations()

    if appendix.len() == 0 {
      counter(page).update(0)
    }
    pagebreak()
  }

  if appendix.len() > 0 {
    outline(
      title: translations.appendix,
      depth: 3,
      indent: true,
      target: heading.where(supplement: [#translations.appendix]),
    )

    counter(page).update(0)
    pagebreak()
  }

  // Main body
  set par(justify: true, leading: 1.1em)
  set page(numbering: "1")
  set block(spacing: 1.2em)
  set heading(supplement: [#translations.kapitel])
  show heading: it => block(it,below: 1.1em)

  body

  pagebreak()

  if bib != none {
    if type(bib) == "string" {
      bibliography(bib)
    } else {
      bibliography(..bib)
    }
    pagebreak() 
  }


  // Appendix
  if appendix.len() > 0 {
    // set page(numbering: "I")
    counter(heading).update(0)
    set heading(numbering: none)
    heading(translations.appendix, outlined: false, )
    set heading(numbering: "A")

    appendix.join()
    pagebreak()
  }


  // 🇺🇸🇺🇸🇺🇸🇺🇸🇺🇸🇺🇸🦅🦅🦅🦅🗽🗽🗽🔫🔫🔫
  if declaration_of_independence {
    set heading(numbering: none)
    set page()
    heading("Ehrenwörtliche Erklärung", outlined: false)
    text(lang: "de", 
    "Hiermit bestätige ich, dass ich die vorliegende Arbeit persönlich und selbständig verfasst und keine anderen als die angegebenen Quellen und Hilfsmittel verwendet habe. Alle Stel-len, die wörtlich oder sinngemäß anderen Quellen entnommen wurden, sind als solche kennt-lich gemacht. Die Zeichnungen, Abbildungen und Tabellen in dieser Arbeit sind von mir selbst erstellt oder wurden mit einem entsprechenden Quellennachweis versehen. Diese Arbeit wurde weder in gleicher noch in ähnlicher Form von mir an anderen Hochschulen zur Erlangung eines akademischen Abschlusses eingereicht."
    )

    v(8%)
    line(length: 50%)
    [#strong(authors.map(author => author.name).join(", "))
    #linebreak()
    #location, den #datetime.today().display("[day].[month].[year]")]
  }
}