cat preamble.html > resume.html
python -m markdown -x smarty resume.md >> resume.html
cat postamble.html >> resume.html