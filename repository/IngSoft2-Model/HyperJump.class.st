Class {
	#name : #HyperJump,
	#superclass : #Object,
	#instVars : [
		'posibleMoves',
		'parsecs',
		'index'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'class initialization' }
HyperJump class >> with:aCollectionOfPosiblesMoves parsecs: aNumberOfParsecs [
 
	^self new initializeWith:aCollectionOfPosiblesMoves and:aNumberOfParsecs.
]

{ #category : #initialization }
HyperJump >> effect [
	index:= index+1.
	(index > posibleMoves size) ifTrue:[index:=1.].
	^posibleMoves at: index.
]

{ #category : #initialization }
HyperJump >> effectTo: ships appliedBy: aShip with: endPosition and:laps [
	ships moveParsecs: aShip to: (self effect) parsecs:(parsecs) with:endPosition and:laps.
]

{ #category : #initialization }
HyperJump >> initializeWith:aCollectionOfPosiblesMoves and:aNumberOfParsecs [
	index:=0.
	posibleMoves:= aCollectionOfPosiblesMoves.
	parsecs:= aNumberOfParsecs.
]
