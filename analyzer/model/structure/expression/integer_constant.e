note
	description: "Summary description for {INTEGER_CONSTANT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	INTEGER_CONSTANT

inherit
	EXPRESSION

create
	make

feature
	value: INTEGER

feature -- Constructor
	make (i: INTEGER)
		require
			larger_value:
				i > 0
		do
			value := i
		end

feature -- Visitor operations
	accept (v: VISITOR)
		do
			v.visit_integer (Current)
		end

end
