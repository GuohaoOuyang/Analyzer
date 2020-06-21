note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_INT_VALUE
inherit
	ETF_INT_VALUE_INTERFACE
create
	make
feature -- command
	int_value(c: INTEGER_32)
    	do
    		-- if no spots avaliable (no ?) , send the error
			-- if there is spot avaliable, insert the constant in next cursor
			if
				not model.assignment_not_finished
			then
				model.set_status (model.e_report.set_e01)
			else
				model.set_status (model.e_report.set_report_ok)
				if
					model.assft ~ "query"
				then
	                model.pro.at (model.assci).queries.at (model.assfi).assignment.at (model.aindex).insert_int (create {INTEGER_CONSTANT}.make (c))
	            elseif
	                model.assft ~ "command"
	            then
	            	model.pro.at (model.assci).commands.at (model.assfi).assignment.at (model.aindex).insert_int (create {INTEGER_CONSTANT}.make (c))
				end
			end
			model.set_status (model.e_report.set_report_ok)

			etf_cmd_container.on_change.notify ([Current])
    	end

end
