note
	description: "Summary description for {TYPE_CHECKER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TYPE_CHECKER

inherit
	VISITOR

create
	make

feature -- Attributes
	type_check_result: BOOLEAN
	types: STRING -- Store type value for parent recurrence

feature {NONE} -- Constructor
	make
		do
			create types.make_empty
			create type_check_result.default_create
		end

feature -- constraints
	visit_boolean (e: BOOLEAN_CONSTANT)
		do
			types := "BOOLEAN"
			type_check_result := true
		end

	visit_integer (e: INTEGER_CONSTANT)
		do
			types := "INTEGER"
			type_check_result := true
		end

feature --expression
	visit_current_exp (e: CURRENT_EXPRESSION)
		do
			type_check_result := false
		end

	visit_nil_exp (e: NIL_EXPRESSION)
		do
			type_check_result := false
		end

feature -- binarry operations
	visit_addition (e: ADDITION)
		local
			left_res: BOOLEAN
			right_res: BOOLEAN
		do
			e.left.accept(current)
				left_res := (types ~ "INTEGER" or types ~ "callchain")
			e.right.accept(current)
				right_res := (types ~ "INTEGER" or types ~ "callchain")
			type_check_result := left_res and right_res
		end

	visit_subtraction (e: SUBTRACTION)
		local
			left_res: BOOLEAN
			right_res: BOOLEAN
		do
			e.left.accept(current)
				left_res := (types ~ "INTEGER" or types ~ "callchain")
			e.right.accept(current)
				right_res := (types ~ "INTEGER" or types ~ "callchain")
			type_check_result := left_res and right_res
		end

	visit_multiplication (e: MULTIPLICATION)
		local
			left_res: BOOLEAN
			right_res: BOOLEAN
		do
			e.left.accept(current)
				left_res := (types ~ "INTEGER" or types ~ "callchain")
			e.right.accept(current)
				right_res := (types ~ "INTEGER" or types  ~ "callchain")
			type_check_result := left_res and right_res
		end

	visit_division (e: DIVISION)
		local
			left_res: BOOLEAN
			right_res: BOOLEAN
		do
			e.left.accept(current)
				left_res := (types ~ "INTEGER" or types ~ "callchain")
			e.right.accept(current)
				right_res := (types ~ "INTEGER" or types  ~ "callchain")
			type_check_result := left_res and right_res
		end

	visit_equal (e:EQUALS)
		local
			left_res: BOOLEAN
			right_res: BOOLEAN
		do
			e.left.accept(current)
			if types ~ "BOOLEAN" then
				left_res := (types ~ "BOOLEAN")
				e.right.accept(current)
				right_res := (types ~ "BOOLEAN")
			elseif types ~ "INTEGER" then
				left_res := (types ~ "INTEGER")
				e.right.accept(current)
				right_res := (types ~ "INTEGER")
			else
				--when callchain
				left_res := true
				right_res := true
			end
			type_check_result := left_res and right_res
		end

	visit_and (e: LOGICAL_AND)
		local
			left_res: BOOLEAN
			right_res: BOOLEAN
		do
			e.left.accept(current)
				left_res := (types ~ "BOOLEAN" or types ~ "callchain")
			e.right.accept(current)
				right_res := (types ~ "BOOLEAN" or types ~ "callchain")
			type_check_result := left_res and right_res
		end

	visit_or (e: LOGICAL_OR)
		local
			left_res: BOOLEAN
			right_res: BOOLEAN
		do
			e.left.accept(current)
				left_res := (types ~ "BOOLEAN" or types ~ "callchain")
			e.right.accept(current)
				right_res := (types ~ "BOOLEAN" or types ~ "callchain")
			type_check_result := left_res and right_res
		end

	visit_greater_than (e: GREATER_THAN)
		local
			left_res: BOOLEAN
			right_res: BOOLEAN
		do
			e.left.accept(current)
				left_res := (types ~ "INTEGER" or types ~ "callchain")
			e.right.accept(current)
				right_res := (types ~ "INTEGER" or types ~ "callchain")
			type_check_result := left_res and right_res
		end

	visit_smaller_than (e: SMALLER_THAN)
		local
			left_res: BOOLEAN
			right_res: BOOLEAN
		do
			e.left.accept(current)
				left_res := (types ~ "INTEGER" or types ~ "callchain")
			e.right.accept(current)
				right_res := (types ~ "INTEGER" or types  ~ "callchain")
			type_check_result := left_res and right_res
		end

	visit_modulo (e: MODULO)
		local
			left_res: BOOLEAN
			right_res: BOOLEAN
		do
			e.left.accept(current)
				left_res := (types ~ "INTEGER" or types ~ "callchain")
			e.right.accept(current)
				right_res := (types ~ "INTEGER" or types  ~ "callchain")
			type_check_result := left_res and right_res
		end

feature --unary operations
	visit_negation (e: NEGATION)
		do
			e.right.accept(current)
				type_check_result := (types ~ "BOOLEAN" or types ~ "callchain")

		end

	visit_negative (e: NEGATIVE)
		do
			e.right.accept(current)
				type_check_result := (types ~ "INTEGER" or types ~ "callchain")
		end

feature --callchain
	visit_callchain (e: CALLCHAIN)
		do
			type_check_result := e.type_check
			types := e.get_type
		end

end
