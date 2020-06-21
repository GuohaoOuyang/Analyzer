note
	description: "Summary description for {BINARY_OP}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BINARY_OP

inherit
	EXPRESSION
	COMPOSITE[EXPRESSION]

create
	make

feature -- Queries
	left: EXPRESSION
		do
			Result := children[1]
		end

	right: EXPRESSION
		do
			Result := children[2]
		end

	set_left (e:EXPRESSION)
		do
			children[1] := e
		end

	set_right (e:EXPRESSION)
		do
			children[2] := e
		end

feature -- Constructor
	make
		local
			l,r: EXPRESSION
		do
			create {CURRENT_EXPRESSION}l.make
			create {NIL_EXPRESSION}r.make

			create children.make
			children.extend (l)
			children.extend (r)
		end

feature -- Visitor operations
	accept (v: VISITOR)
		do

		end

invariant
	binary_operation: children.count = 2

end
