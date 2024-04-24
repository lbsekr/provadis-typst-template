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
  abbreviation_entries: (),
  show_lists_after_content: false,
  ai_entries: (),
  body
  ) = {
  let translations = json("translations.json").at(language)

  // Main Context
  context {
    let glossary-page(heading-text, entries) = {
      if entries.len() == 0 {
        return
      }

      pagebreak()
      heading(heading-text, supplement: translations.vorwort, numbering: none, outlined: true, )
      print-glossary(entries)
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
            if show_lists_after_content {
              pagebreak()
            }
            show outline: set heading(
              outlined: true,
              supplement:  [#translations.vorwort]
            )
          
            outline(
              title: translations.abbildungsverzeichnis,  
              depth: 3,
              indent: true,
              target: figure.where(kind: image)
            )
          }  
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
      )
    )

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
    // -----------------
    //  PRE-AMBEL STUFF
    // -----------------
    set par(justify: true, leading: 1.1em)
    set page(
      header: context {
        let section = ""
        let here = here()
        let selector = heading.where(level: 1, supplement: [#translations.vorwort])
          .or(heading.where(level: 1, supplement: [#translations.kapitel]))
      
        let before = query(
          selector.before(here, inclusive: false)
        )
      
        let page_sections =  query(
          selector.after(here)
        ).filter((it) => it.location().page() == here.page())

        if before.len() > 0 and page_sections.len() == 0{
          section = before.last().body
        }else if page_sections.len() > 0 {
          section = page_sections.first().body
        }

        stack(
          dir: ttb, [#section #h(1fr) #counter(page).display(here.page-numbering())], [#v(4pt)],[#line(length: 100%)]
        )
      },
      margin: (
        top: 2cm,
        right: 2cm,
        left: 3.5cm,
        bottom: 1cm
      ),
      numbering: "i",
      number-align: top + right
    )

    // Confidental Clause
    if confidental_clause == true {
      context {
        heading(translations.confidentalClaus, outlined: false, numbering: none,supplement: translations.vorwort)  
        v(1em)
        text(lang: "de", translations.confidentalClausText)
        v(5em)
        line(length: 16em)
        [#strong(authors.map(author => author.name).join(", "))
        #linebreak()
        #location, den #datetime.today().display("[day].[month].[year]")]
        pagebreak()
      }
    }

    if not show_lists_after_content {
      table_of_figures()
      glossary()
      abbreviations()
    }
    
    set block(spacing: .65em)
    set text(font: "Times New Roman", lang: language, weight: 500, size: 12pt,)

    show outline.entry.where(
      level: 1
    ): it => {
      v(12pt, weak: true)
      strong(it)
    }


    show outline: set heading(
      outlined: false,
      supplement: translations.vorwort
    ) 

    context {
      if abbreviation_entries.len() != 0 and not show_lists_after_content {
        pagebreak()
      }
      outline(
        depth: 3,
        indent: true,
        target: heading.where(supplement: [#translations.kapitel])
        .or(heading.where(supplement: [#translations.vorwort]))
      )
    }

    
    if appendix.len() > 0 {
      show outline: set heading(
        outlined: false,
        supplement: translations.vorwort
      )

      outline(
        title: translations.appendix,
        depth: 3,
        indent: true,
        target: heading.where(supplement: [#translations.appendix]),
      )
    }


    if show_lists_after_content {
        table_of_figures()
        glossary()
        abbreviations()
    }

    
    // Main Body Context
    context {
      // Main body
      counter(page).update(0)
      set page(numbering: "1")
      set par(justify: true, leading: 1.1em)
      set heading(supplement: [#translations.kapitel])
      set block(spacing: 1.2em)
      set heading(supplement: [#translations.kapitel])
      show heading: it => block(it,below: 1.1em)

      body

      // After Main Body Contexts
      context {

        set heading(supplement: [#translations.kapitel])
        counter(page).update(0)
        set page(numbering: "I")

        if bib != none {
          if type(bib) == "string" {
            bibliography(bib)
          } else {
            bibliography(..bib)
          }
        }

        pagebreak()

        set heading(numbering: none)

        // AI
        heading(translations.ki.verzeichnis)
        if ai_entries.len() == 0 {
          [#translations.ki.unbenutzt]
        } else {
          table(
            columns: (auto, auto, auto),
            align: horizon,
            table.header(
              [*#translations.ki.system*], [*#translations.ki.prompt*], [*#translations.ki.verwendung*],
            ),
            ..ai_entries.flatten()
          )

        }


        // Appendix
        if appendix.len() > 0 {
          context {
            pagebreak()
            heading(translations.appendix, outlined: false)
            set heading(numbering: "A")
            counter(heading).update(0)

            appendix.join()
          }
        }


        // 🇺🇸🇺🇸🇺🇸🇺🇸🇺🇸🇺🇸🦅🦅🦅🦅🗽🗽🗽🔫🔫🔫
        if declaration_of_independence {
          pagebreak()
          set page(header: none, numbering: none)
          set heading(numbering: none)
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
    }
  }
}