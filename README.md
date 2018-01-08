My goal when building this website was a simple, fast, long-term maintainable, portable, static site. This readme is intended to help with a couple sticking points.

I'm fond of the Hack typeface. To include it in your website follow the instructions [here](https://github.com/source-foundry/Hack#web-font-usage) and take a look at ./css/{default,hack-subset}.css and ./fonts/.

The website is basically what $ hakyll init gives you, modified to build with nix following [utdemir](https://utdemir.com/posts/hakyll-on-nixos.html). Nix is fantastic in that it means this site will build identically on any system with nix installed, with no other dependencies. Note that nix-build hashes the entire source folder to determine when it needs to rebuild. So we need to keep the hakyll/haskell source for the site in a separate folder from the source for the content of the site, unlike the default hakyll project layout.

If you run into "commitBuffer: invalid argument (invalid character)" errors, you've got encoding problems:
   $ grep -riI utf
in the repo to see where encoding needs to be set.

# To add posts:
Simply place a file (any file which pandoc can convert, which is most text formats) in site/posts. See the source of my posts for metadata formatting.

# To build:
        $ nix-build
in the repo root. The build products will be in a symlinked folder named result/