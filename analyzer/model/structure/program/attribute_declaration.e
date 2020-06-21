note
	description: "Summary description for {ATTRIBUTE_DECLARATION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ATTRIBUTE_DECLARATION

create
    make

feature --attribute
	type : TYPES
	name : STRING

feature
       make (t : STRING; n : STRING)
         do
            create type.make (t)
            name := n
         end

feature -- Queries
	pretty_print: STRING
		local
			t_print: STRING
		do
			if type.get ~ "INTEGER" then
				t_print := "int"
			elseif type.get ~ "BOOLEAN" then
				t_print := "bool"
			else
				t_print := type.get
			end
			create Result.make_empty
			Result.append ("%N" + "    " + t_print+" "+ name+";")
		end

	get_type: STRING
		do
			Result := type.get
		end

	get_name: STRING
		do
			Result := name
		end

end
