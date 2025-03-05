WorkshopID = '2961940791'


function getClueToken()
    return getObjectsWithAllTags({'Search', 'Token'})[1]
end
function getDarknessToken()
    return getObjectsWithAllTags({'Darkness', 'Token'})[1]
end
function getTimeBag()
    return getObjectsWithAllTags({'Bag', 'Time'})[1]
end
function getProgressBag()
    return getObjectsWithAllTags({'Bag', 'Progress'})[1]
end
function getItemBag()
    return getObjectsWithAllTags({'Item', 'Bag'})[1]
end
function getBlightBoard()
    return getObjectFromGUID('2f4bb6')
end

Settings = {
    difficultyOptions = {0,0,0,0,0,0,0,0},
    heroTurnPanelClosedBy = {"Nobody"},
    actionsPanelClosedBy = {"Nobody"},
    difficultyPanelClosedBy = {"Nobody"},
    mapSelected = false,
    mapType = 'Everything',
    pawns = {},
    started = false
}


Events = {}
Events['A Time for Heroes'] = { FateValue = 1 }
Events['Altar']             = { FateValue = 3 }
Events['Anathema']          = { FateValue = 6 }
Events['Aurora']            = { FateValue = 4 }
Events['Barghest']          = { FateValue = 3 }
Events['Betrayal']          = { FateValue = 5 }
Events['Black Banner']      = { FateValue = 4 }
Events['Blink']             = { FateValue = 6 }
Events['Call to Action']    = { FateValue = 3 }
Events['Close Call']        = { FateValue = 4 }
Events['Cultist']           = { FateValue = 1 }
Events['Dark Champion']     = { FateValue = 3 }
Events['Dark Discharge']    = { FateValue = 3 }
Events['Dark Tempest']      = { FateValue = 6 }
Events['Dark Scrying']      = { FateValue = 6 }
Events['Dead Servant']      = { FateValue = 3 }
Events['Deterioration']     = { FateValue = 4 }
Events['Demon']             = { FateValue = 3 }
Events['Demon Eater']       = { FateValue = 5 }
Events['Desperate Bargain'] = { FateValue = 1 }
Events['Dilemma']           = { FateValue = 5 }
Events['Dust Storm']        = { FateValue = 4 }
Events['Electrical Storm']  = { FateValue = 4 }
Events['Evil Day']          = { FateValue = 5 }
Events['Fissure']           = { FateValue = 2 }
Events['Forbidden Treasure'] = { FateValue = 1 }
Events['Grim Tidings']      = { FateValue = 2 }
Events['Guarded Trove']     = { FateValue = 1 }
Events['Haunt']             = { FateValue = 3 }
Events['Horde']             = { FateValue = 3 }
Events['Host of Haunts']    = { FateValue = 5 }
Events['Jinx']              = { FateValue = 6 }
Events['Latent Spell']      = { FateValue = 2 }
Events['Lich']              = { FateValue = 4 }
Events['Looters']           = { FateValue = 2 }
Events['Metamorphosis']     = { FateValue = 3 }
Events['Midnight']          = { FateValue = 7 }
Events['Mind Blast']        = { FateValue = 6 }
Events['Mind Leech']        = { FateValue = 3 }
Events['Panic']             = { FateValue = 4 }
Events['Patrols']           = { FateValue = 4 }
Events['Raid']              = { FateValue = 6 }
Events['Renewal']           = { FateValue = -1 }
Events['Rescue']            = { FateValue = 3 }
Events['Respite']           = { FateValue = 1 }
Events['Ritual']            = { FateValue = 6 }
Events['Runed Golem']       = { FateValue = 4 }
Events['Setback']           = { FateValue = 5 }
Events['Shadow Sight']      = { FateValue = 1 }
Events['Shambling Horror']  = { FateValue = 4 }
Events['Sleeping Pollen']   = { FateValue = 3 }
Events['Sloppy Search']     = { FateValue = 2 }
Events['Startling News']    = { FateValue = 3 }
Events['Temptation']        = { FateValue = 6 }
Events['Test of Faith']     = { FateValue = 3 }
Events['Tracker']           = { FateValue = 5 }
Events['Twilight']          = { FateValue = 5 }
Events['Twist of Fate']     = { FateValue = 1 }
Events['Unfriendly Eyes']   = { FateValue = 5 }
Events['Vengeful Spirit']   = { FateValue = 4 }
Events['Vile Beast']        = { FateValue = 2 }
Events['Vile Messenger']    = { FateValue = 4 }
Events['Upheaval']          = { FateValue = 2 }
Events['Urgent Plea']       = { FateValue = 5 }
Events['Unsubtle Messenger'] = { FateValue = 6 }
Events['Watchers']          = { FateValue = 4 }

