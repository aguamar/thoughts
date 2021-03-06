# Builds thoughts (well, not quite like that)
#
#  Copyright (C) 2013  Mike Gerwitz
#
#  This program is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program.  If not, see <http://www.gnu.org/licenses/>.
# #

pages := $(patsubst %.pg, %.html, \
         $(shell find docs/ -name '*.pg'))
pages_md := $(patsubst %.md, %.html, \
            $(shell find docs/ -name '*.md'))
articles := $(patsubst %.txt, %.html, \
	$(shell find docs/ -maxdepth 2 -name '*.txt' | grep -Fv /gh/))
# articles in TeX with an inappropriate var name
texticles=$(patsubst %/, %.html, $(dir $(shell find docs/ -name 'Makefile')))
www_root := www-root/
url_root := https://mikegerwitz.com
repo_url := https://mikegerwitz.com/projects/thoughts
repo_commit_url := '$(repo_url)/commit/?id=%s'

# configured repo2html command
repo2html := repo2html \
		-t 'Mike Gerwitz' \
		-d 'Free Software Hacker+Activist' \
		-c 'Mike Gerwitz' \
		-l 'This content is licensed under the Creative Commons Attribution-ShareAlike 4.0 International License.' \
		-C '/style.css' \
		-f 'tools/thoughts-fmt' \
		-F .listfilter \
		-T '$(PWD)/tpl' \
		-u '$(repo_url)' \
		-U '$(repo_commit_url)' \
		-E ''

.PHONY: default clean pages articles thoughts docs

default: www-root

thoughts:
	mkdir -p "$(www_root)"
	$(repo2html) \
		-R 40 \
		-o "$(www_root)" \
		'$(url_root)' \
		> "$(www_root)/index.html"

# all .txt articles will be compiled with asciidoc, then post-processed with the
# mgify script
%.html: %.txt
	asciidoc -fasciidoc.conf -v \
		-a stylesdir= \
		-a themedir=$(PWD)/ \
		$<
	./tools/mgify "$@"

# "pages"
%.html: %.pg docs/papers/.list tpl/.config
	$(repo2html) -icontent -ftools/extfmt <$< >$@
%.html: %.md tpl/.config
	$(repo2html) -icontent -ftools/mdfmt <$< >$@

# TeX papers are expected to have their own makefiles as well as an abstract.tex
%.html: coope/%.tex
	$(MAKE) -C '$(dir $<)' pdf dvi
	url_root='$(url_root)' ./tools/texdoc '$(dir $<)' | $(repo2html) -icontent -ftools/extfmt >$@

docs/papers/.list: thoughts articles
	echo "$(articles) $(texticles)" | tr ' ' '\n' | tools/doclist >$@

images: images/tp/Makefile
	$(MAKE) -C '$(dir $<)' all check
images/tp/Makefile: images/tp/gen-makefile
	( cd images/tp/ && ./gen-makefile ) >$@

pages: $(pages) $(pages_md)
articles: $(articles) $(texticles)
docs: pages articles
www-root: docs thoughts images
	mkdir -p www-root/papers
	( cd docs/ \
		&& find . -maxdepth 2 -name '*.html' -exec ../tools/doc-cp {} ../www-root/{} \; \
		&& find . -maxdepth 3 \( -name '*.pdf' -o -name '*.dvi' \) -exec cp {} ../www-root/{} \; \
	)
	mkdir -p www-root/images/
	cp -v images/*.* images/tp/*.png www-root/images/
	cp -rv fonts/ www-root/
	cp -rv _raw/* www-root/
	cp -v style.css www-root/
	mkdir -p www-root/docs
	cp -rv docs/gh/ www-root/docs/
	cp -rv docs/about/resume www-root/about/
	cp -rv docs/hoxsl www-root/hoxsl

clean:
	rm -rf www-root/
	rm -f $(pages) $(pages_md) $(articles) $(texticles)
