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
L["ttt2_mdm_spirit"] = "The spirits speak: "

--SETTINGS LANGUAGE STRINGS
L["label_ttt2_mdm_add_nicks"] = "Incorporate player usernames into chat noise"
L["label_ttt2_mdm_scramble_chance"] = "Chance to scramble order of letters of words"
L["label_ttt2_mdm_replace_chance"] = "Chance to replace words with random words"
L["label_ttt2_mdm_shuffle_chance"] = "Chance to shuffle the order of words"