return {
	cmd = { "tailwindcss-language-server", "--stdio" },
	filetypes = {"typescriptreact", "javascriptreact", "typescript", "javascript", "html"},
	root_dir = function(bufnr, on_dir)
    local root = vim.fs.root(bufnr, {
      "tailwind.config.js",
      "tailwind.config.ts",
      "deno.json",
      "postcss.config.js",
      "package.json",
      ".git",
    })

    if root then
      on_dir(root)
    end
	end,
	settings = {
		tailwindCSS = {
			classAttributes = { "class", "className", "data-classes" },
			classFunctions = { "clsx", "cn", "cva" },
			experimental = {
				classRegex = {
					"class(Name)?\\s*=\\s*['\"]([^'\"]*)['\"]",
				}
			}
		}
	}

	-- filetypes = { "aspnetcorerazor", "astro", "astro-markdown", "blade", "clojure", "django-html", "htmldjango", "edge", "eelixir", "elixir", "ejs", "erb", "eruby", "gohtml", "gohtmltmpl", "haml", "handlebars", "hbs", "html", "htmlangular", "html-eex", "heex", "jade", "leaf", "liquid", "markdown", "mdx", "mustache", "njk", "nunjucks", "php", "razor", "slim", "twig", "css", "less", "postcss", "sass", "scss", "stylus", "sugarss", "javascript", "javascriptreact", "reason", "rescript", "typescript", "typescriptreact", "vue", "svelte", "templ" },
	-- settings = {
	-- 	includeLanguages = {
	-- 		eelixir = "html-eex",
	-- 		elixir = "phoenix-heex",
	-- 		eruby = "erb",
	-- 		heex = "phoenix-heex",
	-- 		htmlangular = "html",
	-- 		html = "html",
	-- 		templ = "html"
	-- 	}
	-- }
}
