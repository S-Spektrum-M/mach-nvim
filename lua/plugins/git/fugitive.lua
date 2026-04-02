local git_st = require('mach.features.git_status')

return {
    'tpope/vim-fugitive',
    keys = {
        { '<leader>gc', ':Git commit',    desc = 'commit' },
        { '<leader>gC', '<cmd>Git commit % --amend<CR>',    desc = 'ammend current file to commit' },
        { '<leader>gn', '<cmd>Git commit % --amend --no-edit<CR>',    desc = 'ammend current file to commit; no-edits' },

        { '<leader>ga', '<cmd>Git add %<CR>', desc = 'add current file to commit', },
        { '<leader>gA', '<cmd>Git restore --stage %<CR>', desc = 'remove current file from commit', },

        { '<leader>gp', ':Git push origin', desc = 'push commits to origin' },
        { '<leader>gP', ':Git pull origin', desc = 'pull from origin' },

        --- from lua/plugins/ui/snacks.lua:28:5
        --[[ {
            "<Leader>gl",
            function() Snacks.picker.git_log() end,
            desc = "Git Commits Log"
        }, ]]


        {
            '<leader>gL',
            '<cmd>Git log --graph --date=relative --pretty=tformat:\'%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%an %ad)%Creset\'<CR>',
            desc = 'display log'
        },

        { '<leader>gs', git_st,             desc = 'Git status picker' },
        {
            '<leader>gS',
            '<cmd>Git status<CR>',
            desc = 'display git status'
        },
    }
}

