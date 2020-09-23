# .cfg

## Installation

To install config files run 

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/kamilczerw/.cfg/master/install.sh)"
```


## Update configs

After installation there is a `config` alias created to interact with this repo. It's basically a `git` alias, so all git commands work.


***
**NOTE**

Don't use `config add .`, it will add all files from home directory to be tracked with git.

***


## iTerm2 

After installing iterm you need to set the directory form where it reads configuration. To do so, go to `Preferences` -> `General` -> `Preferences`, 
check the checkbox `Load preferences from a custom folder or URL` and choose `~/.iterm/config`. 

Now you can restart iterm, and the config should be loaded. Now you can check the `Save changes to folder when iTerm2 quits`
![image](https://user-images.githubusercontent.com/6637762/94055416-2f37b080-fddd-11ea-817c-9dd279c09663.png)

To toggle iTerm press `[cmd] + [control] + [T]`
