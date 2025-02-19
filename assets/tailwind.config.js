module.exports = {
  theme: {
    extend: {
      fontFamily: {
        sans: ["Space Grotesk", "sans-serif"],
      },
    },
  },
  content: [
    "./**/*.js",
    "../lib/personal_site.ex",
  ],
  plugins: [
    // require("@tailwindcss/typography"),
  ],
};
