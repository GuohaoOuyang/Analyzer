note
	description: "Summary description for {MULTIPLICATION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MULTIPLICATION

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
			v.visit_multiplication (Current)
		end

end
