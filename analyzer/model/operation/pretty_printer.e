note
	description: "Summary description for {PRETTY_PRINTER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	PRETTY_PRINTER

INHERIT
	VISITOR

create
	make

feature -- Attributes
	output: STRING

feature {NONE} -- Constructor
	make
		do
			create output.make_empty
		end

feature
	reset
		do
			make
		end

feature -- constraints
	visit_boolean (e: BOOLEAN_CONSTANT)
		do
			output.append(e.value.out)
		end

	visit_integer (e: INTEGER_CONSTANT)
		do
			output.append(e.value.out)
		end

feature --expression
	visit_current_exp (e: CURRENT_EXPRESSION)
		do
			output.append("?")
		end

	visit_nil_exp (e: NIL_EXPRESSION)
		do
			output.append("nil")
		end

feature -- binarry operations
	visit_addition (e: ADDITION)
		do
			output.append("( ")
			e.left.accept(current)
			output.append(" + ")
			e.right.accept(current)
			output.append(" )")
		end

	visit_subtraction (e: SUBTRACTION)
		do
			output.append("( ")
			e.left.accept(current)
			output.append(" - ")
			e.right.accept(current)
			output.append(" )")
		end

	visit_multiplication (e: MULTIPLICATION)
		do
			output.append("( ")
			e.left.accept(current)
			output.append(" * ")
			e.right.accept(current)
			output.append(" )")
		end

	visit_division (e: DIVISION)
		do
			output.append("( ")
			e.left.accept(current)
			output.append(" / ")
			e.right.accept(current)
			output.append(" )")
		end

	visit_equal (e:EQUALS)
		do
			output.append("( ")
			e.left.accept(current)
			output.append(" == ")
			e.right.accept(current)
			output.append(" )")
		end

	visit_and (e: LOGICAL_AND)
		do
			output.append("( ")
			e.left.accept(current)
			output.append(" && ")
			e.right.accept(current)
			output.append(" )")
		end

	visit_or (e: LOGICAL_OR)
		do
			output.append("( ")
			e.left.accept(current)
			output.append(" || ")
			e.right.accept(current)
			output.append(" )")
		end

	visit_greater_than (e: GREATER_THAN)
		do
			output.append("( ")
			e.left.accept(current)
			output.append(" > ")
			e.right.accept(current)
			output.append(" )")
		end

	visit_smaller_than (e: SMALLER_THAN)
		do
			output.append("( ")
			e.left.accept(current)
			output.append(" < ")
			e.right.accept(current)
			output.append(" )")
		end

	visit_modulo (e: MODULO)
		do
			output.append("( ")
			e.left.accept(current)
			output.append(" %% ")
			e.right.accept(current)
			output.append(" )")
		end

feature --unary operations
	visit_negative (e: NEGATIVE)
		do
			output.append("-")
			e.right.accept(current)
		end

	visit_negation (e: NEGATION)
		do
			output.append("!")
			e.right.accept(current)
		end

feature --callchain
	visit_callchain (e: CALLCHAIN)
		do
			output.append(e.pretty_print)
		end

end
