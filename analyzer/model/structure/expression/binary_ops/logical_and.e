note
	description: "Summary description for {LOGICAL_AND}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LOGICAL_AND

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
			v.visit_and (Current)
		end

end
