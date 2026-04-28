return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- use latest release, remove to use latest commit
  keys = {
    { "<leader>od", ":Obsidian dailies<cr>", desc = "obsidian [d]ailies" },
    { "<leader>ot", ":Obsidian tags<cr>", desc = "obsidian [t]ags" },
    { "<leader>oi", ":e ~/vaults/personal/00 Inbox/inbox.md<cr>", desc = "obsidian [i]nbox" },
    { "<leader>ol", ":Obsidian link<cr>", desc = "obsidian [l]ink selection" },
    { "<leader>of", ":Obsidian follow_link<cr>", desc = "obsidian [f]ollow link" },
    {
      "<leader>onp",
      function()
        local title = vim.fn.input("Project: ")
        if title ~= "" then
          vim.cmd("Obsidian new_from_template 01 Projects/" .. title .. " template-project")
        end
      end,
      desc = "obsidian [n]ew project from template",
    },
    {
      "<leader>ona",
      function()
        local title = vim.fn.input("Area: ")
        if title ~= "" then
          vim.cmd("Obsidian new_from_template 02 Areas/" .. title .. " template-area")
        end
      end,
      desc = "obsidian [n]ew area from template",
    },
    {
      "<leader>onr",
      function()
        local title = vim.fn.input("Resource: ")
        if title ~= "" then
          vim.cmd("Obsidian new_from_template 03 Resources/" .. title .. " template-resource")
        end
      end,
      desc = "obsidian [n]ew resource from template",
    },
    { "<leader>os", ":Obsidian search<cr>", desc = "obsidian [s]earch" },
    { "<leader>oo", ":Obsidian quick_switch<cr>", desc = "obsidian [o]pen quickswitch" },
    { "<leader>oO", ":Obsidian open<cr>", desc = "obsidian [O]pen in app" },
  },
  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    legacy_commands = false, -- this will be removed in 4.0.0
    footer = {
      enabled = false,
    },
    ui = {
      enable = false, -- using render-markdown.nvim instead
    },
    workspaces = {
      {
        name = "personal",
        path = "~/vaults/personal",
      },
    },
    daily_notes = {
      -- Optional, if you keep daily notes in a separate directory.
      folder = "05 Dailies",
      -- Optional, if you want to change the date format for the ID of daily notes.
      date_format = "%Y-%m-%d %A",
      -- Optional, if you want to change the date format of the default alias of daily notes.
      alias_format = "%B %-d, %Y",
      -- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
      template = "template-daily",
      workdays_only = false,
    },
    templates = {
      subdir = "06 Templates",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M:%S",
      -- A map for custom variables, the key should be the variable and the value a function
      substitutions = {},
    },
    callbacks = {
      pre_write_note = function(note)
        -- This is called before a note is written to disk, you can use it to modify the note object.
        -- For example, you could add a custom variable to the note like this:
        -- note.custom_variable = "This is a custom variable"
        note:add_field("updated", os.date("%Y-%m-%d %H:%M:%S"))
        note:update_frontmatter()
      end,
    },
    note_id_func = function(title)
      -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
      -- In this case a note with the title 'My new note' will be given an ID that looks
      -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
      local suffix = ""
      if title ~= nil then
        -- If title is given, transform it into valid file name.
        suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
      else
        -- If title is nil, just add 4 random uppercase letters to the suffix.
        for _ = 1, 4 do
          suffix = suffix .. string.char(math.random(65, 90))
        end
      end
      return tostring(os.time()) .. "-" .. suffix
    end,
  },
}
