# How to use

1. Add this repository as a submodule

    `git submodule add https://github.com/lbsekr/provadis-typst-template.git`

2. Create a new main.typ file and use the template
```
echo "#import \"provadis-typst-template/template.typ\": Template
#let translations = json(\"provadis-typst-template/translations.json\").at(\"de\")

#show: Template.with(
  document-type: \"Bachelorarbeit\",
)
" > main.typ
```
