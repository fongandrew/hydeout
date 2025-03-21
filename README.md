# Hydeout

This project is a fork of the [original Hydeout theme](https://github.com/fongandrew/hydeout) by Andrew Fong.
This fork exists to remove SASS code that is now considered deprecated.

Hydeout updates the original [Hyde](https://github.com/poole/hyde)
theme for [Jekyll](http://jekyllrb.com) 3.x and 4.x and adds new functionality.

![Desktop](/_screenshots/1.png?raw=true)
<img alt="Mobile home page" src="/_screenshots/2.png?raw=true" width="300px" />
<img alt="Mobile post page" src="/_screenshots/3.png?raw=true" width="300px" />

### Usage

Hydeout is available as the `jekyll-theme-hydeout-funfox` Ruby Gem.
Add `gem "jekyll-theme-hydeout-funfox", "~> 1.0"` to your Gemfile and run
`bundle install`.

If you're installing on GitHub pages, you may also have to add
`remote_theme: functional-fox/hydeout` to your `_config.yml`. [See the GitHub
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

To override these variables, define your own variables inside a SASS file
in the `assets/css/` directory.
Then `@use` that file in your own `assets/css/main.scss` file, like so:

```scss
---
# Jekyll needs front matter for SCSS files
---

@use "colours";
@use "hydeout/variables" with (
  $body-bg:           colours.$grey,
  $body-color:        white,
  $heading-color:     colours.$light-pink,
  $link-color:        colours.$green,
  $sidebar-bg-color:  colours.$dark-pink,
  $sidebar-sticky:    false,
  );
@use "hydeout";
```

Example content of `assets/css/colours.scss`:

```scss
$green:       #61c200;
$grey:        #363636;
$dark-pink:   #9f0647;
$light-pink:  #f0a2c3;
```

See the [_variables](_sass/hydeout/_variables.scss) file for other variables
you can override.

**Pay attention to the namespace of the variables you intend to override, otherwise, you will probably experience errors.**

You can see the full set of partials you can replace in the
[`_includes`](_includes) folder, but there are a few worth noting:

* `_includes/copyright.html` - Insert your own copyright here.

* `_includes/custom-head.html` - Insert custom head tags (e.g. to load your
  own stylesheets)

* `_includes/custom-foot.html` - Insert custom elements at the end of the
  body (e.g. for custom JS)

* `_includes/custom-nav-links.html` - Additional nav links to insert at the
  end of the list of links in the sidebar.

  Pro-tip: The `nav`s in the sidebar are flexboxes. Use the `order` property
  to order your links.

* `_includes/custom-icon-links.html`- Additional icon links to insert at the
  end of the icon links at the bottom of the sidebar. You can use the `order`
  property to re-order.

* `_includes/favicons.html` - Replace references to `favicon.ico` and
  `favicon.png` with your own favicons references.

* `_includes/font-includes.html` - The Abril Fatface font used for the site
  title is loaded here. If you're overriding that font in the CSS, be sure
  to also remove the font load reference here.

### New Features

* Hydeout adds a new tags page (accessible in the sidebar). Just create a
  new page with the tags layout:

  ```
  ---
  layout: tags
  title: Tags
  ---
  ```

* Hydeout adds a new "category" layout for dedicated category pages.
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

* You can control how pages are sorted by using the `sidebar_sort_order`
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

* A simple redirect-to-Google search is available. Just create a page with
  the `search` layout.

  ```
  ---
  layout: search
  title: Google Search
  ---
  ```

* Disqus integration is ready out of the box. Just add the following to
  your config file:

  ```yaml
  disqus:
    shortname: my-disqus-shortname
  ```

  If you don't want Disqus or want to use something else, override
  `comments.html`.

* For Google Analytics support, define a `google_analytics` variable with
  your property ID in your config file.

There's also a bunch of minor tweaks and adjustments throughout the
theme. Hope this works for you!
