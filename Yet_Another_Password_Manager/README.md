# Yet another password manager

A simple posix shell password manager script that uses dmenu or rofi for selecting a password.


## Usage:

### Setup the global key (passowrd)
```bash
./yapm --setup
```

### Encrypt (add) a password to the vault
```bash
./yapm --encrypt
```

### Decrypt a password (copied to clipboard)
```bash
./yapm --decrypt
```


this script saves configuration files to $HOME/.config/yapm/ in order to save your hashed key.


