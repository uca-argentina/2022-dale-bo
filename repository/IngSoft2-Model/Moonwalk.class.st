Class {
	#name : #Moonwalk,
	#superclass : #Object,
	#instVars : [
		'retroPositions',
		'parsecs'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Moonwalk class >> with: aNumberOfBoxesToSendBack and:aNumberOfParsecs [
 
	^self new initializeWith:aNumberOfBoxesToSendBack and:aNumberOfParsecs.
]

{ #category : #action }
Moonwalk >> effect [
	^ 0- retroPositions.
]

{ #category : #'action handling' }
Moonwalk >> effectTo: ships appliedBy: aShip with: endPosition and:laps [

	ships positions do: [ :each | 
		each ownerShip ~= aShip ifTrue: [ 
			ships moveBackwards: each ownerShip to: self effect with: endPosition and:laps] ]
]

{ #category : #initialization }
Moonwalk >> initializeWith: aNumberOfBoxesToSendBack and:aNumberOfParsecs [
	retroPositions:= aNumberOfBoxesToSendBack.
	parsecs:= aNumberOfParsecs.
]
