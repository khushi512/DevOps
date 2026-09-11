# Git & GitHub Homework

## Task 1: `git commit -m` vs `git commit -a -m`

### 1. `git commit -m`

First, the file was staged using `git add` and then committed:

```bash
git add homework.md
git commit -m "Add Task 1 notes"
```

Output:

```text
[main a828049] Add Task 1 notes
1 file changed, 5 insertions(+)
create mode 100644 Git&GitHub/homework.md
```

### 2. `git commit -a -m`

A change was made to the already tracked file:

```bash
echo "Testing git commit -a -m" >> homework.md
git commit -a -m "Test commit -a"
```

Output:

```text
[main 4dcb5e0] Test commit -a
1 file changed, 1 insertion(+)
```

### Difference

* `git commit -m` commits changes that have already been staged using `git add`.
* `git commit -a -m` automatically stages and commits changes to already tracked files.
* `git commit -a -m` does not automatically include new untracked files.

---

## Task 2: Git Cherry-Pick

### 1. Commits in `main`

Multiple commits were created in the `main` branch and viewed using:

```bash
git log --oneline
```

Relevant commits:

```text
168f11b Add another main change
61d5858 Add main branch change
8ad222a Complete Task 1
```

### 2. Create a new branch

A new branch named `feature` was created:

```bash
git checkout -b feature
```

### 3. Commits in `feature`

Two commits were created in the `feature` branch:

```text
f8d08b7 Feature commit 1
09e83a7 Feature commit 2
```

The commits were identified using:

```bash
git log --oneline
```

### 4. Cherry-pick a specific commit

Switched back to the `main` branch:

```bash
git checkout main
```

Cherry-picked the specific commit `f8d08b7`:

```bash
git cherry-pick f8d08b7
```

Output:

```text
[main 5ee6f5c] Feature commit 1
1 file changed, 1 insertion(+)
```

### 5. Verification

The commit was verified using:

```bash
git log --oneline
```

The cherry-picked commit now appears on `main`:

```text
5ee6f5c Feature commit 1
168f11b Add another main change
61d5858 Add main branch change
8ad222a Complete Task 1
4dcb5e0 Test commit -a
a828049 Add Task 1 notes
```

The working tree was also verified:

```bash
git status
```

Output:

```text
On branch main
Your branch is ahead of 'origin/main' by 6 commits.
nothing to commit, working tree clean
```

### Conclusion

Task 1 demonstrated the difference between `git commit -m` and `git commit -a -m`.

Task 2 demonstrated creating commits on `main` and a feature branch, identifying a specific commit, cherry-picking it into `main`, and verifying the result.
