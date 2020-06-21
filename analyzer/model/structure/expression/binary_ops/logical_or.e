note
	description: "Summary description for {LOGICAL_OR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LOGICAL_OR

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
			v.visit_or (Current)
		end
end
