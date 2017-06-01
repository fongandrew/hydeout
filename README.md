# Hydeout

Hydeout updates the original [Hyde](https://github.com/poole/hyde)
theme for [Jekyll](http://jekyllrb.com) 3.x and adds new functionality.

### Usage

Hydeout currently isn't available as a Ruby Gem. I recommend just forking
it at the moment

### Keep It Simple

In keeping with the original Hyde theme, Hydeout avoids using
Javascript and aims to keep the overall design lightweight and plugin-free.

It updates Hyde's styling to incorporate the latest SASS files from
[Poole](https://getpoole.com) and replaces class-based theming with the use
of the following SASS variables:

```scss
$sidebar-bg-color: #202020 !default;
$sidebar-sticky: true !default;
$layout-reverse: false !default;
```

### New Features

It also adds a new tags page (accessible in the sidebar) and a new
"category" layout for dedicated category pages.

Category pages are automatically added to the sidebar. All other pages
must have `sidebar_link: true` in their front matter to show up in
the sidebar.

There's also a bunch of minor tweaks and adjustments throughout the
theme. Hope this works for you!
