note
	description: "Summary description for {ASSIGNMENT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ASSIGNMENT

create
	make

feature -- Attributes
	name: STRING
	is_query : BOOLEAN

feature {NONE}
	cindex: INTEGER
	qindex: INTEGER
	tc_report: STRING

	-- tree structure to store the expression
	exp_tree: ARRAY[EXPRESSION]
	count: INTEGER

	-- top of expression structure
	root: EXPRESSION
		do
			Result := exp_tree.at (1)
		end

	-- printer
	printer: PRETTY_PRINTER
	--type checker
	checker: TYPE_CHECKER

	-- access the model for type_checker
	model: ETF_MODEL
		local
			model_access: ETF_MODEL_ACCESS
		do
			Result := model_access.m
		end


feature -- Constructor
	make (n: STRING)
	local
		cur : CURRENT_EXPRESSION
		do
			name := n
			count := 0

			create exp_tree.make_empty

            create cur.make
            exp_tree.force (cur, 1)
			create printer.make
			create checker.make

			create tc_report.make_empty
		end

feature -- Queries inserting constant
	set_index (c: INTEGER; q: INTEGER)
		do
			cindex := c
			qindex := q
		end

	set_is_query (b: BOOLEAN)
		do
			is_query := b
		end

	insert_int (val: INTEGER_CONSTANT)
		-- Get the insert integer constant in current position of expression
		do
			val.set_location (cindex, qindex, is_query)
			update_constant_nodes (val)
		end

	insert_bool (val: BOOLEAN_CONSTANT)
		-- Get the insert boolean constant in current position of expression
		do
			val.set_location (cindex, qindex, is_query)
			update_constant_nodes (val)
		end

	insert_callchain (val: CALLCHAIN)
	 	do
	 		val.set_location (cindex, qindex, is_query)
	 		update_constant_nodes (val)
	 	end

feature -- queries inserting operations
	insert_binary (b: BINARY_OP)
		local
			i, j, k: INTEGER
			cur: CURRENT_EXPRESSION
		do
			-- insert any kind of binary constant to the specific position of expression
			-- for example -> addition will create it by (create {ADDITION}.make) in the specific position of assignment
			create cur.make

			b.set_location (cindex, qindex, is_query)

			--When expression is not setted up
			count := count + 1

			If count = 1 then
				exp_tree.force (b ,count)
				exp_tree.force (b.left, count * 2)
				exp_tree.force (b.right, (count * 2 + 1))
			else
				-- Otherwise, need to update tree
				from
					i := 1
				until
					i > exp_tree.count
				loop
					if exp_tree.at (i) ~ cur then
						j := i
					end
					i := i + 1
				end

				k := j//2
				if attached {BINARY_OP} exp_tree.at(k) as last_binary_op then
					if j\\2=1 then
						last_binary_op.set_right (b)
					else
						last_binary_op.set_left (b)
					end
				end
				if attached {UNARY_OP} exp_tree.at(k) as last_binary_op then
					last_binary_op.set_right (b)
				end

				grow_tree (j)
				exp_tree.force_and_fill (b, j)
				exp_tree.force_and_fill (b.left, (2 * j))
				exp_tree.force_and_fill (b.right, (2 * j) + 1)

			end
		end

	insert_unary (u: UNARY_OP)
		local
			i,j,k: INTEGER
			cur: CURRENT_EXPRESSION
			emp: EMPTY_EXPRESSION
		do
			create cur.make
			create emp.make

			count := count + 1

			u.set_location (cindex, qindex, is_query)

			--When expression is not setted up
			if count = 1 then
				exp_tree.force (u ,count)
				exp_tree.force (emp, count * 2)
				exp_tree.force (u.right, (count * 2 + 1))
			else
				-- Otherwise, need to update tree
				from
					i := 1
				until
					i > exp_tree.count
				loop
					if exp_tree.at (i) ~ cur then
						j := i
					end
					i := i + 1
				end

				k := j//2
				if attached {BINARY_OP} exp_tree.at(k) as last_binary_op then
					if j\\2=1 then
						last_binary_op.set_right (u)
					else
						last_binary_op.set_left (u)
					end
				end
				if attached {UNARY_OP} exp_tree.at(k) as last_binary_op then
					last_binary_op.set_right (u)
				end

				grow_tree (j)
				exp_tree.force (u, j)
				exp_tree.force (emp, (2 * j))
				exp_tree.force (u.right, (2 * j) + 1)
			end
		end


