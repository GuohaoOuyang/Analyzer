note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_ADD_CALL_CHAIN
inherit
	ETF_ADD_CALL_CHAIN_INTERFACE
create
	make
feature -- command
	add_call_chain(chain: ARRAY[STRING])
    	do
			if
				not model.assignment_not_finished
			then
				model.set_status (model.e_report.set_e01)
			elseif
				chain.is_empty
			then
				model.set_status (model.e_report.set_e12)
			else
				model.set_status (model.e_report.set_report_ok)
				if
					model.assft ~ "query"
				then
				    model.pro.at (model.assci).queries.at (model.assfi).assignment.at (model.aindex).insert_callchain (create {CALLCHAIN}.make (chain))
				elseif
				    model.assft ~ "command"
				then
				    model.pro.at (model.assci).commands.at (model.assfi).assignment.at (model.aindex).insert_callchain (create {CALLCHAIN}.make (chain))
				end
			end
			etf_cmd_container.on_change.notify ([Current])
    	end

end
