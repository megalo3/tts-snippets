

--Clicker Roller Universal      by: MrStump
setting = {print={}} --Don't edit this line

--To change the die that this tool rolls, right click it and hit reset
--Then drop the die you want onto the tool (it is an infinite bag)
--Die must have rotation values! (from the Gizmo Tool)

--Edit the below variables to modify the functionality of this device

--Disables the button, places indicator of roll locations (true or false)
setting.setup = false
--How far from the center of the device the dice are spawned
setting.radius = 2
--How wide of an arch the dice are placed on, in degrees (1-360)
setting.arc = 120
--Where center of the arc is around the tool is placed (0=bottom, 180=top)
setting.rotation = 180
--Height above tool die is spawned
setting.height = 1.5
--Scaling factor for die being spawned (1 is normal, 0.5 is 1/2 size, 2 is 2x)
setting.scale = 1.5

--Maximum dice that can be spawned by this tool (-1 is infinite)
setting.maxCount = 2
--Delay (seconds) after a click that the roll is done (0.5 or more)
setting.rollDelay = 1.0
--Time before dice are cleaned up (0 is instant, -1 won't clean them)
setting.cleanupDelay = 120

--If it dyes the die the color of the player clicking (true or false)
setting.colorDie = true

--Turn on/off printing of the player who rolled (true or false)
setting.print.player = true
--Turn on/off printing of individual results
setting.print.individual = true
--Turn on/off printing of "total" results (adding them together)
setting.print.total = true
--Use player color when printing roll results:
setting.print.playerColor = true

spawnedDice = {}

function spawnDie(color)
    local diceRoller = getObjectFromGUID(Guids.DiceRoller)
    --Find dice positions, moving previously spawned dice if needed
    for i, die in ipairs(spawnedDice) do
        local pos_local = getLocalPointOnArc(i, #spawnedDice+1)
        local pos = diceRoller.positionToWorld(pos_local)
        die.setPositionSmooth(pos)
    end

    --Spawns dice
    local pos_local = getLocalPointOnArc(#spawnedDice+1, #spawnedDice+1)
    local spawnedDie = diceRoller.takeObject({
        position = diceRoller.positionToWorld(pos_local),
        rotation = randomRotation(),
    })
    --Setup die that was just spawned
    spawnedDie.setScale({setting.scale,setting.scale,setting.scale})
    spawnedDie.setLock(true)
    if setting.colorDie == true then
        spawnedDie.setColorTint(stringColorToRGB(color))
    end
    --This line stops the die from re-entering the bag
    spawnedDie.script_state = " "

    rollTimerUpdate({color=color})

    --Update data
    table.insert(spawnedDice, spawnedDie)
end

function rollPilot()
    local die = getObjectFromGUID('7a3f02')
    if (die == nil) then return end
    die.randomize() -- Roll a die

    Wait.condition(
        function() -- Executed after our condition is met
            if die.isDestroyed() then
                print("Die was destroyed before it came to rest.")
            else
                if (die.getRotationValue() == 1) then
                    supplyPilotToken()
                end
            end
        end,

        function() -- Condition function
            return die.isDestroyed() or die.resting
        end
    )
end

function rollWorldEater()
    local die = getObjectFromGUID('0ccf00')
    if (die == nil) then return end
    die.randomize() -- Roll a die
end

--Spawn dice for rolling
function click_roll(_, color)
    --Dice spam protection check
    local denyRoll = false
    if setting.maxCount > 0 and #spawnedDice >= setting.maxCount then
        denyRoll = true
    end

    if rollInProgress==nil and denyRoll==false  then
        rollPilot()
        rollWorldEater()
        rollShyPlutoniumDice()
        spawnDie(color)
        spawnDie(color)

    elseif rollInProgress == false then
        --If after roll but before cleanup
        cleanupDice()
        click_roll(_, color)
    else
        --If button click is denied due to roll (or 2 many dice)
        Player[color].broadcast("Roll in progress.", {0.8, 0.2, 0.2})
    end
end

function rollTimerUpdate(param)
    --Timer starting
    Timer.destroy("clickRoller_"..Guids.DiceRoller)
    Timer.create({
        identifier="clickRoller_"..Guids.DiceRoller, delay=setting.rollDelay,
        function_name="timer_rollDice", function_owner=Global,
        parameters = param
    })
end

--Rolls all the dice and then launches monitoring
function timer_rollDice(p)
    rollInProgress = true
    function coroutine_rollDice()
        for _, die in ipairs(spawnedDice) do
            die.setLock(false)
            die.randomize()
            wait(0.1)
        end

        monitorDice(p.color)

        return 1
    end
    startLuaCoroutine(Global, "coroutine_rollDice")
end

--Monitors dice to come to rest
function monitorDice(color)
    function coroutine_monitorDice()
        repeat
            local allRest = true
            for _, die in ipairs(spawnedDice) do
                if die ~= nil and die.resting == false then
                    allRest = false
                end
            end
            coroutine.yield(0)
        until allRest == true

        --If roll is complete and no further waiting is required
        if setting.print.individual==true or setting.print.total==true then
            displayResults(color)
        end
        finalizeRoll({color=color})

        return 1
    end
    startLuaCoroutine(Global, "coroutine_monitorDice")
end

function finalizeRoll(p)
    local color = p.color
    rollInProgress = false --Used for button lockout

    --Auto die removal
    if setting.cleanupDelay > -1 then
        --Timer starting
        Timer.destroy("clickRoller_cleanup_"..Guids.DiceRoller)
        Timer.create({
            identifier="clickRoller_cleanup_"..Guids.DiceRoller,
            function_name="cleanupDice", function_owner=Global,
            delay=setting.cleanupDelay,
        })
    end
end

--Removes the dice
function cleanupDice()
    for _, die in ipairs(spawnedDice) do
        if die ~= nil then
            destroyObject(die)
        end
    end

    rollInProgress = nil
    spawnedDice = {}

    Timer.destroy("clickRoller_cleanup_"..Guids.DiceRoller)
end

function displayResults(color)
    local s, valueTable = "", {}

    --Player name
    if setting.print.player == true then
        s = Player[color].steam_name
        if setting.print.individual==true or setting.print.total==true then
            s = s .. "    " .. string.char(9679) .. "    "
        end
    end

    --Assemble values into table and order
    if setting.print.individual==true or setting.print.total==true then
        --Get values in table
        for _, die in ipairs(spawnedDice) do
            if die ~= nil then
                table.insert(valueTable, tostring(die.getRotationValue()))
            end
        end
        --Order them
        alphanumsort(valueTable)
    end

    --Individual values
    if setting.print.individual == true then
        --Add values to string
        for i, value in ipairs(valueTable) do
            s = s .. value
            if i < #valueTable then
                s = s .. ", "
            end
        end
        if setting.print.total==true then
            s = s .. "    " .. string.char(9679) .. "    "
        end
    end

    --Total (will be void if there are no numbers)
    if setting.print.total == true then
        local total, hadNumber = 0, false
        for _, value in ipairs(valueTable) do
            if tonumber(value) ~= nil then
                total = total + tonumber(value)
                hadNumber = true
            end
        end
        if hadNumber == true then
            s = s .. tostring(total)
        else
            s = s .. "---"
        end
    end

    --Establish color
    local stringColor = {1,1,1}
    if setting.print.playerColor == true then
        stringColor = stringColorToRGB(color)
    end
    --Broadcast result
    broadcastToAll(s, stringColor)
end

--Finds a local point an an arc, given which point and the total # of points
function getLocalPointOnArc(i, points)
    --This evens it out
    i = i - 0.5
    --What the length of arc this points at (how far along an arc)
    local angle = setting.arc/(points)
    --How much to rotate the angle around the tool
    local offset = -setting.arc/2 + setting.rotation
    --Converting those 2 elements into a local position
    local x = math.sin( math.rad(angle*i+offset) ) * setting.radius
    local y = setting.height
    local z = math.cos( math.rad(angle*i+offset) ) * setting.radius
    return {x=x,y=y,z=z}
end

--Gets a random rotation vector
function randomRotation()
    --Credit for this function goes to Revinor (forums)
    --Get 3 random numbers
    local u1 = math.random();
    local u2 = math.random();
    local u3 = math.random();
    --Convert them into quats to avoid gimbal lock
    local u1sqrt = math.sqrt(u1);
    local u1m1sqrt = math.sqrt(1-u1);
    local qx = u1m1sqrt *math.sin(2*math.pi*u2);
    local qy = u1m1sqrt *math.cos(2*math.pi*u2);
    local qz = u1sqrt *math.sin(2*math.pi*u3);
    local qw = u1sqrt *math.cos(2*math.pi*u3);
    --Apply rotation
    local ysqr = qy * qy;
    local t0 = -2.0 * (ysqr + qz * qz) + 1.0;
    local t1 = 2.0 * (qx * qy - qw * qz);
    local t2 = -2.0 * (qx * qz + qw * qy);
    local t3 = 2.0 * (qy * qz - qw * qx);
    local t4 = -2.0 * (qx * qx + ysqr) + 1.0;
    --Correct
    if t2 > 1.0 then t2 = 1.0 end
    if t2 < -1.0 then ts = -1.0 end
    --Convert back to X/Y/Z
    local xr = math.asin(t2);
    local yr = math.atan2(t3, t4);
    local zr = math.atan2(t1, t0);

    return {math.deg(xr),math.deg(yr),math.deg(zr)}
end

--Coroutine delay, in seconds
function wait(time)
    local start = os.time()
    repeat coroutine.yield(0) until os.time() > start + time
end

--Sorts numbers/strings alphabeticall (does not handle decimals or leading 0s)
function alphanumsort(o)
    local function padnum(d) return ("%03d%s"):format(#d, d) end
    table.sort(o, function(a,b)
    return tostring(a):gsub("%d+",padnum) < tostring(b):gsub("%d+",padnum) end)
    return o
end

-- Roll dice in auto-roll zones
function rollShyPlutoniumDice()
    -- 2 to 3 player games, every player rolls every turn
    -- 4+ player games, do not roll if active player
    local players = {}
    local seatedPlayers = getSeatedPlayers()
    for key, color in ipairs(seatedPlayers) do
        -- If 4+ players, remove the active player from the shy plutonium roll
        if (#seatedPlayers < 4 or color ~= Turns.turn_color) then
            table.insert(players, color)
        end
    end

    for key, color in ipairs(players) do
        if (isPlayerColor(color) == true) then

            local zone = getObjectFromGUID(Guids.Zones.AutoRoll[color])
            local diceValues = {
                charge = 0,
                credits = 0,
                income = 0,
                ship = 0
            }
            diceValues['bonus roll'] = 0
            diceValues['victory points'] = 0
            local dice = zone.getObjects()
            local filteredDice = {}
            for _, die in ipairs(dice) do
                if ((die.hasTag('pluto') or die.hasTag('proxima')) and die.tag == 'Dice') then
                    table.insert(filteredDice, die)
                    die.roll()
                end
            end

            monitorShyPlutoniumDice(color, filteredDice)
        end
    end
end

--Monitors dice to come to rest
function monitorShyPlutoniumDice(color, dice)
    function coroutine_monitorShyPlutoniumDice()
        repeat
            local allRest = true
            for _, die in ipairs(dice) do
                if die ~= nil and die.resting == false then
                    allRest = false
                end
            end
            coroutine.yield(0)
        until allRest == true

        local diceValues = sumDiceValues(dice)
        local message = '';
        for key, value in pairs(diceValues) do
            if (message ~= '') then message = message .. ', ' end
            message = message .. value .. ' ' .. key
        end

        if (message ~= '') then
            printToAll(color .. ' player: ' .. message, stringColorToRGB(color))
        end
        return 1
    end
    startLuaCoroutine(Global, "coroutine_monitorShyPlutoniumDice")
end

function sumDiceValues(dice)
    local diceValues = {}
    for _, die in ipairs(dice) do
        -- Only dice have a rotation value
        if (die.tag == 'Dice') then
            local rotationValue = die.getRotationValue()
            -- Don't show any values that are 0
            if (tonumber(rotationValue) > 0) then
                -- Don't count "pluto" as a tag
                for _, tag in ipairs(die.getTags()) do
                    if (tag ~= 'pluto' and tag ~= 'proxima') then
                        -- If this tag hasn't be set, it needs to be defaulted to 0
                        if (diceValues[tag] == nil) then diceValues[tag] = 0 end
                        diceValues[tag] = diceValues[tag] + die.getRotationValue()
                    end
                end
            end
        end
    end
    return diceValues;
end