{ pkgs, config, ... }:

{
  programs.firefox = {
    enable = true;
    configPath = ".mozilla/firefox";
    profiles.default = {
      id = 0;
      name = "default";
      isDefault = true;

      extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
        ublock-origin
        bitwarden
      ];

      settings = {
        # Startup
        "browser.startup.homepage"            = "about:home";
        "browser.aboutConfig.showWarning"     = false;

        # Dark theme
        "ui.systemUsesDarkTheme"                          = 1;
        "layout.css.prefers-color-scheme.content-override" = 0;
        "browser.theme.toolbar-theme"                     = 0;

        # New tab page — disable sponsored/top sites
        "browser.newtabpage.activity-stream.feeds.topsites"          = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites"   = false;
        "browser.newtabpage.activity-stream.showSponsoredCheckboxes" = false;
        "browser.newtabpage.activity-stream.system.showWeatherOptIn" = false;
        "browser.newtabpage.activity-stream.newtabWallpapers.user.enabled" = true;
        "browser.newtabpage.activity-stream.newtabWallpapers.wallpaper"    = "dark-landscape";

        # Privacy / tracking
        "network.dns.disablePrefetch"            = true;
        "network.prefetch-next"                  = false;
        "network.http.speculative-parallel-limit" = 0;
        "browser.contentblocking.category"       = "standard";
        "privacy.clearOnShutdown_v2.formdata"    = true;

        # Disable password/form saving
        "signon.rememberSignons"                    = false;
        "extensions.formautofill.addresses.enabled" = false;
        "extensions.formautofill.creditCards.enabled" = false;

        # Private browsing autostart
        "browser.privatebrowsing.autostart" = true;

        # UI
        "browser.toolbars.bookmarks.visibility" = "never";
        "sidebar.visibility"                    = "hide-sidebar";
        "extensions.autoDisableScopes"          = 0;

        # Search region
        "browser.search.region" = "FR";

        # Active theme: Alpenglow
        "extensions.activeThemeID" = "firefox-alpenglow@mozilla.org";

        # Toolbar layout (preserves your customised nav-bar)
        "browser.uiCustomization.state" = builtins.toJSON {
          placements = {
            widget-overflow-fixed-list = [];
            unified-extensions-area = [ "_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action" ];
            nav-bar = [
              "back-button" "forward-button" "stop-reload-button"
              "customizableui-special-spring1" "vertical-spacer" "urlbar-container"
              "customizableui-special-spring2" "downloads-button"
              "fxa-toolbar-menu-button" "reset-pbm-toolbar-button"
              "ublock0_raymondhill_net-browser-action" "unified-extensions-button"
            ];
            toolbar-menubar = [ "menubar-items" ];
            TabsToolbar = [ "firefox-view-button" "tabbrowser-tabs" "new-tab-button" "alltabs-button" ];
            vertical-tabs = [];
            PersonalToolbar = [ "import-button" "personal-bookmarks" ];
          };
          seen = [
            "reset-pbm-toolbar-button"
            "ublock0_raymondhill_net-browser-action"
            "_446900e4-71c2-419f-a6a7-df9c091e268b_-browser-action"
            "developer-button"
            "screenshot-button"
          ];
          dirtyAreaCache = [
            "unified-extensions-area" "nav-bar" "toolbar-menubar"
            "TabsToolbar" "vertical-tabs" "PersonalToolbar"
          ];
          currentVersion = 24;
          newElementCount = 0;
        };

        # Bitwarden in sidebar
        "sidebar.installed.extensions" = "{446900e4-71c2-419f-a6a7-df9c091e268b}";
        "sidebar.main.tools"           = "{446900e4-71c2-419f-a6a7-df9c091e268b}";
      };
    };
  };
}
