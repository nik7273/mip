(define (domain groceryworld)
	(:requirements :strips :typing)
	(:types item)
	(:predicates (on ?x - item ?y - item)
		(on-table ?x - item)
		(clear ?x - item)
		(arm-empty ?x)
		(holding ?x - item)
		(clearleft ?x - item)
		(clearright ?x - item)
		(toleft ?x - item ?y - item)
		(toright ?x - item ?y - item)
		(onsomething ?x - item)
		(onclutterortable ?x - item))
		
	(:action pickup
        :parameters (?ob- item)
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
	    :parameters (?ob - item)
	    :precondition (holding ?ob)
	    :effect
	    (and (not (holding ?ob))
            (clear ?ob)
            (arm-empty)
            (on-table ?ob)
            (onclutterortable ?ob)
            (onsomething ?ob)))
    
    (:action unstack
		:parameters (?ob - item ?underob - item)
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
        :parameters (?ob - item ?underob - item)
        :precondition (and (holding ?ob) (clear ?underob) (onsomething ?ob))
        :effect
        (and (not (holding ?ob))
            (not (clear ?underob))
            (clear ?ob)
            (arm-empty)
            (onsomething ?ob)
            (on ?ob ?underob)))
	        	        
	(:action putleft
        :parameters (?ob - item ?staticob- item)
        :precondition (and (holding ?ob) (clearleft ?staticob) (on-table ?staticob))
        :effect
        (and (not (holding ?ob))
            (not (clearleft ?staticob))
            (clearleft ?ob)
            (arm-empty)
            (onsomething ?ob)
            (toleft ?ob ?staticob)))
	
	(:action putright
        :parameters (?ob - item ?staticob - item)
        :precondition (and (holding ?ob) (clearright ?staticob) (on-table ?staticob))
        :effect
        (and (not (holding ?ob))
            (not (clearright ?staticob))
            (clearright ?ob)
            (arm-empty)
            (onsomething ?ob)
            (toright ?ob ?staticob)))
)
