# Personal / CV Site
Just your run-of-the-mill static site hosted on Github Pages.  This particular site was build with [Elixir](https://elixir-lang.org/) and [Phoenix](https://phoenixframework.org/).

The design was heavily inspired by Devfolio by [Cruip](https://cruip.com/).

As for the structure of this project, credit there goes to an article by [Jason at Fly.io](https://fly.io/phoenix-files/crafting-your-own-static-site-generator-using-phoenix/)

## Setup
Clone this repo and get deps via Mix
```bash
git clone <...>
mix deps.get
```
### Build the site
```bash
mix site.build
```

### Host it with Python
```bash
cd output
python3 -m http.server 9000
```

## Deploying to Github Pages
Commit your changes, push up to `main` and run
```bash
bash deploy.sh
```

🤔 I am unsure who this README is for as this is my own site. Maybe it is for Six-Months-From-Now Me 😂


