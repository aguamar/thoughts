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

# list of articles to compile
articles := $(patsubst %.txt, %.html, $(wildcard papers/*.txt))

.PHONY: default clean thoughts


default: www-root

thoughts:
	repo2html \
		-t "Mike Gerwitz's Thoughts and Ramblings" \
		-d 'The miscellaneous thoughts and ramblings of a free software hacker' \
		-c 'Mike Gerwitz' \
		-l 'Verbatim redistribution of this document in its entirety is permitted so long as this copyright notice is preserved.' \
		-R40 \
		'http://mikegerwitz.com/thoughts/' \
		> index.html

# all .txt articles will be compiled with asciidoc, then post-processed with the
# mgify script
%.html: %.txt
	asciidoc -fasciidoc.conf -v \
		-a stylesdir=$(PWD)/asciidoc-themes/ \
		-a themedir=$(PWD)/asciidoc-themes/ \
		$<
	./tools/mgify "$@"

www-root: $(articles) thoughts
	mkdir -p www-root/papers \
		&& cp papers/*.html www-root/papers/ \
		&& cp -r [0-9]* www-root/ \
		&& cp -r images/ www-root/ \
		&& ln -sf ../images www-root/papers/images

clean:
	rm -rf [0-9]*/
