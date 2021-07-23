(define (domain groceryworld)
	(:requirements :strips :equality)
	(:predicates (on ?x ?y)
		(on-table ?x)
		(clear ?x)
		(arm-empty ?x)
		(holding ?x)
		(clearleft ?x)
		(clearright ?x)
		(toleft ?x ?y)
		(toright ?x ?y)
		(onsomething ?x)
		(onclutterortable ?x))
		
	(:action pickup
        :parameters (?ob)
        :precondition (and (clear ?ob) (arm-empty) (onclutterortable ?ob))
        :effect
        (and (not (on-table ?ob))
            (not (arm-empty))
            (not (clear ?ob))
            (holding ?ob)
            (clearleft ?ob)
            (clearright ?ob)
            (not (onclutterortable ?ob))
            (not (onsomething ?ob))))
	            
	(:action putdown
	    :parameters (?ob)
	    :precondition (holding ?ob)
	    :effect
	    (and (not (holding ?ob))
            (clear ?ob)
            (arm-empty)
            (on-table ?ob)
            (onclutterortable ?ob)
            (onsomething ?ob)))
    
    (:action unstack
		:parameters (?ob ?underob)
		:precondition (and (on ?ob ?underob) (onsomething ?ob) (clear ?ob) (arm-empty))
		:effect
		(and
            (not (arm-empty))
            (not (clear ?ob))
            (holding ?ob)
            (not (on ?ob ?underob))
            (clear ?underob)
            (clearleft ?ob)
            (clearright ?ob)
            (not (onsomething ?ob))))
	
	(:action stack
        :parameters (?ob ?underob)
        :precondition (and (holding ?ob) (clear ?underob) (onsomething ?ob))
        :effect
        (and (not (holding ?ob))
            (not (clear ?underob))
            (clear ?ob)
            (arm-empty)
            (onsomething ?ob)
            (on ?ob ?underob)))
	        	        
	(:action putleft
        :parameters (?ob ?staticob)
        :precondition (and (holding ?ob) (clearleft ?staticob) (on-table ?staticob))
        :effect
        (and (not (holding ?ob))
            (not (clearleft ?staticob))
            (clearleft ?ob)
            (arm-empty)
            (onsomething ?ob)
            (toleft ?ob ?staticob)))
	
	(:action putright
        :parameters (?ob ?staticob)
        :precondition (and (holding ?ob) (clearright ?staticob) (on-table ?staticob))
        :effect
        (and (not (holding ?ob))
            (not (clearright ?staticob))
            (clearright ?ob)
            (arm-empty)
            (onsomething ?ob)
            (toright ?ob ?staticob)))
)
