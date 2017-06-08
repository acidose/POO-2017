!classDefinition: #Measure category: #'Measure-Solution'!
Magnitude subclass: #Measure
	instanceVariableNames: 'amount unit'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!Measure methodsFor: 'as yet unclassified' stamp: 'PR 6/6/2017 21:05:20'!
* aSmallInteger 
	^self class amount: amount*aSmallInteger unit: self unit.! !

!Measure methodsFor: 'as yet unclassified' stamp: 'PR 6/8/2017 18:15:18'!
+ aMeasure 
|measures|
	(aMeasure class = CompositeMeasure ) ifTrue: [^ aMeasure + self]. 
	
	(self class = aMeasure class) ifTrue: [
		
		(unit = aMeasure unit) ifTrue: [
			^self class amount: amount + aMeasure amount unit: unit.
		] ifFalse: [
			^self class amount: (amount + (aMeasure convertTo: unit) amount ) unit: unit
		]		
		
	] ifFalse: [
		measures := OrderedCollection new. 
		measures add: self. 
		measures add: aMeasure .
 		^CompositeMeasure new initialize: measures
	]! !

!Measure methodsFor: 'as yet unclassified' stamp: 'Mirko 6/8/2017 14:27:25'!
- aDistance 
	^self + aDistance  negated .! !

!Measure methodsFor: 'as yet unclassified' stamp: 'Mirko 6/6/2017 03:41:16'!
/ aSmallInteger 
	^self * (1/aSmallInteger). ! !

!Measure methodsFor: 'as yet unclassified' stamp: 'PR 6/5/2017 21:41:45'!
< aMeasure
	^ (amount * unit ratio) < (aMeasure amount * aMeasure unit ratio).! !

!Measure methodsFor: 'as yet unclassified' stamp: 'PR 6/8/2017 18:44:07'!
= aMeasure

	^(aMeasure isKindOf: self class) and: [ amount = (aMeasure convertTo: unit) amount].! !

!Measure methodsFor: 'as yet unclassified' stamp: 'Mirko 6/6/2017 00:42:33'!
adaptToNumber: aSmallInteger andSend: aSymbol 
	^self perform: aSymbol with: aSmallInteger.! !

!Measure methodsFor: 'as yet unclassified' stamp: 'PR 6/5/2017 19:02:40'!
amount
	^amount.! !

!Measure methodsFor: 'as yet unclassified' stamp: 'Mirko 6/8/2017 01:58:27'!
belong: anOrderedCollection
	|val collectVal|
	val := false.
	collectVal :=anOrderedCollection collect: [:element | val := val or: (self = element )].
	^collectVal at: collectVal size.! !

!Measure methodsFor: 'as yet unclassified' stamp: 'PR 6/8/2017 17:57:58'!
convertTo: anUnit
	| convertedAmount standardizedAmount |
	
	standardizedAmount := unit convertToStandard: amount.
	convertedAmount := anUnit convertFromStandard: standardizedAmount.

	^self class amount: convertedAmount unit: anUnit. ! !

!Measure methodsFor: 'as yet unclassified' stamp: 'Mirko 6/7/2017 23:41:52'!
initializeWithAmount: aNumber withUnit: anUnit 
	amount := aNumber.
	unit := anUnit.
	! !

!Measure methodsFor: 'as yet unclassified' stamp: 'PR 6/6/2017 21:05:53'!
negated
	^ self class amount: (amount * (-1)) unit: unit .! !

!Measure methodsFor: 'as yet unclassified' stamp: 'PR 6/5/2017 19:02:47'!
unit
	^unit.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Measure class' category: #'Measure-Solution'!
Measure class
	instanceVariableNames: ''!

!Measure class methodsFor: 'as yet unclassified' stamp: 'Mirko 6/7/2017 21:49:43'!
amount: aSmallInteger unit: anUnit 
	
	^self new initializeWithAmount: aSmallInteger withUnit: anUnit. 
	! !


!classDefinition: #CompositeMeasure category: #'Measure-Solution'!
Measure subclass: #CompositeMeasure
	instanceVariableNames: 'compositeMeasure'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!CompositeMeasure methodsFor: 'as yet unclassified' stamp: 'Mirko 6/8/2017 13:58:50'!
+ anMeasure 
	|measures|
	"tengo que sumar una medida compuesta con una medida"
measures := compositeMeasure collect: [:val | (anMeasure class = val class) ifTrue:[val + anMeasure ]ifFalse: [val]].
	(compositeMeasure = measures )ifTrue:[measures add: anMeasure ].
	
	^CompositeMeasure new initialize: measures.! !

!CompositeMeasure methodsFor: 'as yet unclassified' stamp: 'Mirko 6/8/2017 02:05:01'!
= anCompositeMeasure
	^(self included: anCompositeMeasure  ) and: (anCompositeMeasure  included: self ).! !

!CompositeMeasure methodsFor: 'as yet unclassified' stamp: 'Mirko 6/7/2017 23:59:11'!
compositeMeasure
	^compositeMeasure ! !

!CompositeMeasure methodsFor: 'as yet unclassified' stamp: 'Mirko 6/8/2017 02:00:36'!
included: anCompositeMeasure
	|val collectVal|
	val:= true.
	collectVal :=self compositeMeasure collect: [:element | val := val and: (element belong: anCompositeMeasure compositeMeasure )].
	^collectVal at: collectVal size.! !

!CompositeMeasure methodsFor: 'as yet unclassified' stamp: 'Mirko 6/8/2017 01:02:59'!
initialize: aOrderedCollection
	compositeMeasure := aOrderedCollection .! !


!classDefinition: #Currency category: #'Measure-Solution'!
Measure subclass: #Currency
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!


!classDefinition: #Dolar category: #'Measure-Solution'!
Currency subclass: #Dolar
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!


!classDefinition: #Peso category: #'Measure-Solution'!
Currency subclass: #Peso
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!


