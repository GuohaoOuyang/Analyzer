note
	description: "A default business model."
	author: "Jackie Wang"
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_MODEL

inherit
	ANY
		redefine
			out
		end

create {ETF_MODEL_ACCESS}
	make

feature {NONE} -- Initialization
	make
		do
			create s.make_empty
			i := 0
			status := e_report.set_report_ok
			create pro.make
			create cna.make_empty
			create fna.make_empty
			create nna.make_empty
			create fname.make
			create java.make_empty
			create tc.make_empty
			create assft.make_empty
			assci := 0
			assfi := 0
			aindex := 0
		end

feature -- model attributes
	s : STRING
	i : INTEGER
	cna : STRING
	fna : STRING
	nna : STRING
    assci : INTEGER
    assft : STRING
    assfi : INTEGER
    aindex : INTEGER

feature {NONE}
    java : STRING
    tc: STRING

feature -- error report by singleton
    e_report : STATUS_REPORT
    status : STRING

feature -- set status
    set_status (st : STRING)
        do
        	status := st
        end

feature -- linked list of classes
	--Linked list of class
    pro : LINKED_LIST[CLASSES]
    fname : LINKED_LIST [STRING]

feature -- add class
    add_class (cn : STRING)
    local
    	a : CLASSES
        do
           create a.make (cn)
           pro.extend (a)
        end

feature -- add attribute
    add_attribute(cn: STRING ; fn: STRING ; ft: STRING)
        local
        at: ATTRIBUTE_DECLARATION
        do
        	create at.make (ft, fn)
        	across 1 |..| pro.count is clas
        	loop
        		if
        			pro.at (clas).name ~ cn
        		then
        			pro.at (clas).add_attribute (at)
        			fname.force(fn)
        		end
        	end
        end

feature -- add commands
    add_command (cn: STRING ; fn: STRING ; ps: ARRAY[TUPLE[pn: STRING; ft: STRING]])
         local
         	co : COMMAND
        do
            create co.make (fn, ps )
        	across 1 |..| pro.count is com
        	loop
        		if
        			pro.at (com).name ~ cn
        		then
        			pro.at (com).add_command (co)
        			fname.force (fn)
        		end
        	end

        end

feature -- add query
    add_query (cn: STRING ; fn: STRING ; ps: ARRAY[TUPLE[pn: STRING; pt: STRING]] ; rt: STRING)

         local
         	que : ROUTINE_DECLARATION
        do
            create que.make (fn, ps, rt)
        	across 1 |..| pro.count is com
        	loop
        		if
        			pro.at (com).name ~ cn
        		then
        			pro.at (com).add_query (que)
        			fname.force (fn)
        		end
        	end
        end

feature -- add assignment instruction
    add_assignment_instruction(clas : STRING; cin: INTEGER ; ain : INTEGER; assin : INTEGER)
        do
        	assft := clas
        	assfi := ain
        	assci := cin
        	aindex := assin
        end


feature -- geretrate java code
    generate_java_code
        do
        	java := "yes"
        end

feature -- type_checker
	type_check
		do
			tc := "yes"
		end

