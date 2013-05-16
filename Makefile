# builds thoughts
# (well, not quite like that)

.PHONY: default clean


default:
	repo2html \
		-t "Mike Gerwitz's Thoughts and Ramblings" \
		-d 'The miscellaneous thoughts and ramblings of a free software hacker' \
		-c 'Mike Gerwitz' \
		-l 'Verbatim redistribution of this document in its entirety is permitted so long as this copyright notice is preserved.' \
		-R40 \
		'http://mikegerwitz.com/thoughts/' \
		> index.html

clean:
	rm -rf [0-9]*/
