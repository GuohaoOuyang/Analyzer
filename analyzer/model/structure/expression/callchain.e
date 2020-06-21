note
	description: "Summary description for {CALLCHAIN}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CALLCHAIN

inherit
	EXPRESSION


create
	make

feature
	value: ARRAY[STRING]
	type: STRING

feature -- Constructor
	make (chain: ARRAY[STRING])
		require
			not_empty:
				not chain.is_empty
		local
			i: INTEGER
		do
			value := chain
			type := "nil"
		end

	pretty_print: STRING
		local
			i: INTEGER
		do
			create Result.make_empty
			from
				i := 1
			until
				i > value.count
			loop
				Result.append (value[i])
					if not (i = value.count) then
						Result.append (".")
					end
				i := i + 1
			end
		end

	type_check: BOOLEAN
		local
			i, j: INTEGER
			t, ct: STRING
		do
			-- Initialize true, when something fails, Result become false
			Result := true
			t := "nil"

			-- going over each parameter
			from
				i := 1
			until
				i > value.count
			loop

				ct := t
				--check a.result which is not allowed.
				if not (i = 1) and ( value[i] ~ "result" or value[i] ~ "Result" ) then
					Result := false
				end

				if i = 1 then
					if is_query and model.pro.at(cindex).queries.at(qindex).parray.has(value[i]) then
						t := model.pro.at(cindex).queries.at(qindex).parray.get_type(value[i])
					elseif not is_query and model.pro.at(cindex).commands.at(qindex).parray.has(value[i]) then
						t := model.pro.at(cindex).commands.at(qindex).parray.get_type(value[i])
					elseif model.pro.at(cindex).has_attribute(value[i]) then
						t := model.pro.at(cindex).get_attribute_type(value[i])
					else
						Result := false
						i := value.count
					end
				else
					t := "nil"
					from
						j := 1
					until
						j > model.pro.count
					loop
						if model.pro.at(j).name ~ ct then
							if model.pro.at(j).has_attribute(value[i]) then
								t := model.pro.at(j).get_attribute_type(value[i])
							else
								Result := false
								j := model.pro.count
								i := value.count
							end
						end
						j := j + 1
					end
				end

				-- if no type detected, not type correct
				if t ~ "nil" then
					Result := false
				end
				i := i + 1

				-- send the type of current object
				type := t
			end

			if type ~ "nil" then
				Result := false
			end
		end

	get_type: STRING
		do
			Result := type
		end


feature -- accessing the model
	model: ETF_MODEL
		local
			model_access: ETF_MODEL_ACCESS
		do
			Result := model_access.m
		end

feature -- Visitor operations
	accept (v: VISITOR)
		do
			v.visit_callchain (Current)
		end

end
