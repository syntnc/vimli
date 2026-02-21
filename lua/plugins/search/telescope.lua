return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  cond = function()
    return vim.g.picker == "telescope"
  end,
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      cond = function()
        return vim.fn.executable("make") == 1
      end,
    },
    { "nvim-telescope/telescope-ui-select.nvim" },
    { "nvim-mini/mini.icons", enabled = vim.g.icons_enabled },
  },
  config = function()
    local actions = require("telescope.actions")
    require("telescope").setup({
      defaults = {
        path_display = { "filename_first" },
      },
      pickers = {
        buffers = {
          mappings = {
            i = { ["<c-d>"] = actions.delete_buffer },
            n = { ["<c-d>"] = actions.delete_buffer },
          },
        },
        find_files = {
          find_command = {
            "rg",
            "--files",
            "--follow",
            "--hidden",
            "--ignore-case",
            "--glob",
            "!{.git, node_modules}",
          },
          previewer = false,
          theme = "dropdown",
        },
        diagnostics = {
          layout_strategy = "vertical",
          layout_config = {
            prompt_position = "top",
            preview_cutoff = 0,
            preview_height = 0.4,
          },
          sorting_strategy = "ascending",
        },
        git_files = {
          previewer = false,
          theme = "dropdown",
        },
        lsp_references = {
          layout_strategy = "vertical",
          layout_config = {
            prompt_position = "top",
            preview_cutoff = 0,
            preview_height = 0.4,
          },
          sorting_strategy = "ascending",
        },
        oldfiles = {
          previewer = false,
          theme = "dropdown",
        },
      },
      extensions = {
        ["ui-select"] = {
          require("telescope.themes").get_dropdown(),
        },
      },
    })
    -- Enable Telescope extensions if they are installed
    pcall(require("telescope").load_extension, "fzf")
    pcall(require("telescope").load_extension, "ui-select")

    local builtin = require("telescope.builtin")
    local map = vim.keymap.set
    map("n", "<leader>fh", builtin.help_tags, { desc = "[H]elp" })
    map("n", "<leader>fk", builtin.keymaps, { desc = "[K]eymaps" })
    map("n", "<leader>ff", builtin.find_files, { desc = "[F]iles" })
    map("n", "<leader>fF", builtin.find_files, { desc = "[F]iles in cwd" })
    map("n", "<leader>fs", builtin.builtin, { desc = "[S]elect Telescope" })
    map("n", "<leader>fg", builtin.live_grep, { desc = "[G]rep" })
    map("n", "<leader>fd", builtin.diagnostics, { desc = "[D]iagnostics" })
    map("n", "<leader>fR", builtin.resume, { desc = "[R]esume" })
    map("n", "<leader>fo", builtin.oldfiles, { desc = "[O]ld files" })
    map("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Existing buffers" })
    -- Custom pickers
    map("n", "<leader>fw", function()
      builtin.grep_string({ search = vim.fn.expand("<cword>") })
    end, { desc = "Current [w]ord" })
    map("n", "<leader>fW", function()
      builtin.grep_string({ search = vim.fn.expand("<cWORD>") })
    end, { desc = "Current [W]ORD" })
    map("n", "<leader>f/", function()
      builtin.live_grep({ grep_open_files = true, prompt_title = "Live Grep in Open Files" })
    end, { desc = "[/] in Open Files" })
    map("n", "<leader>fC", function()
      builtin.find_files({ cwd = vim.fn.stdpath("config"), prompt_title = "Find Neovim config files" })
    end, { desc = "Neovim [C]onfig files" })
  end,
}

-- telescope.setup {
--
-- local function is_git_repo()
--   vim.fn.system "git rev-parse --is-inside-work-tree"
--   return vim.v.shell_error == 0
-- end
--
-- local function get_git_root()
--   local dot_git_path = vim.fn.finddir(".git", ".;")
--   return vim.fn.fnamemodify(dot_git_path, ":h")
-- end
--
-- local function project_files()
--   if is_git_repo() then
--     builtin.find_files { cwd = get_git_root() }
--   else
--     builtin.find_files()
--   end
-- end
--
-- local function project_grep()
--   if is_git_repo() then
--     builtin.live_grep { cwd = get_git_root() }
--   else
--     builtin.live_grep()
--   end
-- end
--
-- local map = vim.keymap.set
--
-- map("n", "<leader>ff", function()
--   project_files()
-- end, { desc = "[f]ind: [f]iles" })
-- map("n", "<leader>fg", builtin.git_files, { desc = "[f]ind: [g]it files" })
-- map("n", "<leader>fk", builtin.keymaps, { desc = "[f]ind: [k]eymaps" })
-- map("n", "<leader>fs", function()
--   project_grep()
-- end, { desc = "[f]ind: [s]string" })
--
