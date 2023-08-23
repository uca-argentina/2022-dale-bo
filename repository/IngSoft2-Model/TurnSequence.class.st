Class {
	#name : #TurnSequence,
	#superclass : #Object,
	#instVars : [
		'turnNumber',
		'spaceshipsNames',
		'doubledTurn'
	],
	#classInstVars : [
		'ships',
		'turnNumber'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
TurnSequence class >> with: aCollectionOfNames [

	^ self new initializeWith: aCollectionOfNames
]

{ #category : #action }
TurnSequence >> assertSpaceshipTurn:aSpaceship [

	(self whoPlays = aSpaceship) ifFalse:[Error signal:
			'A permanent card cannot be played on another spaceship turn']
]

{ #category : #actions }
TurnSequence >> doubleTurn [

	doubledTurn := true
]

{ #category : #initialization }
TurnSequence >> initializeWith: aCollectionOfNames [

	spaceshipsNames := aCollectionOfNames.
	turnNumber := 1.
	doubledTurn:= false.
]

{ #category : #action }
TurnSequence >> next [
	
	doubledTurn ifTrue: [doubledTurn:= false ] ifFalse:[turnNumber:= (turnNumber%(spaceshipsNames size)) + 1.]
	"turnNumber := turnNumber + numberOfTurns.
	turnNumber > spaceshipsNames size ifTrue: [ turnNumber := 1 ].
	turnNumber < 1 ifTrue: [ turnNumber := (spaceshipsNames size) ]."
]

{ #category : #actions }
TurnSequence >> reverseTurns [
	spaceshipsNames reverse.
	turnNumber := spaceshipsNames size - turnNumber +1
]

{ #category : #action }
TurnSequence >> whoPlays [

	^ (spaceshipsNames at: turnNumber).
]
