note
	description: "Summary description for {CLASSES}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CLASSES

create
    make

feature -- attribute
    attributes: LINKED_LIST[ATTRIBUTE_DECLARATION]
    name : STRING
    commands : LINKED_LIST[COMMAND]

    --linked list of routine
    queries : LINKED_LIST [ROUTINE_DECLARATION]

feature
    make (c : STRING)
      do
      	name := c
      	create {LINKED_LIST[ATTRIBUTE_DECLARATION]} attributes.make
      	create {LINKED_LIST[COMMAND]} commands.make
      	create {LINKED_LIST[ROUTINE_DECLARATION]} queries.make
      end

feature
	add_attribute (a : ATTRIBUTE_DECLARATION)
	  do
          attributes.extend(a)
	  end

feature
    add_query (q : ROUTINE_DECLARATION)
      do
         queries.extend (q)
      end

feature
	add_command (c : COMMAND)
	  do
         commands.extend(c)
	  end

feature -- Queries
	pretty_print: STRING
		do
			create Result.make_empty
			Result.append ("  class " + name +" {")
			--print attributes
			from
				attributes.start
			until
				attributes.after
			loop
				Result.append ("" +attributes.item.pretty_print)
				attributes.forth
			end
			--print query
			from
				queries.start
			until
				queries.after
			loop
				Result.append ("	"+queries.item.pretty_print)
				queries.forth
			end
			--print command
			from
				commands.start
			until
				commands.after
			loop
				Result.append ("" +commands.item.pretty_print)
				commands.forth
			end
			Result.append (  "%N  }")
		end

	type_check: BOOLEAN
		local
			i: INTEGER
			query_result: BOOLEAN
			command_result: BOOLEAN
		do
			Result :=
				(across
					queries as cursor
				all
					cursor.item.type_check
				end)
				and (across
					commands as cursor
				all
					cursor.item.type_check
				end)
		end

	tc_report: STRING
		do
			create Result.make_empty
			across
				queries as cursor
			loop
				Result.append(cursor.item.get_tc_report)
			end
			across
				commands as cursor
			loop
				Result.append(cursor.item.get_tc_report)
			end
		end

	has_attribute (n: STRING): BOOLEAN
		do
			Result := false
			across
				attributes as cursor
			loop
				if cursor.item.name ~ n then
					Result := true
				end
			end
		end

	get_attribute_type (n: STRING): STRING
		do
			create Result.make_empty
			across
				attributes as cursor
			loop
				if cursor.item.get_name ~ n then
					Result.append(cursor.item.get_type)
				end
			end
		end

end
