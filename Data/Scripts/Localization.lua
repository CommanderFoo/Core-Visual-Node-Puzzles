local Localization = {}

Localization.English = require(script:GetCustomProperty("Translations_English"))
Localization.French = require(script:GetCustomProperty("Translations_French"))
Localization.German = require(script:GetCustomProperty("Translations_German"))
Localization.Spanish = require(script:GetCustomProperty("Translations_Spanish"))
Localization.Chinese = require(script:GetCustomProperty("Translations_Chinese"))
Localization.Russian = require(script:GetCustomProperty("Translations_Russian"))

Localization.language = "English"

function Localization.set_language(lan)
	Localization.language = lan
end

function Localization.set_language_from_index(index)
	if(index == 2) then
		Localization.language = "French"
	elseif(index == 3) then
		Localization.language = "German"
	elseif(index == 4) then
		Localization.language = "Spanish"
	elseif(index == 5) then
		Localization.language = "Chinese"
	else
		Localization.language = "English"
	end
end

function Localization.id_exists(id)
	if(Localization[Localization.language][id] ~= nil) then
		return true
	end

	return false
end

function Localization.get_text(id)
	if(Localization[Localization.language][id] ~= nil) then
		return CoreString.Trim(Localization[Localization.language][id])
	elseif(Localization["English"][id] ~= nil) then
		print("Localization Missing: ", id)

		return Localization["English"][id]
	end

	print("Localization Missing: ", id)
	
	return "MISSING TEXT"
end

return Localization