Class {
	#name : #AtomicBombEffect,
	#superclass : #BoxEffect,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
AtomicBombEffect >> reverse [
	"do nothing"
]

{ #category : #action }
AtomicBombEffect >> triggeredBy: aSpaceship with: aGame [

	(aGame board) moveSpaceshipsToTheFirstBox
]
