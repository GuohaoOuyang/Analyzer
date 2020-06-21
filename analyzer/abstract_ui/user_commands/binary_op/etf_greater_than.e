note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_GREATER_THAN
inherit
	ETF_GREATER_THAN_INTERFACE
create
	make
feature -- command
	greater_than
    	do
			-- perform some update on the model state
			if
				not model.assignment_not_finished
			then
				model.set_status (model.e_report.set_e01)
			else
				model.set_status (model.e_report.set_report_ok)
				if
					model.assft ~ "query"
				then
	                model.pro.at (model.assci).queries.at (model.assfi).assignment.at (model.aindex).insert_binary (create {GREATER_THAN}.make)
	            elseif
	            	model.assft ~ "command"
	            then
	            	model.pro.at (model.assci).commands.at (model.assfi).assignment.at (model.aindex).insert_binary (create {GREATER_THAN}.make)
				end
			end

			etf_cmd_container.on_change.notify ([Current])
    	end

end
