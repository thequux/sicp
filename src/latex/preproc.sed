#!/bin/sed -Ef
1,/<div class=navigation>/d
/<p><div class=navigation>/,$d

# clean up index references
s@<a name="%_idx_[[:digit:]]*"></a>@@g

# Clean up xrefs
s@<a href="#%_(fig)_([[:digit:].]*)">\2</a>@\\ref{\1:\2}@g
s@<a href="(book-Z-H-[[:digit:]]*\.html)?#%_(sec)_([[:digit:].]*)">\3</a>@\\ref{\2:\3}@g
s@<a href="#%_(thm)_([[:digit:].]*)">\2</a>@\\ref{exc:\2}@g


# Clean up spacing
s@&nbsp;@ @g
s@<br>$@@g
s@<p>@@g

s@<h2><a href=[^>]*>([[:digit:].]+) +([^<]*)</a></h2>@\\section{\2}\n\\label{sec:\1}@
s@<h3><a href=[^>]*>([[:digit:].]+) +([^<]*)</a></h3>@\\subsection{\2}\n\\label{sec:\1}@
s@<h4><a href=[^>]*>([^ [:digit:]][^<]*)</a></h4>@\\subsubsection*{\1}@

# Replace formatting
s@<tt>([^<]*)</tt>@\\scheme|\1|@g
s@<tt>@\\begin{schemedisplay}\n@
s@</tt>@\\end{schemedisplay}@
s@<em>([^<]*)</em>@\\textit{\1}@g

s@<ul>@\\begin{itemize}@
s@</ul>@\\end{itemize}@
s@<li>@\\item @

# Symbols...
s/<img src="book-Z-G-D-3.gif" border="0">/$\\Theta$/g
