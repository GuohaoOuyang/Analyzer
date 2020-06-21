note
	description: "Summary description for {COMMAND}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	COMMAND

create
    make

feature --attribute
	cname : STRING
	parray : PARAMETERS
    assignment : LINKED_LIST[ASSIGNMENT]

feature {NONE}
    tc_report: STRING

feature --initialize
	make ( c: STRING; j: ARRAY[TUPLE[s: STRING ; t : STRING]])
	  do
         cname := c
         create parray.make(j)
         create assignment.make
         create tc_report.make_empty
	  end

feature
	pretty_print: STRING
		do
			create Result.make_empty
			Result.append ("%N    void "  + cname + "(")
			if
				parray.parameter.is_empty
			then
				Result.append (") {")
			else
				across 1 |..| parray.parameter.count
                is
                   in
                loop
                   parray.instance (in)
            	   Result.append (parray.ty + " " + parray.na  )
            	   if
            	   	in /~ parray.parameter.count
            	   then
            	   	Result.append (", ")
            	   end
                end
                Result.append (")"  +" {")
			end
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
            Result.append ("%N    }")
		end

	type_check: BOOLEAN
		do
			tc_report.make_empty
			Result := true
			across
				assignment as cursor
			loop
				if
					not cursor.item.type_check
				then
					tc_report.append (cursor.item.get_tc_report)
					Result := false
				end
			end
		end

	get_tc_report: STRING
		do
			Result := tc_report.out
		end


end
