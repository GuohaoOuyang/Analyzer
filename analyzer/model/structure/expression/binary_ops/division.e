note
	description: "Summary description for {DIVISION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DIVISION

inherit
	BINARY_OP
		redefine
			accept
		end

create
	make

feature -- Visitor operations
	accept (v: VISITOR)
		do
			v.visit_division (Current)
		end

end