feature {NONE} -- INTERNAL Queries related to tree
	grow_tree (entry: INTEGER)
		-- expand the tree
		local
			j, exit_cond: INTEGER
			empty: EMPTY_EXPRESSION
		do
			create empty.make
			exit_cond := (2 * exp_tree.count) + 1
			from
				j := exp_tree.count + 1
			until
				j > exit_cond
			loop
				exp_tree.force (empty, j)
				j := j + 1
			end
		end

	update_constant_nodes (n: EXPRESSION)
		local
			i, j, k, l: INTEGER
			cur: CURRENT_EXPRESSION
			nil: NIL_EXPRESSION
		do
			create cur.make
			create nil.make

			from
				i := 1
			until
				i > exp_tree.count
			loop
				if exp_tree.item (i) ~ cur then
					exp_tree.force_and_fill (n, i)
					if exp_tree.count > 1 then
						k := i//2
						l := i
						if attached {BINARY_OP} exp_tree.at(k) as last_binary_op then
							if i\\2=1 then
								last_binary_op.set_right (n)
							else
								last_binary_op.set_left (n)
							end
						end
						if attached {UNARY_OP} exp_tree.at(k) as last_unary_op then
							last_unary_op.set_right (n)
						end
					end

				end
				i := i + 1
			end

			-- loop for changing the the cursor to current position
			from
				i := exp_tree.count
			until
				i < 1
			loop
				if exp_tree.item (i) ~ nil then
					exp_tree.put (cur, i)
					j := i
					k := i//2
					if attached {BINARY_OP} exp_tree.at(k) as last_binary_op then
						if i\\2=1 then
							last_binary_op.set_right (cur)
						else
							last_binary_op.set_left (cur)
						end
					end
					if attached {UNARY_OP} exp_tree.at(k) as last_binary_op then
							last_binary_op.set_right (cur)
					end
					i := 1 -- exit immidiate
				end
				i := i - 1
			end

		end


feature -- Printer
	pretty_print: STRING
		--only outputs expression part
		do
			reset_printer
			root.accept(printer)
			Result := printer.output
		end

	print_java: STRING
		--output for generate_java_code
		local
			tmp: STRING
		do
			create Result.make_empty
			Result.append (name + " = ")
			tmp := pretty_print
			if tmp.starts_with ("(") then
				tmp.remove_head (1)
				tmp.remove_tail (1)
			end
			Result.append (tmp)
			Result.append (";")
		end

	print_assign: STRING
		--output for assignment
		do
			create Result.make_empty
			Result.append (name + " := ")
			Result.append (pretty_print)
		end

	reset_printer
		do
			printer.reset
		end

feature -- type_checker
	type_check: BOOLEAN
		local
			type_name: STRING
			type_exp: STRING
			i: INTEGER
			t: STRING
		do
			--go for parameters of current queries / command
			create type_name.make_empty
			if is_query then
				type_name := model.pro.at (cindex).queries.at(qindex).parray.get_type (name)
			else
				type_name := model.pro.at (cindex).commands.at(qindex).parray.get_type (name)
			end

			--then go attributes for each for type-checking
			if
				is_query and name = "Result" or name = "result"
			then
				type_name := model.pro.at (cindex).queries.at(qindex).get_type

			elseif type_name.is_empty then
				from
					i := 1
				until
					i > model.pro.count
				loop
					if model.pro.at(i).has_attribute (name) then
						type_name := model.pro.at(i).get_attribute_type(name)
					end
					i := i + 1
				end
			end

			root.accept(checker)
			type_exp := checker.types

			Result := type_name ~ type_exp and checker.type_check_result = true

			if Result = false then
				t := print_java
				t.remove_tail (1)
				if
					is_query
				then
					tc_report.append ("   "+ t +" in routine "+ model.pro.at(cindex).queries.at(qindex).qname +" is not type-correct.%N")
				else
					tc_report.append ("   "+ t +" in routine "+ model.pro.at(cindex).commands.at(qindex).cname +" is not type-correct.%N")
				end
			end
		end

		get_tc_report: STRING
			do
				Result := tc_report.out
			end
end
