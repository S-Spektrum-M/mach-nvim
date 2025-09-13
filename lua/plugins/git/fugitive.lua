local git_st = require('mach.features.git_status')

return {
    'tpope/vim-fugitive',
    keys = {
        { '<leader>gac', ':Git commit % --amend',    desc = 'commit current file' },
        { '<leader>gc', ':Git commit %',    desc = 'commit current file' },
        { '<leader>gs', git_st,             desc = 'Git status picker' },
        { '<leader>gp', ':Git push origin', desc = 'push commits to origin' },
        { '<leader>gP', ':Git pull origin', desc = 'push from origin' },
        {
            '<leader>gL',
            '<cmd>Git log --graph --date=relative --pretty=tformat:\'%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%an %ad)%Creset\'<CR>',
            desc = 'display log'
        },
        {
            '<leader>gS',
            '<cmd>Git status<CR>',
            desc = 'display git status'
        },
    }
}

