note
	description: "Summary description for {STATUS_REPORT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

expanded class
	STATUS_REPORT

feature -- Constant Report Strings
	set_report_ok: STRING
		once
			Result := "OK."
		end

	set_e01: STRING
		once
			Result := "Error (An assignment instruction is not currently being speciied)."
		end

	set_e02(r: STRING; c: STRING): STRING
		do
			Result := "Error (An assignment instruction is currently being speciied for routine "+r+" in class "+c+")."
		end

	set_e03(cn: STRING): STRING
		do
			Result := "Error ("+cn+" is already an existing class name)."
		end

	set_e04(c: STRING): STRING
		do
			Result := "Error ("+c+" is not an existing class name)."
		end

	set_e05(fn: STRING; cn: STRING): STRING
		do
			Result := "Error ("+fn+" is already an existing feature name in class "+cn+")."
		end

	set_e06 (list: LIST[STRING]): STRING
		local
			l: STRING
		do
			create l.make_empty

            across
            	1 |..| list.count is co
            loop
            	l.append (list.at (co))
            	if
            		co /~ list.count
            	then
            		l.append (", ")
            	end
            end

			Result := "Error (Parameter names clash with existing classes: "+l+")."
		end

	set_e07 (list: LIST[STRING]): STRING
		local
			l: STRING
		do
			create l.make_empty

            across
            	1 |..| list.count is co
            loop
            	l.append (list.at (co))
            	if
            		co /~ list.count
            	then
            		l.append (", ")
            	end
            end
			Result := "Error (Duplicated parameter names: "+l+")."
		end

	set_e08 (list: LIST[STRING]): STRING
		local
			l: STRING
		do
			create l.make_empty

            across
            	1 |..| list.count is co
            loop
            	l.append (list.at (co))
            	if
            		co /~ list.count
            	then
            		l.append (", ")
            	end
            end
			Result := "Error (Parameter types do not refer to primitive types or existing classes: "+l+")."
		end

	set_e09 (rt: STRING): STRING
		do
			Result := "Error (Return type does not refer to a primitive type or an existing class: "+rt+")."
		end

	set_e10 (fn: STRING; cn: STRING): STRING
		do
			Result := "Error ("+fn+" is not an existing feature name in class "+cn+")."
		end

	set_e11 (fn: STRING; cn: STRING): STRING
		do
			Result := "Error (Attribute "+fn+" in class "+cn+ " cannot be specfied with an implementation)."
		end

	set_e12: STRING
		once
			Result := "Error (Call chain is empty)."
		end
end
