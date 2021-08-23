## Fluid

An open source scanner from https://docs.fluidattacks.com/machine/scanner/plans/foss/

There are also paid versions

### Installation:
curl -L https://nixos.org/nix/install | sh

Then run this: . /home/USER/.nix-profile/etc/profile.d/nix.sh

bash <(curl -L fluidattacks.com/install/skims)

### Usage:
It needs a config yaml

skims scan /path/to/config.yaml

example
# Description:
#   Pick a name you like, normally the name of the repository.
# Example:
namespace: repository

# Description:
#   Omit if you want pretty-printed results,
#   Set to a path if you want CSV results.
# Optional:
#   Yes
# Example:
output: /path/to/results.csv

# Description:
#   Working directory, normally used as the path to the repository.
# Example:
working_dir: /path/to/your/repository

# Description:
#   SAST for source code.
# Example:
path:
  # Description:
  #   Target files used in the analysis.
  # Example:
  include:
    # Absolute path
    - /path/to/file/or/dir
    # Relative path to `working_dir`
    - src/main/java/org/test/Test.java
    # Unix-style globs
    - glob(*)
    - glob(**.java)
    - glob(src/**/test*.py)

# Description:
#   DAST for HTTP.
http:
  # Description:
  #   Target HTTP urls used in the analysis.
  # Example:
  include:
    - http://example.com/

# Description:
#  Reversing checks for Android APKs.
apk:
  # Description:
  #   Target files used in the analysis.
  # Example:
  include:
    # Absolute path
    - /path/to/build/awesome-app-v1.0.apk
    # Relative path to `working_dir`
    - build/awesome-app-v1.0.apk

# Description:
#  DAST for SSL.
ssl:
  # Description:
  #   Target host and port used in the analysis.
  # Example:
  include:
    - host: example.com
      port: 443

# Description:
#   Findings to analyze.
#   The complete list of findings can be found here:
#   https://gitlab.com/fluidattacks/product/-/blob/master/skims/manifests/findings.lst
# Optional:
#   Yes, if not present all security findings will be analyzed.
# Example:
checks:
- F052

# Description:
#   Language to use, valid values are: EN, ES.
# Optional:
#   Yes, defaults to: EN.
language: EN