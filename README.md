# Timeline Service Logger Adjuster

## Description
The "Timeline Logger Utility" utility contains a shell script (adjust-log-levels.sh) designed to dynamically configure the logging levels for the HDInsight Timeline Service. This tool benefits administrators and developers by allowing logging details (debug, info, trace) to be modified 'on the fly' without requiring a service restart Timeline services. Having dynamic control over logging output is important for continuous operations and effective troubleshooting.

## Requirements
- Access to a HDInsight ESP cluster environment where the Timeline Service is operational.
- Sufficient permissions to execute `sudo` commands, specifically for accessing keytab files and executing commands as the `yarn` user.

## Installation
Instead of cloning the repository, you can directly download the `adjust-timeline-log.sh` script using `wget` and make it executable with a single command:

```bash
wget -O adjust-timeline-log.sh https://raw.githubusercontent.com/Suaroman/TimelineServer/master/adjust-timeline-log.sh && chmod +x adjust-timeline-log.sh
```

This command will download the script and set the execute permission in one go, making it ready for use.


## Instructions
Go to the folder containing the program and run it with one of the three log intensities as an argument. Be sure you have authorization to execute the program.

```bash
./adjust-timeline-log.sh [log_level]
```

### Arguments
- `log_level`: The desired log level for the Timeline Service. Valid options are `debug`, `info`, or `trace`.

### Example
```bash
./adjust-timeline-log.sh debug
```

## Script Details
The script, `adjust-timeline-log.sh`, performs several functions:
1. Sets a Kerberos ticket cache location.
2. Checks for the presence of a log level argument and validates it.
3. Validates the script is running on a machine with a hostname starting with 'hn0'.
4. Extracts the principal name from the SPNEGO specified keytab file.
5. Executes Kerberos authentication using the extracted principal.
6. Dynamically sets the log level for Apache Hadoop as specified.

## Limitations
- The script assumes a hostname starting with 'hn0'.
- It requires `sudo` access and specific permissions for modifying Hadoop Timeline Service settings.



---