feature-- duplicate check
    is_class_duplicate(c :STRING) : BOOLEAN
        do
        	if
        		across 1 |..| pro.count is co some pro.at (co).name ~ c  end
        	then
        		Result := True
        	else
        		Result := False
        	end
        end

    is_f_duplicate(cn : STRING; fn : STRING) : BOOLEAN
    local
    	glas : INTEGER
        do
            glas := get_class_index(cn)
            if
                 across 1 |..| pro[glas].attributes.count is coo some
        				     	pro[glas].attributes[coo].name ~ fn
        			    end
        	then
        		 Result := True
            elseif
                 across 1 |..| pro[glas].queries.count is coo some pro[glas].queries[coo].qname ~ fn  end
            then
                 Result := True
            elseif
                 across 1 |..| pro[glas].commands.count is coo some pro[glas].commands[coo].cname ~ fn  end
            then
                 Result := True
            else
                 Result := False
            end


        end

	is_f_attribute(c : STRING; f : STRING) :  BOOLEAN
     	local
     		clin2 : INTEGER
        do
        	clin2 := get_class_index(c)
        	if
        		across 1 |..| pro.at (clin2).attributes.count is co some pro.at (clin2).attributes.at (co).name ~ f  end
        	then
        		Result := True
        	else
        		Result := False
        	end
        end


    get_class_index( c: STRING) : INTEGER
        do
            across
            	1 |..| pro.count is co
            loop
            	if
            		pro.at (co).name ~ c
            	then
            		Result := co
            	end
            end
        end

    is_primitive_or_declared_class (c : STRING) : BOOLEAN
        do
        	if
        		across 1 |..| pro.count is co some pro.at (co).name ~ c end or
        		c ~ "INTEGER" or c ~ "BOOLEAN"
        	then
        		Result := True
        	else
        		Result := False
        	end
        end

	parameter_types_check (c :ARRAY[TUPLE[pn: STRING; FT : STRING]]) : LINKED_LIST[STRING]
		local
     		names: LINKED_LIST[STRING]
        do
        	create names.make
        	across
        		1 |..| c.count is co
        	loop
        		check attached {STRING} c.at (co).at (2) as k then
        		if
        			not is_primitive_or_declared_class(k)
        		then
        			names.force (k)
        		end
        		end

        	end
        	Result := names
        end

     clash_name_with_class_name (c :ARRAY[TUPLE[pn: STRING; FT : STRING]]) : LINKED_LIST[STRING]
     local
     	names: LINKED_LIST[STRING]
        do
        	create names.make
        	across
        		1 |..| c.count is co
        	loop
        		if
        			across 1 |..| pro.count is coo some c.at (co).at (1) ~ pro.at (coo).name  end or
        			c.at (co).at (1) ~ "INTEGER" or c.at (co).at (1) ~ "BOOLEAN"
        		then
                    check attached {STRING} c.at (co).at (1) as cn then
                    	names.force (cn)
                    end

        		end
        	end
        	Result := names
        end

     duplicate_parameter_names (c :ARRAY[TUPLE[pn: STRING; FT : STRING]]) : LINKED_LIST[STRING]
     	local
	     	tnames: LINKED_LIST[STRING]
	     	names : LINKED_LIST[STRING]

        do
            create names.make
        	create tnames.make

        	across
        		1 |..| c.count is co
        	loop
        		check attached {STRING} c.at (co).at (1) as cn then
--        			if
--        				across (co+1) |..| c.count is coo some c[coo][1] ~ cn end
--        				and across 1 |..| names.count is foo all names[foo] /~ cn end
--        			then
--        				names.force (cn)
--        			end
                    if
                    	across 1 |..| tnames.count is coo all tnames[coo] /~ cn end
                    then
                    	tnames.force(cn)
                    else
                    	if
                    		across 1 |..| names.count is foo all names[foo] /~ cn end
                    	then
                    		names.force(cn)
                    	end
                    end
        		end
        	end

        	Result := names
        end

feature -- set instruction
    set_instruction(cn: STRING ; fn: STRING ; n: STRING)
        do
        	cna := cn
        	fna := fn
        	nna := n
        end

feature
	assignment_not_finished : BOOLEAN
		do
			if
			 	(assft ~ "query" and pro.at (assci).queries.at (assfi).assignment.at (aindex).pretty_print.has ('?')) or
			 	(assft ~ "command" and pro.at (assci).commands.at (assfi).assignment.at (aindex).pretty_print.has ('?'))
			then
				Result := True
			else
				Result := False
			end
		end

feature -- model operations
	reset
			-- Reset model state.
		do
			make
		end

