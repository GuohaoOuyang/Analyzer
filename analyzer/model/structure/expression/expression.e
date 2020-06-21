note
	description: "Summary description for {EXPRESSION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EXPRESSION

feature-- Accepting visitor operation
	accept (v: VISITOR)
		deferred
	end

feature -- location holder
	cindex: INTEGER
	qindex: INTEGER
	is_query: BOOLEAN

	set_location (c: INTEGER; q: INTEGER; i_q:BOOLEAN)
		do
			cindex := c
			qindex := q
			is_query := i_q
		end
end
