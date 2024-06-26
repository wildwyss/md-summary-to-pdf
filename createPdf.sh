#!/bin/bash
if [ -z "$1" ]; then
   name="output.tex"
else
  name="${1}.tex"
fi

pandoc -o "${name}" -f markdown -t latex --template=template.tex *.md --listings
sed -i 's/\\includegraphics{\(.*\)}/\\begin{figure}[H]\\centering\\includegraphics[width=\\imagewidth]{\1}\\end{figure}/g' output.tex
pdflatex  -interaction=nonstopmode "${name}"
rm ${name}