Maps = {
    {
        GUID = 'ccdb75',
        Quest = '',
        Mountains = {'Unholy Aura', 'Mystery'},
        Castle = {'Evil Presence', 'Forgotten Shrine'},
        Village = {'Unholy Aura', 'Bottled Magic'},
        Swamp = {'Zombies', 'Epiphany'},
        Forest = {'Evil Presence', 'Mystery'},
        Ruins = {'Evil Presence', 'Mystery'},
        Monastery = {'Unholy Aura'}
    },
    {
        GUID = '1573e8',
        Quest = '',
        Mountains = {'Terror', 'Mystery'},
        Castle = {'Specters', 'Tome of Retraining'},
        Village = {'Stigma', 'Treasure Chest'},
        Swamp = {'Revenants', 'Bottled Magic'},
        Forest = {'Revenants', 'Mystery'},
        Ruins = {'Crows', 'Mystery'},
        Monastery = {'Terror'}
    },
    {
        GUID = 'ac44f0',
        Quest = 'Forest',
        Mountains = {'Taint', 'Mystery'},
        Castle = {'Spies', 'Treasure Chest'},
        Village = {'Curse', 'Waystone'},
        Swamp = {'Vampire', 'Epiphany'},
        Forest = {'Corruption', 'Supply Cache'},
        Ruins = {'Spies', 'Mystery'},
        Monastery = {'Desecration'}
    },
    {
        GUID = '4755d7',
        Quest = 'Swamp',
        Mountains = {'Omen', 'Forgotten Shrine'},
        Castle = {'Nexus', 'Supply Cache'},
        Village = {'Zombies', 'Treasure Chest'},
        Swamp = {'Skeletons', 'Epiphany'},
        Forest = {'Enigma', 'Artifact'},
        Ruins = {'Skeletons', 'Artifact'},
        Monastery = {'Taint'}
    },
    {
        GUID = '701b68',
        Quest = '',
        Mountains = {'Crows', 'Forgotten Shrine'},
        Castle = {'Specters', 'Supply Cache'},
        Village = {'Terror', 'Treasure Chest'},
        Swamp = {'Specters', 'Epiphany'},
        Forest = {'Revenants', 'Cursed Ashes'},
        Ruins = {'Wraiths', 'Revelation'},
        Monastery = {'Stigma'}
    },
    {
        GUID = '9f30bf',
        Quest = '',
        Mountains = {'Shroud', 'Mystery'},
        Castle = {'Curse', 'Supply Cache'},
        Village = {'Vampire', 'Mystery'},
        Swamp = {'Shroud', 'Epiphany'},
        Forest = {'Desecration', 'Artifact'},
        Ruins = {'Vampire', 'Waystone'},
        Monastery = {'Spies'}
    },
    {
        GUID = '457b84',
        Quest = '',
        Mountains = {'Stigma', 'Mystery'},
        Castle = {'Specters', 'Soothing Lyre'},
        Village = {'Crows', 'Mystery'},
        Swamp = {'Wraiths', 'Epiphany'},
        Forest = {'Terror', 'Mystery'},
        Ruins = {'Revenants', 'Mystery'},
        Monastery = {'Terror'}
    },
    {
        GUID = 'faa261',
        Quest = 'Mountains',
        Mountains = {'Oblivion', 'Mystery'},
        Castle = {'Evil Presence', 'Tome of Retraining'},
        Village = {'Wraiths', 'Artifact'},
        Swamp = {'Decay', 'Inspiration'},
        Forest = {'Gate', 'Revelation'},
        Ruins = {'Flux Cage', 'Revelation'},
        Monastery = {'Spies'}
    },
    {
        GUID = 'a378f1',
        Quest = '',
        Mountains = {'Shades', 'Treasure Chest'},
        Castle = {'Zombies', 'Supply Cache'},
        Village = {'Taint', 'Treasure Chest'},
        Swamp = {'Skeletons', 'Bottled Magic'},
        Forest = {'Shroud', 'Treasure Chest'},
        Ruins = {'Taint', 'Mystery'},
        Monastery = {'Shroud'}
    },
    {
        GUID = '77e4c2',
        Quest = 'Swamp',
        Mountains = {'Shroud', 'Artifact'},
        Castle = {'Vampire', 'Supply Cache'},
        Village = {'Curse', 'Supply Cache'},
        Swamp = {'Curse', 'Epiphany'},
        Forest = {'Shroud', 'Vanishing Dust'},
        Ruins = {'Shroud', 'Mystery'},
        Monastery = {'Curse'}
    },
    {
        GUID = '15e9a2',
        Quest = '',
        Mountains = {'Decay', 'Tome of Retraining'},
        Castle = {'Decay', 'Skull Token'},
        Village = {'Curse', 'Treasure Chest'},
        Swamp = {'Shades', 'Inspiration'},
        Forest = {'Zombies', 'Treasure Chest'},
        Ruins = {'Oblivion', 'Tome of Retraining'},
        Monastery = {'Decay'}
    },
    {
        GUID = '3a507a',
        Quest = '',
        Mountains = {'Taint', 'Supply Cache'},
        Castle = {'Shroud', 'Supply Cache'},
        Village = {'Zombies', 'Treasure Chest'},
        Swamp = {'Shades', 'Bottled Magic'},
        Forest = {'Zombies', 'Mystery'},
        Ruins = {'Skeletons', 'Mystery'},
        Monastery = {'Taint'}
    },
    {
        GUID = '5a790c',
        Quest = '',
        Mountains = {'Shades', 'Mystery'},
        Castle = {'Lich', 'Vanishing Dust'},
        Village = {'Curse', 'Vanishing Dust'},
        Swamp = {'Taint', 'Waystone'},
        Forest = {'Lich', 'Vanishing Dust'},
        Ruins = {'Skeletons', 'Mystery'},
        Monastery = {'Curse'}
    },
    {
        GUID = 'bea484',
        Quest = 'Castle',
        Mountains = {'Zombies', 'Mystery'},
        Castle = {'Skeletons', 'Supply Cache'},
        Village = {'Skeletons', 'Mystery'},
        Swamp = {'Shades', 'Bottled Magic'},
        Forest = {'Shades', 'Supply Cache'},
        Ruins = {'Zombies', 'Treasure Chest'},
        Monastery = {'Taint'}
    },
    {
        GUID = '353ca1',
        Quest = '',
        Mountains = {'Oblivion', 'Forgotten Shrine'},
        Castle = {'Shades', 'Cursed Ashes'},
        Village = {'Stigma', 'Mystery'},
        Swamp = {'Zombies', 'Psion Stone'},
        Forest = {'Stigma', 'Mystery'},
        Ruins = {'Skeletons', 'Revelation'},
        Monastery = {'Decay'}
    },
    {
        GUID = '250362',
        Quest = '',
        Mountains = {'Specters', 'Forgotten Shrine'},
        Castle = {'Crows', 'Supply Cache'},
        Village = {'Wraiths', 'Skull Token'},
        Swamp = {'Revenants', 'Tome of Retraining'},
        Forest = {'Stigma', 'Treasure Chest'},
        Ruins = {'Terror', 'Stardust'},
        Monastery = {'Terror'}
    },
    {
        GUID = 'c97c0f',
        Quest = '',
        Mountains = {'Vampire', 'Mystery'},
        Castle = {'Curse', 'Treasure Chest'},
        Village = {'Zombies', 'Mystery'},
        Swamp = {'Skeletons', 'Artifact'},
        Forest = {'Vampire', 'Treasure Chest'},
        Ruins = {'Shroud', 'Mystery'},
        Monastery = {'Curse'}
    },
    {
        GUID = 'd5592a',
        Quest = '',
        Mountains = {'Lich', 'Treasure Chest'},
        Castle = {'Desecration', 'Mystery'},
        Village = {'Confusion', 'Treasure Chest'},
        Swamp = {'Lich', 'Mystery'},
        Forest = {'Dark Fog', 'Mystery'},
        Ruins = {'Unholy Aura', 'Mystery'},
        Monastery = {'Spies'}
    },
    {
        GUID = '04b12d',
        Quest = 'Village',
        Mountains = {'Specters', 'Artifact'},
        Castle = {'Terror', 'Supply Cache'},
        Village = {'Revenants', 'Treasure Chest'},
        Swamp = {'Specters', 'Epiphany'},
        Forest = {'Terror', 'Artifact'},
        Ruins = {'Wraiths', 'Charm'},
        Monastery = {'Stigma'}
    },
    {
        GUID = 'fdb0d1',
        Quest = '',
        Mountains = {'Terror', 'Mystery'},
        Castle = {'Wraiths', 'Psion Stone'},
        Village = {'Revenants', 'Soothing Lyre'},
        Swamp = {'Revenants', 'Inspiration'},
        Forest = {'Crows', 'Mystery'},
        Ruins = {'Specters', 'Mystery'},
        Monastery = {'Stigma'}
    },
    {
        GUID = 'c22b76',
        Quest = '',
        Mountains = {'Evil Presence', 'Forgotten Shrine'},
        Castle = {'Unholy Aura', 'Treasure Chest'},
        Village = {'Evil Presence', 'Forgotten Shrine'},
        Swamp = {'Zombies', 'Bottled Magic'},
        Forest = {'Unholy Aura', 'Treasure Chest'},
        Ruins = {'Evil Presence', 'Forgotten Shrine'},
        Monastery = {'Taint'}
    },
    {
        GUID = '2e5db3',
        Quest = '',
        Mountains = {'Skeletons', 'Treasure Chest'},
        Castle = {'Shades', 'Treasure Chest'},
        Village = {'Shades', 'Supply Cache'},
        Swamp = {'Shroud', 'Artifact'},
        Forest = {'Skeletons', 'Supply Cache'},
        Ruins = {'Shades', 'Supply Cache'},
        Monastery = {'Taint'}
    },
    {
        GUID = '9a3302',
        Quest = '',
        Mountains = {'Flux Cage', 'Psion Stone'},
        Castle = {'Wraiths', 'Treasure Chest'},
        Village = {'Omen', 'Mystery'},
        Swamp = {'Wraiths', 'Bottled Magic'},
        Forest = {'Terror', 'Mystery'},
        Ruins = {'Revenants', 'Mystery'},
        Monastery = {'Flux Cage'}
    },
    {
        GUID = '7c1486',
        Quest = 'Village',
        Mountains = {'Enigma', 'Forgotten Shrine'},
        Castle = {'Decay', 'Psion Stone'},
        Village = {'Zombies', 'Tome of Retraining'},
        Swamp = {'Shades', 'Epiphany'},
        Forest = {'Vampire', 'Cursed Ashes'},
        Ruins = {'Nexus', 'Stardust'},
        Monastery = {'Taint'}
    },
    {
        GUID = 'd03cc4',
        Quest = 'Mountains',
        Mountains = {'Shades', 'Treasure Chest'},
        Castle = {'Skeletons', 'Treasure Chest'},
        Village = {'Zombies', 'Artifact'},
        Swamp = {'Shades', 'Bottled Magic'},
        Forest = {'Zombies', 'Mystery'},
        Ruins = {'Skeletons', 'Mystery'},
        Monastery = {'Taint'}
    },
    {
        GUID = 'd54c4b',
        Quest = 'Ruins',
        Mountains = {'Wraiths', 'Stardust'},
        Castle = {'Curse', 'Treasure Chest'},
        Village = {'Vampire', 'Treasure Chest'},
        Swamp = {'Lich', 'Epiphany'},
        Forest = {'Decay', 'Charm'},
        Ruins = {'Lich', 'Stardust'},
        Monastery = {'Decay'}
    },
    {
        GUID = '8536eb',
        Quest = 'Forest',
        Mountains = {'Vampire', 'Stardust'},
        Castle = {'Lich', 'Revelation'},
        Village = {'Oblivion', 'Treasure Chest'},
        Swamp = {'Curse', 'Epiphany'},
        Forest = {'Wraiths', 'Mystery'},
        Ruins = {'Decay', 'Revelation'},
        Monastery = {'Oblivion'}
    },
    {
        GUID = '87779a',
        Quest = 'Castle',
        Mountains = {'Wraiths', 'Treasure Chest'},
        Castle = {'Flux Cage', 'Cursed Ashes'},
        Village = {'Flux Cage', 'Supply Cache'},
        Swamp = {'Gate', 'Psion Stone'},
        Forest = {'Wraiths', 'Mystery'},
        Ruins = {'Specters', 'Revelation'},
        Monastery = {'Flux Cage'}
    },
    {
        GUID = '4c5437',
        Quest = '',
        Mountains = {'Curse', 'Supply Cache'},
        Castle = {'Unholy Aura', 'Waystone'},
        Village = {'Lich', 'Treasure Chest'},
        Swamp = {'Confusion', 'Epiphany'},
        Forest = {'Dark Fog', 'Treasure Chest'},
        Ruins = {'Lich', 'Supply Cache'},
        Monastery = {'Desecration'}
    },
    {
        GUID = '30708b',
        Quest = 'Ruins',
        Mountains = {'Shades', 'Artifact'},
        Castle = {'Skeletons', 'Supply Cache'},
        Village = {'Enigma', 'Treasure Chest'},
        Swamp = {'Nexus', 'Epiphany'},
        Forest = {'Omen', 'Treasure Chest'},
        Ruins = {'Shroud', 'Mystery'},
        Monastery = {'Enigma'}
    },
    {
        GUID = '04f478',
        Quest = '',
        Mountains = {'Desecration', 'Treasure Chest'},
        Castle = {'Spies', 'Supply Cache'},
        Village = {'Dark Fog', 'Treasure Chest'},
        Swamp = {'Corruption', 'Epiphany'},
        Forest = {'Confusion', 'Mystery'},
        Ruins = {'Spies', 'Mystery'},
        Monastery = {'Desecration'}
    },
    {
        GUID = 'cb44b9',
        Quest = '',
        Mountains = {'Desecration', 'Waystone'},
        Castle = {'Dark Fog', 'Supply Cache'},
        Village = {'Spies', 'Treasure Chest'},
        Swamp = {'Corruption', 'Artifact'},
        Forest = {'Desecration', 'Treasure Chest'},
        Ruins = {'Corruption', 'Treasure Chest'},
        Monastery = {'Confusion'}
    },
    {
        GUID = '3fb4cc',
        Quest = '',
        Mountains = {'Void', 'Artifact'},
        Castle = {'Void', 'Supply Cache'},
        Village = {'Confusion', 'Charm'},
        Swamp = {'Corruption', 'Inspiration'},
        Forest = {'Dark Fog', 'Tome of Retraining'},
        Ruins = {'Gate', 'Psion Stone'},
        Monastery = {'Stigma'}
    },
    {
        GUID = 'ac0b3b',
        Quest = 'Forest',
        Mountains = {'Omen', 'Artifact'},
        Castle = {'Crows', 'Mystery'},
        Village = {'Webs', 'Mystery'},
        Swamp = {'Webs', 'Epiphany'},
        Forest = {'Omen', 'Treasure Chest'},
        Ruins = {'Webs', 'Mystery'},
        Monastery = {'Webs'}
    },
    {
        GUID = '9b4232',
        Quest = '',
        Mountains = {'Stigma', 'Stardust'},
        Castle = {'Dark Fog', 'Artifact'},
        Village = {'Gate', 'Psion Stone'},
        Swamp = {'Confusion', 'Bottled Magic'},
        Forest = {'Void', 'Supply Cache'},
        Ruins = {'Void', 'Skull Token'},
        Monastery = {'Desecration'}
    },
    {
        GUID = '236a37',
        Quest = '',
        Mountains = {'Corruption', 'Forgotten Shrine'},
        Castle = {'Spies', 'Mystery'},
        Village = {'Spies', 'Treasure Chest'},
        Swamp = {'Confusion', 'Epiphany'},
        Forest = {'Spies', 'Mystery'},
        Ruins = {'Desecration', 'Artifact'},
        Monastery = {'Spies'}
    },
    {
        GUID = '4efa5a',
        Quest = '',
        Mountains = {'Void', 'Mystery'},
        Castle = {'Gate', 'Soothing Lyre'},
        Village = {'Stigma', 'Revelation'},
        Swamp = {'Corruption', 'Inspiration'},
        Forest = {'Void', 'Artifact'},
        Ruins = {'Omen', 'Revelation'},
        Monastery = {'Desecration'}
    },
    {
        GUID = '18c8e0',
        Quest = '',
        Mountains = {'Corruption', 'Mystery'},
        Castle = {'Confusion', 'Treasure Chest'},
        Village = {'Spies', 'Treasure Chest'},
        Swamp = {'Desecration', 'Epiphany'},
        Forest = {'Dark Fog', 'Mystery'},
        Ruins = {'Spies', 'Mystery'},
        Monastery = {'Spies'}
    },
    {
        GUID = '8b4808',
        Quest = 'Swamp',
        Mountains = {'Corruption', 'Forgotten Shrine'},
        Castle = {'Flux Cage', 'Treasure Chest'},
        Village = {'Flux Cage', 'Cursed Ashes'},
        Swamp = {'Void', 'Bottled Magic'},
        Forest = {'Webs', 'Charm'},
        Ruins = {'Flux Cage', 'Skull Token'},
        Monastery = {'Spies'}
    },
    {
        GUID = '1b1984',
        Quest = '',
        Mountains = {'Crows', 'Mystery'},
        Castle = {'Webs', 'Supply Cache'},
        Village = {'Omen', 'Treasure Chest'},
        Swamp = {'Webs', 'Artifact'},
        Forest = {'Webs', 'Treasure Chest'},
        Ruins = {'Crows', 'Mystery'},
        Monastery = {'Webs'}
    },
    {
        GUID = '6ca99b',
        Quest = 'Ruins',
        Mountains = {'Confusion', 'Supply Cache'},
        Castle = {'Dark Fog', 'Treasure Chest'},
        Village = {'Corruption', 'Supply Cache'},
        Swamp = {'Desecration', 'Vanishing Dust'},
        Forest = {'Confusion', 'Waystone'},
        Ruins = {'Dark Fog', 'Mystery'},
        Monastery = {'Corruption'}
    },
    {
        GUID = '6fcd83',
        Quest = 'Mountains',
        Mountains = {'Void', 'Tome of Retraining'},
        Castle = {'Webs', 'Skull Token'},
        Village = {'Flux Cage', 'Artifact'},
        Swamp = {'Confusion', 'Bottled Magic'},
        Forest = {'Omen', 'Cursed Ashes'},
        Ruins = {'Flux Cage', 'Revelation'},
        Monastery = {'Spies'}
    },
    {
        GUID = '8f1a85',
        Quest = '',
        Mountains = {'Taint', 'Artifact'},
        Castle = {'Unholy Aura', 'Treasure Chest'},
        Village = {'Webs', 'Treasure Chest'},
        Swamp = {'Omen', 'Epiphany'},
        Forest = {'Shroud', 'Mystery'},
        Ruins = {'Nexus', 'Mystery'},
        Monastery = {'Nexus'}
    },
    {
        GUID = 'e888f8',
        Quest = '',
        Mountains = {'Shroud', 'Mystery'},
        Castle = {'Enigma', 'Treasure Chest'},
        Village = {'Crows', 'Treasure Chest'},
        Swamp = {'Nexus', 'Epiphany'},
        Forest = {'Webs', 'Mystery'},
        Ruins = {'Unholy Aura', 'Mystery'},
        Monastery = {'Enigma'}
    },
    {
        GUID = 'e304c5',
        Quest = '',
        Mountains = {'Omen', 'Forgotten Shrine'},
        Castle = {'Omen', 'Supply Cache'},
        Village = {'Omen', 'Treasure Chest'},
        Swamp = {'Taint', 'Artifact'},
        Forest = {'Enigma', 'Mystery'},
        Ruins = {'Enigma', 'Mystery'},
        Monastery = {'Nexus'}
    },
    {
        GUID = 'b24b41',
        Quest = 'Castle',
        Mountains = {'Gate', 'Revelation'},
        Castle = {'Nexus', 'Tome of Retraining'},
        Village = {'Corruption', 'Supply Cache'},
        Swamp = {'Enigma', 'Tome of Retraining'},
        Forest = {'Confusion', 'Charm'},
        Ruins = {'Oblivion', 'Revelation'},
        Monastery = {'Void'}
    },
    {
        GUID = 'f70d10',
        Quest = '',
        Mountains = {'Oblivion', 'Forgotten Shrine'},
        Castle = {'Flux Cage', 'Artifact'},
        Village = {'Gate', 'Mystery'},
        Swamp = {'Nexus', 'Inspiration'},
        Forest = {'Flux Cage', 'Supply Cache'},
        Ruins = {'Evil Presence', 'Revelation'},
        Monastery = {'Spies'}
    },
    {
        GUID = 'b53aff',
        Quest = 'Village',
        Mountains = {'Unholy Aura', 'Mystery'},
        Castle = {'Evil Presence', 'Bottled Magic'},
        Village = {'Evil Presence', 'Mystery'},
        Swamp = {'Unholy Aura', 'Treasure Chest'},
        Forest = {'Evil Presence', 'Mystery'},
        Ruins = {'Unholy Aura', 'Mystery'},
        Monastery = {'Unholy Aura'}
    },
    {
        GUID = 'f367e6',
        Quest = '',
        Mountains = {'Oblivion', 'Psion Stone'},
        Castle = {'Oblivion', 'Soothing Lyre'},
        Village = {'Oblivion', 'Stardust'},
        Swamp = {'Decay', 'Inspiration'},
        Forest = {'Stigma', 'Revelation'},
        Ruins = {'Decay', 'Revelation'},
        Monastery = {'Oblivion'}
    },
    {
        GUID = 'c19a9b',
        Quest = '',
        Mountains = {'Taint', 'Artifact'},
        Castle = {'Crows', 'Treasure Chest'},
        Village = {'Crows', 'Supply Cache'},
        Swamp = {'Taint', 'Epiphany'},
        Forest = {'Crows', 'Treasure Chest'},
        Ruins = {'Shroud', 'Artifact'},
        Monastery = {'Taint'}
    }
}
Blights = {
    Confusion = {
        Strength = -1,
        Awareness = -1,
        Might = 4,
        Effect = 'No tactics',
        Defense = 'Lose a turn',
        Type = 'Blue'
    },
    Corruption = {
        Strength = 0,
        Awareness = 0,
        Might = 0,
        Effect = 'No Bonuses',
        Defense = 'Exhaust all powers',
        Type = 'Blue'
    },
    Crows = {
        Strength = -1,
        Awareness = 4,
        Might = 5,
        Effect = 'Fail: Lose 2 secrecy',
        Defense = 'Lose 1 secrecy',
        Type = 'Yellow'
    },
    Curse = {
        Strength = -1,
        Awareness = -1,
        Might = 5,
        Effect = 'Lose 1 grace entering',
        Defense = 'Lose 1 grace',
        Type = 'Blue'
    },
    Decay = {
        Strength = -1,
        Awareness = -1,
        Might = 5,
        Effect = 'Items have no effect',
        Defense = 'No effect',
        Type = 'Red'
    },
    Desecration = {
        Strength = -1,
        Awareness = -1,
        Might = 4,
        Effect = '+1 darkness each round',
        Defense = 'No effect',
        Type = 'Red'
    },
    Enigma = {
        Strength = -1,
        Awareness = -1,
        Might = 4,
        Effect = '+1 search difficulty',
        Defense = 'No effect',
        Type = 'Red'
    },
    Gate = {
        Strength = -1,
        Awareness = -1,
        Might = 5,
        Effect = 'Necromancer teleports',
        Defense = '+1 darkness',
        Type = 'Red'
    },
    Lich = {
        Strength = 5,
        Awareness = 5,
        Might = 5,
        Effect = 'Fail: Take 1 wound',
        Defense = 'Take 1 wound',
        Type = 'Yellow'
    },
    Nexus = {
        Strength = -1,
        Awareness = -1,
        Might = 3,
        Effect = 'Protects far blights',
        Defense = 'No effect',
        Type = 'Red'
    },
    Oblivion = {
        Strength = -1,
        Awareness = -1,
        Might = 4,
        Effect = 'Exhaust one power each turn',
        Defense = 'Lose a turn',
        Type = 'Blue'
    },
    Omen = {
        Strength = -1,
        Awareness = -1,
        Might = 6,
        Effect = 'Higher-fate events',
        Defense = 'Event',
        Type = 'Blue'
    },
    Revenants = {
        Strength = 5,
        Awareness = 4,
        Might = 5,
        Effect = 'Fail: Take 1 wound',
        Defense = 'Take 1 wound',
        Type = 'Yellow'
    },
    Shades = {
        Strength = 3,
        Awareness = 5,
        Might = 5,
        Effect = 'Fail: Take 1 wound',
        Defense = 'Take 1 wound',
        Type = 'Yellow'
    },
    Shroud = {
        Strength = -1,
        Awareness = -1,
        Might = 5,
        Effect = 'Protects blights',
        Defense = 'Take 1 wound',
        Type = 'Blue'
    },
    Skeletons = {
        Strength = 4,
        Awareness = 4,
        Might = 5,
        Effect = 'Fail: Take 1 wound',
        Defense = 'Take 1 wound',
        Type = 'Yellow'
    },
    Specters = {
        Strength = 4,
        Awareness = 5,
        Might = 4,
        Effect = 'Fail: Take 1 wound',
        Defense = 'Take 1 wound',
        Type = 'Yellow'
    },
    Spies = {
        Strength = -1,
        Awareness = -1,
        Might = 5,
        Effect = 'Lose 1 secrecy each turn',
        Defense = 'Lose 1 secrecy',
        Type = 'Blue'
    },
    Stigma = {
        Strength = -1,
        Awareness = -1,
        Might = 5,
        Effect = '-2 default grace',
        Defense = 'Lose 1 grace',
        Type = 'Red'
    },
    Taint = {
        Strength = -1,
        Awareness = -1,
        Might = 5,
        Effect = 'Cannot gain grace',
        Defense = 'Lose 1 grace',
        Type = 'Blue'
    },
    Terror = {
        Strength = -1,
        Awareness = -1,
        Might = 4,
        Effect = '+1 die; discard highest',
        Defense = 'Exhaust a power',
        Type = 'Blue'
    },
    Vampire = {
        Strength = 4,
        Awareness = 4,
        Might = 6,
        Effect = 'Fail: Take 1 wound',
        Defense = 'Take 1 wound',
        Type = 'Yellow'
    },
    Void = {
        Strength = -1,
        Awareness = -1,
        Might = 7,
        Effect = 'Counts as 2 blights',
        Defense = 'No effect',
        Type = 'Blue'
    },
    Webs = {
        Strength = -1,
        Awareness = -1,
        Might = 5,
        Effect = 'Lose a turn leaving',
        Defense = 'Lose 1 secrecy',
        Type = 'Blue'
    },
    Wraiths = {
        Strength = 4,
        Awareness = 4,
        Might = 4,
        Effect = 'Fail: Take 2 wounds',
        Defense = 'Take 1 wound',
        Type = 'Yellow'
    },
    Zombies = {
        Strength = 5,
        Awareness = 3,
        Might = 5,
        Effect = 'Fail: Take 1 wound',
        Defense = 'Take 1 wound',
        Type = 'Yellow'
    }
}
Blights["Dark Fog"] = {
    Strength = -1,
    Awareness = -1,
    Might = 5,
    Effect = '+2 search difficulty',
    Defense = 'Lose a turn',
    Type = 'Blue'
}
Blights["Evil Presence"] = {
    Strength = -1,
    Awareness = -1,
    Might = 4,
    Effect = '-1 die eluding',
    Defense = 'Event',
    Type = 'Blue'
}
Blights["Flux Cage"] = {
    Strength = -1,
    Awareness = -1,
    Might = 6,
    Effect = 'Lose 1 secrecy entering and leaving',
    Defense = 'Lose 1 secrecy',
    Type = 'Blue'
}
Blights['Unholy Aura'] = {
    Strength = -1,
    Awareness = -1,
    Might = 4,
    Effect = '-1 die fighting',
    Defense = 'Lose 1 grace',
    Type = 'Blue'
}