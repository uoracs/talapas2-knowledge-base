# Talapas Knowledge Base

This is the github repository for the user-facing documentation of UO RACS resaerch computing cluster, Talapas (i.e. wiki.talapas.uoregon.edu). 

## Repo Structure and Contributing

The website is built using the static site generator, [Jekyll](https://jekyllrb.com) with the [Just-The-Docs](https://just-the-docs.github.io/just-the-docs/) theme. All content on the site is generated from source markdown files (i.e. `.md`) within the repository. The landing page is laid out in `index.md` where the remaining documentation pages live in the `docs/` folder.

To contribute feel free to edit any of the documentation markdown files. Preferrably if the change is significant in size, make the changes in a new feature branch, followed by creating a pull request to merge those changes into the main branch. Only the main branch is deployed to the site through [GitHub Pages](https://docs.github.com/en/pages) and is automatically deployed on any new changes to the main branch.

Some common formatting options for Just-the-docs used throughout the markdown files are:
- Callouts:
  - To add a callout, above the paragraph of text you want inside the callout message add: "{: .note }" where the note is the type of callout. See [this page](https://just-the-docs.github.io/just-the-docs/docs/ui-components/callouts/) for other callout options. 
- Internal Links:
  - When adding a link to a different page within the documentation you do not need to add a normal markdown hyperlink to the url. Instead it is preferable to add a Just-the-docs internal link, which will get checked within the CI tests to confirm the link exists and is not broken. To add an internal link you start as a normal markdown hyperlink where the name goes in square brackets followed by parentheses. In the parentheses you tell it the path to the docs file you want to link to as if you are in the repo's root directory. For example: "\[Directory Structure\]({% link docs/storage/directory_structure.md %})" will create an internal link named "Directory structure" pointing to the page that contains the markdown file at the path: docs/storage/directory_structure.md. 

For more details on the formmatting of specific details including navigation, callouts, code blocks, mermaid diagrams, page linking, etc see the documentation site for the Just-The-Docs theme [here](https://just-the-docs.github.io/just-the-docs/) (built with itself!).

## Github Workflows

There are two github workflows in this repo. One for performing CI tests, and one to deploy the github pages website. The "ci.yml" workflow will build the jekyll site, then run a few validation tests to confirm the Just-the-docs functionalities are correct and that all links correctly point to other pages that exist. If any of the ci.yml tests fail -- the deploy.yml workflow will complete (you will see a green check mark in the actions tab), but it does **NOTHING** if the ci.yml workflow fails in order to prevent deploying a broken site. Only once the ci.yml worklfow completes successfully will the deploy workflow actually deploy the site to github pages. 

If your CI job keeps failing on the html-proofer step when linking to outside pages you may need to add that website/url to the ignore list if you know it is correct in order for the CI test to pass and thus deploy the docs site. You can see previously ignored urls and add more [here](https://github.com/uoracs/talapas2-knowledge-base/blob/main/.github/workflows/ci.yml#L66). 
