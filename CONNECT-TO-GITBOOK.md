# How to Connect This Repo to GitBook

Follow these steps to turn this folder into a live public docs site in ~10 minutes.

---

## Step 1 — Push to GitHub

1. Create a new GitHub repository (e.g., `amplideX-one-reporter-docs`). Set it to **Private** or **Public** depending on your preference — GitBook works with both.

2. From your terminal, in this folder:

   ```bash
   git init
   git add .
   git commit -m "Initial docs structure"
   git remote add origin https://github.com/YOUR_ORG/amplideX-one-reporter-docs.git
   git push -u origin main
   ```

---

## Step 2 — Set Up GitBook

1. Go to [gitbook.com](https://gitbook.com) and create a free account (or log in).

2. Click **+ New Space** → **Import from GitHub**.

3. Authorize GitBook to access your GitHub organization.

4. Select the `amplideX-one-reporter-docs` repository and choose the `main` branch.

5. GitBook will import the content, using `SUMMARY.md` as the navigation structure.

6. Your docs site is live. GitBook gives you a URL like `https://your-org.gitbook.io/amplideX-one-reporter`.

---

## Step 3 — Invite Collaborators

- **Engineers** can edit via Git: commit Markdown to the repo and changes sync to GitBook automatically.
- **Non-technical contributors** (QA, product, regulatory): invite them directly in GitBook → they edit in the visual WYSIWYG editor → changes sync back to the GitHub repo.

Go to **Settings → Members** in GitBook to add editors.

---

## Ongoing Workflow

| Who | How they edit |
|-----|--------------|
| Engineers | Edit `.md` files in the repo → push to `main` |
| Technical writers | Edit in GitBook's editor or via the repo |
| QA / Regulatory / Product | Edit in GitBook's visual editor — no Git knowledge needed |

Changes from either side sync bidirectionally within seconds.

---

## Versioning by Release

When you release a new software version, create a new **GitBook Variant** (GitBook's term for a versioned copy of a space):

1. In GitBook, go to your Space → click the version dropdown → **New Variant**.
2. Name it after the release (e.g., `v2.0`, `v2.1`).
3. Each variant maps to a branch in the GitHub repo.

Users can switch between versions from the docs site. Old versions remain available as read-only archives.