!classDefinition: #Distance category: #'Measure-Solution'!
Measure subclass: #Distance
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!Distance methodsFor: 'intervals' stamp: 'PR 5/30/2017 17:47:25'!
to: aDistance 
	^DistanceInterval from: self to: aDistance.! !

!Distance methodsFor: 'intervals' stamp: 'PR 5/30/2017 18:17:01'!
to: aDistance by: aDistance2 
	^DistanceInterval from: self to: aDistance by: aDistance2.! !



!Distance methodsFor: 'initialization' stamp: 'PR 6/1/2017 23:01:27'!
printString
	| distanceAsString |
	distanceAsString := amount printString, ' ',unit printString.
	
	(amount > 1) ifTrue: [distanceAsString := distanceAsString, 's'].
	
	^distanceAsString.! !

!Distance methodsFor: 'initialization' stamp: 'PR 6/1/2017 21:20:53'!
withAmount: anAmount withUnit: aUnit
	amount := anAmount.
	unit := aUnit.! !


!Distance methodsFor: 'inspecting' stamp: 'PR 6/3/2017 20:46:55'!
lesserUnit: aDistance 
(self unit ratio < aDistance unit ratio)ifTrue: [^self unit ] ifFalse: [^aDistance unit ]. ! !


!Distance methodsFor: 'hashing' stamp: 'Mirko 6/3/2017 22:50:58'!
hash
	|hasher|
	hasher := self convertTo: Unit createMeter.
	^  hasher amount hash .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Distance class' category: #'Measure-Solution'!
Distance class
	instanceVariableNames: 'unit value'!


!classDefinition: #Mass category: #'Measure-Solution'!
Measure subclass: #Mass
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!


!classDefinition: #Temperature category: #'Measure-Solution'!
Measure subclass: #Temperature
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!


!classDefinition: #Tiempo category: #'Measure-Solution'!
Measure subclass: #Tiempo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!


!classDefinition: #MeasureTest category: #'Measure-Solution'!
TestCase subclass: #MeasureTest
	instanceVariableNames: 'factory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!MeasureTest methodsFor: 'setup' stamp: 'PR 6/5/2017 18:34:24'!
setUp
	factory := MeasureFactory new.! !


!MeasureTest methodsFor: 'mass' stamp: 'PR 6/6/2017 19:10:58'!
test000CreatedMassShouldHaveCorrectUnitAndAmount.

	self assert: factory oneKilogram unit = factory kilogram.
	self assert: factory oneKilogram amount = 1.! !

!MeasureTest methodsFor: 'mass' stamp: 'PR 6/5/2017 21:03:23'!
test001MassRepresentingSameMassShouldBeEqual

	self assert: factory oneKilogram = factory oneKilogram.
	self assert: factory fiveHundredGrams = factory fiveHundredGrams.! !

!MeasureTest methodsFor: 'mass' stamp: 'PR 6/5/2017 21:03:34'!
test002DifferentMassesShouldntBeEqual

	self deny: factory oneKilogram = factory twoKilograms.
	self deny: factory fiveHundredGrams = factory oneThousandGrams.! !

!MeasureTest methodsFor: 'mass' stamp: 'PR 6/6/2017 20:57:30'!
test003AMassCanBeAddedWithAnotherMassWithSameUnit

	self assert: factory oneKilogram  + factory  oneKilogram = factory twoKilograms .
	self assert: factory oneGram + factory oneGram = factory twoGrams.! !

!MeasureTest methodsFor: 'mass' stamp: 'PR 6/6/2017 20:57:18'!
test004AMassCanBeAddedWithAnotherMassWithDifferentUnit

	self assert: factory oneKilogram  +  factory oneThousandGrams = factory twoKilograms .
! !

!MeasureTest methodsFor: 'mass' stamp: 'PR 6/6/2017 20:58:43'!
test005AMassCanBeSubstractedWithAnotherMassWithSameUnit

	self assert: factory twoKilograms  - factory  oneKilogram = factory oneKilogram .
	self assert: factory twoGrams - factory oneGram = factory oneGram.! !

!MeasureTest methodsFor: 'mass' stamp: 'Mirko 6/7/2017 13:14:34'!
test006AMassCanBeSubstractedWithAnotherMassWithDifferentUnit

	self assert: factory twoKilograms  -  factory oneThousandGrams = factory oneKilogram .
! !

!MeasureTest methodsFor: 'mass' stamp: 'PR 6/6/2017 20:59:12'!
test007AMassCanBeMultipliedByAScalar

	self assert: factory oneKilogram  * 2 = factory twoKilograms .
	self assert: factory twoGrams *(1/2) = factory oneGram.! !

!MeasureTest methodsFor: 'mass' stamp: 'PR 6/6/2017 20:59:36'!
test008AScalarCanBeMultipliedByAMass

	self assert:  2 * factory oneKilogram   = factory twoKilograms .
	self assert: (1/2) * factory twoGrams  = factory oneGram.! !

!MeasureTest methodsFor: 'mass' stamp: 'PR 6/6/2017 21:00:00'!
test009AMassCanBeDividedByAScalar

	self assert: factory twoKilograms  / 2 = factory oneKilogram .
	self assert: factory twoGrams /2 = factory oneGram.! !

!MeasureTest methodsFor: 'mass' stamp: 'PR 6/6/2017 21:00:26'!
test010AMassCanBeNegated

	self assert: factory oneKilogram negated = factory minusOneKilogram .
	self assert: factory oneKilogram negated negated = factory oneKilogram .! !


!MeasureTest methodsFor: 'temperature' stamp: 'PR 6/6/2017 19:13:10'!
test100CreatedTemperaturesShouldHaveCorrectUnitAndAmount

	self assert: factory oneCelsius unit= factory celsius.
	self assert: factory oneCelsius amount = 1.
	
	self assert: factory threeKelvin unit = factory kelvin.
	self assert: factory threeKelvin amount = 3.
	
	self assert: factory thirtyTwoFahrenheits unit = factory fahrenheit.
	self assert: factory thirtyTwoFahrenheits amount = 32.! !

