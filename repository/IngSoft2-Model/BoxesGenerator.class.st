Class {
	#name : #BoxesGenerator,
	#superclass : #Object,
	#instVars : [
		'parsecPerBox',
		'boxes',
		'boxesSequence'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
BoxesGenerator class >> generateWith: numberOfBoxes and: numberOfParsecs [
	^self new initializeWith:numberOfBoxes and:numberOfParsecs.
]

{ #category : #action }
BoxesGenerator >> boxSequence [
	^ boxesSequence
]

{ #category : #action }
BoxesGenerator >> boxes [
	^ boxes
]

{ #category : #action }
BoxesGenerator >> createBoxesSequenceWith: quantityOfBoxesByEffect [

	| i |
	i := 1.
	quantityOfBoxesByEffect do: [ :each | 
		[ each >= i ] whileTrue: [ 
			boxesSequence add: (quantityOfBoxesByEffect keyAtValue:each).
			i := i + 1 ]. (each >=i ) ifFalse:[i:=1.]].
	boxesSequence:= boxesSequence shuffled first:boxes.
]

{ #category : #action }
BoxesGenerator >> generateBoxes [

	| wormholeBoxes atomicBombBoxes moonWalkBoxes speedUpBoxes hyperjumpBoxes noEffectBoxes quantityOfBoxesByEffect |
	wormholeBoxes := (boxes * 0.2) floor.
	atomicBombBoxes := (boxes * 0.02) floor.
	moonWalkBoxes := (boxes * 0.1) floor.
	speedUpBoxes := (boxes * 0.2) floor.
	hyperjumpBoxes := (boxes * 0.08) floor.
	noEffectBoxes := boxes - wormholeBoxes - atomicBombBoxes
	                 - moonWalkBoxes - hyperjumpBoxes- speedUpBoxes .
	quantityOfBoxesByEffect := Dictionary newFrom: { 
			                           ((WormHole with:parsecPerBox) -> wormholeBoxes).
			                           ((AtomicBomb with:
				                            parsecPerBox) -> atomicBombBoxes).
			                           ((Moonwalk
				                            with: ((0 to:(boxes//7)floor) atRandom)
				                            and: parsecPerBox) -> moonWalkBoxes).
			                           ((SpeedUp with:
				                            parsecPerBox) -> speedUpBoxes).
			                           ((HyperJump
				                            with: {5. 4. 3. 2. 1}
				                            parsecs:
				                            parsecPerBox) -> hyperjumpBoxes).
			                           ((Box parsecs:
				                            parsecPerBox) -> noEffectBoxes) }.
				self createBoxesSequenceWith:quantityOfBoxesByEffect.
]

{ #category : #initialization }
BoxesGenerator >> initializeWith: numberOfBoxes and: numberOfParsecs [ 
	parsecPerBox:= numberOfParsecs//numberOfBoxes.
	boxes:=numberOfBoxes.
	boxesSequence:= OrderedCollection new.
	self generateBoxes.
]
