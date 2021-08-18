const plugin = require('tailwindcss/plugin')
const colors = require('tailwindcss/colors')

module.exports = {
  purge: [],
  darkMode: false, // or 'media' or 'class'
  theme: {
    extend: {
      container: {
        padding: {
          DEFAULT: '1rem',
          sm: '2rem',
          lg: '4rem',
          xl: '5rem',
          '2xl': '6rem',
        },
        center: true,
      },
      colors: {
        transparent: 'transparent',
        current: 'currentColor',
        gray: colors.trueGray,
        red: colors.red,
        black: {
          DEFAULT: '#262626',
        },
        yellow: {
          lighter: '#FCF9E5',
          light: '#FFF2A0',
          DEFAULT: '#FFDD00'
        },
        orange: {
          light: '#FBDEC6',
          DEFAULT: '#E76F51'
        },
        green: {
          lighter: '#EDF9F3',
          light: '#C1EEEA',
          DEFAULT: '#2EC4B6'
        },
        beige: {
          DEFAULT: '#FBF9F9'
        }
      },
      boxShadow: {
        yellow: '0 20px 25px -5px rgba(255, 221, 0, 0.1), 0 10px 10px -5px rgba(255, 221, 0, 0.04)',
        green: '0 20px 25px -5px rgba(46, 196, 182, 0.1), 0 10px 10px -5px rgba(46, 196, 182, 0.04)',
      },
      transitionProperty: {
       'width': 'width',
      },
    },
    fontFamily: {
      'sans': ['ui-sans-serif', 'system-ui'],
      'serif': ['ui-serif', 'Georgia'],
      'mono': ['ui-monospace', 'SFMono-Regular'],
      'headers': ['Poppins'],
      'body': ['Poppins'],
    },
    scale: {
      '300': '3',
      '400': '4'
    }
  },
  variants: {
    extend: {
      width: ['hover', 'group-hover'],
      zIndex: ['hover']
    },
  },
  plugins: [
  plugin(function({ addBase, theme }) {
    addBase({
      'body': {
        fontFamily: theme('fontFamily.body'),
        fontSize: theme('fontSize.base'),
        fontWeight: theme('fontWeight.light'),
        color: theme('colors.black.DEFAULT'),
      },
      'h1': {
        fontFamily: theme('fontFamily.headers'),
        fontSize: theme('fontSize.5xl'),
        fontWeight: theme('fontWeight.semibold'),
        color: theme('colors.black.DEFAULT'),
      },
      'h2': {
        fontFamily: theme('fontFamily.headers'),
        fontSize: theme('fontSize.4xl'),
        fontWeight: theme('fontWeight.semibold'),
        color: theme('colors.black.DEFAULT'),
      },
      'h3': {
        fontFamily: theme('fontFamily.headers'),
        fontSize: theme('fontSize.2xl'),
        fontWeight: theme('fontWeight.semibold'),
        color: theme('colors.black.DEFAULT'),
      },
    })
  }),
  ],
}
