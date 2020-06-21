note
	description: "Summary description for {UNARY_OP}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	UNARY_OP

inherit
	EXPRESSION
	COMPOSITE[EXPRESSION]

create
	make

feature -- Queries
	right: EXPRESSION
		do
			Result := children[1]
		end

	set_right (e:EXPRESSION)
		do
			children[1] := e
		end

feature -- Constructor
	make
		local
			r: EXPRESSION
		do
			create {CURRENT_EXPRESSION}r.make

			create children.make
			children.extend (r)
		end

feature -- Visitor operations
	accept (v: VISITOR)
		do
		end

invariant
	unary_operation: children.count = 1

end
