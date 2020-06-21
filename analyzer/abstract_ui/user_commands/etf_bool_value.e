note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_BOOL_VALUE
inherit
	ETF_BOOL_VALUE_INTERFACE
create
	make
feature -- command
	bool_value(c: BOOLEAN)
    	do
			if
				not model.assignment_not_finished
			then
				model.set_status (model.e_report.set_e01)
			else
				model.set_status (model.e_report.set_report_ok)
				if
					model.assft ~ "query"
				then
	                model.pro.at (model.assci).queries.at (model.assfi).assignment.at (model.aindex).insert_bool (create {BOOLEAN_CONSTANT}.make (c))
	            elseif
	                model.assft ~ "command"
	            then
	            	model.pro.at (model.assci).commands.at (model.assfi).assignment.at (model.aindex).insert_bool (create {BOOLEAN_CONSTANT}.make (c))
				end
			end
			etf_cmd_container.on_change.notify ([Current])
    	end

end
