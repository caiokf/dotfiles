// Future versions of Hyper may add additional config options,
// which will not automatically be merged into this file.
// See https://hyper.is#cfg for all currently supported options.

module.exports = {
  config: {
    // Choose either "stable" for receiving highly polished,
    // or "canary" for less polished but more frequent updates
    updateChannel: "stable",

    // default font size in pixels for all tabs
    fontSize: 14,

    // font family with optional fallbacks
    fontFamily: '"Hack Nerd Font", Consolas, "Lucida Console", monospace',

    // terminal cursor background color and opacity (hex, rgb, hsl, hsv, hwb or cmyk)
    cursorColor: "grey",

    // `BEAM` for |, `UNDERLINE` for _, `BLOCK` for █
    cursorShape: "UNDERLINE",

    // set to true for blinking cursor
    cursorBlink: false,

    // color of the text
    foregroundColor: "#fff",

    // terminal background color
    backgroundColor: "rgba(0, 0, 0, 1)",

    // selection color
    selectionColor: "rgba(102, 102, 102, 0.3)",

    // border color (window, tabs)
    borderColor: "#000",

    // custom css to embed in the terminal window
    termCSS: "",

    // set to `true` (without backticks) if you're using a Linux setup that doesn't show native menus
    // default: `false` on Linux, `true` on Windows (ignored on macOS)
    showHamburgerMenu: "",

    // set to `false` if you want to hide the minimize, maximize and close buttons
    // additionally, set to `'left'` if you want them on the left, like in Ubuntu
    // default: `true` on windows and Linux (ignored on macOS)
    showWindowControls: "true",

    // custom padding (css format, i.e.: `top right bottom left`)
    padding: "12px 14px",

    minimal: "false",
    // the full list. if you're going to provide the full color palette,
    // including the 6 x 6 color cubes and the grayscale map, just provide
    // an array here instead of a color map object
    colors: {
      black: "rgb(67, 73, 68)",
      red: "rgb(218, 86, 115)",
      green: "rgb(140, 193, 109)",
      yellow: "rgb(238, 191, 53)",
      blue: "rgb(95, 165, 208)",
      magenta: "rgb(181, 149, 207)",
      cyan: "rgb(68, 169, 186)",
      white: "rgb(251, 251, 251)",

      lightBlack: "rgb(108, 108, 108)",
      lightRed: "rgb(219, 162, 180)",
      lightGreen: "rgb(140, 193, 109)",
      lightYellow: "rgb(138, 107, 61)",
      lightBlue: "rgb(41, 156, 197)",
      lightMagenta: "rgb(116, 87, 162)",
      lightCyan: "rgb(135, 199, 212)",
      lightWhite: "rgb(195, 195, 195)",
    },

    // the shell to run when spawning a new session (i.e. /usr/local/bin/fish)
    // if left empty, your system's login shell will be used by default
    shell: "/bin/zsh",

    // for setting shell arguments (i.e. for using interactive shellArgs: ['-i'])
    // by default ['--login'] will be used
    shellArgs: ["--login"],

    // for environment variables
    env: {},

    // set to false for no bell
    bell: "false",

    // if true, selected text will automatically be copied to the clipboard
    copyOnSelect: false,

    // number of lines to scroll upwards
    // https://github.com/zeit/hyper/issues/280
    scrollback: 10000,

    // if true, on right click selected text will be copied or pasted if no
    // selection is present (true by default on Windows)
    quickEdit: true,

    // URL to custom bell
    // bellSoundURL: 'http://example.com/bell.mp3',

    // for advanced config flags please refer to https://hyper.is/#cfg

    // Change how terminal is opened:
    summon: {
      hotkey: "ctrl+;",
    },

    // custom plugin
    opacity: 0.95,
  },

  // a list of plugins to fetch and install from npm
  plugins: ["hyperterm-summon", "hypercwd", "hyper-opacity"],

  hyperTabs: {
    trafficButtons: true,
    border: true,
  },

  // in development, you can create a directory under
  // `~/.hyper_plugins/local/` and include it here
  // to load it and avoid it being `npm install`ed
  localPlugins: [],

  keymaps: {
    "tab:next": ["command+right"],
    "tab:prev": ["command+left"],
    "editor:moveBeginningLine": "command+shift+left",
    "editor:moveEndLine": "command+shift+right",
  },
};
