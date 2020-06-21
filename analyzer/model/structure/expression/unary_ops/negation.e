note
	description: "Summary description for {NEGATION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	NEGATION

inherit
	UNARY_OP
		redefine
			accept
		end
create
	make

feature -- Visitor operations
	accept (v: VISITOR)
		do
			v.visit_negation (Current)
		end
end
