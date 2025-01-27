-- {tab, val}
function has_value(tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end

function has_any_value(tab, values)
    for _, value in ipairs(values) do
        if has_value({tab, value}) then
            return true
        end
    end
    return false
end