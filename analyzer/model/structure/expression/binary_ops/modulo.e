note
	description: "Summary description for {MODULO}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	MODULO

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
			v.visit_modulo (Current)
		end
end
