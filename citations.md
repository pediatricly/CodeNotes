Based initially on [Writing academic papers on the command line](https://www.youtube.com/watch?v=nO4T8JDNYG0)

23 Jan
Got pdfinfo working but the metadata are disappointing, frequently missing the 
DOI

Next step he uses is tapping crossref with curl

```bash
doi2bib ()
{
	echo >> bib.bib
	curl -s "http://api.crossref.org/works/$1/transform/application/x-bibtx" >> bib.bib
	echo >> bib.bib
}
```

Btw, you'll want to setup [pandoc](https://github.com/vim-pandoc/vim-pandoc) (once you have pathogen)
