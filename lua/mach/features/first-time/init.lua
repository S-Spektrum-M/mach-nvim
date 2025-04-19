local setup_wizard = require("mach.features.first-time.wizard")

-- 2. Define the marker file details
local marker_filename = "mach-first-time"
local state_dir = vim.fn.stdpath("state")                           -- Gets ~/.local/state/nvim (or platform equivalent)
local marker_filepath = vim.fs.joinpath(state_dir, marker_filename) -- Safely join paths

-- 3. Check for the marker file's existence
-- vim.fn.filereadable returns 1 if file exists and is readable, 0 otherwise.
if vim.fn.filereadable(marker_filepath) == 0 then
    -- Marker file does NOT exist - run first-time setup

    vim.defer_fn( -- defer so that snacks can start
        function()
            vim.notify("First-time marker file not found at: " .. marker_filepath, vim.log.levels.INFO,
                { title = "Neovim Setup" })
            vim.notify("Running first-time  setup..." .. marker_filepath, vim.log.levels.INFO, { title = "Neovim Setup" })
            -- Ensure the state directory exists before creating the file
            -- The "p" flag creates parent directories if needed, doesn't error if it exists
            vim.fn.mkdir(state_dir, "p")

            local success = vim.fn.writefile({}, marker_filepath)

            if success == 0 then
                print("Successfully created marker file: " .. marker_filepath)
                -- Call your setup function *after* successfully creating the marker
                setup_wizard() -- wait for snacks notify to load
            else
                -- Failed to create the marker file (e.g., permissions issue)
                vim.notify(
                    "Error: Could not create the first-time marker file: " ..
                    marker_filepath .. "\nSetup wizard may run again on next start.",
                    vim.log.levels.ERROR,
                    { title = "Neovim Setup Error" }
                )
                -- Decide if you still want to run the wizard even if the marker failed.
                -- Running it might be okay, but it will likely run again next time.
                print("WARNING: Failed to create marker file, but running setup wizard anyway.")
                setup_wizard()
            end
        end, 300
    )
else
    -- do nothing
end
