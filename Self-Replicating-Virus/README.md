# SELF-REPLICATING VIRUS

- ##  SCRIPT WRITTEN BY : [Ahmed Ayman](https://github.com/a7medayman6)

### Simple virus written in bash, the virus searches for other bash scripts and the copy itself into these scripts.

#### Input

- The script takes no input

#### Output

- infects the virus code into all the bash scripts under the . directory

#### How

- the script lists all the directories and files in the current directory
- loop through each one of them
  - if the ith is a directory it recursively calls the infect function again with this directory as the root
  - if the ith is a file  
    - checks if the file is a bash script
      - inject the code into the other bash script

#### Notes 

- the code doesn't do anything malicious, it just infects itself into other bash scripts.
- but by adding a malicious code inside it it will infect all the bash scripts with the same malicious code
- you can test the script in an empty directory by placing some unimportant scripts in side it. 