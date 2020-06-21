note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_ADD_CLASS
inherit
	ETF_ADD_CLASS_INTERFACE
create
	make
feature -- command
	add_class(cn: STRING)
		require else
			add_class_precond(cn)
    	do

			-- perform some update on the model state
			if
				not model.assignment_not_finished
			then
				if
					model.is_class_duplicate (cn)
				then
					model.set_status (model.e_report.set_e03 (cn))
				else
					model.add_class (cn)
					model.set_status (model.e_report.set_report_ok)
				end
			else
				model.set_status (model.e_report.set_e02 (model.fna, model.cna))
			end


			etf_cmd_container.on_change.notify ([Current])
    	end

end
