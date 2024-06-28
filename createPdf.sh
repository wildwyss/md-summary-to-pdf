#!/bin/bash
if [ -z "$1" ]; then
  name="output"
else
  name="${1}"
fi

currentdir=$(pwd)
if [ -z "$2" ]; then
  workdir="${currentdir}"
else
  workdir="${2}"
fi

if [ -z "$3" ]; then
  file="*.md"
else
  file="${3}"
fi

cd "${workdir}"

pandoc -o "${name}.tex" -f markdown -t latex --template="${currentdir}/template.tex" "${file}" --listings
sed -i '' 's/\\includegraphics{\(.*\)}/\\begin{figure}[H]\\centering\\includegraphics[width=\\imagewidth]{\1}\\end{figure}/g' "${name}.tex"
pdflatex  -interaction=nonstopmode "${name}.tex"
rm "${name}.tex"
rm "${name}.aux"
rm "${name}.log"

mv "${name}.pdf" "${currentdir}/${name}.pdf"
