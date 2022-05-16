Class {
	#name : #HyperJam,
	#superclass : #Object,
	#instVars : [
		'posibleMoves',
		'parsecs',
		'index'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'class initialization' }
HyperJam class >> with:aCollectionOfPosiblesMoves parsecs: aNumberOfParsecs [
 
	^self new initializeWith:aCollectionOfPosiblesMoves and:aNumberOfParsecs.
]

{ #category : #initialization }
HyperJam >> effect [
	index:= index+1.
	(index > posibleMoves size) ifTrue:[index:=1.].
	^posibleMoves at: index.
]

{ #category : #initialization }
HyperJam >> effectTo: ships appliedBy: aShip with: endPosition and:laps [
	ships moveParsecs: aShip to: (self effect) parsecs:(parsecs) with:endPosition and:laps.
]

{ #category : #initialization }
HyperJam >> initializeWith:aCollectionOfPosiblesMoves and:aNumberOfParsecs [
	index:=0.
	posibleMoves:= aCollectionOfPosiblesMoves.
	parsecs:= aNumberOfParsecs.
]
