My goal when building this website was a simple, fast, long-term maintainable (which entails only open standards, and open source software), portable, static site.  To that end I've chosen to use Hakyll, Nix and Emacs Org-Mode.  This readme is intended to help with a couple sticking points in such a setup.  

I'm fond of the Hack typeface.  To include it in your website follow the instructions [here](https://github.com/source-foundry/Hack#web-font-usage) and take a look at ./css/{default,hack-subset}.css and ./fonts/ in the source.

The website is just a bit more than what hakyll-init gives you, modified to build with Nix following [utdemir](https://utdemir.com/posts/hakyll-on-nixos.html).  Nix is fantastic in that it means this site will build identically on any system with Nix installed, with no other dependencies. Nix will fetch the dependcies required, even compiling them if they are not available in a binary cache. Note that the nix-build command hashes the entire source folder to determine if and when it needs to rebuild, so in order to avoid unecessary rebuilds every time the content of the site changes, we need to keep the hakyll/haskell source for the site in a separate folder from the source for the content of the site, unlike the default hakyll project layout.

If you run into "commitBuffer: invalid argument (invalid character)" errors, you've got encoding problems:
       $ grep -riI utf
in the repo for this site to see where encoding needs to be set.

# To add new posts:
Simply place a file with appropriate metadata in the first few lines in site/posts.  Any filetype which pandoc can convert, which is most text formats, will work.  See the source of any of my posts for examples of the metadata formatting.

# To build:
       $ nix-build
in the repo root.  The build products will be in a symlinked folder named result/

n.b. this failed on me once when Pandoc was broken in the unstable Nix channel that I follow. To solve this, simply build against a different version of nixpkgs. There are multiple approaches to this. I simply build with $ nix-build -I nixpkgs=$(path to checked-out nixpkgs repo on stable branch)

# To publish:
With my setup, publishing is as simple as rsyncing the result folder to my host, [nearlyfreespeech.net](https://www.nearlyfreespeech.net), over ssh.
