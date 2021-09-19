local Localization = {}

Localization.English = require(script:GetCustomProperty("Translations_English"))
Localization.French = require(script:GetCustomProperty("Translations_French"))

Localization.language = "English"

function Localization.set_language(lan)
	Localization.language = lan
end

function Localization.set_language_from_index(index)
	if(index == 2) then
		Localization.language = "French"
	else
		Localization.language = "English"
	end
end

function Localization.get_text(id)
	if(Localization[Localization.language][id] ~= nil) then
		return Localization[Localization.language][id]
	else
		print(id)
	end

	return "MISSING TEXT"
end

return Localization