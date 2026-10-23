# Template de dépôt gouverné (Orca v4)

Base pour tout nouveau projet de Pierre. Créer le dépôt avec "Use this template", puis lancer le skill `bootstrap-gouvernance` depuis la session orchestrateur Orca.

## Contenu
- `.githooks/` : refus de commit et push sur main/master, format de branche, scan gitleaks, refus des force-push et suppressions distantes.
- `.github/workflows/ci.yml` : lint, typecheck, tests, build (scripts npm, ignorés s'ils n'existent pas), format de branche, gitleaks.
- `.github/CODEOWNERS` : fichiers de gouvernance soumis à la revue de @Pwierre-M5.
- `.github/pull_request_template.md` : ticket Linear, review, CI, risques, captures, Lighthouse, preview.
- `.env.example` : variables avec valeurs factices. `.env` est ignoré.

## Installer les hooks (à faire dans chaque clone et worktree)
```bash
git config core.hooksPath .githooks
brew install gitleaks   # recommandé, sinon seule la CI scanne
```

## Format de branche
`<type>/<id>-<slug>` : `feat/pwi-25-responsive`, `fix/t042-export-pdf`. Types : feat, fix, refactor, docs, test, chore. Id Linear en minuscules, à défaut id Orca. Slug de 40 caractères max. Exception : `chore/bootstrap-gouvernance`.

## Réglages GitHub à activer
1. Settings > General > Pull Requests : cocher "Automatically delete head branches".
2. Settings > Branches (ou Rulesets) sur `main` : PR obligatoire, checks `checks`, `secrets` et `branch-name` requis, force-push et suppression interdits.
3. Approbation : option A (agents sur GitHub App ou compte bot, "Require approvals: 1" et "Require review from Code Owners") ou option B (approbation dans Orca, la règle n'exige que la CI). Voir `docs/decisions/`.
4. Ajuster `.nvmrc` à la version Node du projet ; la CI suppose un `package.json` et un `package-lock.json` ; ajouter les scripts `lint`, `typecheck`, `test`, `build` dans `package.json`.
