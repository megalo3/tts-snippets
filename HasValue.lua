-- {tab, val}
function has_value(input)
    for index, value in ipairs(input[1]) do
        if value == input[2] then
            return true
        end
    end
    return false
end