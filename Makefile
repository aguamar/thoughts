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
##

pages := $(patsubst %.pg, %.html, \
	$(shell find docs/ -name '*.pg'))
articles := $(patsubst %.txt, %.html, \
	$(shell find docs/ -name '*.txt'))
www_root := www-root/

# configured repo2html command
repo2html := repo2html \
		-t 'Mike Gerwitz' \
		-d 'Free Software Hacker' \
		-c 'Mike Gerwitz' \
		-l 'Verbatim redistribution of this document in its entirety is permitted provided that this copyright notice is preserved.' \
		-C '/style.css' \
		-T "$(PWD)/tpl" \
		-E

.PHONY: default clean pages articles thoughts

default: www-root

thoughts:
	mkdir -p "$(www_root)"
	$(repo2html) \
		-R 40 \
		-o "$(www_root)" \
		'http://mikegerwitz.com/thoughts/' \
		> "$(www_root)/index.html"

# all .txt articles will be compiled with asciidoc, then post-processed with the
# mgify script
%.html: %.txt
	asciidoc -fasciidoc.conf -v \
		-a stylesdir= \
		-a themedir=$(PWD)/ \
		$<
	./tools/mgify "$@"

%.html: %.pg
	$(repo2html) -i index < $< > $@

pages: $(pages)
articles: $(articles)
docs: pages articles
www-root: docs thoughts
	mkdir -p www-root/papers
	( cd docs/ && find . -name '*.html' -exec ../tools/doc-cp {} ../www-root/{} \; )
	cp -r images/ www-root/
	cp style.css www-root/
	ln -sf ../images www-root/papers/images

clean:
	rm -rf [0-9]*/ www-root/
