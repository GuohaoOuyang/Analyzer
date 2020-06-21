note
	description: "Summary description for {TYPES}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TYPES

create
	make

feature {NONE} --Attributes
	type: STRING

feature	--Constructor
	make (t: STRING)
		do
			type := t
		end

feature -- Queries
	get : STRING
		do
			Result := type
		end

	get_java: STRING
		do
			if type ~ "INTEGER" then
				Result := "int"
			elseif type ~ "BOOLEAN" then
				Result := "bool"
			else
				Result := type
			end
		end
end
