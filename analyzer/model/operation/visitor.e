note
	description: "Summary description for {VISITOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	VISITOR

-- Visit Features for all effective desendents of EXPRESSION
feature -- constraints
	visit_boolean (e: BOOLEAN_CONSTANT)
		deferred end

	visit_integer (e: INTEGER_CONSTANT)
		deferred end

feature --expression
	visit_current_exp (e: CURRENT_EXPRESSION)
		deferred end

	visit_nil_exp (e: NIL_EXPRESSION)
		deferred end

feature -- binarry operations
	visit_addition (e: ADDITION)
		deferred end

	visit_subtraction (e: SUBTRACTION)
		deferred end

	visit_multiplication (e: MULTIPLICATION)
		deferred end

	visit_division (e: DIVISION)
		deferred end

	visit_equal (e:EQUALS)
		deferred end

	visit_and (e: LOGICAL_AND)
		deferred end

	visit_or (e: LOGICAL_OR)
		deferred end

	visit_greater_than (e: GREATER_THAN)
		deferred end

	visit_smaller_than (e: SMALLER_THAN)
		deferred end

	visit_modulo (e: MODULO)
		deferred end

feature --unary operations
	visit_negative (e: NEGATIVE)
		deferred end

	visit_negation (e: NEGATION)
		deferred end

feature --callchain
	visit_callchain (e: CALLCHAIN)
		deferred end

end
