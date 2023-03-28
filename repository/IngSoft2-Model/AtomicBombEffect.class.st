Class {
	#name : #AtomicBombEffect,
	#superclass : #BoxEffect,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
AtomicBombEffect >> triggeredBy: aSpaceship with: aBoard [

	aBoard moveSpaceshipsToTheFirstBox.
]
