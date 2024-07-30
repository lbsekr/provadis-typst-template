#import "@preview/glossarium:0.4.1": print-glossary, make-glossary

#show: make-glossary

#let code_identifier =  "code"

#let code(body,caption: "",supplement: "") = {
  figure(
    body,
    kind: code_identifier,
    caption: caption,
    supplement: supplement
  )
}
#let custom-outline-entry(it) = {
  let children = it.body.at("children")
  let prefix = children.slice(0, 4).join([])
  let body = children.slice(4)
  if body.len() == 1 and body.at(0).has("text") {
    return link(it.element.location())[*#prefix* #body.at(0).text #box(width: 1fr, repeat[.]) #it.page]
  } else {
    let i = body.position(it => it.has("text") and it.text == "(Quelle")
    let bodyWithoutCite = body.slice(0, i)
    return link(it.element.location())[*#prefix* #bodyWithoutCite.join([]) #box(width: 1fr, repeat[.]) #it.page]
  }
}


#let Template(
  language: "de",
  title: [Textvorlage für wissenschaftliche Arbeiten

Titel und Untertitel der Arbeit],
  authors: (
    (
      name: "Max Julian Mustermann", 
      email: "max.mustermann@stud-provadis-hochschule.de", 
      postal: "Hauptstraße 10, D-10341 Hauptstadt",
      matrikel: "XXXX"
    ),
  ),
  logo: image("img/t-systems.png", width: 180pt, height: 2.06cm, fit: "contain"),
  abstract: lorem(100),
  preface: lorem(100),
  acknowledgement: "Für meine Brudis",
  document-type: "Wiss. Kurzbericht / WAB / Bachelorarbeit / Masterarbeit",
  reason: [
    Zur Veranstaltung… / zur Erlangung des akademischen Grades \
    ’Bachelor of Science’ B.Sc. / ’Master of Science’ M.Sc. \
    im Studiengang ’XXX’
  ],
  submitted_to: [
    vorgelegt dem Fachbereich Informatik und Wirtschaftsinformatik der \
    Provadis School of International Management and Technology \
    von \
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
  glossary_disable_back_refs: false,
  outline_depth: 3,
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
      print-glossary(entries, disable-back-references: glossary_disable_back_refs)
    }

    let glossary() = {
      glossary-page(translations.glossar, glossary_entries)
    }

    let abbreviations() = {
      glossary-page(translations.abkuerzungsverzeichnis, abbreviation_entries)
    }

    // Man könnte die ganzen Tables wsl. abstrahieren. Aber kein Bock
    let table_of_code()  = {
      locate(loc => {
        if counter(figure.where(kind: code_identifier)).final(loc).at(0) > 0 {
            context {
              pagebreak()
          
              show outline: set heading(
                outlined: true,
                supplement:  [#translations.vorwort]
              )
            
              outline(
                title: translations.codeausschnittverzeichnis,  
                depth: 3,
                indent: true,
                target: figure.where(kind: code_identifier)
              ) 
            }

        }
      })
    }

    let table_of_tables()  = {
      locate(loc => {
        if counter(figure.where(kind: table)).final(loc).at(0) > 0 {
          context {
              pagebreak()
              // v(2em)
          
              show outline: set heading(
                outlined: true,
                supplement:  [#translations.vorwort]
              )

              show outline.entry.where(level: 1): custom-outline-entry

              outline(
                title: [
                  #translations.tabellenverzeichnis
                ],  
                depth: 1,
                indent: true,
                target: figure.where(kind: table)
              ) 
            }
          }
        }
      )
    }

    let table_of_figures() = {
      locate(loc => {
        if counter(figure.where(kind: image)).final(loc).at(0) > 0 {
          context {
            if show_lists_after_content {
              pagebreak()
            }
            show outline: set heading(
              outlined: true,
              supplement:  [#translations.vorwort]
            )
            show outline.entry.where(level: 1): custom-outline-entry
          
            outline(
              title: [
                  #translations.abbildungsverzeichnis
                ],  
              depth: 1,
              indent: true,
              target: figure.where(kind: image)
            )
          }  
        }
      })
    }

    let lists = [
      #table_of_figures()
      #table_of_code()
      #table_of_tables()
      #glossary()
      #abbreviations()
    ]

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

    place(
      top,
      float: false,
      clearance: 0em,
        grid(
        columns: (1fr,1fr),
        align(left ,image("img/provadis.png", height: 2.06cm)),
        align(right,logo),
      )
    )

    v(11em)

    align(center, text(1.1em,document-type)) 

    v(1cm)

    set par(leading: 1em)
    align(center,
      text(14pt, weight: 600, title)
    )

    v(2.5cm)

    set par(justify: true, leading: 1.5em)
    align(center, 
      text(1.1em, reason),
    ) 

    v(1cm)
    set par(justify: true, leading: 1em)

    align(center, 
      text(1.1em, submitted_to),
    ) 
    
    v(2em)
    set block(spacing: 1em)
    align(
      center,
      grid(
        ..authors.map(author => align(center)[
          #author.name 

          #author.matrikel 

          #author.email 

          #author.postal 

          #{if author.keys().contains("affiliation") {
            author.affiliation
          }}
        ]),
      )
    )

    place(
      bottom + left,
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
        [#deadline],
        v(1em)
      )
    )
    


  
    // Workaroung um Monate in der ausgewählte Sprache (deutsch,english) anzuzeigen, bis Typst es out-of-the-box unterstüzt
    // text(
    //   [
    //     Frankfurt am Main, #translations.meta.monatZeitPrefix #translations.monate.at(datetime.today().display("[month repr:long]")) #datetime.today().display("[year]")
    //   ]
    // )
    // v(.5fr)

    if type(acknowledgement) == "content" or type(acknowledgement) == "string" {
      pagebreak()
      place(
        center + horizon,
        text(acknowledgement, style: "italic", size: 14pt)
      )
    }

    counter(page).update(0)

pagebreak() 
place(
        center + horizon,
        text("Placeholder for Steckbrief", style: "italic", size: 14pt)
      )

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
        top: 3cm,
        right: 2cm,
        left: 3cm,
        bottom: 2cm
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

    if type(abstract) == "content" or type(abstract) == "string" {
      heading(translations.abstract, outlined: false, numbering: none,supplement: translations.vorwort)
      v(1em)

      abstract
      pagebreak()
    }

    if type(preface) == "content" or type(preface) == "string" {
      heading(translations.vorwort, outlined: false, numbering: none,supplement: translations.vorwort)
      v(1em)

      preface
      pagebreak()
    }

    if not show_lists_after_content {
      lists
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
        depth: outline_depth,
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
      pagebreak()
      outline(
        title: translations.appendix,
        depth: outline_depth,
        indent: true,
        target: heading.where(supplement: [#translations.appendix]),
      )
    }


    if show_lists_after_content {
      lists
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
            bibliography(bib, style: "ieee", title: "Literaturverzeichnis")
          } else {
            bibliography(..bib, style: "ieee", title: "Literaturverzeichnis")
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
            set heading(numbering: "A", supplement: translations.appendix)
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
          text(lang: "de")[
            Hiermit bestätige ich, dass ich die vorliegende Arbeit persönlich und selbständig verfasst und keine anderen als die angegebenen Quellen und Hilfsmittel verwendet habe.
            Alle Stellen, die wörtlich oder sinngemäß anderen Quellen entnommen wurden, sind als solche kenntlich gemacht.
            Die Zeichnungen, Abbildungen und Tabellen in dieser Arbeit sind von mir selbst erstellt oder wurden mit einem entsprechenden Quellennachweis versehen.
            Diese Arbeit wurde weder in gleicher noch in ähnlicher Form von mir an anderen Hochschulen zur Erlangung eines akademischen Abschlusses eingereicht.
          ]

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
