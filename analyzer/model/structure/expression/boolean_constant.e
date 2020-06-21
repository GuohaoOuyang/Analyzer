note
	description: "Summary description for {BOOLEAN_CONSTANT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BOOLEAN_CONSTANT

inherit
	EXPRESSION

create
	make

feature
	value: BOOLEAN

feature -- constructor
	make (b: BOOLEAN)
		do
			value := b
		end

feature -- Visitor operations
	accept (v: VISITOR)
		do
			v.visit_boolean(Current)
		end

end
