note
	description: "Summary description for {GREATER_THAN}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	GREATER_THAN

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
			v.visit_greater_than (Current)
		end

end
