# Hosts Override

Override `hosts` file entries for the lifetime of the process

This project was initially created by @rcaught during his time with @ausaccessfed.

## Installation

### MacOS

#### Homebrew via own tap

``` shell
brew install ausaccessfed/hosts-override/hosts-override
```

#### Manual Install

``` shell
curl -Ls https://github.com/ausaccessfed/hosts-override/releases/latest/download/macos.zip > /tmp/hosts-override.zip
unzip /tmp/hosts-override.zip -d /usr/local/bin
```

### Linux

``` shell
curl -Ls https://github.com/ausaccessfed/hosts-override/releases/latest/download/linux.zip > /tmp/hosts-override.zip
unzip /tmp/hosts-override.zip -d /usr/local/bin
```

### Windows

- Download <https://github.com/ausaccessfed/hosts-override/releases/latest/download/windows.zip>
- Unzip the file and run the exe as Administrator

## Usage

### Mac / Linux

- Override myhost.com to resolve to 127.0.0.1

  ``` shell
  sudo hosts-override myhost.com,127.0.0.1
  ```

- google.com will be resolved into an IP / set of IPs

  ``` shell
  sudo hosts-override myhost.com,google.com
  ```

- Multiple hosts and values are supported

  ``` shell
  sudo hosts-override myhost.com,127.0.0.1 anotherhost.com,127.0.0.1
  ```

- Refresh of unresolved hosts (with custom interval)

  ``` shell
  sudo hosts-override -r -i=1m myhost.com,127.0.0.1
  ```
  
### Windows

- Run Command Prompt as Administrator and navigate to the directory containing hosts-override.exe

  ``` shell
  hosts-override.exe myhost.com,127.0.0.1
  ```

### Notes

- `sudo` or running as Administrator is required as the hosts file is owned by `root`
- On exiting the program with an interrupt (CTRL-c), the hosts file is cleaned of appended records
- In the case of an unclean shutdown, the next invocation of `hosts-override` will clear the previous sessions records
- IPv4 and IPv6 addresses supported

## Development

This is a Go based project so you'll need to [install Go](https://golang.org/doc/install) on your development machine if you want to make changes.

There is no CI associated with this project, otherwise normal PR review process applies.

## Releasing

We ship releases for:

- Windows
- Linux
- MacOS

To build all three releases using Go's cross platform capabilities run `./release.sh` which will create 3 new zip files in the `release` directory. This should only ever occur once PR are merged into the main branch.

From there [create a new release on GitHub](https://github.com/ausaccessfed/hosts-override/releases/new) and attach the binaries for consumption by users.
