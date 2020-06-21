note
	description: "Summary description for {PARAMETERS}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PARAMETERS

create
    make

feature
	parameter: ARRAY[TUPLE[s: STRING ; t : STRING]]
    ty : STRING
    na : STRING
    t : TYPES

feature
	make(pa : ARRAY[TUPLE[s: STRING ; t : STRING]])
	do
		parameter := pa
		create na.make_empty
        create ty.make_empty
        create t.make(ty)
	end

feature
	instance(i : INTEGER)
		do
			check attached {STRING} parameter.at (i).at(1) as a then
				na := a
			end
			check attached {STRING} parameter.at (i).at(2) as b then
	            create t.make (b)
	            ty := t.get_java

		    end
		end

	get_type (n: STRING): STRING
		do
			create Result.make_empty
			across 1 |..| parameter.count is i
			loop
				if n ~ parameter.at(i).s  then
					Result := parameter.at(i).t
				end
			end

		end

	has (n: STRING): BOOLEAN
		do
			Result := false
			across 1 |..| parameter.count is i
			loop
				if n ~ parameter.at(i).s  then
					Result := True
				end
			end

		end

	size: INTEGER
		do
			Result := parameter.count
		end

end
