note
	description: "Summary description for {EQUALS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EQUALS

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
			v.visit_equal (Current)
		end

end
