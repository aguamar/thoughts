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
articles := $(patsubst %.txt, %.html, \
	$(shell find docs/ -maxdepth 2 -name '*.txt'))
# articles in TeX with an inappropriate var name
texticles=$(patsubst %/, %.html, $(dir $(shell find docs/ -name 'Makefile')))
www_root := www-root/
url_root := http://mikegerwitz.com
repo_url := https://gitorious.org/mtg-personal/thoughts
repo_commit_url := '$(repo_url)/commit/%s'

# configured repo2html command
repo2html := repo2html \
		-t 'Mike Gerwitz' \
		-d 'Free Software Hacker' \
		-c 'Mike Gerwitz' \
		-l 'Verbatim redistribution of this document in its entirety is permitted provided that this copyright notice is preserved.' \
		-C '/style.css' \
		-T '$(PWD)/tpl' \
		-u '$(repo_url)' \
		-U '$(repo_commit_url)' \
		-E

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
%.html: %.pg docs/papers/.list
	$(repo2html) -icontent -ftools/extfmt <$< >$@

# TeX papers are expected to have their own makefiles as well as an abstract.tex
%.html: coope/%.tex
	$(MAKE) -C '$(dir $<)' pdf dvi
	url_root='$(url_root)' ./tools/texdoc '$(dir $<)' | $(repo2html) -icontent -ftools/extfmt >$@

docs/papers/.list: thoughts articles
	echo "$(articles) $(texticles)" | tr ' ' '\n' | tools/doclist >$@

pages: $(pages)
articles: $(articles) $(texticles)
docs: pages articles
www-root: docs thoughts
	mkdir -p www-root/papers
	( cd docs/ \
		&& find . -maxdepth 2 -name '*.html' -exec ../tools/doc-cp {} ../www-root/{} \; \
		&& find . -maxdepth 3 \( -name '*.pdf' -o -name '*.dvi' \) -exec cp {} ../www-root/{} \; \
	)
	cp -r images/ www-root/
	cp style.css www-root/
	ln -sf ../images www-root/papers/images

clean:
	rm -rf www-root/
	rm -f $(pages) $(articles) $(texticles)
