note
	description: "Summary description for {ADDITION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ADDITION

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
			v.visit_addition (Current)
		end

end
