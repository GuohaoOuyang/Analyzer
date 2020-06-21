note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_ADD_QUERY
inherit
	ETF_ADD_QUERY_INTERFACE
create
	make
feature -- command
	add_query(cn: STRING ; fn: STRING ; ps: ARRAY[TUPLE[pn: STRING; pt: STRING]] ; rt: STRING)
		require else
			add_query_precond(cn, fn, ps, rt)

    	do

			-- perform some update on the model state
			if
				not model.assignment_not_finished
			then

					if
					    not model.is_class_duplicate (cn)
					then
					    model.set_status (model.e_report.set_e04 (cn))
					elseif
					    model.is_f_duplicate (cn, fn)
					then
						model.set_status (model.e_report.set_e05 (fn, cn))
					elseif
		                not model.clash_name_with_class_name (ps).is_empty
					then
					   	model.set_status (model.e_report.set_e06 (model.clash_name_with_class_name (ps)))
				    elseif
					    not model.duplicate_parameter_names (ps).is_empty
					then
					    model.set_status (model.e_report.set_e07 (model.duplicate_parameter_names (ps)))
					elseif
					    not model.parameter_types_check (ps).is_empty
					then
					    model.set_status (model.e_report.set_e08 (model.parameter_types_check (ps)))
					elseif
						not model.is_primitive_or_declared_class (rt)
					then
						model.set_status (model.e_report.set_e09 (rt))
		            else
						model.set_status (model.e_report.set_report_ok)
					  	model.add_query (cn, fn, ps, rt)
					end
			else
				model.set_status (model.e_report.set_e02 (model.fna, model.cna))
			end


			etf_cmd_container.on_change.notify ([Current])
    	end

end
