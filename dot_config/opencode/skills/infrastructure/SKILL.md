---
name: infrastructure
description: Use when planning or editing Terraform/OpenTofu, Ansible, Helm, Flux/GitOps, cloud-init, deployment workflows, or stateful infrastructure configuration.
---

# Infrastructure Operations

- Treat infrastructure as production-like: minimal, reversible, observable changes.
- Identify target environment, source of truth, hosts/services, network scope, persistent state, and deployment mechanism before proposing state-changing commands.
- Preserve generated/source-of-truth boundaries.
  Modify declarative sources rather than generated files.
- Use inspect → render/plan/diff → review → apply → verify → document.
- Never run remote or state-changing commands without explicit approval, including `tofu apply`, `terraform apply`, `ansible-playbook`, deployments, or restarts.
- Include rollback and post-change verification for every state-changing proposal.
- Prefer idempotent, version-controlled, repeatable automation.
- For Flux GitOps clusters, do not manually apply manifests with `kubectl`; leave desired changes uncommitted unless the user explicitly requests a commit/push.
