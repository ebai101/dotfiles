-----------------------------------------------
-- Hyper Google Search
-- G: Open Tab in Browser for Search
-----------------------------------------------

local googleChooser = hs.chooser.new(function(term)
    hs.task.new('/usr/bin/open', nil, {'https://www.google.com/search?q=' .. term.text}):start()
end):bgDark(true):choices({})

googleChooser:queryChangedCallback(function()
    if not(googleChooser:query() == '') then
        local queryURL = 'http://suggestqueries.google.com/complete/search?client=chrome&q=' .. hs.http.encodeForQuery(googleChooser:query())
        hs.http.asyncGet(queryURL, nil, function(status, body, headers)
            if status == 200 then
                local options = {}
                local suggestions = hs.json.decode(body)
                table.insert(options, { ['text'] = suggestions[1] })
                for i=1, #suggestions[2] do
                    table.insert(options, { ['text'] = suggestions[2][i] })
                end
                googleChooser:choices(options)
            else
                print(status .. ': ' .. body)
            end
        end)
    else
        googleChooser:choices({})
    end
end)

hs.hotkey.bind(hyper, 'g', function()
    local brave = hs.application.open('Brave Browser', 5, true)
    brave:selectMenuItem({'File', 'New Tab'})
    -- googleChooser:choices({})
    -- googleChooser:show()
end)