!MeasureTest methodsFor: 'temperature' stamp: 'PR 6/5/2017 19:19:44'!
test101TemperatureRepresentingSameTemperatureShoudBeEqual

	self assert: factory oneCelsius = factory oneCelsius.
	self assert: factory zeroKelvin = factory zeroKelvin.
	self assert: factory thirtyTwoFahrenheits = factory thirtyTwoFahrenheits.! !

!MeasureTest methodsFor: 'temperature' stamp: 'PR 6/8/2017 16:50:55'!
test102DifferentTemperatureShouldntBeEqual

	self deny: factory oneCelsius = factory twoCelsius.
	self deny: factory threeKelvin = factory zeroKelvin.
	self deny: factory thirtyTwoFahrenheits = factory tenFahrenheits.! !

!MeasureTest methodsFor: 'temperature' stamp: 'PR 6/6/2017 21:34:58'!
test103ATemperatureCanBeAddedWithAnotherTemperatureWithSameUnit

	self assert: factory oneCelsius  + factory  oneCelsius = factory twoCelsius.
	self assert: factory threeKelvin + factory threeKelvin = factory sixKelvin.! !

!MeasureTest methodsFor: 'temperature' stamp: 'PR 6/8/2017 18:24:06'!
test104ATemperatureCanBeAddedWithAnotherTemperatureWithDifferentUnit

	self assert: factory oneCelsius  + factory  threeKelvin = factory minusTwoHundredSixtyNineDotFifteenCelsius .
	self assert: factory oneCelsius + factory thirtyTwoFahrenheits = factory oneCelsius.
	self assert: factory threeKelvin + factory thirtyTwoFahrenheits = factory twoHundredSeventySixDotFifteenKelvin.! !

!MeasureTest methodsFor: 'temperature' stamp: 'PR 6/6/2017 21:39:36'!
test105ATemperatureCanBeSubstractedWithAnotherTemperatureWithSameUnit

	self assert: factory twoCelsius - factory  oneCelsius = factory oneCelsius .
	self assert: factory thirtyTwoFahrenheits - factory twentyFahrenheits = factory twelveFahrenheits .	! !

!MeasureTest methodsFor: 'temperature' stamp: 'PR 6/8/2017 18:33:00'!
test106ATemperatureCanBeSubstractedWithAnotherTemperatureWithDifferentUnit

	self assert: factory thirtyCelsius - factory  threeHundredKelvin = factory minusFiveHundredFourtyThreeDotFifteenCelsius.! !


!MeasureTest methodsFor: 'distance' stamp: 'PR 6/5/2017 21:34:55'!
test201DistanceRepresentingSameDistanceShoudBeEqual

	self assert: factory oneMeter = factory oneMeter.
	self assert: factory oneHundredCentimeters = factory oneHundredCentimeters.
	self assert: factory oneKilometer = factory oneKilometer.! !

!MeasureTest methodsFor: 'distance' stamp: 'PR 6/8/2017 17:45:40'!
test202CanConvertADistanceToAnotherDistance

	self assert: (factory oneHundredCentimeters convertTo: factory meter) = factory oneMeter.
	self assert: (factory oneThousandMeters convertTo: factory kilometer) = factory oneKilometer .! !


!MeasureTest methodsFor: 'time' stamp: 'Mirko 6/7/2017 12:20:40'!
test300CreatedTimesShoudHaveCorrectUnitAndAmount

	self assert: factory oneMinute unit = factory minute.
	self assert: factory oneMinute amount = 1.

! !

!MeasureTest methodsFor: 'time' stamp: 'Mirko 6/7/2017 12:43:46'!
test301TimeRepresentingSameTimeShouldBeEqual

	self assert: factory oneMinute  = factory oneMinute .
	self assert: factory oneHour  = factory oneHour.
	self assert: factory oneSecond = factory oneSecond.

! !

!MeasureTest methodsFor: 'time' stamp: 'Mirko 6/7/2017 12:45:42'!
test302DifferentTimesShouldntBeEqual

	self deny: factory oneMinute  = factory oneHour .
	self deny: factory oneSecond  = factory oneHour.
	self deny: factory oneSecond = factory oneMinute .

! !

!MeasureTest methodsFor: 'time' stamp: 'Mirko 6/7/2017 12:49:17'!
test303EquivalenceBetweenDifferentUnits

	self assert: factory sixtyMinutes  = factory oneHour .
	self assert: factory sixtySecond  = factory oneMinute.
	self assert: factory threeThousandSixhundredSecond = factory oneHour.

! !

!MeasureTest methodsFor: 'time' stamp: 'Mirko 6/7/2017 13:05:20'!
test304ATimeCanBeAddedWithAnotherTimeWithSameUnit

	self assert: factory oneHour  + factory oneHour = factory twoHours.
	self assert: factory oneMinute  + factory oneMinute = factory oneHundredAndTwentySeconds. 
	self assert: factory oneSecond  + factory oneSecond = factory twoSeconds.! !

!MeasureTest methodsFor: 'time' stamp: 'Mirko 6/7/2017 13:05:41'!
test305ATimeCanBeAddedWithAnotherTimeWithDifferentUnit

	self assert: factory sixtyMinutes  + factory oneHour = factory twoHours.
	self assert: factory sixtySecond  + factory oneMinute = factory oneHundredAndTwentySeconds. 
	self assert: factory sixtySecond  + factory oneMinute = factory twoMinutes.! !

!MeasureTest methodsFor: 'time' stamp: 'Mirko 6/7/2017 13:13:09'!
test306ATimeCanBeSubstractedWithAnotherTimeWithSameUnit

	self assert: factory twoHours  - factory oneHour = factory oneHour.
	self assert: factory twoSeconds  - factory oneSecond = factory oneSecond. 
	self assert: factory twoMinutes  - factory oneMinute = factory oneMinute.! !

