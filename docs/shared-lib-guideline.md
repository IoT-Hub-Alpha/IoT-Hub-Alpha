# Guideline on how to create a shared library:


## Create New Repo
1. open https://github.com/orgs/IoT-Hub-Alpha/repositories

2. Click "New repository"
- set Owner to `IoT-Hub-Alpha`
- Chose visibility: `public`
- Start with template: `IoT-Hub-Alpha/Library-Template`

3. click on "Create repository"

4. Clone repo for local use:
`git clone git/url/to/repo`

## Create new service
1. Navigate to `src` folder, rename `team_shared_lib` folder to your service name

2. Create the desired file/code for the lib (In this example the file will be helpers.py)
and the code will be:

`.../src/shared_lib/helpers.py`
```
def greet(name: str) -> str:
    return f"Hello, {name}!"
```

3. create package code at `__init__.py`:
```
from .helpers import greet

__all__ = ["greet"]
```

4. Setup pyproject.toml.

### IMPORTANT!: `name = "shared_lib"` MUST MATCH the folder name in /src/!

for example:
if `name = "shared_lib"` then all the library files will go in `src/shared_lib/...`

5. Create unittests to cover atleast 80% of the package code (Tests go into the tests/ folder)

6. Produce a README.md describing usage and purpose of created lib


## Usage of created shared lib:

- pip install:

`pip install git+https://github.com/your-org/team-shared-lib.git`

or from specific branch (good for testing):

`pip install git+https://github.com/your-org/team-shared-lib.git@main`

- adding to requirments.txt:

`git+https://github.com/your-org/team-shared-lib.git@v0.1.0`

usage after installing:
```
from team_shared_lib import greet

greet("Team")
```

## Example lib:
https://github.com/AntonKoluh/Shared-Lib-Example

this lib can be installed with

`pip install git+https://github.com/AntonKoluh/Shared-Lib-Example.git`

after installing, you can import the lib method like so:
```
from team_shared_lib import greet
```

usage after installing:
```
from team_shared_lib import greet

print(greet("Team"))
```

This should produce a `Hello, Team!` output in the console.

Notes and addendums:

- Be careful with types when creating libs, if typing is not followed correctly there will be type errors in IDEs

- py.typed can be ignored but left in place, it is needed to avoid type errors

- all package code should go in `/src/your-lib-name/` and `/tests/` for tests.

- make sure `your-lib-name` matched `name=your-lib-name` in `pyprojects.toml`

- make sure packages download and install successfully before submitting.