note
	description: "Summary description for {SUBTRACTION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SUBTRACTION

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
			v.visit_subtraction (Current)
		end
end
