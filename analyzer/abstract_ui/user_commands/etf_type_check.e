note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_TYPE_CHECK
inherit
	ETF_TYPE_CHECK_INTERFACE
create
	make
feature -- command
	type_check
    	do
			-- perform some update on the model state
--			if
--				not model.cna.is_empty
--			then
--				model.set_status (model.e_report.set_e02 (model.fna, model.cna))
--			end
            if
            	model.assignment_not_finished
            then
          	    model.set_status (model.e_report.set_e02 (model.fna, model.cna))
          	else
         		model.type_check
            end

			etf_cmd_container.on_change.notify ([Current])
    	end

end
