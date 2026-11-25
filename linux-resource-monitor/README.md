
# Linux Resource Monitoring

## Description

This is a simple Bash script that monitors Linux system resources.

## Features

- Check available disk space
- Check CPU utilization
- Display top 5 processes
- Check system uptime
- Check authentication failures
- Check RAM usage

## Requirements

- Linux or Ubuntu WSL
- Bash

## Usage

Run the following command:

```bash
bash monitoring.sh
```

## Commands Used

- df - Check disk space
- top - Check CPU utilization
- ps - Display running processes
- uptime - Check system uptime
- grep - Search authentication logs
- free - Check RAM usage
- awk - Extract specific values

## Known Limitations

- Disk monitoring checks the root filesystem.
- Failed login monitoring counts authentication failure
  messages in /var/log/auth.log.
- Failed login results may be unavailable if the log
  file is missing or permission is denied.

## Continuous Integration

GitHub Actions checks the script syntax, executes the
script, and validates the output when a pull request
is created or updated.
