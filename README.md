# Typstart

A starter template repo for creating (and collaborating) a document using [Typst](https://typst.app).
The document is compiled using GitHub Actions and published using Cloudflare Pages.

## Getting started

#### TODO:

## Document

You can find the document at https://<YOUR_SUBDOMAIN>.pages.dev/

### Mobile friendly version

An HTML based version of the document can be found at https://<YOUR_SUBDOMAIN>.pages.dev/main.html
This is very experimental. If you find any issues visit the pdf version instead.

## Development

There are three supported ways to edit the document.

### Option 1: Local install

- Install the Typst compiler: https://typst.app/open-source/ (or https://github.com/typst/typst#installation)
- Install VS Code and the recommended extension (`myriad-dreamin.tinymist`)
  - VS Code should prompt to install workspace recommendations from `.vscode/extensions.json`

### Option 2: GitHub Codespaces

This repo is set up to work out-of-the-box in Codespaces (Typst + the recommended VS Code extensions are preinstalled).

- Create a Codespace from the GitHub UI
- Open `src/main.typ`
- Use the VS Code preview feature (see “Typst Preview” below)

### Option 3: Local development with Dev Containers (unnecessary)

If you prefer working locally but still want the reproducible environment:

- Install Docker
- Install VS Code + the “Dev Containers” extension
- Open this repo in VS Code and run “Dev Containers: Reopen in Container”

The container configuration in `.devcontainer.json` installs Typst and the recommended Typst extension automatically.

### Typst Preview (VS Code / Codespaces)

Preview Command
Open command palette (Ctrl+Shift+P), and type >Typst Preview:.

You can also use the shortcut (Ctrl+K V).

### Build / Watch (all options)

In any of the setups above (Codespaces, Dev Containers, or local install), you can build from the terminal in watch mode:

```bash
typst watch src/main.typ main.pdf --open
```
