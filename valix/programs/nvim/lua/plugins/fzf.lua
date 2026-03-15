vim.keymap.set("n", "<leader>ff", function() require("fzf-lua").files() end, {})
vim.keymap.set("n", "<leader>fw", function() require("fzf-lua").grep() end, {})