!MeasureTest methodsFor: 'time' stamp: 'Mirko 6/7/2017 13:17:14'!
test307ATimeCanBeSubstractedWithAnotherTimeWithDifferentUnit

	self assert: factory twoHours  - factory sixtyMinutes = factory oneHour.
	self assert: factory twoHours  - factory sixtyMinutes = factory threeThousandSixhundredSecond.
	self assert: factory twoMinutes  - factory sixtySecond = factory oneMinute.! !

!MeasureTest methodsFor: 'time' stamp: 'Mirko 6/7/2017 13:20:15'!
test308ATimeCanBeMultipliedByAScalar

	self assert: factory oneHour * 2  = factory twoHours.
	self assert: factory sixtyMinutes * 2 =  factory twoHours .
	self assert: factory oneSecond * 60 = factory oneMinute.
	self assert: factory oneHour * (1/60) = factory oneMinute.! !

!MeasureTest methodsFor: 'time' stamp: 'Mirko 6/7/2017 14:43:25'!
test309AScalarCanBeMultipliedByATime

	self assert: 2 * factory oneHour  = factory twoHours.
	self assert:  2 * factory sixtyMinutes  =  factory twoHours .
	self assert: 60 * factory oneSecond  = factory oneMinute.
	self assert:  (1/60) * factory oneHour  = factory oneMinute.! !

!MeasureTest methodsFor: 'time' stamp: 'Mirko 6/7/2017 14:42:47'!
test310ATimeCanBeDividedByAScalar

	self assert:   factory twoHours/ 2 = factory oneHour  .
	self assert:   factory twoHours / 2  = factory sixtyMinutes  .
	self assert:  	factory oneMinute / 60 = factory oneSecond .
	self assert:  	factory oneHour / 3600 = factory oneSecond.! !

!MeasureTest methodsFor: 'time' stamp: 'Mirko 6/7/2017 14:45:46'!
test311ATimeCanBeNegated

	self assert:   factory oneHour negated = factory minus0neHour .
	self assert:  factory oneMinute negated = factory minusOneMinute.
	self assert: factory oneSecond  negated = factory minusOneSecond. 
	
! !


!MeasureTest methodsFor: 'coin' stamp: 'Mirko 6/7/2017 15:00:53'!
test400CreatedCoinShouldHaveCorrectUnitAndAmount.

	self assert: factory oneDolar unit = factory dolar.
	self assert: factory oneDolar amount = 1.
	
	self assert: factory onePeso unit  = factory peso.
	self assert: factory onePeso amount = 1.! !

!MeasureTest methodsFor: 'coin' stamp: 'Mirko 6/7/2017 15:02:58'!
test401CoinRepresentingSameCoinShouldBeEqual

	self assert: factory oneDolar = factory oneDolar.	
	self assert: factory onePeso  = factory onePeso. ! !

!MeasureTest methodsFor: 'coin' stamp: 'Mirko 6/7/2017 15:12:29'!
test402DifferentTypesCoinsDoNotAreEquals

	self deny: factory oneMinute  = factory onePeso.

! !

!MeasureTest methodsFor: 'coin' stamp: 'Mirko 6/7/2017 15:17:07'!
test403ACoinCanBeAddedWithAnotherCoinWithSameUnit

	self assert: factory oneDolar  + factory oneDolar = factory twoDolars.
	self assert: factory onePeso  + factory onePeso = factory twoPesos ! !

!MeasureTest methodsFor: 'coin' stamp: 'Mirko 6/7/2017 19:34:24'!
test404ACoinCanBeSubstractedWithAnotherCoinWithSameUnit

	self assert: factory twoDolars  - factory oneDolar = factory oneDolar.
	self assert: factory twoPesos  - factory onePeso = factory onePeso.! !

!MeasureTest methodsFor: 'coin' stamp: 'Mirko 6/7/2017 19:35:32'!
test405ACoinCanBeMultipliedByAScalar

	self assert: factory oneDolar * 2 = factory twoDolars.
	self assert: factory onePeso *2  = factory twoPesos.! !

!MeasureTest methodsFor: 'coin' stamp: 'Mirko 6/7/2017 19:37:13'!
test406AScalarCanBeMultipliedByACoin

	self assert:  2  * factory oneDolar = factory twoDolars.
	self assert: 2 * factory onePeso  = factory twoPesos.
	! !

!MeasureTest methodsFor: 'coin' stamp: 'Mirko 6/7/2017 19:38:45'!
test407ACoinCanBeDividedByAScalar

	self assert:  factory twoDolars / 2 = factory oneDolar .
	self assert:  factory twoPesos / 2 = factory onePeso  .
	! !

!MeasureTest methodsFor: 'coin' stamp: 'Mirko 6/7/2017 19:41:54'!
test408ACoinCanBeNegated

	self assert: factory oneDolar negated = factory minusOneDolar.
	self assert: factory onePeso negated negated = factory onePeso.! !


!MeasureTest methodsFor: 'Interaction' stamp: 'Mirko 6/8/2017 14:42:18'!
test500a_CompareDifferentTypesOfUnitsMustGiveFalse

self deny:  factory oneMeter = factory oneKilogram .

self deny:  factory oneGram  = factory oneKilometer.

self deny:  factory onePeso  = factory oneDolar.

self deny:  factory onePeso = factory oneGram! !

!MeasureTest methodsFor: 'Interaction' stamp: 'Mirko 6/8/2017 14:42:31'!
test500b_InteractionBetweenSumOfDifferentUnitsNoCombinanUnits

self assert: factory oneMeter + factory oneKilogram  = (factory oneMeter + factory oneKilogram).
self deny:  (factory oneMeter + factory oneKilogram) unit = Unit meter .
self deny:  (factory oneMeter + factory oneKilogram) unit = Unit kilometer .

