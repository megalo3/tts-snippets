
function darknessCardsSelected(selected)
    local options = {
         '-1 dm: 1 card (at 15)',
         '+0 dm: 2 cards (at 10, 20)',
         '+1 dm: 3 cards (at 7, 14, 21)',
         '+2 dm: 4 cards (at 5, 10, 15, 20)',
         '+3 dm: 5 cards (at 4, 8, 12, 16, 20)',
         '+4 dm: 6 cards (at 2, 6, 10, 14, 18, 22)',
         '+5 dm: 7 cards (at 0, 4, 8, 12, 16, 20, 24)',
         '+6 dm: 8 cards (at 0, 3, 6, 9, 12, 15, 18, 21)'
    }
    for index, option in ipairs(options) do
        if option == selected then
            Settings.difficultyOptions[1] = index - 2
        end
    end
    updateTitle()
end

function startingBlightsSelected(selected)
    local options = {
        '-3 dm: Start with no blights',
        '+0 dm: 1 blight per location (except the Monastery)',
        '+3 dm: 2 blights per location (except the Monastery)'
    }

    for index, option in ipairs(options) do
        if option == selected then
            Settings.difficultyOptions[2] = (index - 2) * 3
        end
    end
    updateTitle()
end

function startingDarknessSelected(selected)
    local options = {
        '-1 dm: Darkness -5',
        '+0 dm: Darkness 0',
        '+1 dm: Darkness 5'
    }

    for index, option in ipairs(options) do
        if option == selected then
            Settings.difficultyOptions[3] = index - 2
        end
    end
    updateTitle()
end

function startingPowerCardsSelected(selected)
    local options = {
        '-2 dm: Start every hero with 5 power cards',
        '-1 dm: Start every hero with 4 power cards',
        '+0 dm: Start every hero with 3 power cards'
    }

    for index, option in ipairs(options) do
        if option == selected then
            Settings.difficultyOptions[4] = index - 3
        end
    end
    updateTitle()
end

function startingGraceSelected(selected)
    local options = {
        '-1 dm: Start every hero with 2 extra Grace',
        '+0 dm: Start every hero with 0 extra Grace'
    }

    for index, option in ipairs(options) do
        if option == selected then
            Settings.difficultyOptions[5] = index - 2
        end
    end
    updateTitle()
end

function startingSparksSelected(selected)
    local options = {
        '-1 dm: Start every hero with 3 sparks',
        '+0 dm: Start every hero with 0 sparks'
    }

    for index, option in ipairs(options) do
        if option == selected then
            Settings.difficultyOptions[6] = index - 2
        end
    end
    updateTitle()
end

function numberOfHeroesSelected(selected)
    local options = {
        '+4 dm: Play with 3 heroes',
        '+0 dm: Play with 4 heroes',
        '+0 dm: Play with 5 heroes. (See extra rules)'
    }

    for index, option in ipairs(options) do
        if option == selected then
            if index == 1 then
                Settings.difficultyOptions[7] = 4
            else
                Settings.difficultyOptions[7] = 0
            end

        end
    end
    updateTitle()
end

function increaseQuestsSelected(selected)
    local amount = 0

    if selected == 'True' then amount = 1 end
    Settings.difficultyOptions[8] = amount

    updateTitle()
end

function updateTitle()
    difficulty = 0

    for _, option in ipairs(Settings.difficultyOptions) do
        difficulty = difficulty + option
    end

    if difficulty >= 0  then
        difficulty = "+" .. difficulty
    end

    UI.setAttributes('difficultyOptionsTitle', {
        text = "Difficulty Options (Modifier " .. difficulty .. ")"
    })
end