Class {
	#name : #AtomicBombEffect,
	#superclass : #BoxEffect,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
AtomicBombEffect >> initialize [
	polarity:= true.
]

{ #category : #action }
AtomicBombEffect >> triggeredBy: aSpaceship with: aGame [

	polarity ifTrue:  [ (aGame board) moveSpaceshipsToTheFirstBox]
	
]
