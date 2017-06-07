!classDefinition: #Measure category: #'Measure-Solution'!
Magnitude subclass: #Measure
	instanceVariableNames: 'amount unit'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!Measure methodsFor: 'as yet unclassified' stamp: 'PR 6/6/2017 21:05:20'!
* aSmallInteger 
	^self class amount: amount*aSmallInteger unit: self unit.! !

!Measure methodsFor: 'as yet unclassified' stamp: 'PR 6/6/2017 21:05:32'!
+ aMeasure 
	^self class amount: ((amount*unit ratio) + (aMeasure amount*aMeasure unit ratio))/ unit ratio unit: self unit. ! !

!Measure methodsFor: 'as yet unclassified' stamp: 'Mirko 6/6/2017 03:40:20'!
- aDistance 
	^self + (aDistance * (-1)).! !

!Measure methodsFor: 'as yet unclassified' stamp: 'Mirko 6/6/2017 03:41:16'!
/ aSmallInteger 
	^self * (1/aSmallInteger). ! !

!Measure methodsFor: 'as yet unclassified' stamp: 'PR 6/5/2017 21:41:45'!
< aMeasure
	^ (amount * unit ratio) < (aMeasure amount * aMeasure unit ratio).! !

!Measure methodsFor: 'as yet unclassified' stamp: 'PR 6/5/2017 19:31:09'!
= aMeasure
	^(aMeasure isKindOf: self class) and: [(amount*unit ratio) = (aMeasure amount * aMeasure unit ratio)].! !

!Measure methodsFor: 'as yet unclassified' stamp: 'Mirko 6/6/2017 00:42:33'!
adaptToNumber: aSmallInteger andSend: aSymbol 
	^self perform: aSymbol with: aSmallInteger.! !

!Measure methodsFor: 'as yet unclassified' stamp: 'PR 6/5/2017 19:02:40'!
amount
	^amount.! !

!Measure methodsFor: 'as yet unclassified' stamp: 'PR 6/6/2017 21:05:40'!
convertTo: anUnit
	^self class amount: (amount * unit ratio) / anUnit ratio unit: anUnit. ! !

!Measure methodsFor: 'as yet unclassified' stamp: 'PR 6/5/2017 18:59:27'!
initializeWithAmount: aNumber withUnit: anUnit 
	amount := aNumber.
	unit := anUnit.! !

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

!Measure class methodsFor: 'as yet unclassified' stamp: 'PR 6/6/2017 21:04:47'!
amount: aSmallInteger unit: anUnit 
	^self new initializeWithAmount: aSmallInteger withUnit: anUnit ! !


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


!Distance methodsFor: 'converting' stamp: 'Mirko 6/6/2017 01:58:40'!
convertTo: anUnit
	^self class createWithAmount: (amount * unit ratio) / anUnit ratio withUnit: anUnit. ! !


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


!Distance methodsFor: 'as yet unclassified' stamp: 'Mirko 6/3/2017 22:50:58'!
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

!Temperature methodsFor: 'as yet unclassified' stamp: 'PR 6/6/2017 21:42:05'!
+ aTemperature
	| celsius receptorAsCelsius aTemperatureAsCelsius result |
	
	(aTemperature unit = unit) ifTrue: [
		^self class amount: amount + aTemperature amount unit: unit
	].
	
	celsius := Unit celsius.
	
	receptorAsCelsius := self convertTo: celsius.
	aTemperatureAsCelsius := aTemperature convertTo: celsius .
	
	result := receptorAsCelsius amount + aTemperatureAsCelsius amount .
	 ^Temperature amount: result unit: celsius.! !

!Temperature methodsFor: 'as yet unclassified' stamp: 'PR 6/6/2017 21:42:21'!
- aTemperature
	| celsius receptorAsCelsius aTemperatureAsCelsius result |
	
	(aTemperature unit = unit) ifTrue: [
		^self class amount: amount - aTemperature amount unit: unit
	].
	
	celsius := Unit celsius.
	
	receptorAsCelsius := self convertTo: celsius.
	aTemperatureAsCelsius := aTemperature convertTo: celsius .
	
	result := receptorAsCelsius amount - aTemperatureAsCelsius amount .
	 ^Temperature amount: result unit: celsius.! !

!Temperature methodsFor: 'as yet unclassified' stamp: 'PR 6/6/2017 21:28:50'!
= aTemperature
	^(aTemperature isKindOf: self class) and: [ (self convertTo: Unit celsius) amount = (aTemperature convertTo: Unit celsius) amount].! !

!Temperature methodsFor: 'as yet unclassified' stamp: 'PR 6/6/2017 21:49:23'!
convertTo: anUnit

	(unit = anUnit) ifTrue: [^self].
	[ :arg :arg2 | arg +arg2.1] value: 4 value: 5.
	^self class amount: (anUnit ratio value: amount) unit: anUnit. 
	
	"self convertToCelsius."
	
	
	"(unit = Unit kelvin ) ifTrue:[^Temperature createCelsiusWithAmount: amount -273.15]
	ifFalse: [^Temperature createCelsiusWithAmount: (amount -32)*(5/9)]."! !


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

