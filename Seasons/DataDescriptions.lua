SpecialAbilityTokens = {
    {
        Number = 1,
        Description = 'Draw a Power card. Either add this card to your hand or discard it. If you use this effect, lose 5 Prestige points at the end of the game.'
    },
    {
        Number = 2,
        Description = 'Sacrifice or discard one of your Power cards. If you use this effect, gain 6 Prestige points at the end of the game.'
    },
    {
        Number = 3,
        Description = 'Collect 2 energy tokens of your choice from the stockpile. Place them in your reserve. If you use this effect, lose 5 Prestige points at the end of the game.'
    },
    {
        Number = 4,
        Description = 'Move your sorcerer token back one space on the summoning gauge. If you use this effect, gain 10 Prestige points at the end of the game. Important: After using this token, your summoning gauge cannot be lower than the number of your Power cards in play.'
    },
    {
        Number = 5,
        Description = 'Gain 3 Prestige points (instead of losing 5 Prestige points) for each Power card still in your hand at the end of the game. Do not turn over this token after use. Its effect is permanent.'
    },
    {
        Number = 6,
        Description = 'You are allowed to transmute during your turn, and receive 1 additional crystal per energy transmuted. Using this effect does not cause you to lose or gain any Prestige points at the end of the game.'
    },
    {
        Number = 7,
        Description = 'Move your sorcerer token forward 12 spaces on the crystal track. If you use this effect, lose 6 Prestige points at the end of the game.'
    },
    {
        Number = 8,
        Description = 'Discard 4 water energy tokens from your reserve. If you use this effect, gain 18 Prestige points at the end of the game. Note: You can also use energy tokens placed on the Amulet of Water to activate the effect of this Special Ability token.'
    },
    {
        Number = 9,
        Description = 'Move your sorcerer token forward 2 spaces on your summoning gauge. If you use this effect, lose 5 Prestige points at the end of the game.'
    },
    {
        Number = 10,
        Description = 'Move the season marker 2 spaces backwards or forwards on the season wheel. If you use this effect, gain 3 Prestige points at the end of the game.'
    },
    {
        Number = 11,
        Description = "Look at the Power cards in the other players' hands. If you use this effect, gain 9 Prestige points at the end of the game."
    },
    {
        Number = 12,
        Description = 'Look at the top three cards of the Power card draw pile then return them in the order of your choice. Using this effect does not cause you to lose or gain any Prestige points at the end of the game.'
    },
    {
        Number = 13,
        Description = 'Look at the top Power card of the discard pile. Add this card to your hand. If you use this effect, lose 5 Prestige points at the end of the game.'
    },
    {
        Number = 14,
        Description = 'Move your Sorcerer token back one space on your bonus track. If you use this effect, gain 3 Prestige points at the end of the game.'
    },
    {
        Number = 15,
        Description = 'Discard 5 Fire energy tokens from your reserve and draw a Power card. If you use this effect, gain 10 Prestige points at the end of the game.'
    },
    {
        Number = 16,
        Description = 'Roll the die of Destiny and apply its effect in addition to performing the action(s) shown by your Season die. If you use this effect, gain 5 Prestige points at the end of the game. Note: This Special Ability token can only be used if you are playing with the Divine Destiny or Force of Destiny Enchantment cards.'
    },
    {
        Number = 17,
        Description = 'Reroll your Season die before performing the action(s) shown on it. You must perform the action(s) shown on the Season die after it has been rerolled. If you use this effect, gain 9 Prestige points at the end of the game.'
    },
    {
        Number = 18,
        Description = "Select a Power card that is currently under one of your Library tokens (for year 2 or year 3) and add it to your hand. If you use this effect, gain 9 Prestige points at the end of the game. This token can't be used in year III."
    }
}

