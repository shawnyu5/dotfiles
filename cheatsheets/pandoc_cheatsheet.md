# pandoc

`pandoc`

By default, pandoc acts as a filter. It takes markdown as
input and converts it into html.

We could convert go in reverse

`pandoc -f html -t markdown`

# converting file formates

`pandoc file1.md -f markdown -t html -s -o file2.html`

`file1.html` - the file that will be converted

`-f markdown` - the original file type.

`-s` option says to create a “standalone” file, with a
header and footer, not just a fragment.

`-o file2.html` - the output file