feature -- queries
	out : STRING
		local
			comm : INTEGER
		do
			create Result.make_empty

			if
				java.is_empty and tc.is_empty
			then
			    Result.append ("  Status: " + status)
			    Result.append ("%N")
			    Result.append ("  Number of classes being specified: " + pro.count.out)
			if
                not pro.is_empty
			then

				across 1 |..| pro.count is index
				loop
					Result.append ("%N")
					Result.append ("    " + pro.at (index).name)
					Result.append ("%N")
					Result.append ("      Number of attributes: " )
					Result.append(pro.at (index).attributes.count.out)
					if
                        not pro.at (index).attributes.is_empty
					then

						across 1 |..| pro.at (index).attributes.count is index2
						loop
							Result.append("%N")
							Result.append("        + " + pro.at(index).attributes.at(index2).name + ": " + pro.at(index).attributes.at(index2).type.get)
						end

					end
					Result.append ("%N")
					Result.append ("      Number of queries: " )
					Result.append (pro.at (index).queries.count.out)
				    if
				    	not pro.at (index).queries.is_empty
				    then
				    	across 1 |..| pro.at (index).queries.count is index3
				    	loop
				    		Result.append("%N")
							Result.append ("        + " + pro.at (index).queries.at (index3).qname)
							if
							    pro.at (index).queries.at (index3).parray.parameter.is_empty
							then
								Result.append (": ")
						     	Result.append (pro.at (index).queries.at (index3).returnt.get)
						    else
						    	Result.append ("(" )
						    	check attached {STRING} pro.at (index).queries.at(index3).parray.parameter.item(1).item(2) as a then
						    		Result.append (a)
						    	end
                                Result.append (")" )
                                Result.append (": ")
						     	Result.append (pro.at (index).queries.at (index3).returnt.get)
						    end
				    	end
				    end
					Result.append ("%N")
					Result.append ("      Number of commands: " )
					Result.append (pro.at (index).commands.count.out)
					if
						not pro.at (index).commands.is_empty
					then
						across 1 |..| pro.at (index).commands.count is index4
						loop
							Result.append("%N")
							Result.append ("        + " + pro.at (index).commands.at (index4).cname)
							if
								not pro.at (index).commands.at (index4).parray.parameter.is_empty
							then
								Result.append ("(")
								comm := pro.at (index).commands.at (index4).parray.parameter.count
								across 1 |..| (comm - 1) is index5
								loop
									check attached {STRING} pro.at (index).commands.at(index4).parray.parameter.item(index5).item(2) as b then
									Result.append (b)
									Result.append (", ")
									end
								end
								check attached {STRING} pro.at (index).commands.at(index4).parray.parameter.item(comm).item(2) as d then
									Result.append (d)
								end
								Result.append (")")
							end
						end
					end
				end
			end
            if
				assignment_not_finished
			then
				Result.append("%N")
				Result.append ("  Routine currently being implemented: {")
				Result.append (pro.at (assci).name.out + "}." + fna)
				Result.append("%N")
				Result.append ("  Assignment being specified: " + nna + " := ")
				if
					assft ~ "query"
				then
					Result.append(pro.at (assci).queries.at (assfi).assignment.at (aindex).pretty_print)
				elseif
					assft ~ "command"
				then
					Result.append(pro.at (assci).commands.at (assfi).assignment.at (aindex).pretty_print)
				end
			end
           	elseif tc.is_empty and not java.is_empty then
               across 1 |..| pro.count is in loop
                	Result.append (pro.at (in).pretty_print)
                	if
                		in /~ pro.count
                	then
                		Result.append("%N")
                	end
                end
                java.make_empty
           elseif not tc.is_empty and java.is_empty  then
				across
					pro as cursor
				loop
					if cursor.item.type_check then
						Result.append("  class "+ cursor.item.name +" is type-correct.")
						if not pro.islast then
							Result.append("%N")
						end
					else
						Result.append("  class "+ cursor.item.name +" is not type-correct :")
						Result.append ("%N"+cursor.item.tc_report)
					end
				end
				tc.make_empty
            end
		end

end
