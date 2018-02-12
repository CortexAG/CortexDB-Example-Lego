Readme for the CortexPlatform documentation
===========================================

This documentation based on markdown files. The directory structure is based on the configuration for the tool [mkdocs](http://www.mkdocs.org/) an its extension [mkdocs-material](https://squidfunk.github.io/mkdocs-material/).

Note: Each language has its own repository. The following structure is the same for all languages

project structure
-----------------

```
mkdocs.yml
README.md
docs/
	index.md
	css/
		extra.css
	private/
		private files for own usage (favicon.ico and logo.png)
theme/
	material/
		material template for MkDocs from https://squidfunk.github.io/mkdocs-material/

# language-depended directories

	de/
		German documentation as markdown files
	en/
		English documentation as markdown files
```
