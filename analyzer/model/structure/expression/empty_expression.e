note
	description: "Summary description for {EMPTY_EXPRESSION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EMPTY_EXPRESSION

inherit
	EXPRESSION

create
	make

feature -- constructor
	make
		do
		end

feature -- Visitor operations
	accept (v: VISITOR)
		do
		end
end
