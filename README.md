# orekiyuta.github.io

Personal blog built with Hexo and the NexT theme.

## Setup

```bash
npm install
```

> Note: This project uses an old Hexo 3.9. On newer Node.js (e.g. v24) it needs
> two patches under `node_modules` to build/deploy correctly. Re-apply them if
> `npm install` overwrites them:
> - `hexo-front-matter/lib/front_matter.js`: replace `util.isDate` with `util.types.isDate`
>   (otherwise parsing posts fails with `isDate is not a function`)
> - `hexo-fs/lib/fs.js`: force `copyFile`'s `flags` to `undefined` when it is not a number
>   (otherwise deploy fails with `mode must be int32 or null/undefined`)

## Local Development

```bash
npx hexo clean       # clear cache and the public folder
npx hexo generate    # generate static files
npx hexo server      # start the local server
```

Open http://localhost:4000 to preview. Press `Ctrl + C` to stop.

Common options:

```bash
npx hexo server -p 5000    # use a different port
npx hexo server --draft    # also preview posts in _drafts
```

## Deployment

Deployment is configured in the `deploy` section of `_config.yml`. It uses
`hexo-deployer-git` to push the generated `public/` files to the **`master`**
branch of `git@github.com:OrekiYuta/orekiyuta.github.io.git`, which GitHub Pages
then serves at the custom domain **https://canoe.orekiyuta.cn** (see `source/CNAME`).

```bash
npx hexo clean
npx hexo generate
npx hexo deploy
```

One-liner:

```bash
# bash / PowerShell 7+
npx hexo clean && npx hexo g -d

# Windows PowerShell 5.1
npx hexo clean; npx hexo g -d
```

## Branches

| Branch    | Purpose |
| --------- | ------- |
| `source`  | Source code of the blog (Markdown posts, theme, config). This is the working branch for regular commits/pushes, and what downstream users fork to deploy elsewhere. |
| `master`  | Build output only. `hexo deploy` pushes the generated static site here; GitHub Pages serves it at `canoe.orekiyuta.cn`. Do not edit by hand. |
| `back-up` | Obsolete, no longer maintained. |
