# Linux Homework

## Task 1: Soft Link & Hard Link

### Soft Link

A **soft link (symbolic link)** is a file that points to the path of another file. If the original file is deleted, the soft link becomes broken.

**Create a soft link:**

```bash
ln -s original.txt softlink.txt
```

**Check the link:**

```bash
ls -l
cat softlink.txt
```

### Hard Link

A **hard link** is another filename that points to the same inode and data as the original file. Deleting the original filename does not affect the hard link.

**Create a hard link:**

```bash
ln original.txt hardlink.txt
```

**Check inode numbers:**

```bash
ls -li
```

The original file and hard link will have the **same inode number**.

### Soft Link vs Hard Link

| Soft Link                     | Hard Link                          |
| ----------------------------- | ---------------------------------- |
| Points to the file's path     | Points to the same inode           |
| Has a different inode         | Same inode as original             |
| Breaks if original is deleted | Still works if original is deleted |
| Can cross filesystems         | Cannot cross filesystems           |
| Created using `ln -s`         | Created using `ln`                 |

### Interview Question

**Q: What is the difference between a soft link and a hard link?**

A soft link points to the path of another file, while a hard link points to the same inode. Therefore, deleting the original file breaks a soft link, but a hard link continues to work.

## Task 2: `adduser` vs `useradd`

`adduser` and `useradd` are used to create Linux users.

* **`adduser`** is a user-friendly, interactive command that automatically handles much of the user setup.
* **`useradd`** is a lower-level command that provides more manual control and is commonly useful in scripts.

On **Ubuntu**, `adduser` is generally preferred for manually creating users because it provides an easier interactive setup.

**Create a user:**

```bash
sudo adduser devtest
```

**Verify the user:**

```bash
id devtest
```

**Remove the test user:**

```bash
sudo deluser --remove-home devtest
```

**Interview:** `adduser` is a higher-level, interactive utility, while `useradd` is a lower-level utility requiring more manual configuration.

## Task 3: `journalctl`

`journalctl` is used to view and filter logs collected by the **systemd journal**. It can be used to troubleshoot system and service issues.

**View all logs:**

```bash
journalctl
```

**View the last 20 logs:**

```bash
journalctl -n 20
```

**View logs for a specific service:**

```bash
journalctl -u ssh
```

**View recent logs for a service:**

```bash
journalctl -u ssh -n 20
```

**View logs from the current boot:**

```bash
journalctl -b
```

**View only error-level logs:**

```bash
journalctl -p err
```

`-u` specifies a service/unit, `-n` limits the number of entries, `-b` shows the current boot's logs, and `-p err` filters for errors.

**Use:** `journalctl` is useful for checking service activity and troubleshooting system problems.
