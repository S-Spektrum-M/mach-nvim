local function ollama_pick_model(callback)
    -- Run the command synchronously ( < 100 ms for a local list )
    local ok, lines = pcall(vim.fn.systemlist, { "ollama", "ls" })
    if not ok or vim.v.shell_error ~= 0 then
        vim.notify("Failed to run `ollama ls` – is Ollama on $PATH?",
            vim.log.levels.ERROR)
        callback(nil)
        return
    end

    -- Skip the header line and grab the first whitespace‑delimited field
    local models = {}
    for i = 2, #lines do
        local name = lines[i]:match("^(%S+)")
        if name and name ~= "" then
            table.insert(models, name)
        end
    end

    if vim.tbl_isempty(models) then
        vim.notify("No models found (ollama ls was empty)", vim.log.levels.WARN)
        callback(nil)
        return
    end

    -- Pick the model asynchronously and pass the result to the callback
    vim.ui.select(models, { prompt = "Select an Ollama model" }, function(choice)
        callback(choice)
    end)
end

return function()
    --  | | "cohere" | "copilot" | "bedrock" | "ollama"
    vim.ui.select(
        { "claude", "openai", "azure", "gemini", "vertex", "cohere", "copilot", "bedrock", "ollama", },
        { prompt = "Select a model provider: ", },
        function(choice)
            local filename = vim.fn.expand('~/.config/nvim/lua/mach/user-plugin-opts.lua')
            local file = assert(io.open(filename, "a")) -- "a" = append (text)
            local model = ""
            if choice == "claude" then
                vim.notify(choice .. " support is eventually planned but not currently supported.", vim.log.levels.ERROR)
                return
            elseif choice == "openai" then
                model = 'o3-mini' -- TODO: ui select for different supported openai models
            elseif choice == "azure" then
                vim.notify(choice .. " support is eventually planned but not currently supported.", vim.log.levels.ERROR)
                return
            elseif choice == "gemini" then
                vim.notify(choice .. " support is eventually planned but not currently supported.", vim.log.levels.ERROR)
                return
            elseif choice == "vertex" then
                vim.notify(choice .. " support is eventually planned but not currently supported.", vim.log.levels.ERROR)
                return
            elseif choice == "cohere" then
                vim.notify(choice .. " support is eventually planned but not currently supported.", vim.log.levels.ERROR)
                return
            elseif choice == "copilot" then
                vim.notify(choice .. " support is eventually planned but not currently supported.", vim.log.levels.ERROR)
                return
            elseif choice == "bedrock" then
                vim.notify(choice .. " support is eventually planned but not currently supported.", vim.log.levels.ERROR)
                return
            elseif choice == "ollama" then
                ollama_pick_model(function(selected_model)
                    if not selected_model then
                        vim.notify("No model selected from Ollama.", vim.log.levels.WARN)
                        return
                    end
                    file:write(('vim.mach_opts.avante.provider = "%s"\n'):format(choice))
                    file:write(('vim.mach_opts.avante.%s.model = "%s"\n'):format(choice, selected_model))
                    file:close()
                end)
                return
            else
                vim.notify("Invalid choice", vim.log.levels.WARN)
                return
            end
            file:write(('vim.mach_opts.avante.provider = "%s"\n'):format(choice))
            file:write(('vim.mach_opts.avante.%s.model = "%s"\n'):format(choice, model))
            file:close()
        end
    )
end
