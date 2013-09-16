#!/bin/sed -Ef
/<body>/{
	s/.*/% -*- TeX-master: "sicp.tex" -*-/
	p
}
1,/<div class=navigation>/d
/<p><div class=navigation>/,$d

# clean up index references
s@<a name="%_idx_[[:digit:]]*"></a>@@g

# Clean up xrefs
s@<a href="#%_(fig)_([[:digit:].]*)">\2</a>@\\ref{\1:\2}@g
s@<a href="(book-Z-H-[[:digit:]]*\.html)?#%_(sec)_([[:digit:].]*)">\3</a>@\\ref{\2:\3}@g
s@<a href="(book-Z-H-[[:digit:]]*\.html)?#%_(thm)_([[:digit:].]*)">\3</a>@\\ref{exc:\3}@g
s@<a name="%_sec_(Temp_)?([[:digit:].]*)"></a>@@g
s@<a name="footnote_Temp_[0-9]*" href="#call_footnote_Temp_[0-9]*"><sup><small>([0-9]*)</small></sup></a> *@% Footnote \1\n@g
s@<a name="call_footnote_Temp_[0-9]*" href="#footnote_Temp_[0-9]*"><sup><small>([0-9]*)</small></sup></a>@\\footnote{\1}@g
s@<div class=footnote>@@g


# Clean up spacing
s@&nbsp;@ @g
s@<br>$@@g
s@<p>@@g


# Replace formatting
s@<tt>([^<]*)</tt>@\\scheme|\1|@g
s@<tt>@\\begin{schemedisplay}\n@
s@</tt>@\\end{schemedisplay}@
s@<em>([^<]*)</em>@\\textit{\1}@g

s@<ul>@\\begin{itemize}@
s@</ul>@\\end{itemize}@
s@<li>@\\item @

s@<a name="%_thm_([0-9.]*)"></a>@\\begin{Exercise}\n\\label{exc:\1}@g
s@<b>Exercise ([0-9.]*).</b> *@@g

# Symbols...
s/<img src="book-Z-G-D-3.gif" border="0">/$\\Theta$/g
s/<img src="book-Z-G-D-6.gif" border="0">/$\\lambda$/g
s/<img src="book-Z-G-D-9.gif" border="0">/\\pi /g
s/<img src="book-Z-G-D-11.gif" border="0">/\\phi /g
s/<img src="book-Z-G-D-13.gif" border="0">/\\sqrt /g
s/<img src="book-Z-G-D-16.gif" border="0">/\\uparrow /g
s/<img src="book-Z-G-D-17.gif" border="0">/\\rightarrow /g
s/<img src="book-Z-G-D-18.gif" border="0">/\\vdots /g

s/\&gt;/>/g
s/\&lt;/</g
s/\&quot;/"/g

s@<h2><a href=[^>]*>([[:digit:].]+) +([^<]*)</a></h2>@\\section{\2}\n\\label{sec:\1}@
s@<h3><a href=[^>]*>([[:digit:].]+) +([^<]*)</a></h3>@\\subsection{\2}\n\\label{sec:\1}@
s@<h4><a href=[^>]*>([^ [:digit:]][^<]*)</a></h4>@\\subsubsection*{\1}@

# Document structure

# TODO: 
# - <u>[<>]</u>
# - <\textit{??}>
