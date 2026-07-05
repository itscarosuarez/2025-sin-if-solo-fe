"
card
"
Class {
	#name : 'CardDouble',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'action' }
CardDouble >> applyInstantaneousEffectIn: aGame [ 

	aGame rollAgainDueToDoubleCard.


]

{ #category : 'action' }
CardDouble >> playedBy: aSpaceship targeting: aTarget in: aGame [

	aGame playsInstantaneousCard: self
]
