Class {
	#name : #Moonwalk,
	#superclass : #Object,
	#instVars : [
		'retroPositions'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Moonwalk class >> with: aNumberOfBoxesToSendBack [
 
	^self new initializeWith:aNumberOfBoxesToSendBack.
]

{ #category : #action }
Moonwalk >> effect [
	^ 0- retroPositions.
]

{ #category : #'action handling' }
Moonwalk >> effectTo: ships appliedBy: aShip [

	| shipsAffected |
	shipsAffected := OrderedCollection new.
	ships do: [ :each | 
		each ~= aShip ifTrue: [ shipsAffected add: each ] ].
	^ shipsAffected
]

{ #category : #initialization }
Moonwalk >> initializeWith: aNumberOfBoxesToSendBack [ 
	retroPositions:= aNumberOfBoxesToSendBack.
]