self assert: factory oneGram  + factory oneKilometer  = ( factory oneGram  + factory oneKilometer).
self deny:  (factory oneGram  + factory oneKilometer) unit = Unit gram .
self deny:  (factory oneGram  + factory oneKilometer) unit = Unit kilometer .

self assert: factory onePeso  + factory oneDolar  =  (factory onePeso  + factory oneDolar).
self deny:  (factory onePeso  + factory oneDolar) unit = Unit peso .
self deny:  (factory onePeso  + factory oneDolar) unit = Unit dolar .

self assert: factory onePeso + factory oneGram  =  (factory onePeso + factory oneGram).
self deny:  (factory onePeso + factory oneGram) unit = Unit peso .
self deny:  (factory onePeso + factory oneGram) unit = Unit gram .
! !

!MeasureTest methodsFor: 'Interaction' stamp: 'Mirko 6/8/2017 14:30:59'!
test501InteractionBetweenSumOfDifferentUnitsNoCombinanUnitsAreTheSameRegardlessOfTheSumOrder

self assert: factory oneHundredCentimeters + factory oneKilogram  = ( factory oneKilogram + factory oneMeter ).

self assert: factory oneGram  + factory oneKilometer  = ( factory  oneMeter * 1000 + factory oneGram ).


self assert: factory onePeso + (factory oneGram * 1000)  =  (factory oneKilogram + factory onePeso).
! !

!MeasureTest methodsFor: 'Interaction' stamp: 'Mirko 6/8/2017 13:28:07'!
test503InteractionBetweenSumOfDifferentUnitsNoCombinanUnitsAreTheSameRegardlessOfTheSumOrderAndSupportsEquivalenceOfTheSameUnitType

self assert: factory oneHundredCentimeters + factory oneKilogram  = ( factory oneKilogram + factory oneMeter ).

self assert: factory oneGram  + factory oneKilometer  = ( factory  oneMeter * 1000 + factory oneGram ).


self assert: factory onePeso + (factory oneGram * 1000)  =  (factory oneKilogram + factory onePeso).
! !

!MeasureTest methodsFor: 'Interaction' stamp: 'Mirko 6/8/2017 14:51:53'!
test504AddingCompositeMeasureWithMeasuresWithAllTheDifferentMeasures

self assert: factory oneHundredCentimeters + factory oneKilogram + factory onePeso  = ( factory oneKilogram + factory  onePeso + factory oneMeter ).


self assert: factory onePeso + (factory oneGram * 1000) + factory oneSecond =  (factory oneKilogram + factory onePeso + factory oneSecond ) .
! !

!MeasureTest methodsFor: 'Interaction' stamp: 'Mirko 6/8/2017 14:51:25'!
test505AddingCompositeMeasureWithMeasuresWhereSomeTypesOfMeasuresAreRepeated

self assert: factory oneHundredCentimeters + factory oneKilogram + factory oneMeter  = ( factory oneKilogram + factory twoMeters ).


self assert: factory onePeso + (factory oneGram * 1000) + factory onePeso =  (factory oneKilogram + factory twoPesos ) .
! !

!MeasureTest methodsFor: 'Interaction' stamp: 'Mirko 6/8/2017 14:26:37'!
test506InteractionBetweenSubtractionOfFDfferentTypesOfUnitsAreNotCombinable

self assert: factory oneMeter - factory oneKilogram  = (factory oneMeter - factory oneKilogram).
self deny:  (factory oneMeter - factory oneKilogram) unit = Unit meter .
self deny:  (factory oneMeter - factory oneKilogram) unit = Unit kilometer .

self assert: factory oneGram  - factory oneKilometer  = ( factory oneGram  - factory oneKilometer).
self deny:  (factory oneGram  - factory oneKilometer) unit = Unit gram .
self deny:  (factory oneGram  - factory oneKilometer) unit = Unit kilometer .

self assert: factory onePeso  - factory oneDolar  =  (factory onePeso  - factory oneDolar).
self deny:  (factory onePeso  - factory oneDolar) unit = Unit peso .
self deny:  (factory onePeso  - factory oneDolar) unit = Unit dolar .

self assert: factory onePeso - factory oneGram  =  (factory onePeso - factory oneGram).
self deny:  (factory onePeso - factory oneGram) unit = Unit peso .
self deny:  (factory onePeso - factory oneGram) unit = Unit gram .



! !

!MeasureTest methodsFor: 'Interaction' stamp: 'Mirko 6/8/2017 14:52:22'!
test507CompositeMeasuresCanBeSubtractionWithMeasuresWithAllTheDifferentMeasures

self assert: factory oneHundredCentimeters - factory oneKilogram - factory onePeso  = (factory oneMeter  - factory oneKilogram - factory  onePeso ).


self assert: factory onePeso - (factory oneGram * 1000) - factory oneSecond =  ( factory onePeso  - factory oneSecond - factory oneKilogram ) .

! !

!MeasureTest methodsFor: 'Interaction' stamp: 'Mirko 6/8/2017 14:56:56'!
test508AddingMeasureWithCompositeMeasure

self assert: factory oneHundredCentimeters + (factory oneKilogram + factory onePeso)  = (factory oneMeter  + factory oneKilogram + factory  onePeso ).
self assert: factory onePeso + ((factory oneGram * 1000) + factory oneSecond) =  ( factory onePeso  + factory oneSecond + factory oneKilogram ) .

! !


!classDefinition: #MeasureFactory category: #'Measure-Solution'!
Object subclass: #MeasureFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!MeasureFactory methodsFor: 'mass' stamp: 'PR 6/6/2017 21:08:33'!
fiveHundredGrams
	^Mass amount: 500 unit: Unit gram.! !

!MeasureFactory methodsFor: 'mass' stamp: 'PR 6/6/2017 21:09:09'!
minusOneKilogram
	^Mass amount: -1 unit: Unit kilogram.! !

