---
name: obsidian-everything-vault
description: >-
  Documents how to access the "Everything" Obsidian vault.
  Trigger whenever the user asks about vault location, vault path,
  or how to work with their Obsidian notes.
  The vault is stored on the NAS and accessed via the obsidian CLI tool.
---

If you run on Linux, you must specify the obsidian.exe. Otherwise you will start the obsidian application in WSL2.

# Everything Vault

## Vault Location

| Property | Value |
|----------|-------|
| **Vault name** | `Everything` (used with `vault=` parameter) |
| **NAS path** | `\\NAS\Obsidian\Everything` |
| **Access method** | Via `obsidian` CLI tool only — never use bash directly |

## Using the Obsidian CLI

All vault operations go through the `obsidian` tool with `vault=Everything`:

```
obsidian read file="Note Name" vault=Everything
obsidian write file="New Note.md" vault=Everything
obsidian move file="Old" to="New Path" vault=Everything
obsidian search query="keyword" vault=Everything
```

## Common Operations

### List all files in the vault
```
obsidian files vault=Everything
```

### Read a note
```
obsidian read file="path/to/note.md" vault=Everything
```

### Create or overwrite a note
```
obsidian write file="path/to/note.md" vault=Everything
```

### Search
```
obsidian search query="search term" vault=Everything
```

## Important Notes

- The vault lives on a NAS share — network latency may affect operations
- Always use `vault=Everything` to target this vault explicitly
- Do not use bash commands (mv, cp, rm, ls) on NAS paths containing "Obsidian" or "Everything" — this bypasses Obsidian's index
- If a file operation seems to fail, verify the NAS path is accessible