!MeasureTest methodsFor: 'mass' stamp: 'PR 6/6/2017 20:58:35'!
test006AMassCanBeSubstractedWithAnotherMassWithDifferentUnit

	self assert: factory twoKilograms  -  factory oneThousandGrams = factory oneKilogram .
	self assert: (factory twoKilograms  -  factory oneThousandGrams) class = Mass.
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

!MeasureTest methodsFor: 'temperature' stamp: 'PR 6/5/2017 21:23:48'!
test102DifferentTemperatureShouldntBeEqual

	self deny: factory oneCelsius = factory twoCelsius.
	self deny: factory threeKelvin = factory zeroKelvin.
	self deny: factory thirtyTwoFahrenheits = factory tenFahrenheits.! !

!MeasureTest methodsFor: 'temperature' stamp: 'PR 6/6/2017 21:34:58'!
test103ATemperatureCanBeAddedWithAnotherTemperatureWithSameUnit

	self assert: factory oneCelsius  + factory  oneCelsius = factory twoCelsius.
	self assert: factory threeKelvin + factory threeKelvin = factory sixKelvin.! !

!MeasureTest methodsFor: 'temperature' stamp: 'PR 6/6/2017 21:38:45'!
test104ATemperatureCanBeAddedWithAnotherTemperatureWithDifferentUnit

	self assert: factory oneCelsius  + factory  threeKelvin = factory minusTwoHundredSixtyNineDotFifteenKelvin .
	self assert: factory oneCelsius + factory thirtyTwoFahrenheits = factory oneCelsius.
	self assert: factory threeKelvin + factory thirtyTwoFahrenheits = factory threeKelvin .! !

!MeasureTest methodsFor: 'temperature' stamp: 'PR 6/6/2017 21:39:36'!
test105ATemperatureCanBeSubstractedWithAnotherTemperatureWithSameUnit

	self assert: factory twoCelsius - factory  oneCelsius = factory oneCelsius .
	self assert: factory thirtyTwoFahrenheits - factory twentyFahrenheits = factory twelveFahrenheits .	! !

!MeasureTest methodsFor: 'temperature' stamp: 'PR 6/6/2017 21:35:41'!
test106ATemperatureCanBeSubstractedWithAnotherTemperatureWithDifferentUnit

	self assert: factory twoCelsius  -  factory thirtyTwoFahrenheits = factory twoCelsius .
	self assert: factory threeKelvin  -  factory thirtyTwoFahrenheits = factory threeKelvin .
	self assert: factory thirtyCelsius - factory  threeHundredKelvin = factory threepointEightyFiveCelsius.! !


!MeasureTest methodsFor: 'distance' stamp: 'PR 6/5/2017 21:34:55'!
test201DistanceRepresentingSameDistanceShoudBeEqual

	self assert: factory oneMeter = factory oneMeter.
	self assert: factory oneHundredCentimeters = factory oneHundredCentimeters.
	self assert: factory oneKilometer = factory oneKilometer.! !


!classDefinition: #MeasureFactory category: #'Measure-Solution'!
Object subclass: #MeasureFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!MeasureFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/6/2017 21:11:13'!
oneKilometer
	^Distance amount: 1 unit: Unit kilometer.! !

!MeasureFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/6/2017 21:11:23'!
oneMeter
	^Distance amount: 1 unit: Unit meter.! !

!MeasureFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/6/2017 21:11:50'!
oneThousandGrams
	^Mass amount: 1000 unit: Unit gram.! !

!MeasureFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/6/2017 21:12:05'!
sixKelvin
	^Temperature amount: 6 unit: Unit kelvin.! !

!MeasureFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/6/2017 21:12:22'!
tenFahrenheits
	^Temperature amount: 10 unit: Unit fahrenheit .! !

!MeasureFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/6/2017 21:12:38'!
thirtyCelsius
	^Temperature amount: 30 unit: Unit celsius.! !

!MeasureFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/6/2017 21:13:02'!
thirtyTwoFahrenheits
	^Temperature amount: 32 unit: Unit fahrenheit .! !

!MeasureFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/6/2017 21:13:12'!
threeHundredKelvin
	^Temperature amount: 300 unit: Unit kelvin.! !

!MeasureFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/6/2017 21:13:22'!
threeKelvin
	^Temperature amount: 3 unit: Unit kelvin.! !

!MeasureFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/6/2017 21:14:29'!
threepointEightyFiveCelsius
	^Temperature amount: 30- (300-273.15) unit: Unit celsius.! !

!MeasureFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/6/2017 21:15:14'!
twelveFahrenheits
	^Temperature amount: 12 unit: Unit fahrenheit .! !

!MeasureFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/6/2017 21:15:23'!
twentyFahrenheits
	^Temperature amount: 20 unit: Unit fahrenheit .! !

!MeasureFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/6/2017 21:15:34'!
twoCelsius
	^Temperature amount: 2 unit: Unit celsius .! !

!MeasureFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/6/2017 21:15:48'!
twoGrams
	^Mass amount: 2 unit: Unit gram.! !

!MeasureFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/6/2017 21:15:59'!
twoKilograms
	^Mass amount: 2 unit: Unit kilogram .! !

!MeasureFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/6/2017 21:06:13'!
twoKilometers
	^Distance amount: 2 unit: Unit kilometer.! !

!MeasureFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/6/2017 21:06:23'!
twoMeters
	^Distance amount: 2 unit: Unit meter .! !

!MeasureFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/6/2017 21:16:14'!
zeroCelsius
	^Temperature amount: 0 unit: Unit celsius .! !

!MeasureFactory methodsFor: 'as yet unclassified' stamp: 'PR 6/6/2017 21:16:23'!
zeroKelvin
	^Temperature amount: 0 unit: Unit kelvin .! !


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


!MeasureFactory methodsFor: 'temperature' stamp: 'PR 6/6/2017 21:38:14'!
minusTwoHundredSixtyNineDotFifteenKelvin
	^Temperature amount: -269.15 unit: Unit kelvin.! !

!MeasureFactory methodsFor: 'temperature' stamp: 'PR 6/6/2017 21:10:15'!
oneCelsius
	^Temperature amount: 1 unit: Unit celsius.! !


!classDefinition: #Unit category: #'Measure-Solution'!
Object subclass: #Unit
	instanceVariableNames: 'rate name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!Unit methodsFor: 'inspecting' stamp: 'PR 6/1/2017 23:08:46'!
= anObject
	(anObject isKindOf: self class) ifFalse: [^False].
	
	^(self ratio = anObject ratio) and: [self name = anObject name].! !

!Unit methodsFor: 'inspecting' stamp: 'PR 6/1/2017 20:40:53'!
printString
	^name.! !

!Unit methodsFor: 'inspecting' stamp: 'PR 6/1/2017 20:40:48'!
ratio
	^rate.! !


!Unit methodsFor: 'initialization' stamp: 'PR 6/1/2017 20:40:33'!
initializeWithConvertionRate: aConvertionRate withName: aName.
	rate := aConvertionRate.
	name := aName.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Unit class' category: #'Measure-Solution'!
Unit class
	instanceVariableNames: 'ratio'!

!Unit class methodsFor: 'initialization' stamp: 'PR 6/6/2017 20:45:54'!
initialize
		Smalltalk at: #celsius put: self celsius.
		
		! !


!Unit class methodsFor: 'creation' stamp: 'PR 6/1/2017 20:39:52'!
newConvertionRate: aConvertionRate named: aName.

	^self new initializeWithConvertionRate: aConvertionRate withName: aName.! !


!Unit class methodsFor: 'distance creation' stamp: 'PR 6/6/2017 21:16:52'!
centimeter
	^self newConvertionRate:1/100 named: 'centimeter'.! !

!Unit class methodsFor: 'distance creation' stamp: 'PR 6/6/2017 21:17:34'!
decameter
	^self newConvertionRate:10 named: 'decameter'.! !

!Unit class methodsFor: 'distance creation' stamp: 'PR 6/6/2017 21:17:44'!
decimeter
	^self newConvertionRate:1/10 named: 'decimeter'.! !

!Unit class methodsFor: 'distance creation' stamp: 'PR 6/6/2017 21:18:23'!
hectometer
	^self newConvertionRate:100 named: 'hectometer'.! !

!Unit class methodsFor: 'distance creation' stamp: 'PR 6/6/2017 21:18:29'!
kilometer
	^self newConvertionRate:1000 named: 'kilometer'.! !

!Unit class methodsFor: 'distance creation' stamp: 'PR 6/6/2017 21:18:34'!
meter
	^self newConvertionRate:1 named: 'meter'.! !

!Unit class methodsFor: 'distance creation' stamp: 'PR 6/6/2017 21:19:48'!
millimeter
	^self newConvertionRate: 1/1000 named: 'millimeter'.! !


!Unit class methodsFor: 'temperature creation' stamp: 'PR 6/6/2017 20:44:10'!
celsius
	^self new initializeWithConvertionRate: 1 withName: 'celsius'.! !

!Unit class methodsFor: 'temperature creation' stamp: 'PR 6/6/2017 21:17:53'!
fahrenheit
	"TODO: hay que ver el tema del rate"
	
	^self newConvertionRate: 273.15 named: 'fahrenheit' ! !

!Unit class methodsFor: 'temperature creation' stamp: 'PR 6/6/2017 21:19:21'!
kelvin
	^self newConvertionRate: 273.15 named: 'kelvin' ! !


!Unit class methodsFor: 'mass creation' stamp: 'PR 6/6/2017 21:18:00'!
gram
	^self newConvertionRate: 1 named: 'gram'.! !

!Unit class methodsFor: 'mass creation' stamp: 'PR 6/6/2017 21:19:28'!
kilogram
	^self newConvertionRate: 1000 named: 'kilogram'. ! !

Unit initialize!