!MeasureFactory methodsFor: 'mass' stamp: 'PR 6/6/2017 21:10:32'!
oneGram
	^Mass amount: 1 unit: Unit gram.! !

!MeasureFactory methodsFor: 'mass' stamp: 'PR 6/6/2017 21:25:14'!
oneKilogram
	^Mass amount: 1 unit: Unit kilogram.! !

!MeasureFactory methodsFor: 'mass' stamp: 'PR 6/6/2017 21:11:50'!
oneThousandGrams
	^Mass amount: 1000 unit: Unit gram.! !

!MeasureFactory methodsFor: 'mass' stamp: 'PR 6/6/2017 21:15:48'!
twoGrams
	^Mass amount: 2 unit: Unit gram.! !

!MeasureFactory methodsFor: 'mass' stamp: 'PR 6/6/2017 21:15:59'!
twoKilograms
	^Mass amount: 2 unit: Unit kilogram .! !


!MeasureFactory methodsFor: 'temperature unit' stamp: 'PR 6/6/2017 21:07:58'!
celsius
	^Unit celsius.! !

!MeasureFactory methodsFor: 'temperature unit' stamp: 'PR 6/6/2017 21:08:09'!
fahrenheit
	^Unit fahrenheit.! !

!MeasureFactory methodsFor: 'temperature unit' stamp: 'PR 6/6/2017 21:08:43'!
kelvin
	^Unit kelvin.! !


!MeasureFactory methodsFor: 'distance unit' stamp: 'PR 6/6/2017 21:07:47'!
centimeter
	^Unit centimeter .! !

!MeasureFactory methodsFor: 'distance unit' stamp: 'PR 6/6/2017 21:07:54'!
decameter
	^Unit decameter .! !

!MeasureFactory methodsFor: 'distance unit' stamp: 'PR 6/6/2017 21:08:03'!
decimeter
	^Unit decimeter .! !

!MeasureFactory methodsFor: 'distance unit' stamp: 'PR 6/6/2017 21:08:38'!
hectometer
	^Unit hectometer .! !

!MeasureFactory methodsFor: 'distance unit' stamp: 'PR 6/6/2017 21:08:51'!
kilometer
	^Unit kilometer .! !

!MeasureFactory methodsFor: 'distance unit' stamp: 'PR 6/6/2017 21:08:53'!
meter
	^Unit meter .! !

!MeasureFactory methodsFor: 'distance unit' stamp: 'PR 6/6/2017 21:08:58'!
millimeter
	^Unit millimeter.! !


!MeasureFactory methodsFor: 'mass unit' stamp: 'Mirko 6/7/2017 00:12:33'!
gram
	^Unit gram.! !

!MeasureFactory methodsFor: 'mass unit' stamp: 'PR 6/6/2017 21:08:47'!
kilogram
	^Unit kilogram.! !


!MeasureFactory methodsFor: 'distance' stamp: 'PR 6/6/2017 21:09:33'!
minusOneMeter
	^Distance amount: -1 unit: Unit meter.! !

!MeasureFactory methodsFor: 'distance' stamp: 'PR 6/6/2017 21:11:02'!
oneHundredCentimeters
	^Distance amount: 100 unit: Unit centimeter.! !

!MeasureFactory methodsFor: 'distance' stamp: 'PR 6/6/2017 21:11:13'!
oneKilometer
	^Distance amount: 1 unit: Unit kilometer.! !

!MeasureFactory methodsFor: 'distance' stamp: 'PR 6/6/2017 21:11:23'!
oneMeter
	^Distance amount: 1 unit: Unit meter.! !

!MeasureFactory methodsFor: 'distance' stamp: 'PR 6/8/2017 17:45:13'!
oneThousandMeters
	^Distance amount: 1000 unit: Unit meter .! !

!MeasureFactory methodsFor: 'distance' stamp: 'PR 6/6/2017 21:06:13'!
twoKilometers
	^Distance amount: 2 unit: Unit kilometer.! !

!MeasureFactory methodsFor: 'distance' stamp: 'PR 6/6/2017 21:06:23'!
twoMeters
	^Distance amount: 2 unit: Unit meter .! !


!MeasureFactory methodsFor: 'temperature' stamp: 'PR 6/8/2017 18:33:17'!
minusFiveHundredFourtyThreeDotFifteenCelsius
	^Temperature amount: -543.15 unit: Unit celsius .! !

!MeasureFactory methodsFor: 'temperature' stamp: 'PR 6/8/2017 18:22:26'!
minusTwoHundredSixtyNineDotFifteenCelsius
	^Temperature amount: -269.15 unit: Unit celsius.! !

!MeasureFactory methodsFor: 'temperature' stamp: 'PR 6/6/2017 21:10:15'!
oneCelsius
	^Temperature amount: 1 unit: Unit celsius.! !

!MeasureFactory methodsFor: 'temperature' stamp: 'PR 6/6/2017 21:12:05'!
sixKelvin
	^Temperature amount: 6 unit: Unit kelvin.! !

!MeasureFactory methodsFor: 'temperature' stamp: 'PR 6/6/2017 21:12:22'!
tenFahrenheits
	^Temperature amount: 10 unit: Unit fahrenheit .! !

!MeasureFactory methodsFor: 'temperature' stamp: 'PR 6/6/2017 21:12:38'!
thirtyCelsius
	^Temperature amount: 30 unit: Unit celsius.! !

!MeasureFactory methodsFor: 'temperature' stamp: 'PR 6/6/2017 21:13:02'!
thirtyTwoFahrenheits
	^Temperature amount: 32 unit: Unit fahrenheit .! !

!MeasureFactory methodsFor: 'temperature' stamp: 'PR 6/6/2017 21:13:12'!
threeHundredKelvin
	^Temperature amount: 300 unit: Unit kelvin.! !

!MeasureFactory methodsFor: 'temperature' stamp: 'PR 6/6/2017 21:13:22'!
threeKelvin
	^Temperature amount: 3 unit: Unit kelvin.! !

