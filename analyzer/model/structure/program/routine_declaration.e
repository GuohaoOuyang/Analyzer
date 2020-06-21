note
	description: "Summary description for {ROUTINE_DECLARATION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ROUTINE_DECLARATION

create
    make

feature --attribute
	qname : STRING
	parray : PARAMETERS
	returnt : TYPES
	assignment : LINKED_LIST[ASSIGNMENT]
	tc_report: STRING

feature
	make ( f: STRING; j: ARRAY[TUPLE[s: STRING ; t : STRING]]; rt : STRING)
	  do
         qname := f
         create parray.make(j)
         create returnt.make (rt)
         create assignment.make
         create tc_report.make_empty
	  end


feature
	pretty_print: STRING

		do
			create Result.make_empty
			-- prints type, name, parameters
			-- print assignments (using from loop see the classes for details)
			Result.append ("%N    " +returnt.get_java + " " + qname + "(")
            across 1 |..| parray.parameter.count
            is
                in
            loop
                parray.instance (in)
            	Result.append (parray.ty + " " + parray.na )
            	if
            	   	in /~ parray.parameter.count
            	then
            	   	Result.append (", ")
            	end
            end
            Result.append (")"  +" {")
            Result.append ("%N      A Result = null;")
            if
            	not assignment.is_empty
            then
            	from
            		assignment.start
            	until
            		assignment.after
            	loop

            		Result.append ("%N      " +assignment.item.print_java)
            		assignment.forth
            	end
            end
            Result.append ("%N      return Result;")
            Result.append ("%N    }")
		end

	type_check: BOOLEAN
		local
			t: STRING
		do
			tc_report.make_empty
			Result := true
			across
				assignment as cursor
			loop
				if
					not cursor.item.type_check
				then
					Result := false
					t := cursor.item.print_java
					t.remove_tail (1)
					tc_report.append ("   "+ t +" in routine "+ qname +" is not type-correct.%N")
				end
			end
		end

	get_tc_report: STRING
		do
			Result := tc_report.out
		end

	get_type: STRING
		do
			Result := returnt.out
		end
end
