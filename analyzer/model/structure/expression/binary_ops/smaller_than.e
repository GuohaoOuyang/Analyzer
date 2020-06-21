note
	description: "Summary description for {SMALLER_THAN}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SMALLER_THAN

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
			v.visit_smaller_than (Current)
		end

end