!MeasureFactory methodsFor: 'temperature' stamp: 'PR 6/6/2017 21:15:14'!
twelveFahrenheits
	^Temperature amount: 12 unit: Unit fahrenheit .! !

!MeasureFactory methodsFor: 'temperature' stamp: 'PR 6/6/2017 21:15:23'!
twentyFahrenheits
	^Temperature amount: 20 unit: Unit fahrenheit .! !

!MeasureFactory methodsFor: 'temperature' stamp: 'PR 6/6/2017 21:15:34'!
twoCelsius
	^Temperature amount: 2 unit: Unit celsius .! !

!MeasureFactory methodsFor: 'temperature' stamp: 'PR 6/8/2017 18:25:48'!
twoHundredSeventySixDotFifteenKelvin
	^Temperature amount: 276.15 unit: Unit kelvin.! !

!MeasureFactory methodsFor: 'temperature' stamp: 'PR 6/6/2017 21:16:14'!
zeroCelsius
	^Temperature amount: 0 unit: Unit celsius .! !

!MeasureFactory methodsFor: 'temperature' stamp: 'PR 6/6/2017 21:16:23'!
zeroKelvin
	^Temperature amount: 0 unit: Unit kelvin .! !


!MeasureFactory methodsFor: 'time' stamp: 'Mirko 6/7/2017 14:46:16'!
minus0neHour
	^Tiempo amount: -1 unit: Unit hour.! !

!MeasureFactory methodsFor: 'time' stamp: 'Mirko 6/7/2017 14:46:42'!
minusOneMinute
	^Tiempo amount: -1  unit:Unit minute .! !

!MeasureFactory methodsFor: 'time' stamp: 'Mirko 6/7/2017 14:47:07'!
minusOneSecond
	^Tiempo amount: -1 unit: Unit second. ! !

!MeasureFactory methodsFor: 'time' stamp: 'Mirko 6/7/2017 12:33:37'!
oneHour
	^Tiempo amount: 1 unit: Unit hour.! !

!MeasureFactory methodsFor: 'time' stamp: 'Mirko 6/7/2017 13:00:37'!
oneHundredAndTwentySeconds
	^Tiempo amount: 120 unit: Unit second .! !

!MeasureFactory methodsFor: 'time' stamp: 'Mirko 6/7/2017 12:23:33'!
oneMinute
	^Tiempo amount: 1 unit: Unit  minute .! !

!MeasureFactory methodsFor: 'time' stamp: 'Mirko 6/7/2017 12:39:13'!
oneSecond
	^Tiempo amount: 1 unit: Unit second.! !

!MeasureFactory methodsFor: 'time' stamp: 'Mirko 6/7/2017 12:50:20'!
sixtyMinutes
	^Tiempo amount: 60 unit: Unit minute.! !

!MeasureFactory methodsFor: 'time' stamp: 'Mirko 6/7/2017 12:51:01'!
sixtySecond
	^Tiempo amount: 60 unit: Unit second.
	! !

!MeasureFactory methodsFor: 'time' stamp: 'Mirko 6/7/2017 12:52:47'!
threeThousandSixhundredSecond
	^Tiempo amount: 3600 unit: Unit second.! !

!MeasureFactory methodsFor: 'time' stamp: 'Mirko 6/7/2017 12:59:49'!
twoHours
	^Tiempo amount: 2 unit: Unit hour.! !

!MeasureFactory methodsFor: 'time' stamp: 'Mirko 6/7/2017 13:00:12'!
twoMinutes
	^Tiempo amount: 2 unit: Unit minute.! !

!MeasureFactory methodsFor: 'time' stamp: 'Mirko 6/7/2017 13:06:13'!
twoSeconds
	^Tiempo amount: 2 unit: Unit second .! !


!MeasureFactory methodsFor: 'coin unit' stamp: 'Mirko 6/7/2017 14:54:10'!
dolar
	^Unit dolar .! !

!MeasureFactory methodsFor: 'coin unit' stamp: 'Mirko 6/7/2017 14:59:52'!
peso
	^Unit peso.! !


!MeasureFactory methodsFor: 'time unit' stamp: 'Mirko 6/7/2017 15:28:13'!
hour
	^Unit hour .! !

!MeasureFactory methodsFor: 'time unit' stamp: 'Mirko 6/7/2017 12:25:36'!
minute
	^Unit minute.! !


!MeasureFactory methodsFor: 'coin' stamp: 'Mirko 6/7/2017 19:41:04'!
minusOneDolar
	^Dolar  amount: -1 unit: Unit dolar .! !

!MeasureFactory methodsFor: 'coin' stamp: 'Mirko 6/7/2017 15:03:32'!
oneDolar
	^Dolar amount: 1 unit: Unit dolar. ! !

!MeasureFactory methodsFor: 'coin' stamp: 'Mirko 6/7/2017 14:57:48'!
onePeso
	^Peso amount: 1 unit: Unit peso. ! !

!MeasureFactory methodsFor: 'coin' stamp: 'Mirko 6/7/2017 15:17:37'!
twoDolars
	^ Dolar amount: 2 unit: Unit  dolar .! !

!MeasureFactory methodsFor: 'coin' stamp: 'Mirko 6/7/2017 15:18:02'!
twoPesos
	^Peso amount: 2 unit: Unit peso.! !


!MeasureFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/8/2017 18:28:24'!
minusFiveHundredFourtyThreeDotFifteen
	self shouldBeImplemented! !


!classDefinition: #Unit category: #'Measure-Solution'!
Object subclass: #Unit
	instanceVariableNames: 'name conversionFromStandard conversionToStandard'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!Unit methodsFor: 'inspecting' stamp: 'PR 6/1/2017 23:08:46'!
= anObject
	(anObject isKindOf: self class) ifFalse: [^False].
	
	^(self ratio = anObject ratio) and: [self name = anObject name].! !

