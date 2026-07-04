"
A
"
Class {
	#name : 'CardAcceleration',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'action' }
CardAcceleration >> playedBy: aSpaceship targeting: aTarget in: aGame [

	aGame playsPermanentCard: self
]

{ #category : 'action' }
CardAcceleration >> rollAdjustmentFor: aSpaceship [

	^ 1
]
