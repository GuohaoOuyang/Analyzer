note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_ADD_ASSIGNMENT_INSTRUCTION
inherit
	ETF_ADD_ASSIGNMENT_INSTRUCTION_INTERFACE
create
	make
feature -- command
	add_assignment_instruction(cn: STRING ; fn: STRING ; n: STRING)

		require else
			add_assignment_instruction_precond(cn, fn, n)
		local
			classindex : INTEGER
			attindex : INTEGER
			rindex : INTEGER
			s : STRING
			aindex : INTEGER
			assi : ASSIGNMENT
    	do
			-- perform some update on the model state
            if
            	model.assignment_not_finished
            then
                model.set_status (model.e_report.set_e02 (model.fna, model.cna))
            elseif
		  	    not model.is_class_duplicate (cn)
		    then
		     	model.set_status (model.e_report.set_e04 (cn))
		    elseif
		    	not model.is_f_duplicate (cn, fn)
		    then
		    	model.set_status (model.e_report.set_e10 (fn, cn))
		    elseif
		    	model.is_f_attribute (cn, fn)
		    then
		    	model.set_status (model.e_report.set_e11 (fn, cn))

            else
			create assi.make (n)
			across 1 |..| model.pro.count is a
			loop
				if
					model.pro.at (a).name ~ cn
				then
					classindex := a
					across 1 |..| model.pro.at (a).attributes.count is b
					loop
						if
						model.pro.at (a).attributes.at (b).name ~ n
						then
						attindex := b
						end
					end
					across 1 |..| model.pro.at (a).queries.count is  c
					loop
						if
							model.pro.at (a).queries.at (c).qname ~ fn
						then
							s := "query"
							assi.set_is_query(true)
							rindex := c
							assi.set_index (a, c)
							model.pro.at (a).queries.at (c).assignment.force (assi)
							aindex := model.pro.at (a).queries.at (c).assignment.count
							model.set_instruction (cn, fn, n)
							model.add_assignment_instruction (s, classindex, rindex, aindex)
							model.set_status (model.e_report.set_report_ok)
						end
					end
					across 1 |..| model.pro.at (a).commands.count is d
					loop
						if
							model.pro.at (a).commands.at (d).cname ~ fn
						then
							s := "command"
							assi.set_is_query(false)
							rindex := d
							assi.set_index (a, d)
							model.pro.at (a).commands.at (d).assignment.force (assi)
            	            model.set_instruction (cn, fn, n)
            	            aindex := model.pro.at (a).commands.at (d).assignment.count
            	            model.add_assignment_instruction (s, classindex, rindex, aindex)
            	            model.set_status (model.e_report.set_report_ok)
						end
					end

				end
			end

            end

			etf_cmd_container.on_change.notify ([Current])
    	end

end
