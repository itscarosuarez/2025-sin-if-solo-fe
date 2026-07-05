"
card
"
Class {
	#name : 'CardReverse',
	#superclass : 'Card',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'action' }
CardReverse >> applyInstantaneousEffectIn: aGame [ 

	aGame reverseTurnOrderDueToCard 


]

{ #category : 'action' }
CardReverse >> playedBy: aSpaceship targeting: aTarget in: aGame [

	aGame playsInstantaneousCard: self
]