!Unit methodsFor: 'inspecting' stamp: 'PR 6/8/2017 17:20:26'!
convertFromStandard: anAmount
	^conversionFromStandard value: anAmount.! !

!Unit methodsFor: 'inspecting' stamp: 'PR 6/8/2017 17:20:39'!
convertToStandard: anAmount
	^conversionToStandard value: anAmount.! !

!Unit methodsFor: 'inspecting' stamp: 'PR 6/1/2017 20:40:53'!
printString
	^name.! !

!Unit methodsFor: 'inspecting' stamp: 'PR 6/1/2017 20:40:48'!
ratio
	^rate.! !


!Unit methodsFor: 'initialization' stamp: 'PR 6/8/2017 17:23:17'!
initializeWithConversionsTo: aBlock from: anotherBlock withName: aName
	conversionToStandard := aBlock.
	conversionFromStandard := anotherBlock.
	name := aName.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Unit class' category: #'Measure-Solution'!
Unit class
	instanceVariableNames: ''!

!Unit class methodsFor: 'initialization' stamp: 'PR 6/6/2017 20:45:54'!
initialize
		Smalltalk at: #celsius put: self celsius.
		
		! !


!Unit class methodsFor: 'creation' stamp: 'PR 6/8/2017 17:24:45'!
conversionToStandard: aBlock conversionFromStandard: anotherBlock named: aName
	^self new initializeWithConversionsTo: aBlock from: anotherBlock withName: aName.! !


!Unit class methodsFor: 'distance creation' stamp: 'PR 6/8/2017 17:43:40'!
centimeter
	^self conversionToStandard: [ :amount | amount/100] conversionFromStandard: [ :amount | amount*100 ]  named: 'centimeter'.! !

!Unit class methodsFor: 'distance creation' stamp: 'PR 6/8/2017 17:49:01'!
decameter
	^self conversionToStandard: [ :amount | amount*10 ] conversionFromStandard: [ :amount | amount/10 ]  named: 'decameter'.! !

!Unit class methodsFor: 'distance creation' stamp: 'PR 6/8/2017 17:49:17'!
decimeter
	^self conversionToStandard: [ :amount | amount/10 ] conversionFromStandard: [ :amount | amount*10 ]  named: 'decimeter'.! !

!Unit class methodsFor: 'distance creation' stamp: 'PR 6/8/2017 17:50:08'!
hectometer
	^self conversionToStandard: [ :amount | amount*100 ] conversionFromStandard: [ :amount | amount/100 ]  named: 'hectometer'.! !

!Unit class methodsFor: 'distance creation' stamp: 'PR 6/8/2017 17:41:23'!
kilometer
	^self conversionToStandard: [ :amount | amount*1000 ] conversionFromStandard: [ :amount | amount/1000 ]  named: 'celsius'.! !

!Unit class methodsFor: 'distance creation' stamp: 'PR 6/8/2017 17:33:04'!
meter
	^self conversionToStandard: [ :amount | amount] conversionFromStandard: [ :amount | amount] named: 'meter'.! !

!Unit class methodsFor: 'distance creation' stamp: 'PR 6/8/2017 17:50:28'!
millimeter
	^self conversionToStandard: [ :amount | amount/1000 ] conversionFromStandard: [ :amount | amount*1000 ]  named: 'millimeter'.! !


!Unit class methodsFor: 'temperature creation' stamp: 'PR 6/8/2017 17:28:24'!
celsius
	^self conversionToStandard: [ :amount | amount] conversionFromStandard: [ :amount | amount]  named: 'celsius'.! !

!Unit class methodsFor: 'temperature creation' stamp: 'PR 6/8/2017 17:31:07'!
fahrenheit
	^self conversionToStandard: [ :amount | (amount - 32) / 1.8] conversionFromStandard: [ :amount | amount * 1.8 + 32 ] named: 'fahrenheit' ! !

!Unit class methodsFor: 'temperature creation' stamp: 'PR 6/8/2017 18:19:12'!
kelvin
	^self conversionToStandard: [ :amount | amount - 273.15 ] conversionFromStandard: [ :amount | amount + 273.15 ] named: 'kelvin' ! !


!Unit class methodsFor: 'mass creation' stamp: 'PR 6/8/2017 17:50:44'!
gram
	^self conversionToStandard: [ :amount | amount] conversionFromStandard: [ :amount | amount]  named: 'gram'.! !

!Unit class methodsFor: 'mass creation' stamp: 'PR 6/8/2017 17:51:32'!
kilogram
	^self conversionToStandard: [ :amount | amount*1000 ] conversionFromStandard: [ :amount | amount/1000 ]  named: 'kilogram'.! !


!Unit class methodsFor: 'time creation' stamp: 'PR 6/8/2017 17:53:16'!
hour
	^self conversionToStandard: [ :amount | amount ] conversionFromStandard: [ :amount | amount ]  named: 'hour'.! !

!Unit class methodsFor: 'time creation' stamp: 'PR 6/8/2017 17:53:10'!
minute
	^self conversionToStandard: [ :amount | amount/60 ] conversionFromStandard: [ :amount | amount*60 ]  named: 'minute'.! !

!Unit class methodsFor: 'time creation' stamp: 'PR 6/8/2017 18:39:04'!
second
	^self conversionToStandard: [ :amount | amount/3600 ] conversionFromStandard: [ :amount | amount*3600 ]  named: 'second'.! !


!Unit class methodsFor: 'currency creation' stamp: 'PR 6/8/2017 17:53:34'!
dolar
	^self conversionToStandard: [ :amount | amount] conversionFromStandard: [ :amount | amount]  named: 'dolar'.! !

!Unit class methodsFor: 'currency creation' stamp: 'PR 6/8/2017 17:53:49'!
peso
	^self conversionToStandard: [ :amount | amount] conversionFromStandard: [ :amount | amount]  named: 'peso'.! !

Unit initialize!