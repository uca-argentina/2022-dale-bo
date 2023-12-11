Class {
	#name : #BoxEffectState,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #action }
BoxEffectState >> reverse [
	self subclassResponsibility
]

{ #category : #action }
BoxEffectState >> triggeredBy: aSpaceship with: aGame [

	(aGame board)
		move: aSpaceship
		toFinalDistance: self numberOfDistanceByHyperJump
]
