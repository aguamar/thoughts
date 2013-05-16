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
