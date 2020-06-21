note
	description: ""
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ETF_ADD_ATTRIBUTE
inherit
	ETF_ADD_ATTRIBUTE_INTERFACE
create
	make
feature -- command
	add_attribute(cn: STRING ; fn: STRING ; ft: STRING)
		require else
			add_attribute_precond(cn, fn, ft)

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
                    	not model.is_primitive_or_declared_class (ft)
                    then
                    	model.set_status (model.e_report.set_e09 (ft))
	        		else
	    		        model.set_status (model.e_report.set_report_ok)
     			        model.add_attribute (cn, fn, ft)

    	      		end
    	      	else
    	      	    model.set_status (model.e_report.set_e02 (model.fna, model.cna))
                end

			etf_cmd_container.on_change.notify ([Current])
    	end

end
