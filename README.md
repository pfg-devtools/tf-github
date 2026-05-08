# tf-github

Terraform that manages GitHub teams, repository defaults, and branch
protection for the PFG Dev Tools org.

This is **not** application infrastructure. Cloud accounts, DNS, and
runtime IAM live elsewhere.

## Layout

```
modules/repository/     github_repository + branch protection on main
modules/team/           github_team + maintainer membership
environments/nonprod/   sandbox / tooling org
environments/prod/      production GitHub org
versions.tf             provider pins
teams.tf / repos.tf     root wiring (legacy; prefer environments/)
docs/onboarding.md
```

## Prerequisites

- Terraform >= 1.6
- `integrations/github` provider ~> 6.0
- A PAT or GitHub App token with `admin:org` and `repo` on the target org

```bash
export GITHUB_TOKEN   # or GITHUB_OWNER + app credentials
cd environments/nonprod
cp terraform.tfvars.example terraform.tfvars
terraform init
terraform plan
```

Backend config is supplied at init time. Do not commit state.

## Modules

### repository

| Variable | Default | Notes |
|----------|---------|--------|
| `name` | required | Repository name |
| `description` | `""` | |
| `visibility` | `"private"` | |
| `topics` | `[]` | |

Creates the repo, enables vulnerability alerts, deletes head branches on
merge, and requires one approving review on `main`.

### team

| Variable | Default | Notes |
|----------|---------|--------|
| `name` | required | |
| `description` | required | |
| `maintainers` | `[]` | GitHub usernames |

Teams are `closed`. Add repository grants in the environment root, not
inside the module.

## Environments

`nonprod` and `prod` share the same module graph. Prod should be planned
from a protected runner after a nonprod apply has been reviewed.

Example (`environments/nonprod/main.tf`):

```hcl
module "platform" {
  source      = "../../modules/team"
  name        = "platform"
  description = "Platform engineering"
}

module "actions" {
  source      = "../../modules/repository"
  name        = "actions"
  description = "Reusable GitHub Actions"
  visibility  = "public"
  topics      = ["github-actions", "ci"]
}
```

## CI

Format and `terraform validate` (no backend) run on pull request. Apply is
manual.

## Onboarding

See [docs/onboarding.md](docs/onboarding.md).
