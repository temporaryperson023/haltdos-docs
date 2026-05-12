# Haltdos Docs

A premium internal documentation site built with plain HTML, CSS, and JavaScript.

## Features

- Warm Slate + Amber design system with full dark mode
- Ctrl+K / ⌘K spotlight search across all docs
- Fixed sidebar with grouped navigation and status tags
- Reading progress bar on every doc page
- Auto-generated "On This Page" TOC with live scroll highlight
- Copy button on every code block
- Animated stats dashboard with live counters
- Prev / Next doc navigation
- Fully static — no build tools, no dependencies, no server

## Project Structure
docs-site/
├── index.html              # Dashboard
├── style.css               # Full design system
├── README.md               # This file
├── deploy.sh               # GitHub Pages deploy script
└── docs/
├── doc-template.html           # Master template for new pages
├── getting-started.html
├── binary-components-upload.html
├── email-integration.html
├── tacacs-chap-login.html
├── haltdos-installer.html
├── installer-methods.html
└── vercel-waf-onboarding.html