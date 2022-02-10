local ls = require("luasnip")

ls.config.set_config {
  -- You can remember last snippet location, so we could jump back with C-j/k
  -- even when outside the snippet
  history = true,
  -- if we have dynamic snippets setup, updates all placeholders at once
  updateevents = "TextChanged,TextChangedI",
  -- enable_autosnippets = true,
}

-- Expansion keymaps
vim.keymap.set({"i","s"}, "<C-k>", function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, { silent = true})

vim.keymap.set({"i","s"}, "<C-j>", function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true})

-- For several choice 'nodes' use this to cycle through them
vim.keymap.set("i", "<C-l>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end)

-- $TM_FILES => expands to filename
-- $0 => position to end in
ls.snippets = {
  all = {
    -- Available in all ft
    -- ls.parser.parse_snippet("expand", "-- this is what was expanded!")
  },
  -- other filetypes
  lua = {
    ls.parser.parse_snippet("lf", "local $1 = function($2)\n $0\nend")
  },
  markdown = {
    -- Boxes
    ls.parser.parse_snippet("wm-dan", "{% alert_box danger %}\n$1\n{% endalert_box %}\n$0"),
    ls.parser.parse_snippet("wm-imp", "{% alert_box important %}\n$1\n{% endalert_box %}\n$0"),
    ls.parser.parse_snippet("wm-not", "{% alert_box note %}\n$1\n{% endalert_box %}\n$0"),
    ls.parser.parse_snippet("wm-war", "{% alert_box warning %}\n$1\n{% endalert_box %}\n$0"),
    ls.parser.parse_snippet("wm-tip", "{% alert_box tip %}\n$1\n{% endalert_box %}\n$0"),
  },
}

-- TODO:
--
-- "Jekyll Image": {
--    "scope": "markdown",
--    "prefix": "wm-img",
--    "body": [
--       "![${1:Descriptive alt text}]({{ site.baseurl }}{{ page.images_folder }}/${2:filename.ext})$0"
--    ],
--    "description": "Insert image with alternate text."
-- },
-- "Jekyll Figure": {
--    "scope": "markdown",
--    "prefix": "wm-fig",
--    "body": [
--       "{% include figure src=\"${1:name.jpg}\" alt=\"${2:text to describe image}\" width=\"${3:100}\" align=\"${4:left}\" class=\"${5:img-fluid}\" caption=\"${6:text to display below the image}\" %} $0"
--    ],
--    "description": "Like an image but greater control."
-- },
-- "Jekyll Snippet Include": {
--    "scope": "markdown",
--    "prefix": "wm-snip",
--    "body": [
--       "{% include {{ page.version }}/snippets/${1:filename-extension-required.md} %} $0"
--    ],
--    "description": "Insert a snippet file."
-- },
-- "Jekyll Page Version": {
--    "scope": "markdown",
--    "prefix": "wm-pv",
--    "body": [
--       "{{ page.version }}$0"
--    ],
--    "description": "Insert appropriate doc version value based on page."
-- },
-- "Jekyll New Markdown Page": {
--    "scope": "markdown",
--    "prefix": "wm-new",
--    "body": [
--       "---",
--       "title: \"${1:Set up macOS for C++ App Development}\"",
--       "excerpt: \"${2:Get started with installing Engine on macOS platform.\"}",
--       "category: ${3:cpp | rn | designer (choose just 1)}",
--       "sub_category: ${4:guides}",
--       "tags: ${5:CPP RN Designer (choose up to 3, but at least 1)}",
--       "---",
--       "",
--       "$0"
--    ],
--    "description": "Use for new Markdown page YAML frontmatter setup."
-- },
-- "Jekyll Relative Link": {
--    "scope": "markdown",
--    "prefix": "wm-rel",
--    "body": [
--       "[${1:Text displayed for link}](../${2:page name without extension}/) $0"
--    ],
--    "description": "Insert a link relative to current page."
-- },
-- "Jekyll Link": {
--    "scope": "markdown",
--    "prefix": "wm-ln",
--    "body": [
--       "[${1:link display text}](/{{ page.version }}/${2:path-to-file-without-extension}/) $0"
--    ],
--    "description": "Link incorporating correct version according to current page version."
-- },
-- "Jekyll External Link": {
--    "scope": "markdown",
--    "prefix": "wm-exln",
--    "body": [
--       "[${1:link display text}](${2:http://someplace.com}) $0"
--    ],
--    "description": "Link to external site. External links in tables require further trickery, check docs."
-- },
-- "Jekyll Codeblock with Raw": {
--    "scope": "markdown",
--    "prefix": "wm-code",
--    "body": [
--       "{% raw %}",
--       "",
--       "```${1:jsx|shell|cpp|make mostly}",
--       "${2:code here}",
--       "```",
--       "",
--       "{% endraw %}",
--       "",
--       "$0"
--    ],
--    "description": "Code block wrapped with raw Liquid tag to ensure that text inside a code block isn't interpreted as Liquid syntax."
-- }
-- }
