return {
	cmd = { "roslyn-language-server", "--stdio", "--extension=/path/to/Roslynator.dll" },
	filetypes = { "cs", "razor" },
	root_markers = { "appsettings.json", "*.csproj" },
}
