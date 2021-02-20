L = LANG.GetLanguageTableReference("en")

-- GENERAL ROLE LANGUAGE STRINGS
L[MEDIUM.name] = "Medium"
L["info_popup_" .. MEDIUM.name] = [[You are a Medium! Use your spirit box to hear the dead!]]
L["body_found_" .. MEDIUM.abbr] = "They were a Medium!"
L["search_role_" .. MEDIUM.abbr] = "This person was a Medium!"
L["target_" .. MEDIUM.name] = "Medium"
L["ttt2_desc_" .. MEDIUM.name] = [[The Medium is a detective with a special tool, their Spirit Box.
While equipped the Medium can hear the dead speak, albeit with interference]]

-- OTHER ROLE LANGUAGE STRINGS
L["ttt2_mdm_spirit"] = "The spirits speak: '{msg}'"
