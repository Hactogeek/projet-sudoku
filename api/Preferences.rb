class Preferences
	attr_reader :colorFocus , :colorEquals, :colorError, :colorAide, :colorNeutral, :colorTextOriginal, :colorTextPlayer

	def initialize()
		@colorFocus = "#EFC42E"
		@colorEquals = "#FFEC81"
		@colorError = "#FF6060"
		@colorAide = "#FFA749"
		@colorNeutral = "#FFFFFF"
		@colorTextOriginal = "#000000"
		@colorTextPlayer = "#4169E1"
	end

	def setColorStyle(colorFocus, colorEquals, colorError, colorAide, colorNeutral, colorTextOriginal, colorTextPlayer)
		@colorFocus = colorFocus
		@colorEquals = colorEquals
		@colorError = colorError
		@colorAide = colorAide
		@colorNeutral = colorNeutral
		@colorTextOriginal = colorTextOriginal
		@colorTextPlayer = colorTextPlayer
	end
end