Cards = {}
Cards['Amulet of Air'] = {
    Number = 1,
    Prestige = 6,
    Type = 'Item',
    Effect = 'Instant',
    Game = 'Base',
    Description = 'Increase your summoning gauge by 2.',
    Cost = { Earth = 0, Air = 2, Fire = 0, Water = 0, Crystals = 0 }
}
Cards['Amulet of Fire'] = {
    Number = 2,
    Prestige = 6,
    Type = 'Item',
    Effect = 'Instant',
    Game = 'Base',
    Description = 'Draw 4 power cards: add one to your hand and discard the others.',
    Cost = { Earth = 0, Air = 0, Fire = 2, Water = 0, Crystals = 0 }
}
Cards['Amulet of Earth'] = {
    Number = 3,
    Prestige = 6,
    Type = 'Item',
    Effect = 'Instant',
    Game = 'Base',
    Description = 'Gain 9 crystals.',
    Cost = { Earth = 2, Air = 0, Fire = 0, Water = 0, Crystals = 0 }
}
Cards['Amulet of Water'] = {
    Number = 4,
    Prestige = 6,
    Type = 'Item',
    Effect = 'Instant',
    Game = 'Base',
    Description = [[- When you put the Amulet of Water into play, get four Energy tokens of your choice from the stockpile and place them on the Amulet of Water.

- The Energy tokens placed on the Amulet of Water are not considered part of your reserve, however, they may be used as such. They are thus not affected by the effects of the Wondrous Chest, the Beggar's Horn, the Air Elemental, the Lantern of Xidit, Lewis Greyface, the Potion of Dreams, the Potion of Life, and the Cursed Treatise of Arus.]],
    Cost = { Earth = 0, Air = 0, Fire = 0, Water = 2, Crystals = 0 }
}
Cards['Balance of Ishtar'] = {
    Number = 5,
    Prestige = 4,
    Type = 'Item',
    Effect = 'Activated',
    Game = 'Base',
    Description = [[Activate, discard 3 identical energy tokens: transmute them into 9 crystals.

Notes:
- To activate the Balance of Ishtar, discard three identical Energy tokens, and transmute them into 9 crystals. This moves your Sorcerer token 9 spaces on the crystal track.

- The Balance of Ishtar can be activated even if you don't have access to the gain crystals action.

- The Balance of Ishtar is affected by the effect of the Purse of Io and by the bonus transmutation.]],
    Cost = { Earth = 0, Air = 0, Fire = 0, Water = 0, Crystals = 2 }
}
Cards['Staff of Spring'] = {
    Number = 6,
    Prestige = 9,
    Type = 'Item',
    Effect = 'Ongoing',
    Game = 'Base',
    Description = [[Gain 3 crystals whenever you summon a power card.

Notes:
- The effects of the Staff of Spring only affect the Power cards summoned from the player's hand. Power cards put into play through the use of other cards such as the Divine Chalice, the Crystal Orb, or the Potion of Dreams thus earn no crystals for the owner of the Staff of Spring.]],
    Cost = { Earth = 3, Air = 0, Fire = 0, Water = 0, Crystals = 0 }
}
Cards['Temporal Boots'] = {
    Number = 7,
    Prestige = 8,
    Type = 'Item',
    Effect = 'Instant',
    Game = 'Base',
    Description = [[Move the season token forward or back 1 to 3 spaces.

Notes:
- The Temporal Boots do not require any crystals or Energy tokens to be put into play.

- When you put the Temporal Boots into play, move the Season token forward or back one-to-three spaces on the season wheel.

- If the Temporal Boots make the Season token move back from winter to fall:
--- move the year counter back one year.
--- keep all the Power cards you have in your hand.

- If the Temporal Boots cause a change of season (by moving the Season token forward or back), cards affected by the change of season such as Figrim the Avaricious or the Hourglass of Time take effect immediately.]],
    Cost = { Earth = 0, Air = 0, Fire = 0, Water = 0, Crystals = 0 }
}
Cards['Purse of Io'] = {
    Number = 8,
    Prestige = 6,
    Type = 'Item',
    Effect = 'Ongoing',
    Game = 'Base',
    Description = [[Gain 1 extra crystal for each energy token you transmute.

Notes:
- The Power of the Purse of Io affects the Balance of Ishtar and the Potion of Life.

- The effects of the Purse of Io have no impact on the Glutton Cauldron and the Dragon Skull.]],
    Cost = { Earth = 0, Air = 1, Fire = 1, Water = 0, Crystals = 0 }
}
Cards['Divine Chalice'] = {
    Number = 9,
    Prestige = 10,
    Type = 'Item',
    Effect = 'Instant',
    Game = 'Base',
    Description = [[- When you put the Divine chalice into play, draw four Power cards, choose one and put it into play for free, without paying its activation cost. This summoned Power card doesn't trigger the effect of the Arcano Leech, the Staff of Spring, or of Yjang's Forgotten Vase.

- Place the three remaining cards in the discard pile. You must have a Summoning gauge high enough to be able to put into play the card drawn. Otherwise, discard it.]],
    Cost = { Earth = 1, Air = 1, Fire = 1, Water = 1, Crystals = 0 }
}
Cards['Syllas the Faithful'] = {
    Number = 10,
    Prestige = 14,
    Type = 'Familiar',
    Effect = 'Instant',
    Game = 'Base',
    Description = 'When you put Syllas the Faithfull into play, each opponent must sacrifice a Power card they own which is currently in play.',
    Cost = { Earth = 0, Air = 0, Fire = 3, Water = 0, Crystals = 0 }
}
Cards['Figrim the Avaricious'] = {
    Number = 11,
    Prestige = 7,
    Type = 'Familiar',
    Effect = 'Ongoing',
    ChangeOfSeasonEffect = true,
    Game = 'Base',
    Description = [[Each change of season, each of your opponents must give you 1 crystal if able.

Note: An opponent with no crystals is not affected by Figrim the Avaricious' effect.]],
    Cost = { Earth = 0, Air = 0, Fire = 0, Water = 0, Crystals = '3:6:9' }
}
Cards['Naria the Prophetess'] = {
    Number = 12,
    Prestige = 8,
    Type = 'Familiar',
    Effect = 'Instant',
    Game = 'Base',
    Description = 'When you put Naria the Prophetess into play, draw as many cards as there are players (including yourself). Choose one and add it to your hand. Then, from the remaining cards, deal one of your choice to each of your opponents.',
    Cost = { Earth = 0, Air = 0, Fire = 0, Water = 0, Crystals = 3 }
}
Cards['Wondrous Chest'] = {
    Number = 13,
    Prestige = 4,
    Type = 'Item',
    Effect = 'Ongoing',
    EndOfRoundEffect = true,
    Game = 'Base',
    Description = [[If you have 4 or more energy tokens in your reserve at the end of a round, gain 3 crystals.

Note: The effect of the Wondrous Chest is triggered by the Energy tokens placed on the Bespelled Grimoire which is considered part of your reserve. By contrast, the Energy tokens present on the Amulet of Water or the Glutton Cauldron aren't part of your reserve and thus don't affect the Wondrous Chest.]],
    Cost = { Earth = 0, Air = 0, Fire = 1, Water = 1, Crystals = 0 }
}
Cards["Beggar's Horn"] = {
    Number = 14,
    Prestige = 8,
    Type = 'Item',
    Effect = 'Ongoing',
    EndOfRoundEffect = true,
    Game = 'Base',
    Description = [[If you have 1 energy token or fewer in your reserve at the end of the round, gain 1 energy token.

Note: The effect of the Beggar's Horn is affected by the Energy tokens placed on the Bespelled Grimoire, which is part of your reserve. Inversely, the Energy tokens present on the Amulet of Water or the Glutton Cauldron aren't part of your reserve and thus don't affect the Beggar's horn.]],
    Cost = { Earth = 1, Air = 1, Fire = 0, Water = 0, Crystals = 0 }
}
Cards['Die of Malice'] = {
    Number = 15,
    Prestige = 8,
    Type = 'Item',
    Effect = 'Activated',
    Game = 'Base',
    Description = [[Activate, instead of performing the action(s) of your season die, reroll it: perform the new action(s) of the die roll and gain 2 crystals.

Note: If you own two Dice of Malice, you can use both one after another if the results of your first two dice don't satisfy you. In this case, you gain four crystals.]],
    Cost = { Earth = 0, Air = 0, Fire = 0, Water = 0, Crystals = 0 }
}
Cards['Kairn the Destroyer'] = {
    Number = 16,
    Prestige = 9,
    Type = 'Familiar',
    Effect = 'Activated',
    Game = 'Base',
    Description = 'Activate, discard 1 energy token: each of your opponents lose 4 crystals.',
    Cost = { Earth = 0, Air = 3, Fire = 0, Water = 0, Crystals = 0 }
}
Cards['Amsug Longneck'] = {
    Number = 17,
    Prestige = 8,
    Type = 'Familiar',
    Effect = 'Instant',
    Game = 'Base',
    Description = [[When you put Amsug Longneck into play, each player (yourself included) takes back into their hand one of their magic item cards already in play.

A player without a summoned magic item isn't affected the Amsug Longneck's effect.]],
    Cost = { Earth = 0, Air = 1, Fire = 0, Water = 1, Crystals = 0 }
}
Cards['Bespelled Grimoire'] = {
    Number = 18,
    Prestige = 8,
    Type = 'Item',
    Effect = 'Instant',
    Effect2 = 'Ongoing',
    Game = 'Base',
    Description = 'Gain 2 energy tokens.',
    Description2 = [[You can now store up to 10 energy tokens. The extra energy is stored on the Bespelled Grimoire and is considered to be part of your reserve.

Notes:
- When you put the Bespelled Grimoire into play, gain two Energy tokens of your choice from the stockpile, which will be placed in your Bespelled Grimoire.

- As long as the Bespelled Grimoire is in play, it increases the limit of your reserve, allowing it to store up to 10 Energy tokens instead of 7.

- The Energy tokens placed on the Bespelled Grimoire is considered to be part of your reserve. They are thus affected by the effect of the Wondrous Chest, the Beggar's Horn, the Air Elemental, the Lantern of
Xidit, Lewis Greyface, the Potion of Dreams, the Potion of Life, and the Cursed Treatise of Arus.

- It is possible to move the Energy tokens present on your Bespelled Grimoire to your reserve and vice versa at any time.

- Owning two Bespelled Grimoires doesn't allow you to have up to 13 Energy tokens in your reserve. The limit is of 10 Energy tokens maximum. A player can therefore not store more Energy tokens on a
second Bespelled Grimoire.]],
    Cost = { Earth = 1, Air = 0, Fire = 0, Water = 1, Crystals = 0 }
}
Cards["Ragfield's Helm"] = {
    Number = 19,
    Prestige = 10,
    Type = 'Item',
    Effect = 'Ongoing',
    EndOfGameEffect = true,
    Game = 'Base',
    Description = [[At the end of the game, if you have more power cards in play than each of your opponents, gain 20 crystals.

Note: If you are tied with one or more players for the most Power cards, you do not gain the additional crystals.]],
    Cost = { Earth = 0, Air = 3, Fire = 0, Water = 0, Crystals = 0 }
}
Cards['Hand of Fortune'] = {
    Number = 20,
    Prestige = 9,
    Type = 'Item',
    Effect = 'Ongoing',
    Game = 'Base',
    Description = [[The summoning cost of your power cards is reduced by 1 energy (not to be reduced below 1 energy).

Notes:
- Each time you summon a Power card, the cost of that card is reduced by one energy of your choice. The cost of the summoned cards cannot be reduced to less than one energy, however.

- Under no circumstances does Hand of Fortune reduce the activation costs of your Power cards (such as the one for the Crystal Orb, for example).

- The Hand of Fortune affects the summoning cost of the Elemental Amulet.]],
    Cost = { Earth = 1, Air = 1, Fire = 1, Water = 0, Crystals = 3 }
}
Cards['Lewis Greyface'] = {
    Number = 21,
    Prestige = 6,
    Type = 'Familiar',
    Effect = 'Instant',
    Game = 'Base',
    Description = [[Choose 1 of your opponents: gain exactly the same number and type of energy tokens as that opponent has in their reserve.

Note: Lewis Greyface doesn't copy the Energy tokens on the Amulet of Water or the Glutton Cauldron. However, he can copy the Energy tokens placed on the Bespelled Grimoire.]],
    Cost = { Earth = 0, Air = 1, Fire = 1, Water = 0, Crystals = 0 }
}
Cards['Runic Cube of Eolis'] = {
    Number = 22,
    Prestige = 30,
    Type = 'Item',
    Effect = 'Instant',
    Game = 'Base',
    Description = 'The Runic Cube of Eolis has no effect but is worth 30 Prestige points at the end of the game.',
    Cost = { Earth = 0, Air = 0, Fire = 0, Water = 0, Crystals = 20 }
}
Cards['Potion of Power'] = {
    Number = 23,
    Prestige = 0,
    Type = 'Item',
    Effect = 'Activated',
    Game = 'Base',
    Description = [[Activate, sacrifice the Potion of Power: draw 1 power card and increase your summoning gauge by 2.

Note: You are forced to place the drawn Power card in your hand. It cannot be discarded.]],
    Cost = { Earth = 0, Air = 0, Fire = 2, Water = 0, Crystals = 0 }
}
Cards['Potion of Dreams'] = {
    Number = 24,
    Prestige = 0,
    Type = 'Item',
    Effect = 'Activated',
    Game = 'Base',
    Description = [[Activate, sacrifice the Potion of Dreams and discard all of your energy tokens in your reserve: put a power card into play from your hand for free.

Notes:
- To activate the Potion of Dreams, sacrifice it and discard all the Energy tokens in your reserve in order to put into play a Power card from your hand for free.

- If a player has no Energy token, that player can use the Potion of Dreams.

- If a player activates the Potion of Dreams, the Energy tokens placed on the Amulet of Water or on the Glutton Cauldron aren't discarded. Energy placed on the Bespelled Grimoire, however, is discarded.

- The card summoned by the Potion of Dreams isn't affected by the effects of the Arcano Leech, the Staff of Spring and of Yjang's Forgotten Vase.]],
    Cost = { Earth = 0, Air = 2, Fire = 0, Water = 0, Crystals = 0 }
}
Cards['Potion of Knowledge'] = {
    Number = 25,
    Prestige = 0,
    Type = 'Item',
    Effect = 'Activated',
    Game = 'Base',
    Description = 'Activate, sacrifice the Potion of Knowledge: gain 5 energy tokens.',
    Cost = { Earth = 0, Air = 0, Fire = 0, Water = 2, Crystals = 0 }
}
Cards['Potion of Life'] = {
    Number = 26,
    Prestige = 0,
    Type = 'Item',
    Effect = 'Activated',
    Game = 'Base',
    Description = [[Activate, sacrifice the Potion of Life: transmute each of the energy tokens in your reserve into 4 crystals.

Notes:
- The Potion of Life can be activated without a player having access to the transmutation action.

- The Energy tokens placed on the Amulet of Water or the Glutton Cauldron aren't affected by the effect of the Potion of Life, unlike the Energy tokens placed on the Bespelled Grimoire.

- No player can continue to transmute after having activated the Potion of Life unless you possess a die with the transmute action or are using a bonus transmution.

- The Potion of Life is affected by the effect of the Purse of Io.]],
    Cost = { Earth = 2, Air = 0, Fire = 0, Water = 0, Crystals = 0 }
}
Cards['Hourglass of Time'] = {
    Number = 27,
    Prestige = 6,
    Type = 'Item',
    Effect = 'Ongoing',
    ChangeOfSeasonEffect = true,
    Game = 'Base',
    Description = 'Each change of season, gain 1 energy token.',
    Cost = { Earth = 1, Air = 1, Fire = 1, Water = 1, Crystals = 0 }
}
Cards['Scepter of Greatness'] = {
    Number = 28,
    Prestige = 8,
    Type = 'Item',
    Effect = 'Instant',
    Game = 'Base',
    Description = 'Gain 3 crystals for each of your other magic items in play.',
    Cost = { Earth = 1, Air = 1, Fire = 1, Water = 1, Crystals = 0 }
}
Cards["Olaf's Blessed Statue"] = {
    Number = 29,
    Prestige = 0,
    Type = 'Item',
    Effect = 'Instant',
    Game = 'Base',
    Description = 'Gain 20 crystals.',
    Cost = { Earth = 0, Air = 0, Fire = 0, Water = 3, Crystals = 0 }
}
Cards["Yjang's Forgotten Vase"] = {
    Number = 30,
    Prestige = 6,
    Type = 'Item',
    Effect = 'Ongoing',
    Game = 'Base',
    Description = [[When you summon a power card, gain 1 energy token.

Note: The effect of Yjang's Forgotten Vase affects only the Power cards summoned from a player's hand. The Power cards put into play through the use of other cards such as the Divine Chalice, the Crystal Orb, or the Potion of Dreams are thus worth no energy.]],
    Cost = { Earth = 1, Air = 0, Fire = 1, Water = 1, Crystals = 0 }
}
Cards['Elemental Amulet'] = {
    Number = 31,
    Prestige = 2,
    Type = 'Item',
    Effect = 'Instant',
    Game = 'Base',
    Description = [[If you've used this type of energy:

Water: gain 2 energy tokens.
Earth: gain 5 crystals
Fire: draw a power card.
Air: increase your summoning gauge by 1.

Notes:
- All 4 types of energy can be included in the Elemental Amulet's cost if a player wants to have access to all four effects. However, you cannot pay multiple times for a given type of energy to benefit multiple times from a given effect.

- The Elemental Amulet benefits from the energy reduction offered by the Hand of Fortune. It is thus possible to obtain two different effects by paying only one Energy token.

- If the Elemental amulet is summoned through the use of a Diving Chalice, the Potion of Dreams or the Crystal Orb, consider the price to have included all four types of energy in its summoning cost and trigger the 4 corresponding effects.]],
    OptionalCost = true,
    Cost = { Earth = 1, Air = 1, Fire = 1, Water = 1, Crystals = 0 }
}
Cards['Tree of Light'] = {
    Number = 32,
    Prestige = 12,
    Type = 'Item',
    Effect = 'Activated',
    Game = 'Base',
    Description = [[Activate, discard 3 crystals: gain 1 energy token.

Activate, discard 1 energy token: you can transmute this round.

Note: During a given activation, you can use only one of the two effects.]],
    Cost = { Earth = 2, Air = 0, Fire = 0, Water = 0, Crystals = 0 }
}
Cards['Arcano Leech'] = {
    Number = 33,
    Prestige = 8,
    Type = 'Familiar',
    Effect = 'Ongoing',
    Game = 'Base',
    Description = [[In order to summon a power card, your opponents must give you 1 crystal first.

Note: The effects of the Arcano Leech only affects Power cards summoned from a player's hand. Players who put into play for free Power cards through the use of other cards such as the Divine Chalice, the Crystal Orb, or the Potion of Dreams need not give a crystal to the owner of the Arcano Leech.]],
    Cost = { Earth = 0, Air = 0, Fire = 0, Water = 0, Crystals = '2:5:8' }
}
Cards['Crystal Orb'] = {
    Number = 34,
    Prestige = 6,
    Type = 'Item',
    Effect = 'Activated',
    Game = 'Base',
    Description = [[To activate the Crystal Orb, you can:

- either look at the first Power card from the draw pile, then either return it to the top of the draw pile or discard 4 Energy tokens to put it into play for free if it interests you.

- or move your Sorcerer token back 3 spaces on the crystal track to put the top Power card of the draw pile into the discard pile.

Notes:
- The summoning cost of cards summoned by the Crystal Orb doesn't have to be paid. However, you still need to have a high enough Summoning gauge.

- The cards put into play by the Crystal Orb aren't affected by the effects of the Arcano Leech, the Staff of Spring, or Yjang's Forgotten Vase.

- During a given activation, you can use only one of the two effects.]],
    Cost = { Earth = 1, Air = 0, Fire = 1, Water = 0, Crystals = 0 }
}
Cards['Glutton Cauldron'] = {
    Number = 35,
    Prestige = 0,
    Type = 'Item',
    Effect = 'Activated',
    Effect2 = 'Ongoing',
    Game = 'Base',
    Description = 'Activate, place 1 energy token from your reserve on the glutton cauldron.',
    Description2 = [[Sacrifice the Glutton Cauldron when it contains 7 energy tokens: put these 7 energy tokens into your reserve and gain 15 crystals.

Notes:
- The Glutton Cauldron does not require any crystals or Energy token to be put into play.

- On each of your turns, you can place 1 Energy token from your reserve on the Glutton Cauldron.

- As long as fewer than 7 Energy tokens are on the Glutton Cauldron, it cannot be used.

- When the Glutton Cauldron gains its 7th energy, its effects are applied immediately: sacrifice it, place the energy from the Glutton Cauldron in your reserve and move your Sorcerer token forward 15 spaces on the crystal track.

- The Energy tokens placed on the Glutton Cauldron aren't considered to be a part of your reserve. They are therefore not affected by the effects of the Wondrous Chest, the Beggar's Horn, the Air Elemental, the Lantern of Xidit, Lewis Greyface, the Potion of Dreams, the Potion of Life, and the Cursed Treatise of Arus.

- At no point can a player exceed their reserve's maximum capacity.]],
    Cost = { Earth = 0, Air = 0, Fire = 0, Water = 0, Crystals = 0 }
}
Cards['Vampiric Crown'] = {
    Number = 36,
    Prestige = 0,
    Type = 'Item',
    Effect = 'Instant',
    Game = 'Base',
    Description = [[Discard or draw a power card: gain as many energy tokens as the number of prestige points of the discarded or drawn card.

Notes:
- If you decide to draw a card to resolve the effect of the Vampiric Crown, you must keep the drawn card.

- You must reveal to the other players the drawn or discarded card.

- If the drawn or discarded card offers no Prestige points or offers negative Prestige points, the player doesn't get any Energy tokens.]],
    Cost = { Earth = 0, Air = 1, Fire = 0, Water = 1, Crystals = 0 }
}
Cards['Dragon Skull'] = {
    Number = 37,
    Prestige = 9,
    Type = 'Item',
    Effect = 'Activated',
    Game = 'Base',
    Description = [[Activate, sacrifice 3 power cards: gain 15 crystals.

Note: The effect of the Dragon Skull isn't affected by the Purse of Io.]],
    Cost = { Earth = 1, Air = 0, Fire = 1, Water = 1, Crystals = 0 }
}
Cards['Demon of Argos'] = {
    Number = 38,
    Prestige = 16,
    Type = 'Familiar',
    Effect = 'Instant',
    Game = 'Base',
    Description = [[Reduce the summoning gauge of all your opponents by 1. Each of your opponents draws a power card.

Notes:
- The Power card drawn cannot be discarded.

- After resolving the effect of the Demon of Argos, the players who have too many Power cards in play compared to their Summoning gauges do not have to sacrifice cards.]],
    Cost = { Earth = 1, Air = 1, Fire = 1, Water = 1, Crystals = 0 }
}
Cards['Titus Deepgaze'] = {
    Number = 39,
    Prestige = 4,
    Type = 'Familiar',
    Effect = 'Ongoing',
    EndOfRoundEffect = true,
    Game = 'Base',
    Description = "At the end of the round, your opponents give you 1 crystal. If an opponent no longer has any crystals and cannot give you any, apply Titus Deepgaze's effect only on opponents who can pay. Then, at the end of the round, sacrifice Titus Deepgaze.",
    Cost = { Earth = 0, Air = 0, Fire = '1:2:3', Water = 0, Crystals = 0 }
}
Cards['Air Elemental'] = {
    Number = 40,
    Prestige = 12,
    Type = 'Familiar',
    Effect = 'Instant',
    Game = 'Base',
    Description = [[All the energy tokens present in the reserves of your opponents become air energy tokens.

Note: The Energy tokens placed on the Bespelled Grimoire are part of the reserve and are thus affected by the effect of the Air Elemental. Inversely, the Energy tokens placed on the Amulet of Water and the Glutton Cauldron aren't part of the reserve and are thus not affected by the effect.]],
    Cost = { Earth = 0, Air = 3, Fire = 0, Water = 0, Crystals = 0 }
}
Cards['Thieving Fairies'] = {
    Number = 41,
    Prestige = 6,
    Type = 'Familiar',
    Effect = 'Ongoing',
    Game = 'Base',
    Description = [[Each time an opponent activates one of their power cards, they give you 1 crystal. Gain an extra 1 crystal at that time.

Note: If an opponent doesn't have any crystals when they use an activation effect card, you do not get any crystals from them; however, that opponent can still activate their Power card. You still get one extra crystal.]],
    Cost = { Earth = 0, Air = 0, Fire = 0, Water = 0, Crystals = '0:3:6' }
}
Cards['Cursed Treatise of Arus'] = {
    Number = 42,
    Prestige = -10,
    Type = 'Item',
    Effect = 'Instant',
    Effect2 = 'Ongoing',
    Game = 'Base',
    Description = 'Gain 2 energy tokens, 10 crystals and increase your summoning gauge by 1.',
    Description2 = [[If the Cursed Treatise of Arus is sacrificed, discard all the energy tokens in your reserve.

Notes:
- If you sacrifice the Cursed Treatise of Arus, discard all the Energy tokens placed in your reserve, as well as those on the Bespelled Grimoire (if any).

- The energy placed on the Amulet of Water and the Glutton Cauldron aren't affected.]],
    Cost = { Earth = 0, Air = 0, Fire = 0, Water = 1, Crystals = 0 }
}
Cards['Idol of the Familiar'] = {
    Number = 43,
    Prestige = 0,
    Type = 'Item',
    Effect = 'Instant',
    Effect2 = 'Activated',
    Game = 'Base',
    Description = 'Gain 10 crystals.',
    Description2 = 'Activate, gain 1 crystal for each of your familiars in play.',
    Cost = { Earth = 1, Air = 1, Fire = 1, Water = 1, Crystals = 0 }
}
Cards['Necrotic Kriss'] = {
    Number = 44,
    Prestige = 6,
    Type = 'Item',
    Effect = 'Activated',
    Game = 'Base',
    Description = 'To activate the Necrotic Kriss, discard 1 familiar card from your hand or sacrifice one of your familiar cards in play. Then receive and place in your reserve 4 Energy tokens of your choice from the stockpile.',
    Cost = { Earth = 0, Air = 2, Fire = 0, Water = 1, Crystals = 0 }
}
Cards['Lantern of Xidit'] = {
    Number = 45,
    Prestige = 24,
    Type = 'Item',
    Effect = 'Instant',
    EndOfGameEffect = true,
    Game = 'Base',
    Description = [[At the end of the game, gain 3 crystals for each energy token in your reserve.

Notes:
- The Energy tokens placed on the Bespelled Grimoire are part of your reserve. They are thus worth 3 crystals each.

- The Energy tokens placed on the Amulet of Water and the Glutton Cauldron aren't part of your reserve and will thus not earn you any extra crystals at the end of the game.]],
    Cost = { Earth = 3, Air = 0, Fire = 3, Water = 0, Crystals = 0 }
}
Cards['Sealed Chest of Urm'] = {
    Number = 46,
    Prestige = 10,
    Type = 'Item',
    Effect = 'Ongoing',
    EndOfGameEffect = true,
    Game = 'Base',
    Description = 'At the end of the game, if you only have magic items in play, gain 20 crystals.',
    Cost = { Earth = 1, Air = 0, Fire = 0, Water = 2, Crystals = 0 }
}
Cards['Mirror of the Seasons'] = {
    Number = 47,
    Prestige = 8,
    Type = 'Item',
    Effect = 'Activated',
    Game = 'Base',
    Description = 'Activate, discard X crystals: transform X identical energy tokens from your reserve into X identical energy tokens of another type.',
    Cost = { Earth = 0, Air = 0, Fire = 0, Water = 0, Crystals = 3 }
}
Cards['Pendant of Ragnor'] = {
    Number = 48,
    Prestige = 0,
    Type = 'Item',
    Effect = 'Instant',
    Game = 'Base',
    Description = 'Gain 1 energy token for each of your other magic items in play.',
    Cost = { Earth = 0, Air = 1, Fire = 1, Water = 1, Crystals = 0 }
}
Cards['Sid Nightshade'] = {
    Number = 49,
    Prestige = 6,
    Type = 'Familiar',
    Effect = 'Instant',
    Game = 'Base',
    Description = [[If you are the player with the most crystals, each opponent give you 5 crystals.

Notes:
- If at least one player has at least as many, if not more crystals than you, you steal no crystals from your opponents.

- If a player owns fewer than 5 crystals, Sid Nightshade steals all of their crystals. The player moves their Sorcerer token back to the zero space of the crystal track and you move your Sorcerer token as many spaces as crystals stolen on that same track.]],
    Cost = { Earth = '1:2:3', Air = 0, Fire = 0, Water = 0, Crystals = 0 }
}
Cards['Damned Soul of Onys'] = {
    Number = 50,
    Prestige = -5,
    Type = 'Familiar',
    Effect = 'Instant',
    Effect2 = 'Activated',
    Effect3 = 'Ongoing',
    EndOfRoundEffect = true,
    Game = 'Base',
    Description = 'Gain 10 crystals and 1 water energy token.',
    Description2 = 'Activate, discard a water energy, straighten the Damned Soul of Onys and pass it to the player on your left.',
    Description3 = [[At the end of the round, lose 3 crystals.

Note: A player can receive the Damned Soul of Onys from their right neighbor even if their Summoning gauge isn’t high enough]],
    Cost = { Earth = 0, Air = 0, Fire = 0, Water = 1, Crystals = 0 }
}

-- Enchanted Kingdom
Cards['Heart of Argos'] = {
    Number = 1,
    Prestige = 7,
    Type = 'Item',
    Effect = 'Ongoing',
    EndOfRoundEffect = true,
    Game = 'Enchanted Kingdom',
    Description = [[Once per turn, if you activate one of your Power cards, place an earth energy on the Heart of Argos. At the end of the round, place this energy in your reserve.

Even if you activate multiple Power cards during your turn, you only gain a single earth energy at the end of the round.]],
    Cost = { Earth = 2, Air = 0, Fire = 0, Water = 0, Crystals = 0 }
}
Cards['Horn of Plenty'] = {
    Number = 2,
    Prestige = 4,
    Type = 'Item',
    Effect = 'Instant',
    Game = 'Enchanted Kingdom',
    Description = [[Discard 1 energy token at the end of the round: receive 5 crystals if the discarded energy is an earth energy.

Notes:
- If you have any energy tokens, you must discard one at the end of the round.

- Energy tokens placed on the Amulet of Water are affected by the Horn of Plenty.

- The Horn of Plenty has no effect if you have no energy tokens.

- Energy tokens placed on the Glutton Cauldron, the Jewel of the Ancients or the Fairy Monolith are unaffected by the Horn of Plenty.

- The Horn of Plenty effect can only be applied once per turn.]],
    Cost = { Earth = 1, Air = 0, Fire = 0, Water = 1, Crystals = 0 }
}
Cards['Fairy Monolith'] = {
    Number = 3,
    Prestige = 6,
    Type = 'Item',
    Effect = 'Activated',
    Effect2 = 'Ongoing',
    EndOfRoundEffect = true,
    Game = 'Enchanted Kingdom',
    Description = [[Activated, return any or all (but at least 1) of the energy tokens currently stored on the Fairy Monolight to your energy reserve.

Notes:
- At least one energy token must be returned.

- You cannot activate the Fairy Monolith if it does not contain any energy charges.

- There is no limit to the amount of energy stored by the Fairy Monolith.

- You cannot use energy tokens placed on the Fairy Monolith during the game, for example, to summon one of your Power cards.

- Energy tokens placed on the Fairy Monolith are not considered to be part of your reserve. They are therefore unaffected by the effects of cards such as the Potion of Dreams, Ratty Nightshade, Lewis Greyface, the Cursed Treatise of Arus, the Potion of Life, the Beggar's Horn, the Air Elemental, the Lantern of Xidit, the Wondrous Chest, etc.

- If the Fairy Monolith is removed from play while it contains energy tokens, the energy tokens are discarded.]],
    Description2 = 'At the end of the round, you may place 1 energy token from your reserve on the Fairy Monolith.',
    Cost = { Earth = 2, Air = 0, Fire = 0, Water = 0, Crystals = 0 }
}
Cards["Selenia's Codex"] = {
    Number = 4,
    Prestige = 6,
    Type = 'Item',
    Effect = 'Instant',
    Game = 'Enchanted Kingdom',
    Description = [[Return a magic item to your hand, on condition that the item's summoning cost includes one or more energy tokens.

Notes:
- You cannot use Selenia's Codex to return a magic item to your hand if crystals are the only resource required in order to summon that object.

- You can summon Selenia's Codex even if you do not have any magic items in play, or only magic items with summoning costs that do not include at least one energy, but you will not be able to apply its effect.

- The Nature Spirit enchantment enables Selenia's Codex to be used to return all magic items in the game to your hand.]],
    Cost = { Earth = 0, Air = 1, Fire = 0, Water = 1, Crystals = 0 }
}
Cards['Scroll of Ishtar'] = {
    Number = 5,
    Prestige = 7,
    Type = 'Item',
    Effect = 'Instant',
    Game = 'Enchanted Kingdom',
    Description = [[Name one of the four energy types and then reveal the cards in the draw pile one-by-one until a magic item for which the summoning cost includes the named energy is revealed. Either add the revealed card to your hand or discard it. If you discard it, you may repeat the effect of this card once, but only once.

Notes:
- If you choose not to keep the first magic item that matches the named energy, you must add the second revealed matching magic item to your hand.

- If you decide not to keep the first magic item to be revealed that matches the named energy, you cannot change your decision afterwards.

- Discard all other cards revealed by the Scroll of Ishtar.

- You must name one of the four types of energy (water, earth, fire or air). Crystals are not a type of energy and therefore cannot be named.

- The named energy can be changed the second time that the Scroll of Ishtar is used.]],
    Cost = { Earth = 0, Air = 0, Fire = 2, Water = 0, Crystals = 0 }
}
Cards["Mesodae's Lantern"] = {
    Number = 6,
    Prestige = 24,
    Type = 'Item',
    Effect = 'Ongoing',
    EndOfRoundEffect = true,
    Game = 'Enchanted Kingdom',
    Description = [[Mesodae's Lantern cannot be put into play via another Power card. Your energy reserve is decreased by 1. At the end of the round, receive 3 crystals.

Notes:
- Mesodae's Lantern cannot be put into play via another Power card such as the Potion of Dreams, the Divine Chalice or the Crystal Orb, etc.

- Place a decreased energy reserve token in one of the spaces in your energy reserve while Mesodae's Lantern is in play and under your control.

- The effect of the Hand of Fortune can be applied to Mesodae's Lantern, enabling it to be summoned at a reduced summoning cost.]],
    Cost = { Earth = 0, Air = 3, Fire = 0, Water = 3, Crystals = 0 }
}
Cards['Statue of Eolis'] = {
    Number = 7,
    Prestige = 6,
    Type = 'Item',
    Effect = 'Ongoing',
    ChangeOfSeasonEffect = true,
    Game = 'Enchanted Kingdom',
    Description = [[Your energy reserve is decreased by 1. Whenever the season changes, either collect 1 energy token

OR

receive 2 crystals and look at the top card of the draw pile.

Notes:
- Place a decreased energy reserve token in one of the spaces in your energy reserve while the Statue of Eolis is in play and under your control.

- If the season changes during the round, apply one of the effects of the Statue of Eolis immediately.

- If you choose to collect an energy token, you are not allowed to look at the top card of the draw pile.]],
    Cost = { Earth = 1, Air = 0, Fire = 1, Water = 1, Crystals = 0 }
}
Cards['Familiar Catcher'] = {
    Number = 8,
    Prestige = 7,
    Type = 'Item',
    Effect = 'Instant',
    Game = 'Enchanted Kingdom',
    Description = [[Reveal the cards in the draw pile until you reveal a familiar. Either add the card to your hand or discard it. If you discard it, you may repeat the effect of this card once, but only once.

Notes:
- If you decide not to add to your hand the first familiar revealed, you must keep the next familiar revealed, adding it to your hand.

- If you decide not to keep the first familiar revealed, you cannot change your decision afterwards.

- Discard all other cards revealed by the Familiar Catcher.]],
    Cost = { Earth = 0, Air = 1, Fire = 1, Water = 0, Crystals = 0 }
}
Cards["Io's Transmuter"] = {
    Number = 9,
    Prestige = 6,
    Type = 'Item',
    Effect = 'Ongoing',
    EndOfRoundEffect = true,
    Game = 'Enchanted Kingdom',
    Description = [[If your season die grants you crystals, you may transmute during your turn. At the end of the round, receive 2 crystals if you have used Io's Transmuter to transmute energy tokens.

Notes:
- When you use Io's Transmuter to transmute one or more energy tokens, receive 2 additional crystals, not 2 per transmuted energy token.

- You can only receive these two crystals once per round.

- Transmuting energy tokens by any means other than Io's Transmuter does not earn you 2 crystals at the end of the round.]],
    Cost = { Earth = 1, Air = 0, Fire = 0, Water = 1, Crystals = 0 }
}
Cards['Throne of Renewal'] = {
    Number = 10,
    Prestige = 10,
    Type = 'Item',
    Effect = 'Instant',
    Game = 'Enchanted Kingdom',
    Description = [[Discard a Power card: draw a Power card and move your Sorcerer token back one space on the bonus track.

Notes:
- Do not move your sorcerer token back if you have not used any of your bonus actions when you summon the Throne of Renewal.

- If you do not have any Power cards in your hand to discard when you summon the Throne of Renewal, you cannot draw a Power card or move your sorcerer token back one space on the bonus track.

- If you have any Power cards in your hand when you summon the Throne of Renewal, you must discard one.]],
    Cost = { Earth = 0, Air = 0, Fire = 2, Water = 1, Crystals = 0 }
}
Cards['Potion of Resurrection'] = {
    Number = 11,
    Prestige = 0,
    Type = 'Item',
    Effect = 'Activated',
    Game = 'Enchanted Kingdom',
    Description = [[Activate, sacrifice the Potion of Resurrection and look at the top five cards in the discard area: add one of the cards to your hand and return the others to the bottom of the discard pile.

Notes:
- You may still apply the Potion of Resurrection's effect even if there are fewer than 5 cards in the discard area.]],
    Cost = { Earth = 1, Air = 0, Fire = 1, Water = 0, Crystals = 0 }
}
Cards['Jewel of the Ancients'] = {
    Number = 12,
    Prestige = 10,
    Type = 'Item',
    Effect = 'Activated',
    Effect2 = 'Ongoing',
    EndOfGameEffect = true,
    Game = 'Enchanted Kingdom',
    Description = 'Activate, take 3 identical energy tokens from your reserve: place one on the Jewel of the Ancients and discard the other two.',
    Description2 = [[At the end of the game, receive 35 crystals if there are 3 or more energy tokens on the Jewel of the Ancients. Otherwise, lose 10 crystals.

Notes:
- You may use energy tokens placed on the Amulet of Water to activate the Jewel of the Ancients.

- Energy tokens placed on the Jewel of the Ancients are unaffected by the effects of other Power cards, and cannot be used during the game.]],
    Cost = { Earth = 0, Air = 0, Fire = 2, Water = 0, Crystals = 0 }
}
Cards['Shield of Zira'] = {
    Number = 13,
    Prestige = 5,
    Type = 'Item',
    Effect = 'Ongoing',
    Game = 'Enchanted Kingdom',
    Description = [[Instead of discarding or sacrificing one of your Power cards, you may sacrifice the Shield of Zira instead, in which case, you also receive 10 crystals.

Notes:
- The effect of the Shield of Zira can be used to protect against the effect of a Power card (belonging to yourself or an opponent) or an enchantment that would otherwise force you to discard or sacrifice one of your Power cards.

- All cards that must be sacrificed in order to activate their effect (such as potions) are compatible with the Shield of Zira. In such cases, you apply the effect and then sacrifice the Shield of Zira instead.]],
    Cost = { Earth = 0, Air = 0, Fire = 1, Water = 0, Crystals = 0 }
}
Cards['Steadfast Die'] = {
    Number = 14,
    Prestige = 10,
    Type = 'Item',
    Effect = 'Ongoing',
    Game = 'Enchanted Kingdom',
    Description = [[Instead of performing the actions indicated by your season die, you may choose one of the following actions: increase your summoning gauge by 1, receive 1 energy, or transmute during this turn.

Notes:
- After choosing your seasons die but before applying its actions, you may decide to ignore the actions indicated by the die and activate any one of the effects of the Steadfast Die card instead.

- You may only choose one of the three available effects.]],
    Cost = { Earth = 1, Air = 0, Fire = 1, Water = 0, Crystals = 0 }
}
Cards['Amulet of Time'] = {
    Number = 15,
    Prestige = 9,
    Type = 'Item',
    Effect = 'Instant',
    Game = 'Enchanted Kingdom',
    Description = [[Collect 2 energy tokens. Discard X Power cards and draw X Power cards.

Notes:
- "Any number of cards" may be 0. You still receive two energy tokens.]],
    Cost = { Earth = 0, Air = 0, Fire = 0, Water = 2, Crystals = 0 }
}
Cards['Arcane Telescope'] = {
    Number = 16,
    Prestige = 8,
    Type = 'Item',
    Effect = 'Activated',
    Game = 'Enchanted Kingdom',
    Description = 'Activate, discard 2 crystals: look at the first 3 cards in the draw pile in the order of your choice.',
    Cost = { Earth = 0, Air = 0, Fire = 0, Water = 0, Crystals = 0 }
}
Cards['Argos Hawk'] = {
    Number = 17,
    Prestige = 4,
    Type = 'Familiar',
    Effect = 'Instant',
    Effect2 = 'Activated',
    Game = 'Enchanted Kingdom',
    Description = 'Receive 10 crystals and increase your summoning gauge by 1.',
    Description2 = 'Activate, sacrifice the Argos Hawk: each opponent must decrease their summoning gauge by 1 but receives 6 crystals.',
    Cost = { Earth = 1, Air = 1, Fire = 0, Water = 0, Crystals = 0 }
}
Cards['Raven the Usurper'] = {
    Number = 18,
    Prestige = 2,
    Type = 'Familiar',
    Effect = 'Instant',
    Effect2 = 'Ongoing',
    Game = 'Enchanted Kingdom',
    Description = [[Place the "Raven" token on an opponent's magic item and pay its summoning cost: Raven permanently acquires the effect(s) of the mimicked magic item.]],
    Description2 = [[Sacrifice Raven the Usurper if the mimicked magic item is removed from play.

Notes:
- If the mimicked magic item has "on entering play" effects, apply those effects immediately.

- If the magic item has activation effects, Raven the Usurper can be activated once per turn to trigger the activation effect. The activation costs are also mimicked.

- Only the effects of the targeted card are mimicked, never its Prestige points.]],
    Cost = { Earth = 0, Air = 0, Fire = 1, Water = 0, Crystals = 0 }
}
Cards['Warden of Argos'] = {
    Number = 19,
    Prestige = 6,
    Type = 'Familiar',
    Effect = 'Instant',
    Game = 'Enchanted Kingdom',
    Description = [[Choose one of the following options: each player must discard 4 energy tokens from their reserve

OR

each player must discard a Power card.

Notes:
- Your opponents must apply the effect that you have chosen.

- If players are required to discard a Power card but do not have any in their hand, the Warden of Argos has no effect on them.

- Any players who are required to discard 4 energy tokens but have fewer than 4 energy tokens must discard all their energy tokens.

- Energy tokens placed on the Amulet of Water, the Glutton Cauldron, the Jewel of the Ancients or the Fairy Monolith are unaffected by the Warden of Argos.]],
    Cost = { Earth = 0, Air = 1, Fire = 0, Water = 0, Crystals = 0 }
}
Cards['Ratty Nightshade'] = {
    Number = 20,
    Prestige = 8,
    Type = 'Familiar',
    Effect = 'Instant',
    Game = 'Enchanted Kingdom',
    Description = [[Collect up to 2 energy tokens of your choice from each opponent's energy reserve, and place them in your own reserve.

Notes:
- If an opponent has fewer than two energy tokens, take what energy they do have.

- If an opponent has no energy at all in their reserve, they are unaffected by Ratty Nightshade.

- Energy tokens placed on the Amulet of Water, the Glutton Cauldron, the Jewel of the Ancients or the Fairy Monolith cannot be taken by Ratty Nightshade.]],
    Cost = { Earth = 0, Air = 0, Fire = 0, Water = 0, Crystals = '2:4:6' }
}

-- Path of Destiny
Cards['Dragonsoul'] = {
    Number = 1,
    Prestige = 8,
    Type = 'Item',
    Effect = 'Activated',
    Game = 'Path of Destiny',
    Description = [[Activate, discard 1 crystal: straighten a turned Power card other than a Dragonsoul.

Notes:
- There is no summoning cost for Dragonsoul.

- However, you must discard 1 crystal to activate Dragonsoul.

- The Dragonsoul effect cannot be applied to itself, to another Dragonsoul card or to a copy of a Dragonsoul.]],
    Cost = { Earth = 0, Air = 0, Fire = 0, Water = 0, Crystals = 0 }
}
Cards['Magma Core'] = {
    Number = 2,
    Prestige = 0,
    Type = 'Item',
    Effect = 'Ongoing',
    Effect2 = 'Activated',
    Game = 'Path of Destiny',
    Description = 'Receive a fire energy when an opponent summons a Power card.',
    Description2 = [[Activate, sacrifice the Magma Core: receive 3 fire energy.

Notes:
- Magma Core's summoning cost depends on the number of players.

- Cards put into play (but not summoned) by other players do not grant you the Magma Core effect ( as with the Crystal Orb, Divine Chalice, etc.).]],
    Cost = { Earth = 0, Air = 0, Fire = '1:2:3', Water = 0, Crystals = 0 }
}
Cards['Twist of Fate'] = {
    Number = 3,
    Prestige = 0,
    Type = 'Item',
    Effect = 'Instant',
    Game = 'Path of Destiny',
    Description = [[After selecting your 9 Power cards during the Prelude, remove Twist of Fate from the game and draw two Power cards: add one to your hand and discard the other. Before the tournament, remove any Twist of Fate cards from the draw pile and then shuffle.

Notes:
- The Twist of Fate effect applies only during the Prelude.

- Apply the Twist of Fate effect when you have selected your nine Power cards, before they are allocated to Library tokens. Then remove the Twist of Fate from the game (put it back in the box,
not in the discard pile).

- Ensure that no Twist of Fate cards are present in the draw pile. (Any Twist of Fate cards in the draw pile should be removed from the game).

- If two players have a Twist of Fate, they draw their cards in the turn order.

- Any cards looked at by a player with a Twist of Fate card are not revealed to the other players.

- In the event that a player reveals (or looks at) a Twist of Fate card during the Tournament, remove the Twist of Fate from the game and reveal (or look at) another Power card instead.]],
    Cost = { Earth = 0, Air = 0, Fire = 0, Water = 0, Crystals = 0 }
}
Cards['Potion of the Ancients'] = {
    Number = 4,
    Prestige = 0,
    Type = 'Item',
    Effect = 'Activated',
    Game = 'Path of Destiny',
    Description = [[Activate, sacrifice the Power of the Ancients and choose two effects:

- Crystallize each energy in your reserve for 4 crystals.
- Draw two Power cards and discard one.
- Increase your summoning gauge by 2
- Receive 4 energy tokens.

Notes:
- When you sacrifice the Potion of the Ancients, you must apply two of the four available effects.

- You are free to choose the order in which the effects are applied.

- The transmutation effect of the Potion of Ancients is as for the Potion of Life in the base game.

- If you choose to draw two Power cards, you must add one to your hand and discard the other.]],
    Cost = { Earth = 1, Air = 1, Fire = 1, Water = 1, Crystals = 0 }
}
Cards["Ethiel's Fountain"] = {
    Number = 5,
    Prestige = 7,
    Type = 'Item',
    Effect = 'Ongoing',
    EndOfRoundEffect = true,
    Game = 'Path of Destiny',
    Description = [[At the end of the round, receive 3 crystals if you have no Power cards in your hand.

Notes:
- If you do not have any Power cards in your hand when the season changes, move your Sorcerer token forward 3 spaces on the crystal track.

- When the year changes, apply the Ethiel's Fountain effect before receiving your Power cards.]],
    Cost = { Earth = 2, Air = 0, Fire = 0, Water = 0, Crystals = 0 }
}
Cards['Dial of Colof'] = {
    Number = 6,
    Prestige = 12,
    Type = 'Item',
    Effect = 'Instant',
    Effect2 = 'Ongoing',
    EndOfRoundEffect = true,
    Game = 'Path of Destiny',
    Description = 'Increase your summoning gauge by 2.',
    Description2 = [[At the end of the round, if you have more Power cards in play than any opponent, you may reroll the Season die that was not selected by any of the players.

Notes:
- You benefit from the Dial of Colof's permanent effect even if you are not the player with the most Power cards in play, as long as you have more Power cards in play than one opponent.

- If you have more Power cards in play than an opponent, you may reroll the Season die that was not chosen by the other players ( and which is used to move the Season marker).

- You must use and apply this effect before moving the Season marker.

- You cannot use the action( s ) shown on the rerolled Season die. The purpose of this die is exclusively to move the Season marker, as in the base game.]],
    Cost = { Earth = 1, Air = 0, Fire = 1, Water = 1, Crystals = 0 }
}
Cards['Chalice of Eternity'] = {
    Number = 7,
    Prestige = 10,
    Type = 'Item',
    Effect = 'Ongoing',
    EndOfRoundEffect = true,
    Effect2 = 'Activated',
    Game = 'Path of Destiny',
    Description = 'At the end of the round, you may place 1 energy token from your reserve on the Chalice of Eternity.',
    Description2 = [[Activate, discard 4 energy tokens placed on the Chalice of Eternity: look at the first 4 cards in the Power card draw pile, put one into play free of charge and discard the remaining cards.

Notes:
- Energy tokens placed in the Chalice of Eternity are not affected by cards such as Ratty Nightshade, the Lantern of Xidit, the Wondrous Chest or the Beggar's Horn.

- The summoning gauge requirement applies when the Chalice of Eternity is used to put a card into play.

- If the Chalice of Eternity is removed from play while it contains energy tokens, the energy tokens are discarded.]],
    Cost = { Earth = 1, Air = 1, Fire = 1, Water = 1, Crystals = 0 }
}
Cards['Staff of Winter'] = {
    Number = 8,
    Prestige = 6,
    Type = 'Item',
    Effect = 'Ongoing',
    Effect2 = 'Activated',
    Game = 'Path of Destiny',
    Description = 'In winter, all energy tokens in your reserve are also treated as earth energy.',
    Description2 = [[Activate, discard a magic item: receive 3 energy tokens.

Notes:
- In winter all types of energy may be transmuted to yield 3 crystals per token (This is not in addition to the normal energy values ).

Example: Paul has a Staff of Winter. In winter, he transmutes 2 water energy tokens and 1 fire energy token, receiving a total of 9 crystals.

- In winter, all your energy tokens are also treated as earth energy tokens. You may therefore use them to summon or activate a Power card that requires earth energy.

- You may activate the Staff of Winter to discard a magic item and receive 3 energy tokens from the stockpile.

- You continue to benefit from the Staff of Winter's permanent effect even when it has been activated.]],
    Cost = { Earth = 0, Air = 0, Fire = 0, Water = 2, Crystals = 0 }
}
Cards['Sepulchral Amulet'] = {
    Number = 9,
    Prestige = 8,
    Type = 'Item',
    Effect = 'Instant',
    Game = 'Path of Destiny',
    Description = [[Look at the first 3 cards in the discard pile: add one of the cards to your hand, place one on top of the draw pile and one at the bottom of the draw pile.

Notes:
- If the discard pile contains fewer than 3 Power cards, apply the various effects of the Sepulchral Amulet in order, wherever possible.]],
    Cost = { Earth = 0, Air = 0, Fire = 2, Water = 0, Crystals = 0 }
}
Cards["Eolis's Replicator"] = {
    Number = 10,
    Prestige = 7,
    Type = 'Item',
    Effect = 'Activated',
    Game = 'Path of Destiny',
    Description = [[Activate, discard a water energy: put a Replica Power card into play. This card is treated as a magic item worth 7 Prestige points at the end of the game.

Notes:
- When you activate Eolis's Replicator, put a Replica Power card into play.

- This Replica is treated as a magic item worth 7 Prestige points at the end of the game.

- Your summoning gauge must be high enough to allow you to put the Replica card into play.

- Replicas in play are unaffected by the Staff of Spring, Arcano-Leeches, Yjang's Forgotten Vase, etc.

- The number of Replica cards is limited. When the Replica stockpile is empty, you may no longer use Eolis's Replicator.

- Replicas are never returned to a player's hand. They are removed from the game instead.

- Replicas may not be summoned or put into play by any means other than Eolis's Replicator or a Raven the Usurper that has mimicked an Eolis's Replicator.]],
    Cost = { Earth = 0, Air = 0, Fire = 0, Water = 1, Crystals = 0 }
}
Cards['Estorian Harp'] = {
    Number = 11,
    Prestige = 8,
    Type = 'Item',
    Effect = 'Activated',
    Game = 'Path of Destiny',
    Description = [[Activate, discard 2 energy tokens of the same type: increase your summoning gauge by 1 and receive 3 crystals.

Notes:
- You may activate the Estorian Harp to receive 3 crystals, even if your summoning gauge is already full (15).]],
    Cost = { Earth = 0, Air = 1, Fire = 0, Water = 0, Crystals = 0 }
}
Cards['Chrono-Ring'] = {
    Number = 12,
    Prestige = 12,
    Type = 'Item',
    Effect = 'Ongoing',
    EndOfRoundEffect = true,
    Game = 'Path of Destiny',
    Description = [[Whenever the Season marker moves forward by 3 or more spaces during a round, receive 4 crystals or 1 energy.

Notes:
- The Chrono-Ring's summoning cost depends on the number of players.

- The effect of the Chrono-Ring stacks with the effect of Temporal Boots when the Season die is used to move the Season marker.

- The Chrono-Ring's effect only triggers when the Season marker moves forward by 3 or more spaces in a single movement.]],
    Cost = { Earth = 1, Air = 0, Fire = 0, Water = 1, Crystals = '2:1:0' }
}
Cards["Arus's Mimicry"] = {
    Number = 13,
    Prestige = 10,
    Type = 'Item',
    Effect = 'Instant',
    Game = 'Path of Destiny',
    Description = 'Discard or sacrifice a Power card: receive 12 crystals.',
    Cost = { Earth = 1, Air = 1, Fire = 0, Water = 1, Crystals = 0 }
}
Cards['Carnivora Strombosea'] = {
    Number = 14,
    Prestige = 12,
    Type = 'Item',
    Effect = 'Ongoing',
    EndOfRoundEffect = true,
    Game = 'Path of Destiny',
    Description = [[At the end of the round, if you have no energy tokens in your reserve, look at the first card in the draw pile and choose an effect:

- Replace it on top of the draw pile.
- Add it to your hand and reduce your summoning gauge by 1.

Notes:
- Decrease your summoning gauge by one only if you decide to add the Power card to your hand.

- Carnivora Strombosea cannot decrease your summoning gauge below the number of Power cards currently summoned and in play. However, this does not protect you, for example, against a Demon of Argos or Argos Hawk that require you to decrease your summoning gauge.

- If you already have the maximum number of Power cards as permitted by your summoning gauge, you may not add the Power card to your hand after looking at it. Instead, place it back on the top of the draw pile.]],
    Cost = { Earth = 1, Air = 1, Fire = 1, Water = 0, Crystals = 0 }
}
Cards['Urmian Psychic Cage'] = {
    Number = 15,
    Prestige = 10,
    Type = 'Item',
    Effect = 'Ongoing',
    Game = 'Path of Destiny',
    Description = [[The Urmian Psychic Cage enters play with a Trap token placed on it. While the token remains on the card, a player summoning or putting into play a Power card must either:

- Discard the Power card without applying its effects.
- Or sacrifice a Power card.
In both cases, the Trap token must be removed.

Notes:
- The effect of the Urmian Psychic Cage also applies to you.

- The Urmian Psychic Cage affects cards as they enter play, in the same way as the Chalice of Eternity, the Potion of Dreams, Eolis's Replicator, the Crystal Orb, etc.

- If a player decides to discard the Power card that they were summoning, they must still pay the card's summoning cost, without applying its effects.

- Instead of discarding the card being summoned, a player may choose to sacrifice another Power card already in play and under their control.

- If the player has no other Power cards in play, they must discard the Power card currently being summoned.

- The Urmian Psychic Cage may sacrifice itself.

- If an Urmian Psychic Cage (with or without a Trap token on it) is returned to a player's hand and subsequently summoned again, a Trap token is placed on it again.]],
    Cost = { Earth = 0, Air = 0, Fire = 0, Water = 0, Crystals = 2 }
}
Cards['Servant of Ragfield'] = {
    Number = 16,
    Prestige = 10,
    Type = 'Familiar',
    Effect = 'Instant',
    Game = 'Path of Destiny',
    Description = [[Each player with at least 10 crystals draws a Power card and either adds it to their hand or discards it and increases their summoning gauge by 1.

Notes:
- A player who has fewer than 10 crystals cannot apply the effects of the Servant of Ragfield.

- Cards are drawn in the turn order, beginning with the player that summoned the Servant of Ragfield.]],
    Cost = { Earth = 0, Air = 1, Fire = 1, Water = 0, Crystals = 0 }
}
Cards['Argosian Tangleweed'] = {
    Number = 17,
    Prestige = 14,
    Type = 'Familiar',
    Effect = 'Instant',
    Effect2 = 'Ongoing',
    Game = 'Path of Destiny',
    Description = "Place a Deadbolt token on an opponent's familiar.",
    Description2 = [[A familiar with a Deadbolt token placed on it has no effect.

Notes:
- Place a Deadbolt token on another player's familiar when the Argosian Tangleweed card enters play. The Deadbolt token cancels all (permanent and/or activatable) effects of the targeted familiar card.

- Remove the Deadbolt token from the targeted familiar if the Argosian Tangleweed card is removed from the play area.

- You may summon Argosian Tangleweed even if your opponents do not have any familiars, although you will not benefit from its effect.]],
    Cost = { Earth = 1, Air = 1, Fire = 0, Water = 0, Crystals = 0 }
}
Cards["Io's Minion"] = {
    Number = 18,
    Prestige = -5,
    Type = 'Familiar',
    Effect = 'Instant',
    Effect2 = 'Ongoing',
    Effect3 = 'Activated',
    Game = 'Path of Destiny',
    Description = 'Receive an air energy and increase your summoning gauge by 1.',
    Description2 = 'You may no longer gain crystals.',
    Description3 = [[Activate, discard an air energy: pass Io's Minion (straightened) to the player on your left.

Notes:
- The player who summons or puts Io's Minion into play benefits from the card's "when entering play" effect, but any players who receive Io's Minion as a result of its activation effect do not.

- You cannot receive crystals by any means while you possess Io's Minion.

- Io's Minion does not cancel the effects of cards such as the Arcano Leech, Figrim the Avaricious or Thieving Fairies: opponents still lose crystals but the owner of Io's Minion does not receive them.

- You may transmute energy tokens while you own Io's Minion, but you will not receive any crystals.

- A player who owns Io's Minion can still lose crystals.]],
    Cost = { Earth = 0, Air = 1, Fire = 0, Water = 0, Crystals = 0 }
}
Cards['Otus the Oracle'] = {
    Number = 19,
    Prestige = 10,
    Type = 'Familiar',
    Effect = 'Instant',
    Game = 'Path of Destiny',
    Description = [[Draw and place one Power card per player in the centre of the play area. During their turn, each player may summon a single one of these cards, after paying the summoning cost.

Notes:
- Draw as many Power cards as there are players and place them in the centre of the play area.

- Each player may only summon one of these Power cards per turn. A player may, however, summon a new Power card in a subsequent turn, if any are still present in the centre of the play area.

- These Power cards are considered to be summoned and are therefore affected by cards such as the Staff of Spring, Arcano-Leech, Yjang's Forgotten Vase or the Hand of Fortune when they are summoned.

- At the end of the game, discard any unsummoned Power cards still in the centre of the play area.

- If Otus the Oracle is removed from the game, also remove the related Power cards from the centre of the play area.]],
    Cost = { Earth = 0, Air = 1, Fire = 0, Water = 1, Crystals = 0 }
}
Cards['Crafty Nightshade'] = {
    Number = 20,
    Prestige = 4,
    Type = 'Familiar',
    Effect = 'Instant',
    Game = 'Path of Destiny',
    Description = [[Add the first two Power cards from the draw pile to your hand: give any Power card from your hand to the opponent with the fewest Power cards in play.

Notes:
- You must give one of your Power cards to the opponent who has the fewest Power cards in play, even if you have fewer Power cards in play than that player.

- The Power card gifted to your opponent does not have to be one of the two Power cards added to your hand as a result of the Malicious Nightshade effect.

- If two or more opponents have the same number of Power cards in play, you may choose which of them receives one of your Power cards.]],
    Cost = { Earth = 0, Air = 0, Fire = 1, Water = 0, Crystals = 0 }
}

-- Promo
Cards['Crystal Titan'] = {
    Number = 0,
    Prestige = 9,
    Type = 'Familiar',
    Effect = 'Activated',
    Effect2 = 'Ongoing',
    Game = 'Promo',
    Description = 'Activate, sacrifice the Crystal Titan, the discard all your Power cards and lose all your crystals: choose and sacrifice a Power card belonging to an opponent.',
    Description2 = 'Whenever an opponent wishes to sacrifice a Power card, they must first give you 3 crystals.',
    Cost = { Earth = 0, Air = 0, Fire = 1, Water = 0, Crystals = '0:3:8' }
}
Cards['Speedwall the Escaped'] = {
    Number = 0,
    Prestige = 7,
    Type = 'Familiar',
    Effect = 'Ongoing',
    Game = 'Promo',
    Description = "Activate, when an opponent draws only one Power card, draw the card instead and then place Speedwall the Escaped in that opponent's hand.",
    Cost = { Earth = 0, Air = 0, Fire = 0, Water = 0, Crystals = 'X' }
}
Cards['Orb of Ragfield'] = {
    Number = 0,
    Prestige = -5,
    Type = 'Item',
    Effect = 'Instant',
    Effect2 = 'Ongoing',
    Game = 'Promo',
    Description = 'Gain 20 crystals.',
    Description2 = 'All Power cards in your hand that are worth less than 12 Prestige points henceforth have a summoning cost of 5 crystals.',
    Cost = { Earth = 1, Air = 1, Fire = 1, Water = 1, Crystals = 0 }
}
Cards['Argos Geek'] = {
    Number = 0,
    Prestige = 8,
    Type = 'Familiar',
    Effect = 'Ongoing',
    Game = 'Promo',
    Description = 'Your opponents have to call you "My Lord" until the end of the game. Every time an opponent forgets this rule, they lose 2 crystals.',
    Cost = { Earth = 0, Air = 0, Fire = 0, Water = 0, Crystals = 0 }
}
Cards['Igramul the Banisher'] = {
    Number = 0,
    Prestige = 7,
    Type = 'Familiar',
    Effect = 'Instant',
    Game = 'Promo',
    Description = [[Name a card: opponents reveal their hands and discard all copies of the named card. If at least one card was discarded, receive the energy present in that card's summoning cost.

Notes:
- You can only receive energy if the named card has been discarded.

- You receive no energy if the card's summoning cost contains only crystals.

- If two copies of the named card are revealed, both cards are discarded.

- If two copies of the named card are revealed, you can claim the energy on the card's summoning cost only once.]],
    Cost = { Earth = 0, Air = 0, Fire = 0, Water = 0, Crystals = 3 }
}

-- ENCHANTMENTS
Cards['Divine Destiny'] = {
    Number = 1,
    Game = 'Path of Destiny',
    Description = [[- Players may use the die of Destiny and receive Destiny points.

- After choosing their Season die, each player may roll the die of Destiny and apply its effects instead of performing the actions shown on their Season die.

- The player with the most Destiny points at the end of the game receives a bonus of 20 Prestige points.]]
}
Cards['Elemental Construction'] = {
    Number = 1,
    Game = 'Enchanted Kingdom',
    Description = [[- Elemental Construction modifies the first step of the Prelude phase.

- With this enchantment in play, each player receives 18 Power cards for the Prelude.

- Each player selects 9 of the 18 Power cards. Players do not pass each other cards as done in a conventional Prelude.

- Return the remaining cards to the draw pile and then shuffle it.

- Each player must sort the 9 selected Power cards into 3 piles of 3 cards as described in the rules for the base game.

- The tournament proceeds as usual.]]
}
Cards['Extended Experience'] = {
    Number = 2,
    Game = 'Enchanted Kingdom',
    Description = [[- The Extended Experience enchantment modifies the Prelude phase.

- During the first step of the Prelude, each player receives 12 Power cards, rather than 9.

- The rest of the first step of the Prelude is as described in the rules for the base game.

- During the second step of the Prelude, each player forms 3 piles of 4 cards, rather than 3 piles of 3 cards.

- The Tournament proceeds as usual.]]
}
Cards["Arus's Cunning Schemes"] = {
    Number = 2,
    Game = 'Path of Destiny',
    Description = [[- Whenever the year changes, each player must pass a Power card from their hand to the player on their left.

- Power cards are passed between players simultaneously.

- If a player has only one Power card in their hand, they must pass it to the player on their left.

- If a player has no Power cards in their hand, they are not required to pass a card to the player on their left but may still receive a Power card from the player on their right.

- The change of year rule is also applied at the end of the game.]]
}
Cards['Natural Selection'] = {
    Number = 3,
    Game = 'Enchanted Kingdom',
    Description = [[- Natural Selection modifies the first step of the Prelude phase.

- During the first step of the Prelude, each player receives 11 Power cards, rather than 9.

- Each player looks at their cards and selects a Power card, but discards it rather than keeping it for their hand.

- The rest of the Prelude proceeds as usual for the next 10 cards.

- At the end of the phase, each player must discard one of their 10 Power cards, leaving 9 cards in their hand.

- The second step of the Prelude proceeds as usual.

- The Tournament proceeds as usual.]]
}
Cards["Io's Mastery"] = {
    Number = 3,
    Game = 'Path of Destiny',
    Description = [[Whenever a player receives 15 or more crystals in a single transmutation operation, that player may look at the top Power card of the draw pile and either add it to their hand or discard it.]]
}
Cards['Entangling Roots'] = {
    Number = 4,
    Game = 'Enchanted Kingdom',
    Description = [[Players may not summon more than one Power card during their turn. This restriction applies exclusively to cards summoned from the player's hand.

- The Divine Chalice and Crystal Orb functions in the normal manner.

- The Potion of Dreams functions in the normal manner.]]
}
Cards["Season' Turn"] = {
    Number = 4,
    Game = 'Path of Destiny',
    Description = [[- At the end of the round, if a player's energy reserve contains all four types of energy (water, earth, fire and wind), the player gains 4 crystals.

- The rule for resolving end-of-round effects applies: End-of-round effects are resolved in turn order. Each player applies all their end-of-round effects in the order of their choice.]]
}
Cards['Into the Void'] = {
    Number = 5,
    Game = 'Path of Destiny',
    Description = [[- Whenever the year changes, each player must sacrifice a Power card.

- When the year changes from the first to the second year, the effect does not apply to players who have at least 15 crystals.

- When the year changes from the second to the third year, the effect does not apply to players who have at least 30 crystals.

- When the year changes for the final time, the effect does not apply to players who have at least 50 crystals.

- The effect of the Into the Void enchantment does not apply to any an additional changes of year, caused by Temporal Boots, for example.]]
}
Cards['Nature Spirit'] = {
    Number = 5,
    Game = 'Enchanted Kingdom',
    Description = [[The summoning cost of all Power cards (magic items and familiars) is increased by one energy token of the player's choice. This additional energy cost must be paid when the Power card is summoned.

- The extra energy cost applies exclusively to Power cards summoned from a player's hand.

- An energy token must also be paid when summoning Power cards that normally cost only crystals to summon.

- Power cards that normally do not have a summoning cost now require an energy token to be paid when summoned.

- The effect of the Hand of Fortune may be applied to the additional energy cost.]]
}
Cards["Argos' Embrace"] = {
    Number = 6,
    Game = 'Enchanted Kingdom',
    Description = [[- Whenever a player collects and keeps one or more Power cards in their hand (either by drawing a card, taking back a card currently in play or as the result of an effect applied by another Power card), they must move their sorcerer token back 5 spaces on the crystal track. A player who does not have enough crystals to pay the required cost must sacrifice or discard one of their Power cards.

- A player having only 4 crystals or fewer is considered to be unable to pay the cost, and must therefore sacrifice or discard a Power card.

- A player who does not have enough crystals, has no summoned Power cards and has no cards in their hand apart from the one just collected must discard that card.

- Cards collected when the year changes do not cause players to lose crystals or power cards.

- For example, if a player summons an Amulet of Fire, 4 Power cards are drawn. Note that the player only loses 5 crystals or sacrifices a single Power card, as a result of this enchantment, because they only actually collect one Power card.]]
}
Cards['Force of Destiny'] = {
    Number = 6,
    Game = 'Path of Destiny',
    Description = [[- Players may use the die of Destiny and receive Destiny points.

- After choosing their Season die, each player may roll the die of Destiny and apply its effects instead of performing the actions shown on their Season die.

- Players receive 3 additional crystals whenever tehy roll the die of Destiny.

- The player with the most Destiny points at the end of the game receives a bonus 20 Prestige points.]]
}
Cards["Io's Bounty"] = {
    Number = 7,
    Game = 'Enchanted Kingdom',
    Description = [[- Throughout the game, whenever a player transmutes an energy token, they may move their sorcerer token forward one space on the crystal track. This is in addition to the crystals obtained by the transmutation process.

- Io's Bounty may apply cumulatively with the effect of the Purse of Io or the transmutation bonus.]]
}
Cards['Fertile Grave'] = {
    Number = 7,
    Game = 'Path of Destiny',
    Description = [[- Once per game, each player may look at the Power cards in the discard pile during their turn. Subject to the usual requirements, the player may then choose to summon one of the Power cards as if it were in their hand. The player must still pay the summoning cost and satisfy the summoning gauge requirement.

- The Power card is treated as summoned, and may therefore be affected by the Staff of Spring, Arcano-Leeches, Yjang's Forgotten Vase, etc.]]
}
Cards['Tailwind'] = {
    Number = 8,
    Game = 'Path of Destiny',
    Description = [[- At the end of the round, each player may discard one air energy token from their reserve and move their Sorcerer token forward 4 spaces on the crystal track.

- The rule for resolving end-of-round effects applies: End-of-round effects are resolved in turn order. Each player applies all their end-of-round effects in the order of their choice.]]
}
Cards["Olaf's Knowledge"] = {
    Number = 8,
    Game = 'Enchanted Kingdom',
    Description = [[- In addition to the four existing bonus options, each player may now choose a fifth bonus: "Draw a Power card".

- To use the bonus, the player moves their sorcerer token forward one space on the bonus track.

- A player who uses this bonus may immediately discard the drawn card if they do not want to keep it.

- Players may still use a maximum of 3 bonuses during the game.]]
}
Cards['Drought'] = {
    Number = 9,
    Game = 'Enchanted Kingdom',
    Description = [[- Whenever the season token reaches summer (by moving from space 6 to space 7 on the season wheel), the player whose sorcerer token is highest on the crystal track must either sacrifice one of their Power cards or else decrease their energy reserve by one.

- This effect can only occur once per year.

- A player who decides to decrease their energy reserve permanently places a decreased energy reserve token in their reserve.

- A player who does not have any Power cards to sacrifice must decrease their energy reserve by one.

- If two or more players share the lead on the crystal track, the Drought effect does not apply.]]
}
Cards['Natural Balance'] = {
    Number = 9,
    Game = 'Path of Destiny',
    Description = [[- Each type of energy yields two crystals when transmuted, in all seasons. The energy/crystal ratios shown on the season wheel no longer apply.

Example: Paul decides to transmute 1 water energy token, 1 fire energy token and 1 earth energy token in winter. With the Natural Balance effect, he receives 6 crystals.

- The effects of Io's Purse and any transmutation bonuses still apply, and may be stacked.

- The effects of the Balance of Ishtar, the Potion of Life and the Potion of the Ancients function in the normal way.]]
}
Cards['Vision of Destiny'] = {
    Number = 10,
    Game = 'Enchanted Kingdom',
    Description = [[- The top two Power cards in the draw pile are systematically revealed and placed face-up in a row next to the draw pile.

- The card farthest from the draw pile is considered to be the top card in the pile, and the other visible card is deemed to be the second card in the pile.

- During their turn, after performing the actions indicated by their season die, a player may choose to move their sorcerer token back 5 spaces on the crystal track in order to move the top card in the pile (the face-up card farthest from the pile) to the discard pile.

- A player with fewer than 5 crystals cannot use the Vision of Destiny effect.

- This action may not be performed more than once during a player's turn.]]
}
Cards['Crossed Paths'] = {
    Number = 10,
    Game = 'Path of Destiny',
    Description = [[- Crossed Paths modifies the Prelude.

- With this enchantment in play, each player receives nine Power cards for the Prelude. However, the first card selected by each player is not kept for their own deck, but is passed to the player on their left instead. This card will be the first card in each player's new hand of Power cards.

- The rest of the Prelude is unchanged. Cards are selected as described in the rules for the base game.

- The Tournament is played in the normal way.]]
}