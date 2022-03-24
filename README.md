# ISBA Website

To develop this website, you should following the [GitHub Pages documentation](https://docs.github.com/en/pages/setting-up-a-github-pages-site-with-jekyll/testing-your-github-pages-site-locally-with-jekyll).
Many components also adopted from the [sedaDNA](https://sedadna.github.io) society.

Quick start:

- Install Ruby, gems, and Bundle (see above).
- Clone this repository
- Modify the files in your editor of choice (VSCode is a good option)
- Run `bundle exec jekyll serve` to check locally (with `127.0.0.1:<IP>` link on your browser)
  - Refresh page on browser after each change
  - Fundamental changes e.g. to `_config.yml` _may_ require restarting of the local server (`ctrl+c` and restart)
- Commit and push

Adding content:

- To update main home page/entry page, modify `index.html`
- To add new posts (e.g. news, events, career, meetings) to a news-like page, add your new post to `posts/`, and add the coresponding `categories:` tag.
- To display UPCOMING posts, put `future: true` in the front matter of the post `.md` document  
- To modify the general information about these pages, update the corresponding `.md` file under `category.md`
- To update normal `page` files (e.g. about, board, membership), update the corresponding `.md` file at the root of this repository.

Tips and tricks for theming the website website:

- Import new fonts in `includes/font-includes.html`
- To change which fonts are actually displayed, update `$root-font-family` in `_sass/hydeout/_layout.scss`
- To change sidebar background colour, update `$sidebar-bg-color` in `_sass/hydeout/_layout.scss`
- To change sidebar font colour, update `$sidebar-fg-color` in `_sass/hydeout/_layout.scss`
- To change order of sidebar pages update `includes/sidebar.html`
- To add custom CSS classes (e.g. the membership/contact buttons), modify `assets/css/main.scss`

## Acknowledgments

This webpage is based forked from the Hydeout theme originally by
[Andrew Fong](https://github.com/fongandrew/). The original documentation at time of forking is below. We also adopted a lot of components from the [sedaDNA society](https://sedadna.github.io)

Hydeout updates the original [Hyde](https://github.com/poole/hyde)
theme for [Jekyll](http://jekyllrb.com) 3.x and 4.x and adds new functionality.

![Desktop](/_screenshots/1.png?raw=true)
<img alt="Mobile home page" src="/_screenshots/2.png?raw=true" width="300px" />
<img alt="Mobile post page" src="/_screenshots/3.png?raw=true" width="300px" />

### Usage

Hydeout is available as the `jekyll-theme-hydeout` Ruby Gem.
Add `gem "jekyll-theme-hydeout", "~> 4.1"` to your Gemfile and run
`bundle install`.

If you're installing on Github pages, you may also have to add
`remote_theme: fongandrew/hydeout` to your `_config.yml`. [See the Github
instructions for more details.](https://help.github.com/articles/adding-a-jekyll-theme-to-your-github-pages-site/)

Hydeout uses pagination, so if you have an `index.md`, you'll need to swap
it with an `index.html` that uses the `index` layout:

```
---
layout: index
title: Home
---
```

You'll also need to add a setting to `_config.yml` telling Jekyll how many posts
to include per page (e.g. `paginate: 5`).

### Keep It Simple

In keeping with the original Hyde theme, Hydeout aims to keep the overall
design lightweight and plugin-free. JavaScript is currently limited only
to Disqus and Google Analytics (and is only loaded if you provide configuration
variables).

Hydeout makes heavy use of Flexbox in its CSS. If Flexbox is not available,
the CSS degrades into a single column layout.

### Customization

Hydeout replaces Hyde's class-based theming with the use
of the following SASS variables:

```scss
$sidebar-bg-color: #202020 !default;
$sidebar-fg-color: white !default;
$sidebar-sticky: true !default;
$layout-reverse: false !default;
$link-color: #268bd2 !default;
```

To override these variables, create your own `assets/css/main.scss` file.
Define your own variables, then import in Hydeout's SCSS, like so:

```scss
---
# Jekyll needs front matter for SCSS files
---

$sidebar-bg-color: #ac4142;
$link-color: #ac4142;
$sidebar-sticky: false;
@import "hydeout";
```

See the [\_variables](_sass/hydeout/_variables.scss) file for other variables
you can override.

You can see the full set of partials you can replace in the
[`_includes`](_includes) folder, but there are a few worth noting:

- `_includes/copyright.html` - Insert your own copyright here.

- `_includes/custom-head.html` - Insert custom head tags (e.g. to load your
  own stylesheets)

- `_includes/custom-foot.html` - Insert custom elements at the end of the
  body (e.g. for custom JS)

- `_includes/custom-nav-links.html` - Additional nav links to insert at the
  end of the list of links in the sidebar.

  Pro-tip: The `nav`s in the sidebar are flexboxes. Use the `order` property
  to order your links.

- `_includes/custom-icon-links.html`- Additional icon links to insert at the
  end of the icon links at the bottom of the sidebar. You can use the `order`
  property to re-order.

- `_includes/favicons.html` - Replace references to `favicon.ico` and
  `favicon.png` with your own favicons references.

- `_includes/font-includes.html` - The Abril Fatface font used for the site
  title is loaded here. If you're overriding that font in the CSS, be sure
  to also remove the font load reference here.

### New Features

- Hydeout adds a new tags page (accessible in the sidebar). Just create a
  new page with the tags layout:

  ```
  ---
  layout: tags
  title: Tags
  ---
  ```

- Hydeout adds a new "category" layout for dedicated category pages.
  Category pages are automatically added to the sidebar. All other pages
  must have `sidebar_link: true` in their front matter to show up in
  the sidebar. To create a category page, use the `category` layout"

  ```
  ---
  layout: category
  title: My Category
  ---

  Description of "My Category"
  ```

- You can control how pages are sorted by using the `sidebar_sort_order`
  parameter in the front matter. This works for both category and non-category
  pages, although non-category pages will always come first. Take a look at
  [`_includes/sidebar-nav-links.html`](./_includes/sidebar-nav-links.html) if
  you want to customize this behavior.

  ```
  ---
  layout: page
  title: My page
  sidebar_sort_order: 123
  ---

  Some content.
  ```

- A simple redirect-to-Google search is available. Just create a page with
  the `search` layout.

  ```
  ---
  layout: search
  title: Google Search
  ---
  ```

- Disqus integration is ready out of the box. Just add the following to
  your config file:

  ```yaml
  disqus:
    shortname: my-disqus-shortname
  ```

  If you don't want Disqus or want to use something else, override
  `comments.html`.

- For Google Analytics support, define a `google_analytics` variable with
  your property ID in your config file.

There's also a bunch of minor tweaks and adjustments throughout the
theme. Hope this works for you!
